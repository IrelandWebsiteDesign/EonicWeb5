if not Exists(select * from sys.columns where Name = N'bCollection' and Object_ID = Object_ID(N'tblCartShippingMethods')) 
BEGIN
	ALTER TABLE dbo.tblCartShippingMethods ADD
		bCollection bit NULL
END
