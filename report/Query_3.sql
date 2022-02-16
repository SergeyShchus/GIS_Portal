USE --Base--

----

CREATE PROC dbo.usp_ConvertQuery2HTMLTable (@SQLQuery NVARCHAR(3000))
AS
BEGIN
   DECLARE @columnslist NVARCHAR (1000) = ''
   DECLARE @restOfQuery NVARCHAR (2000) = ''
   DECLARE @DynTSQL NVARCHAR (3000)
   DECLARE @FROMPOS INT

   SET NOCOUNT ON

   SELECT @columnslist += 'ISNULL (' + NAME + ',' + '''' + ' ' + '''' + ')' + ','
   FROM sys.dm_exec_describe_first_result_set(@SQLQuery, NULL, 0)

   SET @columnslist = left (@columnslist, Len (@columnslist) - 1)
   SET @FROMPOS = CHARINDEX ('FROM', @SQLQuery, 1)
   SET @restOfQuery = SUBSTRING(@SQLQuery, @FROMPOS, LEN(@SQLQuery) - @FROMPOS + 1)
   SET @columnslist = Replace (@columnslist, '),', ') as TD,')
   SET @columnslist += ' as TD'
   SET @DynTSQL = CONCAT (
         'SELECT (SELECT '
         , @columnslist
         ,' '
         , @restOfQuery
         ,' FOR XML RAW (''TR''), ELEMENTS, TYPE) AS ''TBODY'''
         ,' FOR XML PATH (''''), ROOT (''TABLE'')'
         )

   EXEC (@DynTSQL)
   SET NOCOUNT OFF
END
GO


---------

IF EXISTS ( SELECT [name] FROM sys.tables WHERE [name] = 'ItemDetails' )    
DROP TABLE Products    
GO  


---------

CREATE TABLE [dbo].[Products]
   (
   Product [varchar](50) NULL,
   UnitPrice [money] NULL
   )
GO 

----------

INSERT INTO [dbo].[Products]
SELECT 'Nougat Creme', 14.00
UNION
SELECT 'Gorgonzola', 12.00
UNION
SELECT 'Ale', 14.00
UNION
SELECT 'Chocolate', 10.00
UNION
SELECT 'Lager', 12.00
UNION
SELECT 'Bread', 9.00


----------

usp_ConvertQuery2HTMLTable 'SELECT Product, UnitPrice FROM dbo.Products'

-------- OR SAVE FILE (BSP):

bcp "exec northwind.dbo.usp_ConvertQuery2HTMLTable 'SELECT Product, UnitPrice FROM dbo.Products'" queryout report.html -c -T -S PCN70152\SQL2K14





/*Next Steps
You can create this procedure in your application database and use it as a tool for reporting selected queries in HTML format whenever needed.
You can compile and create the procedure in the master database and use it for all your user databases.
The procedure was created and tested with: SQL Server 2014 and 2016 Standard Edition
Note that sys.dm_exec_describe_first_result_set dynamic is available with SQL Server 2012 and later.*/