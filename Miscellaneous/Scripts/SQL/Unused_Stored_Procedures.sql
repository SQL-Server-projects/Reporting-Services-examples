USE [YourDataWarehouse]
GO

CREATE PROCEDURE [admin].[Unused_Stored_Procedures]
AS
BEGIN

    DROP TABLE IF EXISTS [#pbirs_report_datasets];
    DROP TABLE IF EXISTS [#false_positives];

    SELECT tbl.* INTO #false_positives FROM (VALUES
      ( 'dbo.KeepThisStoredProcedure1')
    , ( 'dbo.KeepThisStoredProcedure2')
    , ( 'report.KeepThisStoredProcedure1')
    , ( 'report.KeepThisStoredProcedure2')
    ) tbl ([StoredProcedureName]);

    WITH 
    catalog_xml 
    AS 
    (
	   SELECT 
			*
		  , [report_folder] =
			 CASE
				WHEN [Path] = '/' + [Name] THEN ''
				ELSE SUBSTRING([Path], 2, LEN([Path])-LEN([Name])-2)
			 END
		   , [ContentXml] = (CONVERT(XML, CONVERT(VARBINARY(MAX), [Content])))
	   FROM 
		  [ReportServer].[dbo].[Catalog] WITH(NOLOCK) 
	   WHERE
		  [Type] = 2 
    )
    ,
    data_sources 
    AS 
    (
	   SELECT 
			[r].[ItemID]
		   , [r].[LocalDataSourceName] 
		   , [DataProvider] = [r].[DataProvider]
		   , [ConnectionString] = [r].[ConnectionString]
	   FROM
	   (
		  SELECT 
			    [c].*
			  , [LocalDataSourceName] = [DataSourceXml].value('@Name', 'NVARCHAR(260)')
			  , [DataProvider] = [DataSourceXml].value('(*:ConnectionProperties/*:DataProvider)[1]', 'NVARCHAR(260)')
			  , [ConnectionString] = [DataSourceXml].value('(*:ConnectionProperties/*:ConnectString)[1]', 'NVARCHAR(MAX)')
		  FROM
			  catalog_xml AS [c] 
			  CROSS APPLY [ContentXml].[nodes]('/*:Report/*:DataSources/*:DataSource') AS [DataSource]([DataSourceXml])
		  WHERE [c].[Type] = 2 -- limit to reports only
	   ) AS [r]
    )
    ,
    datasets 
    AS 
    (
	   SELECT 
			[ItemID]
		   , [DataSetName] = [QueryXml].value('@Name', 'NVARCHAR(256)')
		   , [DataSourceName] = [QueryXml].value('(*:Query/*:DataSourceName)[1]', 'NVARCHAR(260)')
		   , [CommandType] = [QueryXml].value('(*:Query/*:CommandType)[1]', 'NVARCHAR(15)')
		   , [CommandText] = [QueryXml].value('(*:Query/*:CommandText)[1]', 'NVARCHAR(MAX)')
		   , [report_folder]
	   FROM
		   catalog_xml
		   CROSS APPLY [ContentXml].[nodes]('/*:Report/*:DataSets/*:DataSet') AS [QueryData]([QueryXml])
    )
    SELECT 
		[Name]
	   , [Path]
	   , [LocalDataSourceName]
	   , [DataSetName]
	   , [CommandType] = ISNULL([CommandType], 'Text')
	   , [CommandText]
    INTO [#pbirs_report_datasets]
    FROM
	   datasets AS [ds]
	   INNER JOIN data_sources AS [src] ON [src].[ItemID] = [ds].[ItemID] AND [src].[LocalDataSourceName] = [ds].[DataSourceName]
	   INNER JOIN [ReportServer].[dbo].[Catalog] AS [c] WITH(NOLOCK) ON [ds].[ItemID] = [c].[ItemID];

    WITH
    report_stored_procedures
    AS
    (
	   SELECT DISTINCT 
		  [StoredProcedureName] = CASE WHEN [CommandText] LIKE 'report.%' THEN [CommandText] ELSE 'dbo.' + [CommandText] END
	   FROM 
		  [#pbirs_report_datasets]
	   WHERE
		  1 = 1
		  AND [CommandType] = 'StoredProcedure'
		  AND [LocalDataSourceName] IN('REPORT_DATA_SOURCE1', 'REPORT_DATA_SOURCE2')
    )
    , 
    database_stored_procedures
    AS
    (
	   SELECT 
			[SPECIFIC_SCHEMA]
		   , [SPECIFIC_NAME]
		   , [StoredProcedureName] = [SPECIFIC_SCHEMA] + '.' + [SPECIFIC_NAME]
		   , [CreateDate] = [CREATED]
		   , [ModifiedDate] = [LAST_ALTERED]
	   FROM [INFORMATION_SCHEMA].[ROUTINES]
	   WHERE 
		  1=1
		  AND [ROUTINE_TYPE] = 'PROCEDURE'
		  AND 
			 (
				([SPECIFIC_SCHEMA] = 'dbo' AND [SPECIFIC_NAME] LIKE '%_report_%')
				OR
				([SPECIFIC_SCHEMA] = 'report')
			 )
    )
    SELECT 
	     [dsp].[StoredProcedureName]
	   , [dsp].[CreateDate]
	   , [dsp].[ModifiedDate]
    FROM
	    [database_stored_procedures] AS [dsp]
	    LEFT JOIN [report_stored_procedures] AS [rsp] ON [dsp].[StoredProcedureName] = [rsp].[StoredProcedureName]
	    LEFT JOIN [#false_positives] AS fp ON [dsp].[StoredProcedureName] = [fp].[StoredProcedureName]
    WHERE
	   1=1
	   AND [dsp].[StoredProcedureName] NOT LIKE '%zzz%'
	   --AND [dsp].[StoredProcedureName] LIKE '%zzz%'
	   AND [rsp].[StoredProcedureName] IS NULL
	   AND [fp].[StoredProcedureName] IS NULL
    ORDER BY 1;

    DROP TABLE IF EXISTS [#pbirs_report_datasets];
    DROP TABLE IF EXISTS [#false_positives];

END

GO