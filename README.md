</kbd><kbd><img align="left" src="Images/SSRS1.png" height="100px" ></kbd> &nbsp;  <kbd><img align="left" src="Images/PBIRS2.png" height="100px" >

# Microsoft Report Server (SSRS & PBIRS)

<!---[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/AnthonyDuguid/1.00)--->
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE "MIT License Copyright © Anthony Duguid")
[![Latest Release](https://img.shields.io/github/release/SQL-Server-projects/Reporting-Services-examples.svg?label=latest%20release)](https://github.com/SQL-Server-projects/Reporting-Services-examples/releases)
[![Github commits (since latest release)](https://img.shields.io/github/commits-since/SQL-Server-projects/Reporting-Services-examples/latest.svg)](https://github.com/SQL-Server-projects/Reporting-Services-examples)
![Microsoft Power BI Report Server](https://img.shields.io/badge/SSRS-16.0.1114.11.48-red.svg)
![Microsoft Power BI Report Server](https://img.shields.io/badge/PBIRS-15.0.1117.95-red.svg)

The following examples are used to query the database & report server. I have included some useful scripts and documents as well.

## Reports
            
<a id="user-content-ssrs-reports" class="anchor" href="#ssrs-reports" aria-hidden="true"> </a>
<table style="width:100%">
    <tr valign="top">
        <td width="33%">
            <kbd>
                <a href="https://github.com/SQL-Server-projects/Reporting-Services-examples/blob/master/ServerReports/Report%20List.rdl">Report Listing</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/aduguid/SqlServerReportingServices/master/Images/ReadMe/report_list.png" align="top" width="256px" title="Report Listing" />
                <br>
                <br>
                <span style="max-width:256px;">This report is designed for querying deployed reports, their subscriptions, and execution logs. It includes hyperlinks to the folder, report, subscription, and execution log, along with various parameters to ensure quality maintenance. </span>
                <br>
            </kbd>
        </td>
        <td width="33%">
            <kbd>
                <a href="https://github.com/SQL-Server-projects/Reporting-Services-examples/blob/master/ServerReports/Subscriptions.rdl">Report Subscriptions</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/aduguid/SqlServerReportingServices/master/Images/ReadMe/subscriptions.png" align="top" width="256px" title="Report Subscriptions" />
                <br>
                <br>
                <span style="max-width:256px;">This report is used to query deployed subscriptions and their schedules. It includes hyperlinks to the folder, report, subscription, and execution log, along with various parameters for detailed tracking and management. </span>
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
                <span style="max-width:256px;">This report is used to query the report server execution log, with various parameters available to filter the results. </span>
                <br>
            </kbd>
        </td>
    </tr>
    <tr valign="top">
        <td width="33%">
            <kbd>
                <a href="https://github.com/SQL-Server-projects/Reporting-Services-examples/blob/master/Miscellaneous/Scripts/VB/HeatMapColorGradate.vb">Heat Map Calendar</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/SQL-Server-projects/Reporting-Services-examples/master/Images/ReadMe/ssrsheatmap_calendar.png" align="top" width="256px" title="Heat Map Calendar" />
                <br>
                <br>
                <span style="max-width:256px;">The paginated report features a nested tablix within a matrix to display a calendar view. The heat map is created using a .NET function in custom code and a report variable for the base color, generating a gradient effect. Each day on the calendar is hyperlinked to a detailed Reporting Services report.</span>
                <br>
            </kbd>
        </td>
    </tr>
</table>

## Dashboards

  <table style="width:100%">
    <tr valign="top">
        <td width="33%">
            <kbd>
                <a href="https://github.com/SQL-Server-projects/Reporting-Services-examples/blob/master/Miscellaneous/Templates">Example Template</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/SQL-Server-projects/Reporting-Services-examples/master/Images/ReadMe/powerbi.template.png" align="top" width="256px" title="Power BI Template" />
                <br>
                <br>
                <span style="max-width:256px;">A Power BI template featuring a matrix formatted as a calendar, with bookmarks for day, week, month, quarter, and year to adjust the date timeline selection and control the X-axis date hierarchy level on charts. It also includes date filtering capabilities based on specific timeframes and aging criteria.</span>
                <br>
            </kbd>
        </td>
        <td width="33%">
            <kbd>
                <a href="https://github.com/SQL-Server-projects/Reporting-Services-examples/blob/master/Miscellaneous/Templates">Performance Template</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/SQL-Server-projects/Reporting-Services-examples/master/Images/ReadMe/powerbi.performance.png" align="top" width="256px" title="Power BI Performance" />
                <br>
                <br>
                <span style="max-width:256px;">A Power BI template with a trend and detail execution log, bookmarks for half hour, hour, day, week and month to change the date timeline selection and the X axis date hierarchy level on the trend. The log contains information on the length of time spent running a report's dataset query and the time spent processing the data. If you're a report server administrator, you can review the log information and identify long running tasks. You can also make suggestions to the report authors on the areas of the dataset or processing report they might be able to improve.</span>
                <br>
            </kbd>
        </td>
        <td width="33%">
            <kbd>
                <a href="https://github.com/PowerBi-Projects/ServiceNow">Service Now Template</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/SQL-Server-projects/Reporting-Services-examples/master/Images/ReadMe/powerbi.servicenow.png" align="top" width="256px" title="Power BI Service Now" />
                <br>
                <br>
                <span style="max-width:256px;">A Power BI template for ServiceNow that integrates with the REST API, featuring a slicer to adjust the date used in the relationship, and another slicer to modify the Y-axis on the clustered bar chart. The template also includes bookmarks for day, week, month, quarter, and year, enabling users to toggle the date timeline selection and control the X-axis date hierarchy level on the charts.</span>
                <br>
            </kbd>
        </td>
    </tr>
</table>

</kbd>

## Power BI External Tools
<kbd>
        <img src="https://raw.githubusercontent.com/SQL-Server-projects/Reporting-Services-examples/master/Images/ReadMe/powerbi.external_tools.png" height="100px" >
        <br>
        <br>
        <span style="max-width:256px;">
The order of the buttons in the External Tools menu is determined alphabetically by the JSON file name. To manage this, I use a two-digit number prefix.

Place the .json files in the following directory: C:\Program Files (x86)\Common Files\Microsoft Shared\Power BI Desktop\External Tools

I used [base64-image.de](https://www.base64-image.de/) to generate Base64 Image code for icons. To create and modify the icons I used  GIMP.

You can find the JSON files in my [GitHub project here](https://github.com/SQL-Server-projects/Reporting-Services-examples/tree/master/Miscellaneous/External%20Tools). Please update the URLs in the JSON files to match your organization's sites for services like ServiceNow, Jira, and Confluence. 

Here is the list of installs for External Tools: 

| Name | Location |
| -------- | ------- |
| Analyze in Excel | https://www.sqlbi.com/tools/analyze-in-excel-for-power-bi-desktop/ |
| Bravo | https://github.com/sql-bi/Bravo/releases |
| DAX Studio | https://daxstudio.org/|
| Tabular Editor | https://github.com/TabularEditor/TabularEditor/releases/ |
| ALM Toolkit | https://www.sqlbi.com/tools/alm-toolkit/ |
| Power BI Report Builder|https://go.microsoft.com/fwlink/?LinkId=734968 |
| SQL Server Management Studio | https://aka.ms/ssmsfullsetup  |
| SQL Server Profiler | https://aka.ms/ssmsfullsetup  |
| Azure Data Studio |https://aka.ms/ssmsfullsetup |
| Model Documenter |https://data-marc.com/model-documenter/ |
| Microsoft Loop |https://loop.cloud.microsoft/ (I use this for all of our process documentation) |
| Measure Killer |https://en.brunner.bi/measurekiller |
 
If you have any other suggestions, please add them in the [comments](https://community.fabric.microsoft.com/t5/Desktop/Power-BI-External-Tools/m-p/4052162#M1286411).

There is also an article on [Microsoft Learn about External Tools](https://learn.microsoft.com/en-us/power-bi/transform-model/desktop-external-tools).

</span>
</kbd> 

## Installs

Here is the list of installs I use for my environment

<kbd> 
  
| Name | Location |
| -------- | ------- |
| Power BI Report Server | https://powerbi.microsoft.com/en-au/report-server/ |
| SQL Server 2022 Reporting Services | https://www.microsoft.com/en-us/download/details.aspx?id=104502 |
| SQL Server 2019 Reporting Services | https://www.microsoft.com/en-us/download/details.aspx?id=100122 |
| Visual Studio | https://visualstudio.microsoft.com/vs/ |
| Reporting Services Projects 2022 | https://marketplace.visualstudio.com/items?itemName=ProBITools.MicrosoftReportProjectsforVisualStudio2022 |
| SQL Server Management Studio | https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16 |
| RedGate SQL Prompt | https://www.red-gate.com/products/sql-prompt/ |
| Azure Data Studio | https://learn.microsoft.com/en-us/azure-data-studio/download-azure-data-studio?tabs=win-install%2Cwin-user-install%2Credhat-install%2Cwindows-uninstall%2Credhat-uninstall |
| Azure DevOps Services | https://dev.azure.com/ |
| Azure Storage Explorer | https://azure.microsoft.com/en-us/products/storage/storage-explorer/ |
| Microsoft Power Automate | https://go.microsoft.com/fwlink/?LinkId=2102613&clcid=0x409 | 
| Microsoft PowerToys | https://learn.microsoft.com/en-us/windows/powertoys/install |
| Microsoft Loop | https://apps.microsoft.com/detail/9p1hq5tqzmgd?hl=en-US&gl=US |
| Notepad++ | https://notepad-plus-plus.org/downloads/ |
| Animated Files | https://www.screentogif.com/ |
| Image Markup | https://www.techsmith.com/screen-capture.html |
| Image Editor | https://www.gimp.org/ |
| Problem Recording | https://learn.microsoft.com/en-us/office/troubleshoot/settings/how-to-use-problem-steps-recorder |
| Password Management | https://keepass.info/ |
| Disk Usage | https://portableapps.com/apps/utilities/windirstat_portable |

</kbd> 

<br>
<br>

## File List

<kbd>
  
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
* [Calendar](/Miscellaneous/Scripts/DAX/Calendar.dax) 
* [Calendar Ageing](/Miscellaneous/Scripts/DAX/Calendar_Ageing.dax) 
* [Calendar Timeframe](/Miscellaneous/Scripts/DAX/Calendar_Timeframe.dax) 
* [Dynamic_Number_Format](/Miscellaneous/Scripts/DAX/Dynamic_Number_Format.dax) 

</kbd>
