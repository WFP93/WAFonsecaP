--USE AdventureWorks2014;  
--GO

EXEC sp_addumpdevice 'disk', 'AdventureWorks2014Data',   
'D:\Examen_BD II 2021\SQL\BACKUP\AdventureWorks2014Data.bak';  
GO


BACKUP DATABASE AdventureWorks2014   
 TO AdventureWorks2014Data  
   WITH FORMAT, INIT, NAME = N'AdventureWorks2014 – Full Backup' ;  
GO  


DECLARE @BackupName VARCHAR(100)
SET @BackupName = N'AdventureWorks2014 – Full Backup ' + FORMAT(GETDATE(),'yyyyMMdd_hhmmss');

BACKUP DATABASE AdventureWorks2014
TO AdventureWorks2014Data
WITH NOFORMAT, NOINIT, NAME = @BackupName,
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

RESTORE FILELISTONLY FROM AdventureWorks2014Data
GO
RESTORE HEADERONLY FROM AdventureWorks2014Data
GO


RESTORE DATABASE [AwExamenBDII] 
FROM  DISK = N'D:\Examen_BD II 2021\SQL\BACKUP\AdventureWorks2014Data.bak' 
WITH  FILE = 1,  
MOVE N'AdventureWorks2014_Data' TO N'C:\Program Files\Microsoft SQL Server\MSSQL13.SS2016\MSSQL\DATA\AdventureWorks2014_Data.mdf',  
MOVE N'AdventureWorks2014_Log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL13.SS2016\MSSQL\DATA\AdventureWorks2014_Log.ldf',  
NOUNLOAD,  STATS = 5
