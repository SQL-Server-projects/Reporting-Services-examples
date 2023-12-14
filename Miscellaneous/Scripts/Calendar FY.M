let
    //Set the following variables
    Culture = "English (United States)", //Select a culture.

    //Figure the Start and End Dates, based on above variables
    CurrentDate = DateTime.Date(DateTime.LocalNow()),
	CurrentYear = Date.Year(CurrentDate),
    PreviousYear = Date.Year(CurrentDate) - 2,
	StartDate = if CurrentDate < #date(PreviousYear, 7, 1 ) then #date(PreviousYear - 1, 7, 1 ) else #date(PreviousYear, 7, 1 ),
	EndDate = if CurrentDate > #date(CurrentYear, 6, 30 ) then #date(CurrentYear + 1, 6, 30 ) else #date(CurrentYear, 6, 30 ),
    DayCount = Duration.Days(Duration.From(EndDate - StartDate)) + 1,

    //Get complete list of dates, Convert to a table, update name and data type
    AllDates = List.Dates(StartDate, DayCount, #duration(1,0,0,0)),
    TableFromList = Table.FromList(AllDates, Splitter.SplitByNothing()),
    ChangedType = Table.TransformColumnTypes(TableFromList,{{"Column1", type date}}),
    RenamedColumns = Table.RenameColumns(ChangedType, {{"Column1", "Date"}}),

    //Add Fiscal Time Groups
    InsertFiscalYear = Table.AddColumn(RenamedColumns, "Fiscal Year", each Date.ToText(Date.AddMonths([Date], 6), "yyyy")),
    InsertNextFiscalYear = Table.AddColumn(InsertFiscalYear, "Next Fiscal Year", each Date.ToText(Date.AddMonths([Date], 18), "yyyy")),
    InsertPeriod = Table.AddColumn(InsertNextFiscalYear, "Period", each Date.ToText(Date.AddMonths([Date], 6), "yyyyMM")),
    InsertNextFYPeriod = Table.AddColumn(InsertPeriod, "Next FY Period", each Date.ToText(Date.AddMonths([Date], 18), "yyyyMM")),
    InsertPeriodFyStart = Table.AddColumn(InsertNextFYPeriod, "Fiscal Year Period Start", each Date.ToText(Date.AddMonths([Date], 6), "yyyy01")),
    InsertPeriodFyEnd = Table.AddColumn(InsertPeriodFyStart, "Fiscal Year Period End", each Date.ToText(Date.AddMonths([Date], 6), "yyyy12")),
    InsertFiscalYearQuarterOfYear = Table.AddColumn(InsertPeriodFyEnd, "Fiscal Year Quarter Nbr", each Date.QuarterOfYear(Date.AddMonths([Date], 6))),
    InsertNextFiscalYearQuarterOfYear = Table.AddColumn(InsertFiscalYearQuarterOfYear, "Next Fiscal Year Quarter Nbr", each Date.QuarterOfYear(Date.AddMonths([Date], 18))),
    InsertStartOfMonth = Table.AddColumn(InsertNextFiscalYearQuarterOfYear, "Start of Month", each Date.StartOfMonth([Date])),
    InsertNextFYStartOfMonth = Table.AddColumn(InsertStartOfMonth, "Next FY Start of Month", each Date.StartOfMonth(Date.AddMonths([Date], 12))),
    InsertWeekEnding = Table.AddColumn(InsertNextFYStartOfMonth, "Week Ending", each Date.EndOfWeek([Date])),
    InsertFYQtr = Table.AddColumn(InsertWeekEnding, "Fiscal Year Quarter", each "FY" & Text.Combine({Text.From([Fiscal Year]), Text.From([Fiscal Year Quarter Nbr], "en-AU")}, " Q"), type text),
    InsertNextFYQtr = Table.AddColumn(InsertFYQtr, "Next Fiscal Year Quarter", each "FY" & Text.Combine({[Next Fiscal Year], Text.From([Next Fiscal Year Quarter Nbr], "en-AU")}, " Q"), type text),
    InsertIsFuture = Table.AddColumn(InsertNextFYQtr, "Is Future", each if [Date] > CurrentDate then 1 else 0),
    InsertIsCurrentFY = Table.AddColumn(InsertIsFuture, "Is Current FY", each if [Fiscal Year] = Date.ToText(Date.AddMonths(CurrentDate, 6), "yyyy") then 1 else 0),
    #"Filtered Rows" = Table.SelectRows(InsertIsCurrentFY, each true),
    #"Changed Type" = Table.TransformColumnTypes(#"Filtered Rows",{{"Start of Month", type date}, {"Next FY Start of Month", type date}, {"Week Ending", type date}})
in
    #"Changed Type"