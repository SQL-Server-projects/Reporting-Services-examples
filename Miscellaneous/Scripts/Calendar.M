let
    //Set the following variables
    Culture = "English (United States)", //Select a culture.
    UseYesterdayAsCurrentDate = true, //true = yesterday, false = today
    YearsBack = 6, //How many years to include prior to the current year.
    YearsAhead = 6, //How many years to include after the current year.
    FyYearsBack = 2, //How many fiscal years to include prior to the current year.
    FyYearsAhead = 2, //How many fiscal years to include after the current year.
    GoToBeginning = "Year", //Options: Year, Month, None
    GoToEnd = "Year", //Options: Year, Month, None

    //Figure the Start and End Dates, based on above variables
    DateToday = DateTime.Date(DateTime.LocalNow()),
    CurrentDate = if UseYesterdayAsCurrentDate = true then Date.AddDays(DateToday, -1) else DateToday,
    YearBegin = Date.Year(CurrentDate) - YearsBack,
    MonthBegin = if GoToBeginning = "Year" then 1 else Date.Month(CurrentDate),
    DayBegin = if GoToBeginning = "None" then Date.Day(CurrentDate) else 1,
    StartDate = #date(YearBegin, MonthBegin, DayBegin), 
    YearEnd = Date.Year(CurrentDate) + YearsAhead,
    MonthEnd = if GoToEnd = "Year" then 12 else Date.Month(CurrentDate),
    DayEndTemp = if GoToEnd = "Year" then 31 else Date.Day(CurrentDate),
    EndDateTemp = #date(YearEnd, MonthEnd, DayEndTemp), 
    EndDate = if GoToEnd = "Month" then DateTime.Date(Date.EndOfMonth(EndDateTemp)) else EndDateTemp,
    DayCount = Duration.Days(Duration.From(EndDate - StartDate)) + 1,

    //Get complete list of dates, Convert to a table, update name and data type
    AllDates = List.Dates(StartDate,DayCount,#duration(1,0,0,0)),
    TableFromList = Table.FromList(AllDates, Splitter.SplitByNothing()),
    ChangedType = Table.TransformColumnTypes(TableFromList,{{"Column1", type date}}),
    RenamedColumns = Table.RenameColumns(ChangedType,{{"Column1", "Date"}}),

    //Add other attributes of the date, as desired
    InsertYear = Table.AddColumn(RenamedColumns, "Year", each Date.Year([Date])),
    InsertQuarterOfYear = Table.AddColumn(InsertYear, "Quarter Of Year", each Date.QuarterOfYear([Date])),
    InsertMonthOfYear = Table.AddColumn(InsertQuarterOfYear, "Month Of Year", each Date.Month([Date])),
    InsertDayOfMonth = Table.AddColumn(InsertMonthOfYear, "Day Of Month", each Date.Day([Date])),
    InsertDayOfWeek = Table.AddColumn(InsertDayOfMonth, "Day Of Week", each Date.DayOfWeek([Date])),
    InsertDateAlternateKey = Table.AddColumn(InsertDayOfWeek, "Date Alternate Key", each [Year] * 10000 + [Month Of Year] * 100 + [Day Of Month]),
    InsertMonthName = Table.AddColumn(InsertDateAlternateKey, "Month Name", each Date.ToText([Date], "MMMM", Culture), type text),
    InsertMonthKey = Table.AddColumn(InsertMonthName, "Month Key", each [Year] * 100 + [Month Of Year]),
    InsertMonthYear = Table.AddColumn(InsertMonthKey, "Month Year", each (try(Text.Range([Month Name],0,3)) otherwise [Month Name]) & " " & Number.ToText([Year])),
    InsertMonthStart = Table.AddColumn(InsertMonthYear, "Month Start", each Date.StartOfMonth([Date]), type date),
    InsertMonthEnd = Table.AddColumn(InsertMonthStart, "Month Ending", each Date.EndOfMonth([Date]), type date),
    InsertQuarterName = Table.AddColumn(InsertMonthEnd, "Quarter Name", each "Q" & Number.ToText([Quarter Of Year])),
    InsertQuarterKey = Table.AddColumn(InsertQuarterName, "Quarter Key", each [Year] * 100 + [Quarter Of Year]),
    InsertQuarterYear = Table.AddColumn(InsertQuarterKey, "Quarter Year", each "Q" & Number.ToText([Quarter Of Year]) & " " & Number.ToText([Year])),
    InsertDayName = Table.AddColumn(InsertQuarterYear, "Day Of Week Name", each Date.ToText([Date], "dddd", Culture), type text),
    InsertWeekEnding = Table.AddColumn(InsertDayName, "Week Ending", each Date.EndOfWeek([Date]), type date),

    //Add Relative Date Positions.
    InsertRelativeYear = Table.AddColumn(InsertWeekEnding, "Relative Year", each [Year]-Date.Year(CurrentDate)),
    InsertRelativeYearDescription = Table.AddColumn(InsertRelativeYear, "Relative Year Description", 
                                    each if [Relative Year] = 0 then "Current Year"
                                        else if [Relative Year] = -1 then "Last Year"
                                        else if [Relative Year] = 1 then "Next Year"
                                        else if [Relative Year] < -1 then Number.ToText(Number.Abs([Relative Year])) & " Years Back" 
                                        else Number.ToText([Relative Year]) & " Years Ahead"),
    InsertRelativeQuarter = Table.AddColumn(InsertRelativeYearDescription, "Relative Quarter", 
                                    each 4*([Year]-Date.Year(CurrentDate)) + ([Quarter Of Year]-Date.QuarterOfYear(CurrentDate))),
    InsertRelativeQuarterDescription = Table.AddColumn(InsertRelativeQuarter, "Relative Quarter Description", 
                                    each if [Relative Quarter] = 0 then "Current Quarter"
                                        else if [Relative Quarter] = -1 then "Last Quarter"
                                        else if [Relative Quarter] = 1 then "Next Quarter"
                                        else if [Relative Quarter] < -1 then Number.ToText(Number.Abs([Relative Quarter])) & " Quarters Back" 
                                        else Number.ToText([Relative Quarter]) & " Quarters Ahead"),
    InsertRelativeMonth = Table.AddColumn(InsertRelativeQuarterDescription, "Relative Month", 
                                    each 12*([Year]-Date.Year(CurrentDate)) + ([Month Of Year]-Date.Month(CurrentDate))),
    InsertRelativeMonthDescription = Table.AddColumn(InsertRelativeMonth, "Relative Month Description", 
                                    each if [Relative Month] = 0 then "Current Month"
                                        else if [Relative Month] = -1 then "Last Month"
                                        else if [Relative Month] = 1 then "Next Month"
                                        else if [Relative Month] < -1 then Number.ToText(Number.Abs([Relative Month])) & " Months Back" 
                                        else Number.ToText([Relative Month]) & " Months Ahead"),
    InsertRelativeWeek = Table.AddColumn(InsertRelativeMonthDescription, "Relative Week", 
                                    each Duration.Days(Duration.From([Week Ending]-Date.EndOfWeek(CurrentDate)))/7),
    InsertRelativeWeekDescription = Table.AddColumn(InsertRelativeWeek, "Relative Week Description", 
                                    each if [Relative Week] = 0 then "Current Week"
                                        else if [Relative Week] = -1 then "Last Week"
                                        else if [Relative Week] = 1 then "Next Week"
                                        else if [Relative Week] < -1 then Number.ToText(Number.Abs([Relative Week])) & " Weeks Back" 
                                        else Number.ToText([Relative Week]) & " Weeks Ahead"),
    InsertRelativeDay = Table.AddColumn(InsertRelativeWeekDescription, "Relative Day", 
                                    each Duration.Days(Duration.From([Date]-CurrentDate))),
    InsertRelativeDayDescription = Table.AddColumn(InsertRelativeDay, "Relative Day Description", 
                                    each if [Relative Day] = 0 then "Current Day"
                                        else if [Relative Day] = -1 then "Last Day"
                                        else if [Relative Day] = 1 then "Next Day"
                                        else if [Relative Day] < -1 then Number.ToText(Number.Abs([Relative Day])) & " Days Back" 
                                        else Number.ToText([Relative Day]) & " Days Ahead"),

    //Add Date Category Positions.
    InsertYearGroup = Table.AddColumn(InsertRelativeDayDescription, "Year Group", 
                                    each if [Relative Year] = 0 then "Current Year"
                                        else if [Relative Year] < 0 then "Past Years"
                                        else "Future Years"),
    InsertQuarterGroup = Table.AddColumn(InsertYearGroup, "Quarter Group", 
                                    each if [Relative Quarter] = 0 then "Current Quarter"
                                        else if [Relative Quarter] < 0 then "Past Quarters"
                                        else "Future Quarters"),
    InsertMonthGroup = Table.AddColumn(InsertQuarterGroup, "Month Group", 
                                    each if [Relative Month] = 0 then "Current Month"
                                        else if [Relative Month] < 0 then "Past Months"
                                        else "Future Months"),
    InsertWeekGroup = Table.AddColumn(InsertMonthGroup, "Week Group", 
                                    each if [Relative Week] = 0 then "Current Week"
                                        else if [Relative Week] < 0 then "Past Weeks"
                                        else "Future Weeks"),
    InsertDayGroup = Table.AddColumn(InsertWeekGroup, "Day Group", 
                                    each if [Relative Day] = 0 then "Current Day"
                                        else if [Relative Day] < 0 then "Past Days"
                                        else "Future Days"),
    ChangedType2 = Table.TransformColumnTypes(InsertDayGroup,{{"Year", Int64.Type}, {"Quarter Of Year", Int64.Type}, {"Month Of Year", Int64.Type}, {"Day Of Month", Int64.Type}, {"Day Of Week", Int64.Type}, {"Date Alternate Key", Int64.Type}, {"Quarter Name", type text}, {"Month Year", type text}, {"Quarter Year", type text}, {"Relative Year Description", type text}, {"Relative Quarter Description", type text}, {"Relative Month Description", type text}, {"Relative Week Description", type text}, {"Relative Day Description", type text}, {"Year Group", type text}, {"Quarter Group", type text}, {"Month Group", type text}, {"Week Group", type text}, {"Day Group", type text}, {"Relative Day", Int64.Type}, {"Relative Week", Int64.Type}, {"Relative Month", Int64.Type}, {"Relative Quarter", Int64.Type}, {"Relative Year", Int64.Type}, {"Quarter Key", Int64.Type}, {"Month Key", Int64.Type}}),
    
    //Add Fiscal Periods

    InsertFiscalYear = Table.AddColumn(ChangedType2, "Fiscal Year", each Date.ToText(Date.AddMonths([Date], 6), "yyyy")),
    InsertPeriod = Table.AddColumn(InsertFiscalYear, "Period", each Date.ToText(Date.AddMonths([Date], 6), "yyyyMM")),
    InsertPeriodFyStart = Table.AddColumn(InsertPeriod, "Fiscal Year Period Start", each Date.ToText(Date.AddMonths([Date], 6), "yyyy01")),
    InsertPeriodFyEnd = Table.AddColumn(InsertPeriodFyStart, "Fiscal Year Period End", each Date.ToText(Date.AddMonths([Date], 6), "yyyy12")),
    InsertFiscalYearQuarterOfYear = Table.AddColumn(InsertPeriodFyEnd, "Fiscal Year Quarter", each Date.QuarterOfYear(Date.AddMonths([Date], 6)))
in
    InsertFiscalYearQuarterOfYear