/*'------------------------------------------------------------------------------------------------------------------
| Purpose:	Schedule Of Recurring Report Subscriptions
| Note:		SQLCmdMode Script
'--------------------------------------------------------------------------------------------------------------------

DECLARE @ReportFolder AS VARCHAR(100)
DECLARE @ReportName AS VARCHAR(100)
DECLARE @EmailLike AS VARCHAR(100)
DECLARE @ModifiedBy AS VARCHAR(50)
DECLARE @SubcriptionOwner AS VARCHAR(50)
DECLARE @SubscriptionStatus AS VARCHAR(1)
DECLARE @EventStatus AS VARCHAR(50)
DECLARE @Current AS VARCHAR(50)
DECLARE @LastSubscriptionDate AS DATETIME

SET @ReportFolder = '<ALL>'
SET @ReportName = '<ALL>'
SET @EmailLike = NULL 
SET @ModifiedBy = NULL
SET @SubcriptionOwner = NULL
SET @SubscriptionStatus = 'A' -- Y=Sent, N=Fail, A=All
SET @EventStatus = '<ALL>'  -- status from ReportServer.dbo.ExecutionLog 
SET @Current = '<ALL>' 
SET @LastSubscriptionDate = NULL --getdate()-1

:setvar _server "Server1"
:setvar _user "***username***"
:setvar _password "***password***"
:setvar _database "ReportServer"
:connect $(_server) -U $(_user) -P $(_password)

USE [$(_database)];
GO

*/

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
	WHERE c.Type = 2
)
, 
subscription_days
AS
(
	SELECT tbl.* FROM (VALUES
	  ( 'DaysOfMonth', 1, '1')
	, ( 'DaysOfMonth', 2, '2')
	, ( 'DaysOfMonth', 4, '3')
	, ( 'DaysOfMonth', 8, '4')
	, ( 'DaysOfMonth', 16, '5')
	, ( 'DaysOfMonth', 32, '6')
	, ( 'DaysOfMonth', 64, '7')
	, ( 'DaysOfMonth', 128, '8')
	, ( 'DaysOfMonth', 256, '9')
	, ( 'DaysOfMonth', 512, '10')
	, ( 'DaysOfMonth', 1024, '11')
	, ( 'DaysOfMonth', 2048, '12')
	, ( 'DaysOfMonth', 4096, '13')
	, ( 'DaysOfMonth', 8192, '14')
	, ( 'DaysOfMonth', 16384, '15')
	, ( 'DaysOfMonth', 32768, '16')
	, ( 'DaysOfMonth', 65536, '17')
	, ( 'DaysOfMonth', 131072, '18')
	, ( 'DaysOfMonth', 262144, '19')
	, ( 'DaysOfMonth', 524288, '20')
	, ( 'DaysOfMonth', 1048576, '21')
	, ( 'DaysOfMonth', 2097152, '22')
	, ( 'DaysOfMonth', 4194304, '23')
	, ( 'DaysOfMonth', 8388608, '24')
	, ( 'DaysOfMonth', 16777216, '25')
	, ( 'DaysOfMonth', 33554432, '26')
	, ( 'DaysOfMonth', 67108864, '27')
	, ( 'DaysOfMonth', 134217728, '28')
	, ( 'DaysOfMonth', 268435456, '29')
	, ( 'DaysOfMonth', 536870912, '30')
	, ( 'DaysOfMonth', 1073741824, '31')
	, ( 'DaysOfMonth', 8193, '1st and 14th')
	, ( 'DaysOfWeek', 1, 'Sun')
	, ( 'DaysOfWeek', 2, 'Mon')
	, ( 'DaysOfWeek', 4, 'Tues')
	, ( 'DaysOfWeek', 8, 'Wed')
	, ( 'DaysOfWeek', 16, 'Thurs')
	, ( 'DaysOfWeek', 32, 'Fri')
	, ( 'DaysOfWeek', 64, 'Sat')
	, ( 'DaysOfWeek', 62, 'Mon - Fri')
	, ( 'DaysOfWeek', 10, 'Mon - Wed')
	, ( 'DaysOfWeek', 24, 'Wed - Thurs')
	, ( 'DaysOfWeek', 120, 'Wed - Sat')
	, ( 'DaysOfWeek', 126, 'Mon - Sat')
	, ( 'DaysOfWeek', 127, 'Daily')
	, ( 'DayOfWeek', 1, 'Sun')
	, ( 'DayOfWeek', 127, 'Sun')
	, ( 'DayOfWeek', 2, 'Mon')
	, ( 'DayOfWeek', 10, 'Mon')
	, ( 'DayOfWeek', 62, 'Mon')
	, ( 'DayOfWeek', 126, 'Mon')
	, ( 'DayOfWeek', 127, 'Mon')
	, ( 'DayOfWeek', 4, 'Tue')
	, ( 'DayOfWeek', 10, 'Tue')
	, ( 'DayOfWeek', 62, 'Tue')
	, ( 'DayOfWeek', 126, 'Tue')
	, ( 'DayOfWeek', 127, 'Tue')
	, ( 'DayOfWeek', 8, 'Wed')
	, ( 'DayOfWeek', 10, 'Wed')
	, ( 'DayOfWeek', 24, 'Wed')
	, ( 'DayOfWeek', 62, 'Wed')
	, ( 'DayOfWeek', 120, 'Wed')
	, ( 'DayOfWeek', 126, 'Wed')
	, ( 'DayOfWeek', 127, 'Wed')
	, ( 'DayOfWeek', 16, 'Thr')
	, ( 'DayOfWeek', 24, 'Thr')
	, ( 'DayOfWeek', 62, 'Thr')
	, ( 'DayOfWeek', 120, 'Thr')
	, ( 'DayOfWeek', 126, 'Thr')
	, ( 'DayOfWeek', 127, 'Thr')
	, ( 'DayOfWeek', 32, 'Fri')
	, ( 'DayOfWeek', 62, 'Fri')
	, ( 'DayOfWeek', 120, 'Fri')
	, ( 'DayOfWeek', 126, 'Fri')
	, ( 'DayOfWeek', 127, 'Fri')
	, ( 'DayOfWeek', 64, 'Sat')
	, ( 'DayOfWeek', 120, 'Sat')
	, ( 'DayOfWeek', 126, 'Sat')
	, ( 'DayOfWeek', 127, 'Sat')
	) tbl ([GroupName], [CodeNbr], [Label]) 
)
,
subscription_schedule
AS
(
	SELECT 
		  ScheduleID
		, SchDaySun = Sun
		, SchDayMon = Mon
		, SchDayTue = Tue
		, SchDayWed = Wed
		, SchDayThr = Thr
		, SchDayFri = Fri
		, SchDaySat = Sat
		, ScheduleName
		, ScheduleStartDate 
		, ScheduleEndDate 
		, Flags
		, RecurrenceType
		, [State]
		, MinutesInterval
		, DaysInterval
		, WeeksInterval
		, DaysOfWeek
		, DaysOfMonth
		, [Month]
		, MonthlyWeek 
		, ScheduleDays 
	FROM
		(
		SELECT 
			  sc.ScheduleID 
			, sd.CodeNbr
			, sd.Label
			, ScheduleName = sc.name
			, ScheduleStartDate = sc.StartDate
			, ScheduleEndDate = sc.EndDate
			, sc.Flags
			, sc.RecurrenceType
			, sc.[State]
			, sc.MinutesInterval
			, sc.DaysInterval
			, sc.WeeksInterval
			, sc.DaysOfWeek
			, sc.DaysOfMonth
			, sc.[Month]
			, sc.MonthlyWeek 
			, ScheduleDays = 
				CASE
					WHEN sc.DaysOfMonth IS NOT NULL THEN COALESCE(dom.Label, '(' + CAST(sc.DaysOfMonth AS VARCHAR(20)) + ') NOT CODED')
					WHEN sc.DaysOfWeek IS NOT NULL THEN COALESCE(dow.Label, '(' + CAST(sc.DaysOfWeek AS VARCHAR(20)) + ') NOT CODED')
				END 
			--, sc.RecurrenceType
		FROM 
			dbo.Schedule sc 
			LEFT JOIN subscription_days sd ON sc.DaysOfWeek = sd.CodeNbr AND sd.GroupName = 'DayOfWeek'
			LEFT JOIN subscription_days AS dom ON sc.DaysOfMonth = dom.CodeNbr AND dom.GroupName = 'DaysOfMonth'
			LEFT JOIN subscription_days AS dow ON sc.DaysOfWeek = dow.CodeNbr AND dow.GroupName = 'DaysOfWeek'
		) sch
		PIVOT
		(
			COUNT(sch.Label) 
			FOR sch.Label
			IN ([Sun], [Mon], [Tue], [Wed], [Thr], [Fri], [Sat])
		) AS pvt
)
,
report_subscription
AS
(
	SELECT     
		  s.SubscriptionID
		, s.Report_OID
		, SubscriptionDescription = s.[Description]
		, s.ExtensionSettings
		, s.EventType
		, s.OwnerID
		, s.ModifiedByID
		, s.ModifiedDate		
		, RunTime = CONVERT(VARCHAR(5), s.LastRunTime, 8)
		, LastRunDate = CONVERT(VARCHAR(11),s.LastRunTime,13)
		, s.LastRunTime
		, s.DeliveryExtension		
		, s.MatchData		
		, SubscriptionLastStatus = s.LastStatus		
		, StatusFail = CASE WHEN s.LastStatus  LIKE '%Mail sent%' THEN 'N' ELSE 'Y' END		
		, EmailSubject = CASE CHARINDEX('<Name>SUBJECT</Name><Value>', s.ExtensionSettings) WHEN 0 THEN '' ELSE SUBSTRING(s.ExtensionSettings, LEN('<Name>SUBJECT</Name><Value>') + CHARINDEX('<Name>SUBJECT</Name><Value>', s.ExtensionSettings), CHARINDEX('</Value>', s.ExtensionSettings, CHARINDEX('<Name>SUBJECT</Name><Value>', s.ExtensionSettings) + 1) - (LEN('<Name>SUBJECT</Name><Value>') + CHARINDEX('<Name>SUBJECT</Name><Value>', s.ExtensionSettings))) END
		, EmailTo = SUBSTRING(s.ExtensionSettings, LEN('<Name>TO</Name><Value>') + CHARINDEX('<Name>TO</Name><Value>', s.ExtensionSettings), CHARINDEX('</Value>', s.ExtensionSettings, CHARINDEX('<Name>TO</Name><Value>', s.ExtensionSettings) + 1) - (LEN('<Name>TO</Name><Value>') + CHARINDEX('<Name>TO</Name><Value>', s.ExtensionSettings)))
		, EmailCc = CASE CHARINDEX('<Name>CC</Name><Value>', s.ExtensionSettings) WHEN 0 THEN '' ELSE SUBSTRING(s.ExtensionSettings, LEN('<Name>CC</Name><Value>') + CHARINDEX('<Name>CC</Name><Value>', s.ExtensionSettings), CHARINDEX('</Value>', s.ExtensionSettings, CHARINDEX('<Name>CC</Name><Value>', s.ExtensionSettings) + 1) - (LEN('<Name>CC</Name><Value>') + CHARINDEX('<Name>CC</Name><Value>', s.ExtensionSettings))) END 
		, EmailBcc = CASE CHARINDEX('<Name>BCC</Name><Value>', s.ExtensionSettings) WHEN 0 THEN '' ELSE SUBSTRING(s.ExtensionSettings, LEN('<Name>BCC</Name><Value>') + CHARINDEX('<Name>BCC</Name><Value>', s.ExtensionSettings), CHARINDEX('</Value>', s.ExtensionSettings, CHARINDEX('<Name>BCC</Name><Value>', s.ExtensionSettings) + 1) - (LEN('<Name>BCC</Name><Value>') + CHARINDEX('<Name>BCC</Name><Value>', s.ExtensionSettings))) END
		, EmailComment = CASE CHARINDEX('<Name>Comment</Name><Value>', s.ExtensionSettings) WHEN 0 THEN '' ELSE SUBSTRING(s.ExtensionSettings, LEN('<Name>Comment</Name><Value>') + CHARINDEX('<Name>Comment</Name><Value>', s.ExtensionSettings), CHARINDEX('</Value>', s.ExtensionSettings, CHARINDEX('<Name>Comment</Name><Value>', s.ExtensionSettings) + 1) - (LEN('<Name>Comment</Name><Value>') + CHARINDEX('<Name>Comment</Name><Value>', s.ExtensionSettings))) END
		, EmailIncludeLink = CASE CHARINDEX('<Name>IncludeLink</Name><Value>', s.ExtensionSettings) WHEN 0 THEN '' ELSE SUBSTRING(s.ExtensionSettings, LEN('<Name>IncludeLink</Name><Value>') + CHARINDEX('<Name>IncludeLink</Name><Value>', s.ExtensionSettings), CHARINDEX('</Value>', s.ExtensionSettings, CHARINDEX('<Name>IncludeLink</Name><Value>', s.ExtensionSettings) + 1) - (LEN('<Name>IncludeLink</Name><Value>') + CHARINDEX('<Name>IncludeLink</Name><Value>', s.ExtensionSettings))) END 
		, EmailRenderFormat = CASE CHARINDEX('<Name>RenderFormat</Name><Value>', s.ExtensionSettings) WHEN 0 THEN '' ELSE SUBSTRING(s.ExtensionSettings, LEN('<Name>RenderFormat</Name><Value>') + CHARINDEX('<Name>RenderFormat</Name><Value>', s.ExtensionSettings), CHARINDEX('</Value>', s.ExtensionSettings, CHARINDEX('<Name>RenderFormat</Name><Value>', s.ExtensionSettings) + 1) - (LEN('<Name>RenderFormat</Name><Value>') + CHARINDEX('<Name>RenderFormat</Name><Value>', s.ExtensionSettings))) END
		, EmailPriority = CASE CHARINDEX('<Name>Priority</Name><Value>', s.ExtensionSettings) WHEN 0 THEN '' ELSE SUBSTRING(s.ExtensionSettings, LEN('<Name>Priority</Name><Value>') + CHARINDEX('<Name>Priority</Name><Value>', s.ExtensionSettings), CHARINDEX('</Value>', s.ExtensionSettings, CHARINDEX('<Name>Priority</Name><Value>', s.ExtensionSettings) + 1) - (LEN('<Name>Priority</Name><Value>') + CHARINDEX('<Name>Priority</Name><Value>', s.ExtensionSettings))) END
		, sch.MinutesInterval
		, sch.DaysInterval
		, sch.WeeksInterval
		, sch.DaysOfWeek
		, sch.DaysOfMonth
		, sch.[Month]
		, sch.MonthlyWeek 
		, JobName = sj.name 
		, sch.ScheduleName 
		, sch.ScheduleDays 
		, sch.SchDaySun
		, sch.SchDayMon
		, sch.SchDayTue
		, sch.SchDayWed
		, sch.SchDayThr
		, sch.SchDayFri
		, sch.SchDaySat
		, sch.ScheduleStartDate 
		, sch.ScheduleEndDate 
		, sch.Flags
		, sch.RecurrenceType
		, sch.[State]
	FROM  
		dbo.Subscriptions AS s 
		LEFT JOIN dbo.Notifications AS n ON n.SubscriptionID = s.SubscriptionID AND s.Report_OID = n.ReportID
		LEFT JOIN dbo.ReportSchedule AS rs ON s.SubscriptionID = rs.SubscriptionID 
		LEFT JOIN MSDB.dbo.sysjobs AS sj ON sj.name = CAST(rs.ScheduleID AS VARCHAR(255))
		LEFT JOIN subscription_schedule AS sch ON rs.ScheduleID = sch.ScheduleID 
	WHERE 
		1=1
		--AND sch.RecurrenceType IN(4,5) -- 1 = is one off, 4 = daily, 5 = monthly
		--AND s.EventType = 'TimedSubscription' 
)
SELECT     
	  c.Name 
	, c.Description 
	, c.Parameter 	
	, c.ReportFolder 
	, c.ReportPath 
	, URL_ReportFolder = c.UrlPath + c.ReportFolder + '&ViewMode=List'
	, URL_Report = c.UrlPath + c.ReportFolder + '%2f' + c.Name 
	, URL = 'http://' + Host_Name() + '/Reports/Pages/SubscriptionProperties.aspx?ItemPath=' + c.ReportPath + '&IsDataDriven=False&SubscriptionID=' + CAST(s.SubscriptionID AS VARCHAR(80)) 
	, URL2 = 'http://' + Host_Name() + '/Reports/Pages/Report.aspx?ItemPath=' + c.ReportPath + '&SelectedTabId=SubscriptionsTab'  
	, ReportCreatedBy = urc.SimpleUserName
	, c.ReportCreationDate
	, ReportModifiedBy = urm.SimpleUserName
	, c.ReportModifiedDate 	
	, SubscriptionOwner = usc.SimpleUserName
	, SubscriptionModifiedBy = usm.SimpleUserName
	, SubscriptionModifiedDate = s.ModifiedDate 	
	, s.SubscriptionID
	, s.SubscriptionDescription 
	, s.ExtensionSettings
	, s.EventType
	, s.EmailSubject 
	, s.EmailTo 
	, s.EmailCc 
	, s.EmailBcc 
	, s.EmailComment 
	, s.EmailIncludeLink 
	, s.EmailRenderFormat 
	, s.EmailPriority 
	, s.DeliveryExtension	
	, s.SubscriptionLastStatus
	, s.StatusFail 
	, s.MatchData	
	, s.RunTime 
	, s.LastRunDate
	, s.LastRunTime	
	, s.MinutesInterval
	, s.DaysInterval
	, s.WeeksInterval
	, s.DaysOfWeek
	, s.DaysOfMonth
	, s.[Month]
	, s.MonthlyWeek 	
	, s.JobName 
	, s.ScheduleName 
	, s.ScheduleDays
	, s.SchDaySun
	, s.SchDayMon
	, s.SchDayTue
	, s.SchDayWed
	, s.SchDayThr
	, s.SchDayFri
	, s.SchDaySat
	, s.ScheduleStartDate
	, s.ScheduleEndDate
	, s.Flags
	, s.RecurrenceType
	, s.[State]
	, EventStatus = el.Status 
	, EventDateTime = el.TimeEnd 
