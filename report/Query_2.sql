USE AdventureWorks2014;
GO
 
/*
Declare Variables for DML
*/
 
DECLARE @ReportingPeriodStart DATE;
DECLARE @ReportingPeriodEnd DATE;
 
 -- Reporting date will from the beginning of the current week
SET @ReportingPeriodStart = DATEADD(WEEK, DATEDIFF(WEEK, 0, DATEADD(YEAR, -3, GETDATE())), 0);
SET @ReportingPeriodEnd = DATEADD(WEEK, DATEDIFF(WEEK, 0, DATEADD(YEAR, -3, GETDATE())) + 1, 0);
 
/*
Declare Variables for HTML
*/
 
DECLARE @tableHTML NVARCHAR(MAX)= '';
 
SET @tableHTML += @Style + @tableHTML + N'<H2>Order Summary For : ' + CAST(@ReportingPeriodStart AS CHAR(10)) + ' to ' + CAST(@ReportingPeriodEnd AS CHAR(10)) + '</H2>' 
	+ N'<table class="tg">' --DEFINE TABLE
/*
Define Column Headers and Column Span for each Header Column
*/
	+ N'<tr>' 
    + N'<th class="tg-hgcj" colspan="2">Order Information</th>' 
	+ N'<th class="tg-hgcj" colspan="2">Summary</th>'
	+ N'</tr>' 
/*
Define Column Sub-Headers
*/
	+ N'<tr>'
	+ N'<td class="tg-9ajh">Order Date</td>'
    + N'<td class="tg-9ajh">Shipping Method</td>' 
	+ N'<td class="tg-9ajh">Order QTY</td>'
    + N'<td class="tg-9ajh">Order Total</td></tr>'
/*
Define data for table and cast to xml
*/
    + CAST(( SELECT td = ISNULL(CONVERT(CHAR(8), OrderDate, 112),'2020-01-01') ,
					'',
                    td = ISNULL(SM.Name,'UNKNOWN') ,
					'',
                    td = ISNULL(COUNT(SalesOrderID),0) ,
					'',
                    td = ISNULL(CAST(SUM(TotalDue) AS NUMERIC(18,2)),0) ,
					''
             FROM   [Sales].[SalesOrderHeader] SOH
                    JOIN Purchasing.ShipMethod SM ON SM.ShipMethodID = SOH.ShipMethodID
			 WHERE	SOH.OrderDate >= @ReportingPeriodStart
			 AND	SOH.OrderDate < @ReportingPeriodEnd
             GROUP BY CONVERT(CHAR(8), OrderDate, 112) ,
                    SM.Name
             ORDER BY 1 ,
                    2
           FOR
             XML PATH('tr') ,
                 TYPE
           ) AS NVARCHAR(MAX)) + N'</table>';