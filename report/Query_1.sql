-- DDL and sample data population, start
DECLARE @tbl TABLE (
   ID INT IDENTITY PRIMARY KEY
   , Area CHAR(2)
   , Typvidobr VARCHAR(30)
);
INSERT INTO @tbl (Area, Typvidobr)
VALUES
('10', 'Взяли')
, ('15', 'Віддали')
, ('23', 'Втратили');
-- DDL and sample data population, end

DECLARE @xhtmlBody XML
   , @body NVARCHAR(MAX)
   , @tableCaption VARCHAR(30) = 'Рух землі';

SET @xhtmlBody = (SELECT (
SELECT * FROM @tbl FOR XML PATH('row'), TYPE, ROOT('root'))
.query('<html><head>
            <meta charset="utf-8"/>
            (: including embedded CSS styling :)
            <style>table <![CDATA[ {border-collapse: collapse;  width: 300px;} ]]>
            th <![CDATA[ {background-color: #4CAF50; color: white;} ]]>
            th, td <![CDATA[ { text-align: left; padding: 8px;} ]]>
            tr:nth-child(even) <![CDATA[ {background-color: #f2f2f2;} ]]>
		td:nth-child(3) <![CDATA[ {background-color: red;} ]]>
		#green <![CDATA[ {background-color: lightgreen;} ]]>
         </style>
         </head>
         <body>
<table border="1">
	<caption><h2>{sql:variable("@tableCaption")}</h2></caption>
	<thead>
	   <tr>
		  <th>No.</th>
		  <th>Area</th>
		  <th>Typvidobr</th>
	   </tr>
	</thead>
	<tbody>
{
    for $row in /root/row
    return <tr>
            <td>{data($row/ID)}</td>
            <td>{data($row/Area)}</td>
            <td id="{if ($row/Typvidobr/text()="Віддали") then "green" else ()}">
			{data($row/Typvidobr)}
		</td>
        </tr>
}
</tbody></table></body></html>'));

SELECT @xhtmlBody;

SET @body = CAST(@xhtmlBody AS NVARCHAR(MAX));