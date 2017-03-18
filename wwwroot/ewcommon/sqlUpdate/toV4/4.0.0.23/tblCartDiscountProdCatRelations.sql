CREATE TABLE [dbo].[tblCartDiscountProdCatRelations] (
	[nDiscountProdCatRelationKey] [int] IDENTITY (1, 1) NOT NULL ,
	[nDiscountId] [int] NULL ,
	[nProductCatId] [int] NULL ,
	[nAuditId] [int] NULL ,
	CONSTRAINT [PK_tblCartDiscountProdCatRelations] PRIMARY KEY  CLUSTERED 
	(
		[nDiscountProdCatRelationKey]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
) ON [PRIMARY]



