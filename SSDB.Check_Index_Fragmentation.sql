/*--------------------------------------------------------------------------------------------------------------------------------+
| Purpose:	How to Check Index Fragmentation on Indexes in a Database
| Note:		SQLCmdMode Script
+--------------------------------------------------------------------------------------------------------------------------------*/

SELECT 
	  'Schema' = dbschemas.[name]
	, 'Table' = dbtables.[name]
	, 'Index' = dbindexes.[name]
	, indexstats.avg_fragmentation_in_percent
	, indexstats.page_count
	, SqlScript = 
		CASE 
			WHEN indexstats.avg_fragmentation_in_percent > 30 THEN 'ALTER INDEX [' + dbindexes.[name] + '] ON [' + dbschemas.[name] + '].[' + dbtables.[name] + '] REBUILD  WITH (ONLINE = ON)'
			WHEN indexstats.avg_fragmentation_in_percent > 5 AND indexstats.avg_fragmentation_in_percent < 30 THEN 'ALTER INDEX [' + dbindexes.[name] + '] ON [' + dbschemas.[name] + '].[' + dbtables.[name] + '] REORGANIZE'
			ELSE NULL
		END 	
FROM 
	sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS indexstats
	INNER JOIN sys.tables dbtables on dbtables.[object_id] = indexstats.[object_id]
	INNER JOIN sys.schemas dbschemas on dbtables.[schema_id] = dbschemas.[schema_id]
	INNER JOIN sys.indexes AS dbindexes ON dbindexes.[object_id] = indexstats.[object_id] AND indexstats.index_id = dbindexes.index_id
WHERE 
	1=1
	AND indexstats.database_id = DB_ID()
	AND dbindexes.[name] IS NOT NULL
	--AND dbindexes.[name] = 'IX_IndexName'
ORDER BY 
	indexstats.avg_fragmentation_in_percent desc