<kbd><img align="left" src="Images/PBIRS1.png" width="250px" ></kbd>

# Microsoft Report Server (SSRS & PBIRS)

<!---[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/AnthonyDuguid/1.00)--->
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE "MIT License Copyright © Anthony Duguid")
[![Latest Release](https://img.shields.io/github/release/SQL-Server-projects/Reporting-Services-examples.svg?label=latest%20release)](https://github.com/SQL-Server-projects/Reporting-Services-examples/releases)
[![Github commits (since latest release)](https://img.shields.io/github/commits-since/SQL-Server-projects/Reporting-Services-examples/latest.svg)](https://github.com/SQL-Server-projects/Reporting-Services-examples)
![Microsoft Power BI Report Server](https://img.shields.io/badge/SSRS-16.0.1114.11.48-red.svg)
![Microsoft Power BI Report Server](https://img.shields.io/badge/PBIRS-15.0.1112.48-red.svg)

The following examples are used to query the database & report server. I have included some useful scripts and documents as well.
<!---
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE "MIT License Copyright © 2017 Anthony Duguid")
[![star this repo](http://githubbadges.com/star.svg?user=aduguid&repo=SqlServerReportingServices&style=flat&color=fff&background=007ec6)](http://github.com/aduguid/SqlServerReportingServices)
[![fork this repo](http://githubbadges.com/fork.svg?user=aduguid&repo=SqlServerReportingServices&style=flat&color=fff&background=007ec6)](http://github.com/aduguid/SqlServerReportingServices/fork)
--->

<kbd>
<b>Installs</b>
                <br>
                <br>
    <a href="https://powerbi.microsoft.com/en-au/report-server/">Microsoft Power BI Report Server</a>
                <br>
                <br>
    <a href="https://www.microsoft.com/en-us/download/details.aspx?id=104502)">Microsoft SQL Server 2022 Reporting Services</a>
                <br>
                <br>
    <a href="https://www.microsoft.com/en-us/download/details.aspx?id=100122">Microsoft SQL Server 2019 Reporting Services</a>
                <br>
                <br>
    <a href="https://visualstudio.microsoft.com/vs/">Microsoft Visual Studio</a>
                <br>
                <br>
    <a href="https://marketplace.visualstudio.com/items?itemName=ProBITools.MicrosoftReportProjectsforVisualStudio2022">Microsoft Reporting Services Projects 2022</a>
                <br>
                <br>
    <a href="https://notepad-plus-plus.org/downloads/">Notepad++</a>
</kbd>
            
<a id="user-content-ssrs-reports" class="anchor" href="#ssrs-reports" aria-hidden="true"> </a>
<table style="width:100%">
    <tr valign="top">
        <td width="33%">
            <kbd>
                <a href="https://raw.githubusercontent.com/aduguid/SqlServerReportingServices/master/ServerReports/Report%20List.rdl">Report Listing</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/aduguid/SqlServerReportingServices/master/Images/ReadMe/report_list.png" align="top" width="256px" title="Report Listing" />
                <br>
                <br>
                <span style="max-width:256px;">This report is used for querying the deployed reports, their subscriptions and their execution logs.</span>
                <br>
            </kbd>
        </td>
        <td width="33%">
            <kbd>
                <a href="https://raw.githubusercontent.com/aduguid/SqlServerReportingServices/master/ServerReports/Subscriptions.rdl">Report Subscriptions</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/aduguid/SqlServerReportingServices/master/Images/ReadMe/subscriptions.png" align="top" width="256px" title="Report Subscriptions" />
                <br>
                <br>
                <span style="max-width:256px;">This report is used for querying the deployed subscriptions.</span>
                <br>
            </kbd>
        </td>
        <td width="33%">
            <kbd>
                <a href="https://github.com/aduguid/SqlServerReportingServices/blob/master/ServerReports/Execution%20Log.rdl">Report Execution Log</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/aduguid/SqlServerReportingServices/master/Images/ReadMe/execution_log.png" align="top" width="256px" title="Report Execution Log" />
                <br>
                <br>
                <span style="max-width:256px;">This report is used for querying the report server exection log table.</span>
                <br>
            </kbd>
        </td>
    </tr>
    <tr valign="top">
        <td width="33%">
            <kbd>
                <a href="https://gist.githubusercontent.com/aduguid/4905cd812ef2c86ad3d026be852c62ad/raw/deff6b7cd79f2b729aa31e62795cfa32956cf4f3/SSRS.heatmap_example">Heat Map Calendar</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/SQL-Server-projects/Reporting-Services-examples/master/Images/ReadMe/ssrsheatmap_calendar.png" align="top" width="256px" title="Heat Map Calendar" />
                <br>
                <br>
                <span style="max-width:256px;">The report uses a nested tablix inside of a matrix to show a calendar view. The heat map is implemented using a function with a report variable for the base color to produce a gradients of the color. Each day on the calendar can be hyperlinked to a detailed Reporting Services report.</span>
                <br>
            </kbd>
        </td>
    </tr>
</table>

<kbd>

## File List
#### [Reports](/ServerReports)
* [Activity Monitor](/ServerReports/Activity%20Monitor.rdl)
* [Data Sources](/ServerReports/Data%20Sources.rdl)
* [Database Dictionary](/ServerReports/Database%20Dictionary.rdl)
* [Execution Log](/ServerReports/Execution%20Log.rdl)
* [Heat Map Calendar](/ServerReports/Heatmap%20Calendar.rdl) (using execution log)
* [Integrations](/ServerReports/Integrations.rdl)
* [Job Search](/ServerReports/Job%20Search.rdl)
* [Permissions](/ServerReports/Permissions.rdl)
* [Scheduled Jobs](/ServerReports/Scheduled%20Jobs.rdl) 
* [Report List](/ServerReports/Report%20List.rdl) 
* [Subscriptions](/ServerReports/Subscriptions.rdl) 
#### [Documentation](/Miscellaneous/Documentation)
* [Report Requirements](/Miscellaneous/Documentation/Report%20Requirements.docx)
* [Report Style Guide](/Miscellaneous/Documentation/Report%20Style%20Guide.docx)
* [Report Unit Testing Checklist](/Miscellaneous/Documentation/Report%20Unit%20Testing%20Checklist.docx)
#### [Scripts](/Miscellaneous/Scripts)
##### [RSS Scripts](/Miscellaneous/Scripts/RSS)
* [Apply Standard Header and Footer](/Miscellaneous/Scripts/RSS/Apply_Header_Footer.rss)
* [Backup Reports](/Miscellaneous/Scripts/RSS/Backup_Reports.rss)
* [Deploy Reports](/Miscellaneous/Scripts/RSS/Deploy_Reports.rss)
##### [VB Scripts](/Miscellaneous/Scripts/VB)
* [Candy Stripe](/Miscellaneous/Scripts/VB/CandyStripe.vb)
* [Copy Nodes](/Miscellaneous/Scripts/VB/CopyNodes.vb)
* [Get Parameter and Values](/Miscellaneous/Scripts/VB/GetParameterandValues.vb)
* [Heat Map Color](/Miscellaneous/Scripts/VB/HeatMapColor.vb)
* [Heat Map Color Gradate](/Miscellaneous/Scripts/VB/HeatMapColorGradate.vb)
##### [SQL Scripts](/Miscellaneous/Scripts/SQL)
* [Report_Datasets](/Miscellaneous/Scripts/SQL/Report_Datasets.sql)
* [Report_Linked](/Miscellaneous/Scripts/SQL/Report_Linked.sql)
* [Report_Snapshots](/Miscellaneous/Scripts/SQL/Report_Snapshots.sql)
* [Report_Subreports](/Miscellaneous/Scripts/SQL/Report_Subreports.sql)
* [Source_Control_Current](/Miscellaneous/Scripts/SQL/Source_Control_Current.sql)
* [Update Subscription Owner](/Miscellaneous/Scripts/SQL/Update_Subscription_Owner.sql)
##### [M Scripts](/Miscellaneous/Scripts/M)
* [Calendar](/Miscellaneous/Scripts/M/Calendar.M)
* [Calendar FY](/Miscellaneous/Scripts/M/Calendar_FY.M)
##### [DAX Scripts](/Miscellaneous/Scripts/DAX)
* [Calendar Ageing](/Miscellaneous/Scripts/DAX/Calendar_Ageing.dax) 
* [Calendar Timeframe](/Miscellaneous/Scripts/DAX/Calendar_Timeframe.dax) 

</kbd>
