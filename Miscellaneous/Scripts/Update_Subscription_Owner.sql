/*------------------------------------------------------------------------------+
| Purpose:	How to Update the owner of deployed reports and subscriptions 
| Note:		SQLCmdMode Script
| Reference: 	http://www.andrewjbillings.com/ssrs-migration-subscriptions-dont-work-if-owner-no-longer-exists/
+--------------------------------------------------------------------------------
:setvar _server "Server1"
:setvar _user "***username***"
:setvar _password "***password***"
:setvar _database "ReportServer"
:connect $(_server) -U $(_user) -P $(_password)
USE [$(_database)];
GO
*/

:SETVAR OldUser "DOMAIN\OldUserName"
:SETVAR NewUser "DOMAIN\NewUserName"

SET XACT_ABORT ON
BEGIN TRANSACTION

PRINT '====================================================================='
PRINT 'Update subscriptions...'
PRINT '====================================================================='

;WITH 
new_owner
AS
(
    SELECT UserID, UserName FROM dbo.Users WHERE UserName =  N'$(NewUser)'
)
, 
subscription_source
AS
(
    SELECT DISTINCT
          s.[Report_OID]
        , [OldOwner] = ou.[UserName]
        , [OldOwnerID] = ou.[UserID]
        , [NewOwner] = nu.[UserName]
        , [NewOwnerID] = nu.[UserID]
    FROM 
        [dbo].[Subscriptions] AS s
        INNER JOIN [dbo].[Users] AS ou ON ou.[UserID] = s.[OwnerID]
        , new_owner AS nu
    WHERE 
        1=1
        AND ou.[UserName] =  N'$(OldUser)'
)
--SELECT * FROM subscription_source
MERGE [dbo].[Subscriptions] AS T
USING subscription_source AS S ON T.[Report_OID] = S.[Report_OID]
WHEN MATCHED 
THEN UPDATE SET 
        T.[OwnerID] = S.[NewOwnerID] 
OUTPUT @@ServerName AS ServerName, db_name() AS DatabaseName, $action, inserted.*, deleted.*; 


PRINT '******* ROLLBACK TRANSACTION ******* ';
ROLLBACK TRANSACTION;

--PRINT '******* COMMIT TRANSACTION ******* ';
--COMMIT TRANSACTION;

PRINT '====================================================================='
PRINT 'Finished...'
PRINT '====================================================================='
