if not Exists(select * from sys.columns where Name = N'nDisplayPriority' and Object_ID = Object_ID(N'tblCartShippingMethods')) 
BEGIN
	ALTER TABLE tblCartShippingMethods ADD nDisplayPriority int NULL
END

