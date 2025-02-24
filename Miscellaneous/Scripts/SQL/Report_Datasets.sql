
WITH 
[catalog_xml] 
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
	   [dbo].[Catalog] WITH(NOLOCK) 
    WHERE
	   [Type] = 2 
)
,
[data_sources] 
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
		   , [LocalDataSourceName] = [DataSourceXml].[value]('@Name', 'NVARCHAR(260)')
		   , [DataProvider] = [DataSourceXml].[value]('(*:ConnectionProperties/*:DataProvider)[1]', 'NVARCHAR(260)')
		   , [ConnectionString] = [DataSourceXml].[value]('(*:ConnectionProperties/*:ConnectString)[1]', 'NVARCHAR(MAX)')
	   FROM
		   [catalog_xml] AS [c] 
		   CROSS APPLY [ContentXml].[nodes]('/*:Report/*:DataSources/*:DataSource') AS [DataSource]([DataSourceXml])
	   WHERE [c].[Type] = 2 -- limit to reports only
    ) AS [r]
)
,
[datasets] 
AS 
(
    SELECT 
		 [ItemID]
	    , [DataSetName] = [QueryXml].[value]('@Name', 'NVARCHAR(256)')
	    , [DataSourceName] = [QueryXml].[value]('(*:Query/*:DataSourceName)[1]', 'NVARCHAR(260)')
	    , [CommandType] = [QueryXml].[value]('(*:Query/*:CommandType)[1]', 'NVARCHAR(15)')
	    , [CommandText] = [QueryXml].[value]('(*:Query/*:CommandText)[1]', 'NVARCHAR(MAX)')
	    , [report_folder]
    FROM
	    [catalog_xml]
	    CROSS APPLY [ContentXml].[nodes]('/*:Report/*:DataSets/*:DataSet') AS [QueryData]([QueryXml])
)
SELECT 
      [Name]
    , [Path]
    , [LocalDataSourceName]
    , [DataSetName]
    , [CommandType] = ISNULL([CommandType], 'Text')
    , [CommandText]
FROM
    [datasets] AS [ds]
    INNER JOIN [data_sources] AS [src] ON [src].[ItemID] = [ds].[ItemID] AND [src].[LocalDataSourceName] = [ds].[DataSourceName]
    INNER JOIN [dbo].[Catalog] AS [c] WITH(NOLOCK) ON [ds].[ItemID] = [c].[ItemID]
WHERE
    1=1
    --AND ds.[report_folder] NOT IN('Analytics')
ORDER BY 
    [Path];
