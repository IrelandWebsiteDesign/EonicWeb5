
if not Exists(select * from sys.columns where Name = N'cForeignRef' and Object_ID = Object_ID(N'tblActivityLog')) 

BEGIN 

ALTER TABLE dbo.tblActivityLog ADD
	cForeignRef nvarchar(255) NULL

ALTER TABLE dbo.tblActivityLog SET (LOCK_ESCALATION = TABLE)

END
