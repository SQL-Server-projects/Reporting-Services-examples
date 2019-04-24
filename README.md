<img align="left" src="Images/ReadMe/App.png" width="64px" >

# Microsoft SQL Server Reporting Services (SSRS)

<!---[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/AnthonyDuguid/1.00)--->
[![Join the chat at https://gitter.im/SqlServerReportingServices](https://badges.gitter.im/SqlServerReportingServices/Lobby.svg)](https://gitter.im/SqlServerReportingServices?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE "MIT License Copyright © Anthony Duguid")
[![Latest Release](https://img.shields.io/github/release/SQL-Server-projects/Reporting-Services-examples.svg?label=latest%20release)](https://github.com/SQL-Server-projects/Reporting-Services-examples/releases)
[![Github commits (since latest release)](https://img.shields.io/github/commits-since/SQL-Server-projects/Reporting-Services-examples/latest.svg)](https://github.com/SQL-Server-projects/Reporting-Services-examples)
![current_build 2016](https://img.shields.io/badge/current_build-2016-red.svg)

The following examples are used to query the database & report server. I have included some useful scripts and documents as well.
<!---
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE "MIT License Copyright © 2017 Anthony Duguid")
[![star this repo](http://githubbadges.com/star.svg?user=aduguid&repo=SqlServerReportingServices&style=flat&color=fff&background=007ec6)](http://github.com/aduguid/SqlServerReportingServices)
[![fork this repo](http://githubbadges.com/fork.svg?user=aduguid&repo=SqlServerReportingServices&style=flat&color=fff&background=007ec6)](http://github.com/aduguid/SqlServerReportingServices/fork)
--->
## File List
### [Miscellaneous](/Miscellaneous)
#### [Documentation](/Miscellaneous/Documentation)
* [Report Requirements](/Miscellaneous/Documentation/Report%20Requirements.docx)
* [Report Style Guide](/Miscellaneous/Documentation/Report%20Style%20Guide.docx)
* [Report Unit Testing Checklist](/Miscellaneous/Documentation/Report%20Unit%20Testing%20Checklist.docx)
#### [Scripts](/Miscellaneous/Scripts)
* [Apply Standard Header and Footer](/Miscellaneous/Scripts/Apply_Header_Footer.rss.vb)
* [Backup Deployed Reports](/Miscellaneous/Scripts/Backup_Reports.rss.vb)
* [Candy Stripe](/Miscellaneous/Scripts/CandyStripe.vb)
* [Heat Map Color](/Miscellaneous/Scripts/HeatMapColor.vb)
* [Heat Map Color Gradate](/Miscellaneous/Scripts/HeatMapColorGradate.vb)
* [Update Subscription Owner](/Miscellaneous/Scripts/UpdateSubscriptionOwner.sql)
### Reports
#### [Database Server](/ServerDatabase)
* [Activity Monitor](/ServerDatabase/Activity%20Monitor.rdl)
* [Database Dictionary](/ServerDatabase/Database%20Dictionary.rdl)
* [Job Search](/ServerDatabase/Job%20Search.rdl)
* [Scheduled Jobs](/ServerDatabase/Scheduled%20Jobs.rdl) 
#### [Report Server](/ServerReports)
* [Data Sources](/ServerReports/Data%20Sources.rdl)
* [Execution Log](/ServerReports/Execution%20Log.rdl)
* [Heat Map Calendar](/ServerReports/Heatmap%20Calendar.rdl) (using execution log) 
* [Permissions](/ServerReports/Permissions.rdl)
* [Report Documentation](/ServerReports/Report%20Documentation.rdl)  
* [Report List](/ServerReports/Report%20List.rdl) 
* [Subscriptions](/ServerReports/Subscriptions.rdl) 


<a id="user-content-ssrs-reports" class="anchor" href="#ssrs-reports" aria-hidden="true"> </a>
<table style="width:100%">
    <tr valign="top">
        <td width="33%">
            <kbd>
                <a href="https://raw.githubusercontent.com/aduguid/SqlServerReportingServices/master/ServerDatabase/Database%20Dictionary.rdl">Data Dictionary</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/aduguid/SoftwarePortfolio/master/Images/ReadMe/ssrsdatadictionary.png" align="top" width="256px" title="Data Dictionary" />
                <br>
                <br>
                <span style="max-width:256px;">This report is used for querying the data dictionary of a SQL Server database.</span>
                <br>
            </kbd>
        </td>
        <td width="33%">
            <kbd>
                <a href="https://raw.githubusercontent.com/aduguid/SqlServerReportingServices/master/ServerDatabase/Scheduled%20Jobs.rdl">Scheduled Jobs Gantt Chart</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/aduguid/SoftwarePortfolio/master/Images/ReadMe/ssrsscheduledjobs.png" align="top" width="256px" title="Scheduled Jobs Gantt Chart" />
                <br>
                <br>
                <span style="max-width:256px;">This report is used for querying the scheduled jobs for a SQL Server database.</span>
                <br>
            </kbd>
        </td>
        <td width="33%">
            <kbd>
                <a href="https://github.com/aduguid/SqlServerReportingServices/blob/master/ServerDatabase/Activity%20Monitor.rdl">Activity Monitor</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/aduguid/SoftwarePortfolio/master/Images/ReadMe/ssrsactivitymonitor.png" align="top" width="256px" title="Activity Monitor" />
                <br>
                <br>
                <span style="max-width:256px;">This report queries the activity monitor from SQL Server.</span>
                <br>
            </kbd>
        </td>
    </tr>
    <tr valign="top">
        <td width="33%">
            <kbd>
                <a href="https://raw.githubusercontent.com/aduguid/SqlServerReportingServices/master/ServerReports/Report%20List.rdl">Report Listing</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/aduguid/SoftwarePortfolio/master/Images/ReadMe/ssrsreportlisting.png" align="top" width="256px" title="Report Listing" />
                <br>
                <br>
                <span style="max-width:256px;">This report is used for querying the deployed SSRS reports, their subscriptions and their execution logs.</span>
                <br>
            </kbd>
        </td>
        <td width="33%">
            <kbd>
                <a href="https://raw.githubusercontent.com/aduguid/SqlServerReportingServices/master/ServerReports/Subscriptions.rdl">Report Subscriptions</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/aduguid/SoftwarePortfolio/master/Images/ReadMe/ssrsreportsubscriptions.png" align="top" width="256px" title="Report Subscriptions" />
                <br>
                <br>
                <span style="max-width:256px;">This report is used for querying the deployed SSRS subscriptions.</span>
                <br>
            </kbd>
        </td>
        <td width="33%">
            <kbd>
                <a href="https://github.com/aduguid/SqlServerReportingServices/blob/master/ServerReports/Execution%20Log.rdl">Report Execution Log</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/aduguid/SoftwarePortfolio/master/Images/ReadMe/ssrsreportexecutionlog.png" align="top" width="256px" title="Report Execution Log" />
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
                <a href="https://github.com/aduguid/SqlServerReportingServices/blob/master/ServerReports/Report%20Documentation.rdl">Report Documentation</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/aduguid/SoftwarePortfolio/master/Images/ReadMe/ssrsreportdocumentation.png" align="top" width="256px" title="Report Documentation" />
                <br>
                <br>
                <span style="max-width:256px;">This report is used for querying the deployed report XML.</span>
                <br>
            </kbd>
        </td>
        <td width="33%">
            <kbd>
                <a href="https://github.com/aduguid/SqlServerReportingServices/blob/master/ServerReports/Data%20Sources.rdl">Report Data Sources</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/aduguid/SoftwarePortfolio/master/Images/ReadMe/ssrsreportdatasources.png" align="top" width="256px" title="Report Data Sources" />
                <br>
                <br>
                <span style="max-width:256px;">This report is used for querying the deployed data sources.</span>
                <br>
            </kbd>
        </td>
        <td width="33%">
            <kbd>
                <a href="https://github.com/aduguid/SqlServerReportingServices/blob/master/ServerReports/Permissions.rdl">Report Server Folder Permissions</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/aduguid/SoftwarePortfolio/master/Images/ReadMe/ssrsreportfolderpermissions.png?" align="top" width="256px" title="Report Server Folder Permissions" />
                <br>
                <br>
                <span style="max-width:256px;">This report is used for querying the report server folder permissions.</span>
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

