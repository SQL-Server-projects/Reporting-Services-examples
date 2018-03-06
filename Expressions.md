|Date Format|VB Functions|.Net Functions|
|:----------|:----------|:----------|
|First Date of last month|=DateAdd(“m”, -1, DateSerial(YEAR(NOW()), MONTH(NOW()), 1))|=Today.AddDays(1- Today.Day).AddMonths(-1)|
|Last date of last month|=DateAdd(“d”, -1, DateSerial(YEAR(NOW()), MONTH(NOW()), 1))|=Today.AddDays(-1 * Today.Day)|
|First date of current month|=DateSerial(YEAR(NOW()), MONTH(NOW()), 1)|=Today.AddDays(1 – Today.Day)|
|Last date of current month|=DateAdd(“d”,-1,(DateAdd(“m”, 1, DateSerial(YEAR(NOW()), MONTH(NOW()), 1))))|=Today.AddDays(-1 * Today.Day).AddMonths(1)|
|Yesterday’s date|=DateAdd(“d”, -1, Today)|=Today.AddDays(-1)|
|Tomorrow’s date|=DateAdd(“d”, 1, Today)|=Today.AddDays(1)|
|First day of current year|=DateSerial(YEAR(NOW()), 1, 1)|=Today.AddDays(1- Today.DayOfYear)|
|Last day of current year|=DateSerial(YEAR(NOW()), 12, 31)|=Today.AddDays(-1 * Today.DayOfYear).AddYears(1)|
|Last day of current year|=DateSerial(YEAR(NOW()), 12, 31)|=Today.AddDays(-1 * Today.DayOfYear).AddYears(1|
