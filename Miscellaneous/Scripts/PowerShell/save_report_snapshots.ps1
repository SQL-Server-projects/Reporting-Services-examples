    <#
        Description:	Save SSRS Report Snapshots

    #>

    $sql = "
        DECLARE @ReportName	   NVARCHAR(200) = 'Daily Report';
        DECLARE @FileFormat	   NVARCHAR(50) = 'CSV'; --HTML5,PPTX,ATOM,HTML4.0,MHTML,IMAGE,EXCEL (for .xls),EXCELOPENXML (for .xlsx),WORD (for .doc),WORDOPENXML (for .docx),CSV,PDF,XML
        DECLARE @FileExtn	   NVARCHAR(50) = 'csv'; 
        DECLARE @ServerName	   NVARCHAR(100) = 'https://REPORTS';
        DECLARE @DateFrom	   DATE = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE); --change to NULL for every snapshot
        DECLARE @ExportPath	   NVARCHAR(200) = 'C:\Temp\';

        SELECT 
		    --[ReportID] = [c].[itemid]  
	     --  , [ReportName] = [c].[name]  
	     --  , [ReportPath] = [c].[path]  
	     --  , [SnaphsotDate] = FORMAT([h].[snapshotdate], 'dd-MMM-yyyy')
	     --  , [SnapshotDescription] = [s].[DESCRIPTION]  
	     --  , [SnapshotEffectiveParams] = [s].[effectiveparams]
	     --  , [SnapshotQueryParams] = [s].[queryparams]
	     --  , [ScheduleName] = [sc].[name] 
	     --  , [ScheduleNextRunTime] = CONVERT(VARCHAR(20), [sc].[nextruntime], 113) 
	         [ExportFileName] = @ExportPath + REPLACE([c].[name], ' ', '_') + '_' + FORMAT([h].[snapshotdate], 'yyyyMMdd_HHmm') + '.' + @FileExtn
	       , [SnapshotUrl] = 
		        @ServerName 
		      + '/ReportServer/Pages/ReportViewer.aspx?' 
		      + [c].[path] + '&rs:Command=Render&rs:Format=' 
		      + @FileFormat + '&rs:Snapshot=' 
		      + FORMAT([h].[snapshotdate], 'yyyy-MM-ddTHH:mm:ss')
        FROM
	        [ReportServer].[dbo].[History] AS [h] WITH(NOLOCK)
	        INNER JOIN [ReportServer].[dbo].[SnapshotData] AS [s] WITH(NOLOCK) ON [h].[snapshotdataid] = [s].[snapshotdataid]
	        INNER JOIN [ReportServer].[dbo].[Catalog] AS [c] WITH(NOLOCK) ON [c].[itemid] = [h].[reportid]
	        INNER JOIN [ReportServer].[dbo].[ReportSchedule] AS [rs] WITH(NOLOCK) ON [rs].[reportid] = [h].[reportid]
	        INNER JOIN [ReportServer].[dbo].[Schedule] AS [sc] WITH(NOLOCK) ON [sc].[scheduleid] = [rs].[scheduleid]
        WHERE
	       1=1
	       AND [rs].[reportaction] = 2 
	       AND [c].[Name] = @ReportName
	       AND (@DateFrom IS NULL OR [h].[snapshotdate] >= CAST(DATEADD(DAY, -1, GETDATE()) AS DATE))
        ORDER BY 
	         [c].[name]
	       , [h].[snapshotdate];
						    ;"

        $server = 'REPORTS'; 
	    $dbs = 'MASTER';
        $dsn = "Data Source=$server; Initial Catalog=$dbs; Integrated Security=SSPI;"; 
        $cn = New-Object System.Data.SqlClient.SqlConnection($dsn); 

	    #execute merge statement here with parameters
	    $cn = New-Object System.Data.SqlClient.SqlConnection($dsn);
	    $cn.Open(); 

        $cmd = $cn.CreateCommand();
        $cmd.CommandText = $sql
        $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
        $SqlAdapter.SelectCommand = $cmd
        $cmd.Connection = $cn
        $ds = New-Object System.Data.DataSet
        $SqlAdapter.Fill($ds)
        $cn.Close()
        $Result = $ds.Tables[0]
        #$Result

        Foreach ($item in $Result) 
        {
            #Write-Host $item.name

            $SnapshotUrl = $item.SnapshotUrl
            $ExportFileName = $item.ExportFileName
            (Invoke-WebRequest -Uri $SnapshotUrl -OutFile $ExportFileName -UseDefaultCredentials -TimeoutSec 240);
        }