FROM  
	report_catalog AS c
	INNER JOIN	report_subscription AS s ON s.Report_OID = c.ItemID 
	LEFT OUTER JOIN	(SELECT b.ReportID, b.Status, b.TimeEnd
					FROM dbo.ExecutionLog b 
					INNER JOIN (SELECT ReportID, MAX(TimeEnd) AS TimeEnd
								FROM dbo.ExecutionLog 
								GROUP BY ReportID) a ON b.ReportID = a.ReportID AND b.TimeEnd = a.TimeEnd
					)AS el ON el.ReportID = c.ItemID
	LEFT OUTER JOIN report_users AS urc ON c.CreatedById = urc.UserID 
	LEFT OUTER JOIN report_users AS urm ON c.ModifiedById = urm.UserID 
	LEFT OUTER JOIN report_users AS usc ON s.OwnerID = usc.UserID 
	LEFT OUTER JOIN report_users AS usm ON s.ModifiedByID = usm.UserID 
WHERE c.Type = 2
	AND (SUBSTRING(s.ExtensionSettings, LEN('<Name>TO</Name><Value>') + CHARINDEX('<Name>TO</Name><Value>', s.ExtensionSettings), CHARINDEX('</Value>', s.ExtensionSettings, CHARINDEX('<Name>TO</Name><Value>', s.ExtensionSettings) + 1) - (LEN('<Name>TO</Name><Value>') + CHARINDEX('<Name>TO</Name><Value>', s.ExtensionSettings)))
		LIKE '%' + @EmailLike + '%' OR @EmailLike IS NULL		
		OR CASE CHARINDEX('<Name>CC</Name><Value>', s.ExtensionSettings) WHEN 0 THEN '' ELSE SUBSTRING(s.ExtensionSettings, LEN('<Name>CC</Name><Value>') + CHARINDEX('<Name>CC</Name><Value>', s.ExtensionSettings), CHARINDEX('</Value>', s.ExtensionSettings, CHARINDEX('<Name>CC</Name><Value>', s.ExtensionSettings) + 1) - (LEN('<Name>CC</Name><Value>') + CHARINDEX('<Name>CC</Name><Value>', s.ExtensionSettings))) END 
		LIKE '%' + @EmailLike + '%'
		OR CASE CHARINDEX('<Name>BCC</Name><Value>', s.ExtensionSettings) WHEN 0 THEN '' ELSE SUBSTRING(s.ExtensionSettings, LEN('<Name>BCC</Name><Value>') + CHARINDEX('<Name>BCC</Name><Value>', s.ExtensionSettings), CHARINDEX('</Value>', s.ExtensionSettings, CHARINDEX('<Name>BCC</Name><Value>', s.ExtensionSettings) + 1) - (LEN('<Name>BCC</Name><Value>') + CHARINDEX('<Name>BCC</Name><Value>', s.ExtensionSettings))) END 
		LIKE '%' + @EmailLike + '%') -- search for a name in the email to field
	AND ('<ALL>' IN(@EventStatus) OR el.Status IN(@EventStatus))
	AND ('ALL' = @SubscriptionStatus OR s.SubscriptionLastStatus LIKE '%' + @SubscriptionStatus + '%')
	AND ('<ALL>' IN (@ReportFolder) OR c.ReportFolder IN(@ReportFolder))
	AND ('<ALL>' IN (@ReportFolder) OR CHARINDEX(@ReportFolder, c.ReportPath) > 0)
	AND ('<ALL>' IN(@ReportName) OR c.Name IN(@ReportName))
	AND ('<ALL>' IN(@Current) OR CASE WHEN s.ScheduleEndDate IS NULL THEN 'Current' WHEN s.ScheduleEndDate IS NOT NULL THEN 'Non Current' END = @Current)
	AND (s.LastRunTime >= @LastSubscriptionDate OR @LastSubscriptionDate IS NULL)