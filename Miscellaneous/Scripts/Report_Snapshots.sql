CREATE PROCEDURE [admin].[report_snapshots]
(
      @ReportName AS NVARCHAR(50) = NULL
    , @ReportFormat AS NVARCHAR(50) = 'EXCELOPENXML'
)
AS

BEGIN

    --EXEC [admin].[report_snapshots] @ReportName = 'Report Name Here', @ReportFormat = 'EXCELOPENXML' --current version of Excel
    --EXEC [admin].[report_snapshots] @ReportName = 'Report Name Here', @ReportFormat = 'PDF'
    --EXEC [admin].[report_snapshots] @ReportName = NULL, @ReportFormat = 'PDF' --all snapshots for every report

    SELECT 
		[ReportName] = c.[Name]
	   , [SnaphsotDate] = FORMAT([h].[snapshotdate], 'dd-MMM-yyyy')
	   , [FileName] = FORMAT([h].[snapshotdate], 'yyyyMMdd')
	   , [Url_Download] = 'http://' + @@SERVERNAME + '/ReportServer/Pages/ReportViewer.aspx?' + [c].[path] + '&rs:Command=Render&rs:Format=' + @ReportFormat + '&rs:Snapshot=' + FORMAT([h].[snapshotdate], 'yyyy-MM-ddTHH:mm:ss')
	   , [Url_Open] = 'http://' + @@SERVERNAME + '/Reports/report' + [c].[path] + '?rs:Snapshot=' + FORMAT([h].[snapshotdate], 'yyyy-MM-ddTHH:mm:ss')
	   --, [SnapshotDescription] = [s].[DESCRIPTION]
	   --, [SnapshotEffectiveParams] = [s].[effectiveparams]
	   --, [SnapshotQueryParams] = [s].[queryparams]
	   --, [ScheduleName] = [sc].[name] 
	   --, [ScheduleNextRunTime] = [sc].[nextruntime]
    FROM
	    [ReportServer].[dbo].[History] AS [h] (NOLOCK)
	    INNER JOIN [ReportServer].[dbo].[SnapshotData] AS [s] (NOLOCK) ON [h].[snapshotdataid] = [s].[snapshotdataid]
	    INNER JOIN [ReportServer].[dbo].[Catalog] AS [c] (NOLOCK) ON [c].[itemid] = [h].[reportid]
	    INNER JOIN [ReportServer].[dbo].[ReportSchedule] AS [rs] (NOLOCK) ON [rs].[reportid] = [h].[reportid]
	    INNER JOIN [ReportServer].[dbo].[Schedule] AS [sc] (NOLOCK) ON [sc].[scheduleid] = [rs].[scheduleid]
    WHERE
	  1=1
	  AND [rs].[reportaction] = 2 -- Create schedule
	  AND (@ReportName IS NULL OR [c].[Name] = @ReportName)
    ORDER BY 
	     [c].[name]
	   , [h].[snapshotdate];

END

GO
