CREATE TABLE [dbo].[tblOptOutAddresses] (
	[EmailAddress] [nvarchar] (50) NOT NULL 
) ON [PRIMARY]

ALTER TABLE [dbo].[tblOptOutAddresses] ADD 
	CONSTRAINT [PK_tblOptOutAddresses] PRIMARY KEY  CLUSTERED 
	(
		[EmailAddress]
	)  ON [PRIMARY] 


