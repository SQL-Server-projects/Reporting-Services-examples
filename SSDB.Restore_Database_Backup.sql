/*--------------------------------------------------------------------------------------------------------------------------------+
| Purpose:	Restore a backup of a database
| Example:  EXEC admin.Restore_Database_Backup 'db1_20130619_073701_firstname.lastname.bak', 'db1_Backup'
+--------------------------------------------------------------------------------------------------------------------------------*/

:setvar _server "Server1"
:setvar _user "***username***"
:setvar _password "***password***"
:setvar _database "master"
:connect $(_server) -U $(_user) -P $(_password)

USE [$(_database)];
GO

CREATE PROCEDURE [admin].[Restore_Database_Backup]
(
  @FileName VARCHAR(255)
, @DatabaseName VARCHAR(50)
)
AS 
BEGIN

PRINT '====================================================================='
PRINT 'set the name and path for the restore...'
PRINT '====================================================================='
DECLARE @BackupFile VARCHAR(200)
DECLARE @DataFile VARCHAR(200)
-- TO DO: Standardize the backup folder location for all servers
IF @@SERVERNAME = 'Server1' SET @BackupFile = 'C:\Temp\' + @FileName

PRINT '====================================================================='
PRINT 'set the data path for sql server...'
PRINT '====================================================================='

SELECT @DataFile = SUBSTRING(physical_name, 1, CHARINDEX(N'master.mdf', LOWER(physical_name)) - 1)
                  FROM master.sys.master_files
                  WHERE database_id = 1 AND file_id = 1

PRINT '====================================================================='
PRINT 'get the logical names from the backup file...'
PRINT '====================================================================='
DECLARE @Table TABLE (
					  [LogicalName] varchar(128)
					, [PhysicalName] varchar(128)
					, [Type] varchar
					, [FileGroupName] varchar(128)
					, [Size] varchar(128)
					, [MaxSize] varchar(128)
					, [FileId]varchar(128)
					, [CreateLSN]varchar(128)
					, [DropLSN]varchar(128)
					, [UniqueId]varchar(128)
					, [ReadOnlyLSN]varchar(128)
					, [ReadWriteLSN]varchar(128)
					, [BackupSizeInBytes]varchar(128)
					, [SourceBlockSize]varchar(128)
					, [FileGroupId]varchar(128)
					, [LogGroupGUID]varchar(128)
					, [DifferentialBaseLSN]varchar(128)
					, [DifferentialBaseGUID]varchar(128)
					, [IsReadOnly]varchar(128)
					, [IsPresent]varchar(128)
					, [TDEThumbprint]varchar(128)
					)
					
DECLARE @LogicalNameData varchar(128)
DECLARE @LogicalNameLog varchar(128)
INSERT INTO @table EXEC('RESTORE FILELISTONLY FROM DISK=''' + @BackupFile + '''')

   SET @LogicalNameData=(SELECT LogicalName FROM @Table WHERE Type='D')
   SET @LogicalNameLog=(SELECT LogicalName FROM @Table WHERE Type='L')

PRINT '====================================================================='
PRINT 'Restore the Database starting with a file from a Full Backup...'
PRINT '====================================================================='
BEGIN
      DECLARE @RESTORE_SQL VARCHAR(MAX)
      SET @RESTORE_SQL =
		'RESTORE DATABASE ' + @DatabaseName + '
		FROM DISK = ''' + @BackupFile + '''
		WITH
		  RECOVERY
		, STATS = 10
	, MOVE ''' + @LogicalNameData + ''' TO ''' + @DataFile + @DatabaseName + '.mdf''
	, MOVE ''' + @LogicalNameLog + ''' TO ''' + @DataFile + @DatabaseName + '.ldf'''
      PRINT @RESTORE_SQL
      EXEC (@RESTORE_SQL)
END

PRINT '====================================================================='
PRINT 'Update owner of the database to standard...'
PRINT '====================================================================='
BEGIN
      DECLARE @OWNER_SQL VARCHAR(MAX)
      SET @OWNER_SQL = 'ALTER AUTHORIZATION ON DATABASE::' + @DatabaseName + ' TO sa;'
      PRINT @OWNER_SQL
      EXEC (@OWNER_SQL)
END  

PRINT '====================================================================='
PRINT 'Finished!'
PRINT '====================================================================='

END


GO


