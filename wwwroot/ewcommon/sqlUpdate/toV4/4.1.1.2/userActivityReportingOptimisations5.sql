CREATE PROCEDURE [dbo].[spGetSessionActivity] (
 @FROM datetime,
 @TO datetime,
 @GROUPS nvarchar(255)
)
AS
BEGIN

-- DECLARE TABLES
DECLARE @Sessions table (SessionID nvarchar(255),UserId int, SessionStart datetime, NoPages int,SessionSeconds int)
DECLARE @UserScope TABLE(nDirId int)
DECLARE @GroupTable TABLE (GroupId int)

-- GET THE BASIC SESSION INFORMATION
INSERT INTO @Sessions (SessionID,UserId,SessionStart,NoPages, SessionSeconds) 
	SELECT DISTINCT s.cSessionId,s.nUserDirId,s.SessionStart, p.PageCount, DATEDIFF(second, s.SessionStart, s.SessionEnd)
	FROM	dbo.vw_SessionNonNullSummary s -- Get the session summary
			INNER JOIN dbo.fxn_SessionUserTable() u -- This table works out the correct user for the session (i.e. the MODE of the users in a given session)  Yes, mode is a maths term.
				ON s.nUserDirId = u.nUserDirId AND s.cSessionId = u.cSessionId
			INNER JOIN vw_SessionPageCount p
				ON p.cSessionId = s.cSessionId
	WHERE	s.SessionStart>= @FROM AND s.SessionStart<= @TO -- Limit it by date range


IF @Groups = '0' OR @Groups = '' OR @Groups IS NULL
	BEGIN 
		-- Bit unnecessary, but it means we can write universal statements after this conditional.
		INSERT INTO @UserScope 
			SELECT  DISTINCT s.UserId
			FROM	@Sessions s
	END
ELSE
	BEGIN

		-- Create the groups table
		Insert INTO @GroupTable (GroupId) SELECT * FROM fxn_CSVTableINTEGERS(@Groups)
		DECLARE @GroupID int
		DECLARE @Date datetime
		SET @Date = getdate()
		
		DECLARE curGroups CURSOR FOR SELECT GroupId FROM @GroupTable
	
		-- Populate the user scope
		OPEN curGroups 
		FETCH NEXT FROM curGroups INTO @GroupID 
		WHILE (@@FETCH_STATUS = 0)
			BEGIN
				INSERT INTO @UserScope 
					SELECT	m.nDirId
					FROM	dbo.fxn_getMembers(@GroupID,0 ,'User' ,0 , 0, @Date, 0 ) m
							LEFT JOIN @UserScope u ON m.nDirId = u.nDirId
					WHERE	u.nDirId IS NULL -- Only add users that haven't been added
						
				FETCH NEXT FROM curGroups INTO @GroupID 
			END
		CLOSE curGroups 
		DEALLOCATE curGroups
END


-- OUTPUT OUR RESPONSES
SELECT	users.nDirKey, 
		users.cDirName, 
		session.SessionID AS cSessionId, 
		session.SessionStart AS dSessionStart, 
		session.NoPages AS nNoPages, 
		session.SessionSeconds AS nSessionSeconds
FROM	@Sessions session
		INNER JOIN @UserScope scope
			ON session.UserID = scope.nDirId
		INNER JOIN tblDirectory users
			ON session.UserID = users.nDirKey
ORDER BY session.SessionStart DESC	
END


CREATE NONCLUSTERED INDEX [idx_tblActivityLog_cSessionId] ON [dbo].[tblActivityLog] 
(
	[cSessionId] ASC
) ON [PRIMARY]


CREATE NONCLUSTERED INDEX [idx_tblActivityLog_dDateTime] ON [dbo].[tblActivityLog] 
(
	[dDateTime] ASC
) ON [PRIMARY]


CREATE NONCLUSTERED INDEX [idx_tblActivityLog_User_Struct] ON [dbo].[tblActivityLog] 
(
	[nUserDirId] ASC,
	[nStructId] ASC
) ON [PRIMARY]
