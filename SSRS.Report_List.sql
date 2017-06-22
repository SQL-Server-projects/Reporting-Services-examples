/*'------------------------------------------------------------------------------------------------------------------
| Purpose:	To search deployed reports on the report server
| Note:		SQLCmdMode Script
'--------------------------------------------------------------------------------------------------------------------
*/

DECLARE @ReportFolder AS VARCHAR(100)
DECLARE @ReportName AS VARCHAR(100)
DECLARE @ReportDescription AS VARCHAR(50)
DECLARE @CreatedBy AS VARCHAR(50)
DECLARE @CreatedDate AS DATETIME
DECLARE @ModifiedBy AS VARCHAR(50)
DECLARE @ModifiedDate AS DATETIME
DECLARE @SearchFor AS VARCHAR(50)
DECLARE @SearchType AS VARCHAR(50)

SET @ReportFolder = '<ALL>'
SET @ReportName = NULL
SET @ReportDescription = NULL
SET @CreatedBy = NULL
SET @CreatedDate = NULL
SET @ModifiedBy = NULL
SET @ModifiedDate = NULL
SET @SearchFor = NULL
SET @SearchType = NULL  -- 'Report Name', 'Report Description', 'Report Definition'

:setvar _server "Server1"
:setvar _user "***username***"
:setvar _password "***password***"
:setvar _database "ReportServer"
:connect $(_server) -U $(_user) -P $(_password)

USE [$(_database)];
GO


;WITH
report_users 
AS
(
	SELECT UserID, SimpleUserName = UPPER(RIGHT(UserName,(LEN(UserName)-CHARINDEX('\',UserName)))) FROM dbo.Users
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
	WHERE 
		1=1
		AND c.Type = 2
)
SELECT    
	  c.ItemID
	, c.Name 
	, c.Description
	, c.Parameter
	, ReportCreatedBy = urc.SimpleUserName
	, c.ReportCreationDate 
	, ReportModifiedBy = urm.SimpleUserName
	, c.ReportModifiedDate 
	, c.ReportFolder
	, c.ReportPath 
	, URL_ReportFolder = c.UrlPath + c.ReportFolder + '&ViewMode=List'
	, URL_Report = c.UrlPath + c.ReportFolder + '%2f' + c.Name 
	, c.ReportDefinition
	, CommandText = c.ReportDefinition
	, el.ExecutionLogCount
	, sc.SubscriptionCount
	, SearchForStr = ISNULL(@SearchFor, ' ') 
FROM  
	report_catalog AS c 
	LEFT OUTER JOIN (SELECT COUNT([ReportID]) AS ExecutionLogCount, ReportID FROM dbo.ExecutionLog GROUP BY ReportID) el ON el.ReportID = c.ItemID
	LEFT OUTER JOIN	(SELECT COUNT([Report_OID]) AS SubscriptionCount, Report_OID FROM dbo.Subscriptions GROUP BY Report_OID) sc  ON sc.Report_OID = c.ItemID
	LEFT OUTER JOIN report_users AS urc ON c.CreatedById = urc.UserID 
	LEFT OUTER JOIN report_users AS urm ON c.ModifiedById = urm.UserID 
WHERE 
		(@CreatedBy IS NULL OR urc.SimpleUserName LIKE '%' + @CreatedBy + '%')
	AND (@CreatedDate IS NULL OR c.ReportCreationDate >= @CreatedDate)
	AND (@ModifiedBy IS NULL OR urm.SimpleUserName LIKE '%' + @ModifiedBy + '%')
	AND (@ModifiedDate IS NULL OR c.ReportModifiedDate >= @ModifiedDate)
	AND ('<ALL>' IN (@ReportFolder) OR c.ReportFolder IN(@ReportFolder))
	AND (@SearchFor IS NULL OR 
			(
				   (('<ALL>' IN(@SearchType) OR 'Report Name' IN(@SearchType)) AND c.Name LIKE '%' + @SearchFor + '%')
				OR (('<ALL>' IN(@SearchType) OR 'Report Description' IN(@SearchType)) AND c.[Description] LIKE '%' + @SearchFor + '%')
				OR (('<ALL>' IN(@SearchType) OR 'Report Definition' IN(@SearchType)) AND PATINDEX('%' + @SearchFor + '%', c.ReportDefinition) > 0)   
			)
		)