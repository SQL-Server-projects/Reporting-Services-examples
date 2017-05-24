/*--------------------------------------------------------------------------------------------------------------------------------+
| Purpose:	Create a backup of a database
| Example:  EXEC admin.Create_Database_Backup 'db1'
+--------------------------------------------------------------------------------------------------------------------------------*/

:setvar _server "Server1"
:setvar _user "***username***"
:setvar _password "***password***"
:setvar _database "master"
:connect $(_server) -U $(_user) -P $(_password)

USE [$(_database)];
GO

CREATE PROCEDURE [admin].[Create_Database_Backup]
(
@DatabaseName VARCHAR(50)
)
AS 
BEGIN

PRINT '====================================================================='
PRINT 'set the name of the database...'
PRINT '====================================================================='
DECLARE @SourceDB VARCHAR(50)
SET @SourceDB = @DatabaseName  --DB_NAME() 

PRINT '====================================================================='
PRINT 'get user name...'
PRINT '====================================================================='
DECLARE @BackupUser VARCHAR(255)
SET @BackupUser = (substring(suser_sname(),charindex('\',suser_sname())+(1),len(suser_sname())-charindex('\',suser_sname())))

PRINT '====================================================================='
PRINT 'get current date and time...'
PRINT '====================================================================='
DECLARE @DateStamp VARCHAR(20)
SET @DateStamp = '_' + CONVERT(VARCHAR(20),GetDate(),112) + '_' + REPLACE(CONVERT(VARCHAR(20),GetDate(),108),':','')

PRINT '====================================================================='
PRINT 'set database backup path...'
PRINT '====================================================================='
DECLARE @TargetPath VARCHAR(255)
-- TO DO: Standardize the backup folder location for all servers
IF @@SERVERNAME = 'Server1' SET @TargetPath = 'C:\Temp\'

PRINT '====================================================================='
PRINT 'set the backup file name...'
PRINT '====================================================================='
SET @TargetPath = @TargetPath + @SourceDB + @DateStamp + '_' + @BackupUser + '.bak'''
PRINT @TargetPath

PRINT '====================================================================='
PRINT 'backup the database...'
PRINT '====================================================================='
IF EXISTS(SELECT NAME FROM sys.databases where name = @SourceDB)
BEGIN
      DECLARE @BACKUP_SQL VARCHAR(MAX)
      SET @BACKUP_SQL =
      'BACKUP DATABASE ' + @SourceDB + '
      TO DISK = ''' + @TargetPath + '
        WITH FORMAT,
            MEDIANAME = ''' + @BackupUser + ''',
            NAME = ''' + @SourceDB + @DateStamp + ''''

      PRINT @BACKUP_SQL
      EXEC (@BACKUP_SQL)
END
PRINT '====================================================================='
PRINT 'Finished!'
PRINT '====================================================================='

END


GO


