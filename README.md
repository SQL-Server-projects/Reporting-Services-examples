</kbd><kbd><img align="left" src="Images/SSRS1.png" height="100px" ></kbd> &nbsp;  <kbd><img align="left" src="Images/PBIRS2.png" height="100px" >

# Microsoft Report Server (SSRS & PBIRS)

<!---[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/AnthonyDuguid/1.00)--->
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE "MIT License Copyright © Anthony Duguid")
[![Latest Release](https://img.shields.io/github/release/SQL-Server-projects/Reporting-Services-examples.svg?label=latest%20release)](https://github.com/SQL-Server-projects/Reporting-Services-examples/releases)
[![Github commits (since latest release)](https://img.shields.io/github/commits-since/SQL-Server-projects/Reporting-Services-examples/latest.svg)](https://github.com/SQL-Server-projects/Reporting-Services-examples)
![Microsoft Power BI Report Server](https://img.shields.io/badge/SSRS-16.0.1114.11.48-red.svg)
![Microsoft Power BI Report Server](https://img.shields.io/badge/PBIRS-15.0.1117.95-red.svg)
<br><br>
[Buy me a coffee ☕ 😁](https://www.paypal.me/AnthonyDuguid/5)

<br>

<details>
  <summary><b>Table of Contents</b></summary>
 
- <a href="#reports">SSRS Reports</a>
- <a href="#dashboards">Power BI Dashboards</a>
- <a href="#tools">Power BI External Tools</a>
- <a href="#software">Software</a>
- <a href="#files">File List</a>
- <a href="https://github.com/SQL-Server-projects/Reporting-Services-examples/wiki">Wiki</a>
</details>

## About
The following examples are provided to query both the database and report server. Additionally, I have included some helpful scripts and documents for reference.

<br>

<a id="user-content-reports" class="anchor" href="#reports" aria-hidden="true"> </a>
## SSRS Reports

SQL Server Reporting Services (SSRS) enables the creation, deployment, and management of interactive, web-based reports. These reports provide a platform for sharing and configuring data, as well as delivering actionable insights. The examples below illustrate how to query both the database and the report server effectively.
            
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
                <a href="https://github.com/SQL-Server-projects/Reporting-Services-examples/blob/master/ServerReports/Scheduled%20Jobs.rdl">Scheduled Jobs</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/SQL-Server-projects/Reporting-Services-examples/master/Images/ReadMe/ssrs.scheduled_jobs.png" align="top" width="256px" title="Scheduled Jobs" />
                <br>
                <br>
                <span style="max-width:256px;">This report is designed to query and analyze the scheduled jobs within a SQL Server database. The detail shows the start time, end time or end date, and frequency of execution. The timeframe is displayed as a Gantt chart. </span>
                <br>
            </kbd>
        </td>
            <td width="33%">
            <kbd>
                <a href="https://github.com/SQL-Server-projects/Reporting-Services-examples/blob/master/ServerReports/Database%20Dictionary.rdl">Database Dictionary</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/SQL-Server-projects/Reporting-Services-examples/master/Images/ReadMe/ssrs.database_dictionary.png" align="top" width="256px" title="Database Dictionary" />
                <br>
                <br>
                <span style="max-width:256px;">This report is designed to query and explore the database dictionary of a SQL Server database. The detail includes a collection of names, definitions, and attributes about data elements that are being used in a database.</span>
                <br>
            </kbd>
        </td>
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
                <br>
                <img src="https://raw.githubusercontent.com/SQL-Server-projects/Reporting-Services-examples/master/Images/ReadMe/sharepoint.teamsite.ssrs.png" align="top" width="256px" title="Heat Map Calendar" />
                <br>
                <br>  
                <span style="max-width:256px;">You can then add it to a SharePoint team site with a report viewer web part.</span>
                <br>
                <br>
            </kbd>
        </td>
    </tr>
</table>

<br>
<br>

<a id="user-content-dashboards" class="anchor" href="#dashboards" aria-hidden="true"> </a>

## Power BI Dashboards

Power BI templates ensure that all reports adhere to a consistent design, maintaining a professional appearance that aligns with the organization's branding guidelines. By leveraging these templates, organizations can streamline reporting processes, foster collaboration, and create a polished, cohesive framework for data presentation. Standardized visuals and layouts minimize the risk of misrepresenting data or overlooking critical details. These templates also serve as a valuable starting point for new team members, reducing their learning curve and boosting productivity. Standardization helps stakeholders interpret data more effectively, reducing confusion and enhancing decision-making.

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
                <span style="max-width:256px;">A Power BI template featuring a matrix formatted as a calendar, with bookmarks for day, week, month, quarter, and year to adjust the date timeline selection and control the X-axis date hierarchy level on charts. It also includes date filtering capabilities based on specific timeframes and aging criteria. Templates ensure that all reports adhere to a consistent design, maintaining a professional appearance that aligns with the organization's branding guidelines.</span>
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
                <span style="max-width:256px;">A Power BI template with a trend and detail execution log, bookmarks for half hour, hour, day, week and month to change the date timeline selection and the X axis date hierarchy level on the trend. The log contains information on the length of time spent running a report's dataset query and the time spent processing the data. If you're a report server administrator, you can review the log information and identify long running tasks. You can also make suggestions to the report authors on the areas of the dataset or processing report they might be able to improve. </span>
                <br>
            </kbd>
        </td>
        <td width="33%">
            <kbd>
                <a href="https://github.com/PowerBi-Projects/ServiceNow">Service Now Template</a>
                <br>
                <br>
                <img src="https://raw.githubusercontent.com/SQL-Server-projects/Reporting-Services-examples/master/Images/ReadMe/powerbi.servicenow1.png" align="top" width="256px" title="Power BI Service Now" />
                <br>
                <br>
                <span style="max-width:256px;">A Power BI template for ServiceNow that integrates with the REST API, featuring a slicer to adjust the date used in the relationship, and another slicer to modify the Y-axis on the clustered bar chart. The template also includes bookmarks for day, week, month, quarter, and year, enabling users to toggle the date timeline selection and control the X-axis date hierarchy level on the charts. It's a comprehensive visualization tool designed to provide deep insights into the performance, trends, and key metrics related to tickets generated within the ServiceNow platform. This dashboard offers a user-friendly interface that allows stakeholders, IT managers, and support teams to monitor, analyze, and optimize ticket management processes effectively.</span>
                <br>
            </kbd>
        </td>
    </tr>
</table>

</kbd>

<br>
<br>

<a id="user-content-tools" class="anchor" href="#tools" aria-hidden="true"> </a>

## Power BI External Tools

Power BI External Tools are additional applications or links to websites that integrate seamlessly with Power BI Desktop, enabling advanced modeling, debugging, optimization, and customization tasks. These tools extend Power BI's capabilities by providing specialized functionalities that are not natively available in the Power BI Desktop interface.

<img src="https://raw.githubusercontent.com/SQL-Server-projects/Reporting-Services-examples/master/Images/ReadMe/powerbi.external_tools.png" width="700px" >

The order of the buttons in the External Tools menu is determined alphabetically by the JSON file name. To manage this, I use a two-digit number prefix.

Place the .json files in the following directory: C:\Program Files (x86)\Common Files\Microsoft Shared\Power BI Desktop\External Tools

I used [base64-image.de](https://www.base64-image.de/) to generate Base64 Image code for icons. To create and modify the icons I used  GIMP.

You can find the JSON files in my [GitHub project here](https://github.com/SQL-Server-projects/Reporting-Services-examples/tree/master/Miscellaneous/External%20Tools). Please update the URLs in the JSON files to match your organization's sites for services like ServiceNow, Jira, and Confluence. 

Here is the list of installs for External Tools: 

|Link|Name|Purpose|
|:----------|:----------|:----------|
| [⚡](https://www.sqlbi.com/tools/analyze-in-excel-for-power-bi-desktop/) |Analyze in Excel|Allows direct analysis of Power BI datasets using Excel’s PivotTable and PivotChart features.|
| [⚡](https://github.com/sql-bi/Bravo/releases) |Bravo|Tool for managing Power BI datasets, optimizing models, and formatting DAX queries.|
| [⚡](https://daxstudio.org/) |DAX Studio|Advanced tool for writing, analyzing, and optimizing DAX queries in Power BI and SSAS.|
| [⚡](https://github.com/TabularEditor/TabularEditor/releases/) |Tabular Editor|Lightweight editor for creating, managing, and optimizing Tabular models.|
| [⚡](https://www.sqlbi.com/tools/alm-toolkit/) |ALM Toolkit|Schema comparison tool for managing and deploying Tabular model changes.|
| [⚡](https://go.microsoft.com/fwlink/?LinkId=734968) |Power BI Report Builder|Tool for creating paginated reports to complement Power BI visualizations.|
| [⚡](https://aka.ms/ssmsfullsetup) |SQL Server Management Studio|Comprehensive tool for managing SQL Server and related services.|
| [⚡](https://aka.ms/ssmsfullsetup) |SQL Server Profiler|SQL Server trace tool for analyzing and debugging database performance issues.|
| [⚡](https://aka.ms/ssmsfullsetup) |Azure Data Studio|Cross-platform data management and development tool.|
| [⚡](https://data-marc.com/model-documenter/) |Model Documenter|Automates the generation of comprehensive Power BI model documentation.|
| [⚡](https://loop.cloud.microsoft/) |Microsoft Loop|Collaborative workspace for organizing and documenting processes and workflows.|
| [⚡](https://en.brunner.bi/measurekiller) |Measure Killer|Identifies and removes unused or redundant measures in Power BI models.|

If you have any other suggestions, please add them in the [comments](https://community.fabric.microsoft.com/t5/Desktop/Power-BI-External-Tools/m-p/4052162#M1286411).

There is also an article on [Microsoft Learn about External Tools](https://learn.microsoft.com/en-us/power-bi/transform-model/desktop-external-tools).

<br>
<br>

<a id="user-content-software" class="anchor" href="#software" aria-hidden="true"> </a>

## Software

Below is a curated list of essential software I use to manage and enhance my development, reporting, and productivity tasks. Each entry includes the name, description, and a direct link for easy access. This list reflects my preferred tools for efficient development, data management, and reporting tasks.
  
|Link|Name|Purpose|
|:----------|:----------|:----------|
| [⚡](https://powerbi.microsoft.com/en-au/report-server/) |Power BI Report Server|On-premises report server for hosting and sharing Power BI and paginated reports.|
| [⚡](https://www.microsoft.com/en-us/download/details.aspx?id=104502) |SQL Server 2022 Reporting Services|Advanced reporting tool for creating, publishing, and managing reports.|
| [⚡](https://www.microsoft.com/en-us/download/details.aspx?id=100122) |SQL Server 2019 Reporting Services|Legacy version of SQL Server Reporting Services for enterprise reporting.|
| [⚡](https://visualstudio.microsoft.com/vs/) |Visual Studio|Integrated development environment (IDE) for coding, debugging, and deploying applications.|
| [⚡](https://marketplace.visualstudio.com/items?itemName=ProBITools.MicrosoftReportProjectsforVisualStudio2022) |Reporting Services Projects 2022|Extension for Visual Studio to design SQL Server Reporting Services (SSRS) reports.|
| [⚡](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16) |SQL Server Management Studio|Comprehensive tool for configuring, managing, and administering SQL Server instances.|
| [⚡](https://www.red-gate.com/products/sql-prompt/) |RedGate SQL Prompt|Productivity tool for writing, formatting, and refactoring SQL code.|
| [⚡](https://learn.microsoft.com/en-us/azure-data-studio/download-azure-data-studio?tabs=win-install%2Cwin-user-install%2Credhat-install%2Cwindows-uninstall%2Credhat-uninstall) |Azure Data Studio|Cross-platform data management tool for SQL Server and Azure SQL Database. (End of life Jun 2025)|
| [⚡](https://dev.azure.com/) |Azure DevOps Services|Cloud-based platform for managing DevOps workflows, CI/CD, and source code repositories.|
| [⚡](https://azure.microsoft.com/en-us/products/storage/storage-explorer/) |Azure Storage Explorer|Tool for managing Azure Storage accounts, including blobs, queues, and tables.|
| [⚡](https://go.microsoft.com/fwlink/?LinkId=2102613&clcid=0x409) |Microsoft Power Automate|Workflow automation tool for streamlining repetitive tasks and processes.|
| [⚡](https://learn.microsoft.com/en-us/windows/powertoys/install) |Microsoft PowerToys|Utility toolset to enhance Windows productivity and usability.|
| [⚡](https://apps.microsoft.com/detail/9p1hq5tqzmgd?hl=en-US&gl=US) |Microsoft Loop|Collaborative workspace for managing projects, content, and ideas seamlessly.|
| [⚡](https://notepad-plus-plus.org/downloads/) |Notepad++|Lightweight text and code editor with extensive plugin support.|
| [⚡](https://www.screentogif.com/) |Animated Files (ScreenToGif)|Tool for creating animated GIFs and recording on-screen activities.|
| [⚡](https://www.techsmith.com/screen-capture.html) |Image Markup (Snagit)|Screen capture and image annotation tool for professional workflows.|
| [⚡](https://www.gimp.org/) |Image Editor (GIMP)|Open-source image editing software for graphic design and photo manipulation.|
| [⚡](https://learn.microsoft.com/en-us/office/troubleshoot/settings/how-to-use-problem-steps-recorder) |Microsoft Problem Recording|Step-by-step problem recorder for documenting workflows and troubleshooting.|
| [⚡](https://keepass.info/) |Password Management (KeePass)|Secure tool for managing and storing passwords.|
| [⚡](https://portableapps.com/apps/utilities/windirstat_portable) |Disk Usage (WinDirStat)|Visualizes disk usage for identifying large files and optimizing storage.|
| [⚡](https://mockaroo.com/) |Mock Data (Mockaroo)|Tool for generating realistic mock data for development and testing.|

<br>
<br>

<a id="user-content-files" class="anchor" href="#files" aria-hidden="true"> </a>

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
* [Report Datasets](/Miscellaneous/Scripts/SQL/Report_Datasets.sql)
* [Report Linked](/Miscellaneous/Scripts/SQL/Report_Linked.sql)
* [Report Snapshots](/Miscellaneous/Scripts/SQL/Report_Snapshots.sql)
* [Report Subreports](/Miscellaneous/Scripts/SQL/Report_Subreports.sql)
* [Source Control Current](/Miscellaneous/Scripts/SQL/Source_Control_Current.sql)
* [Update Subscription Owner](/Miscellaneous/Scripts/SQL/Update_Subscription_Owner.sql)
##### [M Scripts](/Miscellaneous/Scripts/M)
* [Calendar](/Miscellaneous/Scripts/M/Calendar.M)
* [Calendar FY](/Miscellaneous/Scripts/M/Calendar_FY.M)
##### [DAX Scripts](/Miscellaneous/Scripts/DAX)
* [Calendar](/Miscellaneous/Scripts/DAX/Calendar.dax) 
* [Calendar Ageing](/Miscellaneous/Scripts/DAX/Calendar_Ageing.dax) 
* [Calendar Timeframe](/Miscellaneous/Scripts/DAX/Calendar_Timeframe.dax) 
* [Dynamic Number Format](/Miscellaneous/Scripts/DAX/Dynamic_Number_Format.dax) 
