/*------------------------------------------------------------------------------+
| Purpose:	How to Update the owner of deployed reports and subscriptions 
| Note:		SQLCmdMode Script
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
PRINT 'Find subscriptions for user...'
PRINT '====================================================================='

;WITH 
user_list
AS
(
	SELECT UserID, UserName FROM dbo.Users WHERE UserName =  N'$(OldUser)'
)
--SELECT 'BEFORE', * FROM user_list
SELECT 
	  'BEFORE'
	, ul.UserName
	, sb.*
FROM 
dbo.Subscriptions sb
INNER JOIN user_list ul ON sb.OwnerID = ul.UserID

PRINT '====================================================================='
PRINT 'Update subscriptions...'
PRINT '====================================================================='

;WITH 
user_old
AS
(
	SELECT Old_UserID = UserID, UserName FROM dbo.Users WHERE UserName =  N'$(OldUser)'
)
, 
user_new
AS
(
	SELECT New_UserID = UserID, UserName FROM dbo.Users WHERE UserName =  N'$(NewUser)'
)
--SELECT 
--	  uo.UserName 
--	, un.UserName 
UPDATE 
	dbo.Subscriptions 
SET 
	OwnerID = un.New_UserID 
FROM 
	dbo.Subscriptions sb
	INNER JOIN user_old uo ON sb.OwnerID = uo.Old_UserID
	, user_new un

PRINT '====================================================================='
PRINT 'Update reports...'
PRINT '====================================================================='

;WITH 
user_old
AS
(
	SELECT Old_UserID = UserID, UserName FROM dbo.Users WHERE UserName =  N'$(OldUser)'
)
, 
user_new
AS
(
	SELECT New_UserID = UserID, UserName FROM dbo.Users WHERE UserName =  N'$(NewUser)'
)
UPDATE 
	dbo.Catalog 
SET 
	CreatedById = un.New_UserID 
FROM  
	dbo.Catalog AS c
	INNER JOIN user_old uo ON c.CreatedById = uo.Old_UserID
	, user_new un
--WHERE c.Type = 2

;WITH 
user_old
AS
(
	SELECT Old_UserID = UserID, UserName FROM dbo.Users WHERE UserName =  N'$(OldUser)'
)
, 
user_new
AS
(
	SELECT New_UserID = UserID, UserName FROM dbo.Users WHERE UserName =  N'$(NewUser)'
)
UPDATE 
	dbo.Catalog 
SET 
	ModifiedById = un.New_UserID 
FROM  
	dbo.Catalog AS c
	INNER JOIN user_old uo ON c.ModifiedById = uo.Old_UserID
	, user_new un
--WHERE c.Type = 2

;WITH 
user_old
AS
(
	SELECT Old_UserID = UserID, UserName FROM dbo.Users WHERE UserName =  N'$(OldUser)'
)
, 
user_new
AS
(
	SELECT New_UserID = UserID, UserName FROM dbo.Users WHERE UserName =  N'$(NewUser)'
)
SELECT 
	  c.CreatedById
	, c.ModifiedById
	, uo.UserName 
	, un.UserName 
	, c.*
FROM  
	dbo.Catalog AS c
	INNER JOIN user_old uo ON c.CreatedById = uo.Old_UserID
	, user_new un

PRINT '====================================================================='
PRINT 'Find OLD subscriptions for user...'
PRINT '====================================================================='

;WITH 
user_list
AS
(
	SELECT UserID, UserName FROM dbo.Users WHERE UserName =  N'$(OldUser)'
)
--SELECT 'BEFORE', * FROM user_list
SELECT 
	  'AFTER'
	, ul.UserName
	, sb.*
FROM 
dbo.Subscriptions sb
INNER JOIN user_list ul ON sb.OwnerID = ul.UserID

PRINT '====================================================================='
PRINT 'Find NEW subscriptions for user...'
PRINT '====================================================================='

;WITH 
user_list
AS
(
	SELECT UserID, UserName FROM dbo.Users WHERE UserName =  N'$(NewUser)'
)
--SELECT 'BEFORE', * FROM user_list
SELECT 
	  'AFTER'
	, ul.UserName
	, sb.*
FROM 
dbo.Subscriptions sb
INNER JOIN user_list ul ON sb.OwnerID = ul.UserID


ROLLBACK TRANSACTION
--COMMIT TRANSACTION   

PRINT '====================================================================='
PRINT 'Finished...'
PRINT '====================================================================='