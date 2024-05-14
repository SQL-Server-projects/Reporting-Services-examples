
    SELECT 
	      [Original_Report] = [prt].[Path]
	    , [Linked_Report] = [rpt].[Path]
    FROM
	    [dbo].[Catalog](NOLOCK) AS [rpt]
	    INNER JOIN [dbo].[Users](NOLOCK) AS [urm] ON [rpt].[ModifiedById] = [urm].[UserID]
	    LEFT JOIN [dbo].[Catalog](NOLOCK) AS [prt] ON [prt].[ItemID] = [rpt].[LinkSourceID] 
    WHERE
	  1 = 1
	  AND [rpt].[Type] IN(4);
