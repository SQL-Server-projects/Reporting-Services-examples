
WITH 
content_binaries
AS 
(
    SELECT 
	     cat.[ItemID]
	   , cat.[Name]
	   , cat.[Path]
	   , cat.[Type]
	   , [TypeDescription] = 
		  CASE cat.[Type]
			 WHEN 2 THEN 'Report'
			 WHEN 5 THEN 'Data Source'
			 WHEN 7 THEN 'Report Part'
			 WHEN 8 THEN 'Shared Dataset'
			 ELSE 'Other'
		  END  
	   , [Content] = CONVERT(VARBINARY(MAX), cat.[Content])
    FROM 
	   [dbo].[Catalog] AS cat
    WHERE 
	   1=1
	   AND cat.[Content] IS NOT NULL
	   AND cat.[Type] = 2 
)
,
content_binaries_format
AS 
(
    SELECT 
	     bin.[ItemID]
	   , bin.[Name]
	   , bin.[Path]
	   , bin.[Type]
	   , bin.[TypeDescription]
	   , [Content] = --strip off the BOM if it exist
		  CASE
			 WHEN LEFT(bin.[Content], 3) = 0xEFBBBF THEN CONVERT(VARBINARY(MAX), SUBSTRING(bin.[Content], 4, LEN(bin.[Content])))
			 ELSE bin.[Content]
		  END  
    FROM 
	   content_binaries AS bin
)
SELECT 
	 cbf.[ItemID]
    , cbf.[Name]
    , cbf.[Path]
    , cbf.[Type]
    , cbf.[TypeDescription]
    , cbf.[Content] 
    , [ContentVarchar] = CONVERT(VARCHAR(MAX), cbf.[Content]) 
    , [ContentXML] = CONVERT(XML, cbf.[Content]) 
FROM 
    content_binaries_format AS cbf
WHERE
    1=1
    AND CONVERT(VARCHAR(MAX), cbf.[Content]) LIKE '%<subreport%';