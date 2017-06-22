/*'------------------------------------------------------------------------------------------------------------------
| Purpose:	To search the reporting services execution log
| Note:		SQLCmdMode Script
'--------------------------------------------------------------------------------------------------------------------
*/

DECLARE @LogStatus AS VARCHAR(50)
DECLARE @ReportFolder AS VARCHAR(450)
DECLARE @ReportName AS VARCHAR(450)
DECLARE @UserName AS VARCHAR(260)
DECLARE @GroupByColumn AS VARCHAR(50)
DECLARE @StartDate AS DATETIME
DECLARE @EndDate AS DATETIME

SET @LogStatus = '<ALL>'
SET @ReportFolder = '...A Report Folder Name...'
SET @ReportName = '<ALL>' 
SET @UserName = '<ALL>'
SET @GroupByColumn = 'Report Folder'
SET @StartDate = NULL
SET @EndDate = NULL

:setvar _server "Server1"
:setvar _user "***username***"
:setvar _password "***password***"
:setvar _database "ReportServer"
:connect $(_server) -U $(_user) -P $(_password)

USE [$(_database)];
GO


;WITH
report_execution_log
AS
(
	SELECT 
		  el.*
		, SimpleUserName = RIGHT(el.UserName,(LEN(el.UserName)-CHARINDEX('\',el.UserName)))
		, TimeStartDate = CONVERT(DATETIME, CONVERT(VARCHAR(11),el.TimeStart,13))
		, TotalSecondsFormat = CONVERT(CHAR(8),DATEADD(ms,(el.TimeDataRetrieval + el.TimeProcessing + el.TimeRendering),0),108)
		, TimeDataRetrievalFormat = CONVERT(CHAR(8),DATEADD(ms,el.TimeDataRetrieval,0),108) 
		, TimeProcessingFormat = CONVERT(CHAR(8),DATEADD(ms,el.TimeProcessing,0),108)  
		, TimeRenderingFormat = CONVERT(CHAR(8),DATEADD(ms,el.TimeRendering,0),108) 
		, OrderbyDateFormat = CAST(TimeStart AS DATETIME) 
	FROM 
		ReportServer.dbo.ExecutionLog el
)
,
report_catalog
AS
(
	SELECT    
		  c.ItemID
		, c.CreatedById
		, c.ModifiedById
		, c.[Type]
		, c.Name 
		, c.[Path]
		, c.[Description]
		, c.Parameter
		, ReportCreationDate = CONVERT(DATETIME, CONVERT(VARCHAR(11), c.CreationDate, 13))
		, ReportModifiedDate = CONVERT(DATETIME, CONVERT(VARCHAR(11), c.ModifiedDate, 13))
		, ReportFolder = 
			CASE
				WHEN c.Path = '/' + c.Name THEN ''
				ELSE SUBSTRING(c.Path, 2, Len(c.Path)-Len(c.Name)-2) 
			END 
		, ReportPath = c.[Path]
		, UrlPath = 'http://' + Host_Name() + '/Reports/Pages/Folder.aspx?ItemPath=%2f'
		, ReportDefinition = CONVERT(VARCHAR(MAX),CONVERT(VARBINARY(MAX),c.content))  
	FROM 
		dbo.Catalog AS c
	WHERE c.Type = 2
)
SELECT 
 	GroupBy1 = CASE  
		WHEN @GroupByColumn = 'Report Name' THEN c.Name
		WHEN @GroupByColumn = 'Report Folder' THEN c.ReportFolder
		WHEN @GroupByColumn = 'User Id' THEN el.SimpleUserName
		ELSE '<N/A>' END
	, c.[Path]
	, c.ReportFolder
	, c.Name
	, URL_ReportFolder = c.UrlPath + c.ReportFolder + '&ViewMode=List'
	, URL_Report = c.UrlPath + c.ReportFolder + '%2f' + c.Name 	
	, URL_Report_Filtered = 'http://' + Host_Name() + '/ReportServer/ReportServer?/' + c.ReportFolder + '%2f' + c.Name + '&rs:Command=Render&' + CONVERT(VARCHAR(2000), el.Parameters)
	, UserName = el.SimpleUserName
	, el.Status
	, el.TimeStart
	, el.[RowCount]
	, el.ByteCount
	, el.Format
	, el.[Parameters]
	, TotalSeconds = el.TotalSecondsFormat
	, TimeDataRetrieval = el.TimeDataRetrievalFormat
	, TimeProcessing = el.TimeProcessingFormat
	, TimeRendering = el.TimeRenderingFormat
	, OrderbyDate = el.OrderbyDateFormat
FROM 
	report_catalog c 
	LEFT JOIN report_execution_log el ON el.ReportID = c.ItemID
WHERE 
	1=1
	AND c.Name NOT IN('Report Execution Log') -- whatever the name of this report is...
	AND (@StartDate IS NULL OR el.TimeStartDate >= @StartDate)
	AND (@EndDate IS NULL OR el.TimeStartDate <= @EndDate)	
	AND ('<ALL>' IN(@UserName) OR el.SimpleUserName IN(@UserName))
	AND ('<ALL>' IN(@LogStatus) OR el.[Status] IN(@LogStatus))
	AND ('<ALL>' IN(@ReportFolder) OR c.ReportFolder IN(@ReportFolder))
	AND ('<ALL>' IN(@ReportName) OR c.Name IN(@ReportName))