CREATE TABLE [dbo].[tblDirectorySubscriptions] (
	[nSubscriptionKey] [int] IDENTITY (1, 1) NOT NULL ,
	[nUserId] [int] NULL ,
	[nSubscriptionId] [int] NULL ,
	[cSubscriptionXML] [ntext]  NULL ,
	[nAuditId] [int] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


ALTER TABLE [dbo].[tblDirectorySubscriptions] ADD 
	CONSTRAINT [PK_tblUserSubscritptions] PRIMARY KEY  CLUSTERED 
	(
		[nSubscriptionKey]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 


