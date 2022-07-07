
DECLARE @TfsSsrsPath AS NVARCHAR(100) = '$\TFS_Project_Name\Reports\';

WITH
current_version
AS
(
    SELECT 
	     [FullPath] = REPLACE([v].[FullPath], '"', '-')
	   , [path_name] = CASE WHEN [v].[FullPath] LIKE CONCAT(@TfsSsrsPath, '%') THEN REPLACE(REPLACE(LEFT([v].[FullPath], LEN([v].[FullPath]) - CHARINDEX('\', REVERSE([v].[FullPath]), 2) + 1), @TfsSsrsPath, ''), '"', '-') END
	   , [file_name] = REPLACE(REPLACE(REPLACE(REPLACE((RIGHT([v].[FullPath], CHARINDEX('\', REVERSE([v].[FullPath]), 2) - 1)), '\', ''), '"', '-'), '>', '_'), '"', '-')
	   , [file_extention] = REPLACE(RIGHT([v].[FullPath], 5), '\', '')
	   , [v].[ItemId]
	   , [VersionFrom] = MAX(v.[VersionFrom])
    FROM 
	   [Tfs_DefaultCollection].[dbo].[tbl_Version] (NOLOCK) AS v
    WHERE 
	   1=1
	   AND [v].[FullPath] LIKE CONCAT(@TfsSsrsPath, '%')
    GROUP BY 
	     [v].[FullPath]
	   , [v].[ItemId]
)
, 
inactive_version
AS
(
    SELECT 
	   [v].[ItemId]
    FROM 
	   [Tfs_DefaultCollection].[dbo].[tbl_Version] (NOLOCK) AS v
	   INNER JOIN current_version AS cv ON [v].[ItemId] = cv.[ItemId] AND cv.[VersionFrom] = [v].[VersionFrom]
    WHERE 
	   1=1
	   AND [DeletionId] != 0 
)
SELECT 
      cv.[FullPath]
    , cv.[path_name]
    , [file_name] = LEFT(cv.[file_name], LEN(cv.[file_name]) - 4)
    , cv.[file_extention] 
    , cv.[ItemId]
    , cv.[VersionFrom]
FROM
	current_version AS cv
	LEFT JOIN inactive_version AS ov ON ov.[ItemId] = cv.[ItemId] 
WHERE 
    1=1
    AND ov.[ItemId] IS NULL
    AND cv.[file_extention] = '.rdl';
