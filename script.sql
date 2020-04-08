/****** Object:  Schema [Deploy]    Script Date: 9/8/2019 8:51:29 PM ******/
CREATE SCHEMA [Deploy]
GO
/****** Object:  Schema [Graph]    Script Date: 9/8/2019 8:51:29 PM ******/
CREATE SCHEMA [Graph]
GO
/****** Object:  Schema [LandNFL]    Script Date: 9/8/2019 8:51:29 PM ******/
CREATE SCHEMA [LandNFL]
GO
/****** Object:  Schema [LandRef]    Script Date: 9/8/2019 8:51:29 PM ******/
CREATE SCHEMA [LandRef]
GO
/****** Object:  Schema [Mapping]    Script Date: 9/8/2019 8:51:30 PM ******/
CREATE SCHEMA [Mapping]
GO
/****** Object:  Schema [MasterNFL]    Script Date: 9/8/2019 8:51:30 PM ******/
CREATE SCHEMA [MasterNFL]
GO
/****** Object:  Schema [NFLDB]    Script Date: 9/8/2019 8:51:30 PM ******/
CREATE SCHEMA [NFLDB]
GO
/****** Object:  Schema [Reference]    Script Date: 9/8/2019 8:51:30 PM ******/
CREATE SCHEMA [Reference]
GO
/****** Object:  Schema [SRCNFL]    Script Date: 9/8/2019 8:51:30 PM ******/
CREATE SCHEMA [SRCNFL]
GO
/****** Object:  Table [Mapping].[team]    Script Date: 9/8/2019 8:51:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Mapping].[team](
	[TeamKey] [int] IDENTITY(1,1) NOT NULL,
	[TeamSuperKey] [int] NULL,
	[SOURCE] [nvarchar](50) NULL,
	[TeamID] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[isPrimary] [bit] NULL,
	[Conference] [nvarchar](50) NULL,
	[Division] [nvarchar](50) NULL,
	[isSourceDup] [bit] NULL,
 CONSTRAINT [PK_team] PRIMARY KEY CLUSTERED 
(
	[TeamKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NFLDB].[Franchise]    Script Date: 9/8/2019 8:51:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NFLDB].[Franchise](
	[FranchiseKey] [int] IDENTITY(1,1) NOT NULL,
	[Team] [nvarchar](255) NULL,
	[From] [int] NULL,
	[To] [int] NULL,
	[W] [int] NULL,
	[L] [int] NULL,
	[T] [int] NULL,
	[W-L%] [float] NULL,
	[AV] [nvarchar](255) NULL,
	[Passer] [nvarchar](255) NULL,
	[Rusher] [nvarchar](255) NULL,
	[Receiver] [nvarchar](255) NULL,
	[Coaching] [nvarchar](255) NULL,
	[Yrplyf] [int] NULL,
	[Chmp] [int] NULL,
	[SBwl] [int] NULL,
	[Conf] [int] NULL,
	[Div] [int] NULL,
 CONSTRAINT [PK_Franchise] PRIMARY KEY CLUSTERED 
(
	[FranchiseKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Graph].[Franchise]    Script Date: 9/8/2019 8:51:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Graph].[Franchise]
AS
SELECT f.FranchiseKey,
	f.Team,
	f.[From],
	f.[To],
	f.W,
	f.L,
	f.T,
	f.[W-L%],
	f.AV,
	f.Passer,
	f.Rusher,
	f.Receiver,
	f.Coaching,
	f.Yrplyf,
	f.Chmp,
	f.SBwl,
	f.Conf,
	f.Div,
	t.TeamSuperKey,
	t.TeamID TeamNameLong,
	t2.TeamID TeamNameShort,
	t2.Conference,
	t2.Division
FROM NFLDB.Franchise AS f
	 LEFT JOIN Mapping.team AS t ON t.TeamID=f.Team AND t.SOURCE='LandRNK.Franchise'
	 LEFT JOIN Mapping.team AS t2 ON t2.TeamSuperKey=t.TeamSuperKey AND t2.SOURCE='landnfl' AND t2.isSourceDup=0;
GO
/****** Object:  Table [NFLDB].[Game]    Script Date: 9/8/2019 8:51:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NFLDB].[Game](
	[GameKey] [int] IDENTITY(1,1) NOT NULL,
	[ScheduleKey] [int] NULL,
	[GameID] [int] NULL,
	[HomeAbbr] [varchar](50) NULL,
	[HomeTurnOver] [varchar](50) NULL,
	[HomeScoreQ1] [varchar](50) NULL,
	[HomeScoreQ2] [varchar](50) NULL,
	[HomeScoreQ3] [varchar](50) NULL,
	[HomeScoreQ4] [varchar](50) NULL,
	[HomeScoreQ5] [varchar](50) NULL,
	[HomeScoreTotal] [varchar](50) NULL,
	[AwayAbbr] [varchar](50) NULL,
	[AwayTurnOver] [varchar](50) NULL,
	[AwayScoreQ1] [varchar](50) NULL,
	[AwayScoreQ2] [varchar](50) NULL,
	[AwayScoreQ3] [varchar](50) NULL,
	[AwayScoreQ4] [varchar](50) NULL,
	[AwayScoreQ5] [varchar](50) NULL,
	[AwayScoreTotal] [varchar](50) NULL,
 CONSTRAINT [PK_GameKey] PRIMARY KEY CLUSTERED 
(
	[GameKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Graph].[Game]    Script Date: 9/8/2019 8:51:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Graph].[Game]
AS
SELECT
g.GameKey gameID,
g.GameID gameName,

--g.ScheduleKey,

g.HomeAbbr,
g.HomeTurnOver,
g.HomeScoreQ1,
g.HomeScoreQ2,
g.HomeScoreQ3,
g.HomeScoreQ4,
g.HomeScoreQ5,
g.HomeScoreTotal,
g.AwayAbbr,
g.AwayTurnOver,
g.AwayScoreQ1,
g.AwayScoreQ2,
g.AwayScoreQ3,
g.AwayScoreQ4,
g.AwayScoreQ5,
g.AwayScoreTotal ,
HomeTeam.TeamSuperKey HomeTeamSuperKey,
--HomeTeam.TeamID,
AwayTeam.TeamSuperKey AS AwayTeamSuperKey
--AwayTeam.TeamID,
FROM NFLDB.Game AS g
JOIN Mapping.team AS HomeTeam ON HomeTeam.TeamID = g.HomeAbbr AND HomeTeam.SOURCE = 'landnfl' 
JOIN Mapping.team AS AwayTeam ON Awayteam.TeamID = g.AwayAbbr AND awayteam.SOURCE = 'landnfl'
GO
/****** Object:  Table [NFLDB].[Schedule]    Script Date: 9/8/2019 8:51:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NFLDB].[Schedule](
	[ScheduleKey] [int] IDENTITY(1,1) NOT NULL,
	[GameID] [int] NOT NULL,
	[SeasonYear] [smallint] NULL,
	[SeasonType] [varchar](4) NULL,
	[SeasonTypeDetail] [varchar](4) NULL,
	[WkNumber] [smallint] NULL,
	[DayName] [varchar](3) NULL,
	[GameDay] [date] NULL,
	[GameTime] [time](7) NULL,
	[GameTimeUTC] [time](7) NULL,
	[Qtr] [varchar](1) NULL,
	[HomeTeam] [varchar](8) NULL,
	[HomeTeamName] [varchar](32) NULL,
	[AwayTeam] [varchar](8) NULL,
	[AwayTeamName] [varchar](32) NULL,
 CONSTRAINT [PK_Schedule_1] PRIMARY KEY CLUSTERED 
(
	[ScheduleKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Graph].[Schedule]    Script Date: 9/8/2019 8:51:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Graph].[Schedule]
AS
SELECT s.ScheduleKey,
	   s.GameID,
	   s.SeasonYear,
	   s.SeasonType,
	   s.SeasonTypeDetail,
	   s.WkNumber,
	   s.DayName,
	   s.GameDay,
	   s.GameTime,
	   s.GameTimeUTC,
	   s.Qtr,
	   s.HomeTeam,
	   s.HomeTeamName,
	   HomeTeam.TeamSuperKey HomeTeamSuperKey,
	   s.AwayTeam,
	   s.AwayTeamName,
	   AwayTeam.TeamSuperKey AwayTeamSuperKey 
	   
	  FROM NFLDB.Schedule AS s
	   

	  JOIN Mapping.team AS HomeTeam ON HomeTeam.TeamID = s.HomeTeam AND HomeTeam.SOURCE = 'landnfl' 
	  JOIN Mapping.team AS AwayTeam ON Awayteam.TeamID = s.AwayTeam AND awayteam.SOURCE = 'landnfl'


GO
/****** Object:  Table [MasterNFL].[play]    Script Date: 9/8/2019 8:51:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MasterNFL].[play](
	[eid] [int] NOT NULL,
	[drivenumber] [int] NOT NULL,
	[playnumber] [int] NOT NULL,
	[posteam] [varchar](50) NULL,
	[desc] [varchar](5000) NULL,
	[ydstogo] [varchar](50) NULL,
	[note] [varchar](50) NULL,
	[qtr] [varchar](50) NULL,
	[yrdln] [varchar](50) NULL,
	[sp] [varchar](50) NULL,
	[down] [varchar](50) NULL,
	[time] [varchar](50) NULL,
	[ydsnet] [varchar](50) NULL,
	[createts] [datetime] NULL,
	[modifyts] [datetime] NULL,
	[deletets] [datetime] NULL,
 CONSTRAINT [PK_pplay] PRIMARY KEY CLUSTERED 
(
	[eid] ASC,
	[drivenumber] ASC,
	[playnumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [NFLDB].[Play_vw]    Script Date: 9/8/2019 8:51:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [NFLDB].[Play_vw]
AS 

SELECT 
	   s.ScheduleKey,
       p.drivenumber DriveNumber,
       p.playnumber PlayNumber,
       p.qtr Qtr ,
	   p.time PlayStartTime ,
	   CONVERT(INT,LEFT(p.time,2)) * 60 + CONVERT(INT,RIGHT(p.time,2)) PlayStartTimeSeconds,
	   p.posteam PossessionTeam,
	   --p.yrdln YardLine,
	   	   CASE WHEN LEFT(p.yrdln, 3) = p.posteam 
					THEN  CONVERT(INT,RIGHT(p.yrdln, 2)) -50 
					ELSE  CONVERT(INT,RIGHT(p.yrdln, 2) ) 
				   END RelativeYardLine,
       p.ydstogo YardsToGo,
       p.ydsnet YardsNet,
	          p.sp ScoredPoint,
       p.down Down,
       p.[desc] [Description],
       p.note Note 

  FROM MasterNFL.play AS p
JOIN NFLDB.Schedule AS s ON p.eid = s.GameID 

WHERE p.deletets IS NULL
GO
/****** Object:  Table [MasterNFL].[game]    Script Date: 9/8/2019 8:51:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MasterNFL].[game](
	[eid] [int] NOT NULL,
	[home-abbr] [varchar](50) NULL,
	[home-players] [varchar](50) NULL,
	[away-to] [varchar](50) NULL,
	[away-score-1] [varchar](50) NULL,
	[away-score-2] [varchar](50) NULL,
	[away-score-3] [varchar](50) NULL,
	[away-score-4] [varchar](50) NULL,
	[away-score-5] [varchar](50) NULL,
	[away-score-T] [varchar](50) NULL,
	[away-stats-team-totfd] [varchar](50) NULL,
	[away-stats-team-pt] [varchar](50) NULL,
	[away-stats-team-ptyds] [varchar](50) NULL,
	[away-stats-team-trnovr] [varchar](50) NULL,
	[away-stats-team-pyds] [varchar](50) NULL,
	[away-stats-team-ryds] [varchar](50) NULL,
	[away-stats-team-totyds] [varchar](50) NULL,
	[away-stats-team-ptavg] [varchar](50) NULL,
	[away-stats-team-pen] [varchar](50) NULL,
	[away-stats-team-penyds] [varchar](50) NULL,
	[away-stats-team-top] [varchar](50) NULL,
	[away-abbr] [varchar](50) NULL,
	[away-players] [varchar](50) NULL,
	[home-to] [varchar](50) NULL,
	[home-score-1] [varchar](50) NULL,
	[home-score-2] [varchar](50) NULL,
	[home-score-3] [varchar](50) NULL,
	[home-score-4] [varchar](50) NULL,
	[home-score-5] [varchar](50) NULL,
	[home-score-T] [varchar](50) NULL,
	[home-stats-team-totfd] [varchar](50) NULL,
	[home-stats-team-pt] [varchar](50) NULL,
	[home-stats-team-ptyds] [varchar](50) NULL,
	[home-stats-team-trnovr] [varchar](50) NULL,
	[home-stats-team-pyds] [varchar](50) NULL,
	[home-stats-team-ryds] [varchar](50) NULL,
	[home-stats-team-totyds] [varchar](50) NULL,
	[home-stats-team-ptavg] [varchar](50) NULL,
	[home-stats-team-pen] [varchar](50) NULL,
	[home-stats-team-penyds] [varchar](50) NULL,
	[home-stats-team-top] [varchar](50) NULL,
	[current-quarter] [varchar](50) NULL,
	[createts] [datetime] NULL,
	[modifyts] [datetime] NULL,
	[deletets] [datetime] NULL,
 CONSTRAINT [PK_game] PRIMARY KEY CLUSTERED 
(
	[eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [NFLDB].[GameDataNeedsRefresh]    Script Date: 9/8/2019 8:51:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [NFLDB].[GameDataNeedsRefresh] 
AS 



SELECT s.*, g.[current-quarter]
FROM NFLDB.Schedule AS s
	 left JOIN MasterNFL.game AS g ON g.eid=s.GameID
WHERE s.SeasonYear=2019
	AND ISNULL(g.[current-quarter], '1') not like '%Final%' 
	AND s.GameDay<=GETDATE()


GO
/****** Object:  Table [LandRef].[Franchise]    Script Date: 9/8/2019 8:51:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LandRef].[Franchise](
	[Franchisetype] [float] NULL,
	[Parent] [nvarchar](255) NULL,
	[Team] [nvarchar](255) NULL,
	[From] [float] NULL,
	[To] [float] NULL,
	[W] [float] NULL,
	[L] [float] NULL,
	[T] [float] NULL,
	[W-L%] [float] NULL,
	[AV] [nvarchar](255) NULL,
	[Passer] [nvarchar](255) NULL,
	[Rusher] [nvarchar](255) NULL,
	[Receiver] [nvarchar](255) NULL,
	[Coaching] [nvarchar](255) NULL,
	[Yrplyf] [float] NULL,
	[Chmp] [float] NULL,
	[SBwl] [float] NULL,
	[Conf] [float] NULL,
	[Div] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  View [NFLDB].[Franchise_vw]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [NFLDB].[Franchise_vw]
AS
SELECT 
  f.[Parent],
  f.Team,
  f.[From],
  f.[To],
  f.W,
  f.L,
  f.T,
  f.[W-L%],
  f.AV,
  f.Passer,
  f.Rusher,
  f.Receiver,
  f.Coaching,
  f.[Yrplyf],
  f.Chmp,
  f.SBwl,
  f.Conf,
  f.Div FROM LandRef.Franchise AS f
  WHERE f.Franchisetype IN (3,1)


GO
/****** Object:  Table [LandNFL].[Schedule]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LandNFL].[Schedule](
	[ScheduleXML] [xml] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [LandNFL].[Schedule_vw]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW	[LandNFL].[Schedule_vw] AS 

SELECT 
	  gd.value('@eid','int') AS eid,
	  gd.value('@gsis', 'int') AS gsis,
	  wy.value('@y', 'smallint') AS SeasonYear,
	  wy.value('@t', 'varchar(4)') AS SeasonType,
	  gd.value('@gt', 'varchar(4)') AS SeasonTypeDetail,
      wy.value('@w', 'smallint') AS wkNumber,
	  gd.value('@d', 'varchar(3)') AS [dayName],
	  gd.value('@t', 'time') AS GameTime,	  
     CONVERT(TIME, CONVERT(DATETIME, gd.value('@t', 'time')) AT TIME ZONE 'Eastern Standard Time' AT TIME ZONE 'UTC') AS GameTimeUTC,
	  gd.value('@q', 'varchar(1)') AS Qtr,
	  gd.value('@h', 'varchar(8)') AS HomeTeam,
	  gd.value('@hnn', 'varchar(32)') AS HomeTeamName,
	  gd.value('@v', 'varchar(8)') AS AwayTeam,
	  gd.value('@vnn', 'varchar(32)') AS AwayTeamName

FROM 
      LandNFL.Schedule
	  CROSS APPLY schedulexml.nodes('/ss/gms') AS WeekYr(wy)
	  CROSS APPLY schedulexml.nodes('/ss/gms/g') AS game(gd)






GO
/****** Object:  View [NFLDB].[Game_vw]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [NFLDB].[Game_vw]
AS


SELECT [eid] AS GameID,
		s.ScheduleKey
      ,[home-abbr] AS [HomeAbbr]
      ,[home-to] AS [HomeTurnOver]
      ,[home-score-1] AS [HomeScoreQ1]
      ,[home-score-2] AS [HomeScoreQ2]
      ,[home-score-3] AS [HomeScoreQ3]
      ,[home-score-4] AS [HomeScoreQ4]
      ,[home-score-5] AS [HomeScoreQ5]
      ,[home-score-T] AS [HomeScoreTotal]
      ,[away-abbr] AS [AwayAbbr]
      ,[away-to] AS [AwayTurnOver]
      ,[away-score-1] AS [AwayScoreQ1]
      ,[away-score-2] AS [AwayScoreQ2]
      ,[away-score-3] AS [AwayScoreQ3]
      ,[away-score-4] AS [AwayScoreQ4]
      ,[away-score-5] AS [AwayScoreQ5]
      ,[away-score-T] AS [AwayScoreTotal]
     
  FROM [MasterNFL].[game] g
  JOIN NFLDB.Schedule AS s ON g.eid = s.GameID


  WHERE deletets IS NULL

GO
/****** Object:  Table [dbo].[ProcedureLog]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcedureLog](
	[ProcedureLogKey] [int] IDENTITY(1,1) NOT NULL,
	[ProcessName] [nvarchar](256) NULL,
	[SchemaName] [nvarchar](256) NULL,
	[ProcedureName] [varchar](300) NULL,
	[TableName] [nvarchar](256) NULL,
	[RecordsReceived] [int] NULL,
	[RecordsInserted] [int] NULL,
	[RecordsUpdated] [int] NULL,
	[RecordsDeleted] [int] NULL,
	[StartTime] [datetimeoffset](7) NULL,
	[EndTime] [datetimeoffset](7) NULL,
	[Duration] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProcedureLog_vw]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ProcedureLog_vw]
AS
SELECT	ProcedureLogKey,
        ProcessName,
        SchemaName,
        ProcedureName,
        TableName,
        RecordsReceived,
        RecordsInserted,
        RecordsUpdated,
        RecordsDeleted,
 		CONVERT(DATETIME, StartTime) AT TIME ZONE 'utc' AT TIME ZONE 'central standard time' AS CstStartTime,
		CONVERT(DATETIME, EndTime) AT TIME ZONE 'utc' AT TIME ZONE 'central standard time' AS CstEndTime,
		Duration, 
		RIGHT('00'+CONVERT(VARCHAR,(Duration/3600) % 24),2) + ':' +	RIGHT('00'+CONVERT(VARCHAR,(Duration/60) % 60),2) +':'+ RIGHT('00'+CONVERT(VARCHAR,Duration % 60),2) DurationHHMMSS
	
FROM ProcedureLog


GO
/****** Object:  Table [MasterNFL].[Schedule]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MasterNFL].[Schedule](
	[eid] [int] NOT NULL,
	[gsis] [int] NOT NULL,
	[SeasonYear] [smallint] NULL,
	[SeasonType] [varchar](4) NULL,
	[SeasonTypeDetail] [varchar](4) NULL,
	[wkNumber] [smallint] NULL,
	[DayName] [varchar](3) NULL,
	[GameTime] [time](7) NULL,
	[GameTimeUTC] [time](7) NULL,
	[Qtr] [varchar](1) NULL,
	[HomeTeam] [varchar](8) NULL,
	[HomeTeamName] [varchar](32) NULL,
	[AwayTeam] [varchar](8) NULL,
	[AwayTeamName] [varchar](32) NULL,
	[createts] [datetime] NULL,
	[modifyts] [datetime] NULL,
	[deletets] [datetime] NULL,
 CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED 
(
	[eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [NFLDB].[Schedule_vw]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--USE [NFLDBII]
--GO

--/****** Object:  View [NFLDB].[Schedule_vw]    Script Date: 1/25/2018 10:19:25 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [NFLDB].[Schedule_vw]
AS

SELECT 
	eid GameID,
    SeasonYear ,
    SeasonType ,
    SeasonTypeDetail ,
    wkNumber ,
    DayName ,
	CONVERT(DATE,LEFT(eid, 8)) AS GameDay,
    dateadd(Hour,12, GameTime) GameTime,
	dateadd(Hour,12, GameTimeUTC) GameTimeUTC,
    Qtr ,
    HomeTeam ,
    HomeTeamName ,
    AwayTeam ,
    AwayTeamName 

  FROM [MasterNFL].[Schedule]
  WHERE	 deletets IS NULL 
GO
/****** Object:  Table [MasterNFL].[drive]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MasterNFL].[drive](
	[eid] [int] NOT NULL,
	[drivenumber] [int] NOT NULL,
	[start-team] [varchar](50) NULL,
	[start-qtr] [varchar](50) NULL,
	[start-time] [varchar](50) NULL,
	[start-yrdln] [varchar](50) NULL,
	[end-team] [varchar](50) NULL,
	[end-qtr] [varchar](50) NULL,
	[end-time] [varchar](50) NULL,
	[end-yrdln] [varchar](50) NULL,
	[posteam] [varchar](50) NULL,
	[postime] [varchar](50) NULL,
	[qtr] [varchar](50) NULL,
	[numplays] [varchar](50) NULL,
	[result] [varchar](50) NULL,
	[ydsgained] [varchar](50) NULL,
	[fds] [varchar](50) NULL,
	[penyds] [varchar](50) NULL,
	[redzone] [varchar](50) NULL,
	[createts] [datetime] NULL,
	[modifyts] [datetime] NULL,
	[deletets] [datetime] NULL,
 CONSTRAINT [PK_drive] PRIMARY KEY CLUSTERED 
(
	[eid] ASC,
	[drivenumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [NFLDB].[Drive_vw]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [NFLDB].[Drive_vw]
AS
SELECT 
	   s.ScheduleKey,
       d.DriveNumber,
	   d.[start-team] AS StartTeam ,
       d.[start-qtr] AS StartQtr,
       d.[start-time] AS StartTime,
	   CONVERT(INT,LEFT(d.[start-time],2)) * 60 + CONVERT(INT,RIGHT(d.[start-time],2)) StartTimeSec,
       d.[start-yrdln] StartYardLine,
	   CASE WHEN LEFT(d.[start-yrdln], 3) = d.[start-team] 
					THEN  CONVERT(INT,RIGHT(d.[start-yrdln], 2)) -50 
					ELSE  CONVERT(INT,RIGHT(d.[start-yrdln], 2) ) 
				   END StartRelativeYardLine,
       d.[end-team] EndTeam ,
       d.[end-qtr] EndQtr,
       d.[end-time] EndTime,
	   CONVERT(INT,LEFT(d.[end-time],2)) * 60 + CONVERT(INT,RIGHT(d.[end-time],2)) EndTimeSec,
       d.[end-yrdln] EndYardLine,
	CASE WHEN LEFT(d.[end-yrdln], 3) = d.[start-team] 
			THEN  CONVERT(INT,RIGHT(d.[end-yrdln], 2)) -50 
			ELSE  CONVERT(INT,RIGHT(d.[end-yrdln], 2) ) 
			END EndRelativeYardLine,
       d.posteam PossessionTeam ,
       d.postime PossessionTime ,
       CONVERT(INT,REPLACE(LEFT(d.postime,2),':','')) * 60 + CONVERT(INT,RIGHT(d.postime,2)) PossessionTimeSec,
	   d.Qtr ,
       d.numplays PlayCount,
       d.result Result,
       d.ydsgained YardsGained,
       d.fds FirstDowns,
       d.penyds PenaltyYards,
       d.redzone RedZone

FROM MasterNFL.drive AS d
JOIN NFLDB.Schedule AS s  ON s.GameID = d.eid
WHERE d.deletets IS NULL 


GO
/****** Object:  Table [LandNFL].[drive]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LandNFL].[drive](
	[eid] [int] NOT NULL,
	[objectname] [varchar](50) NULL,
	[drivenumber] [varchar](50) NOT NULL,
	[posteam] [varchar](50) NULL,
	[ydsgained] [varchar](50) NULL,
	[redzone] [varchar](50) NULL,
	[postime] [varchar](50) NULL,
	[end-yrdln] [varchar](50) NULL,
	[end-team] [varchar](50) NULL,
	[end-qtr] [varchar](50) NULL,
	[end-time] [varchar](50) NULL,
	[start-yrdln] [varchar](50) NULL,
	[start-team] [varchar](50) NULL,
	[start-qtr] [varchar](50) NULL,
	[start-time] [varchar](50) NULL,
	[fds] [varchar](50) NULL,
	[result] [varchar](50) NULL,
	[numplays] [varchar](50) NULL,
	[qtr] [varchar](50) NULL,
	[penyds] [varchar](50) NULL,
 CONSTRAINT [PK_drive] PRIMARY KEY CLUSTERED 
(
	[eid] ASC,
	[drivenumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [LandNFL].[drive_vw]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [LandNFL].[drive_vw]
AS 


SELECT  [eid]
      ,CAST([drivenumber] AS INT) AS [drivenumber]
      ,[start-team]
      ,[start-qtr]
      ,[start-time]
      ,[start-yrdln]
      ,[end-team]
      ,[end-qtr]
      ,[end-time]
      ,[end-yrdln]
      ,[posteam]
      ,[postime]
      ,[qtr]
      ,[numplays]
      ,[result]
      ,[ydsgained]
      ,[fds]
      ,[penyds]
      ,[redzone]
  FROM [LandNFL].[drive]
GO
/****** Object:  Table [LandNFL].[game]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LandNFL].[game](
	[eid] [int] NOT NULL,
	[home-abbr] [varchar](50) NULL,
	[home-players] [varchar](50) NULL,
	[current-quarter] [varchar](50) NULL,
	[away-to] [varchar](50) NULL,
	[away-score-1] [varchar](50) NULL,
	[away-score-3] [varchar](50) NULL,
	[away-score-2] [varchar](50) NULL,
	[away-score-5] [varchar](50) NULL,
	[away-score-4] [varchar](50) NULL,
	[away-score-T] [varchar](50) NULL,
	[away-stats-team-totfd] [varchar](50) NULL,
	[away-stats-team-pt] [varchar](50) NULL,
	[away-stats-team-ptyds] [varchar](50) NULL,
	[away-stats-team-trnovr] [varchar](50) NULL,
	[away-stats-team-pyds] [varchar](50) NULL,
	[away-stats-team-ryds] [varchar](50) NULL,
	[away-stats-team-totyds] [varchar](50) NULL,
	[away-stats-team-ptavg] [varchar](50) NULL,
	[away-stats-team-pen] [varchar](50) NULL,
	[away-stats-team-penyds] [varchar](50) NULL,
	[away-stats-team-top] [varchar](50) NULL,
	[away-abbr] [varchar](50) NULL,
	[away-players] [varchar](50) NULL,
	[home-to] [varchar](50) NULL,
	[home-score-1] [varchar](50) NULL,
	[home-score-3] [varchar](50) NULL,
	[home-score-2] [varchar](50) NULL,
	[home-score-5] [varchar](50) NULL,
	[home-score-4] [varchar](50) NULL,
	[home-score-T] [varchar](50) NULL,
	[home-stats-team-totfd] [varchar](50) NULL,
	[home-stats-team-pt] [varchar](50) NULL,
	[home-stats-team-ptyds] [varchar](50) NULL,
	[home-stats-team-trnovr] [varchar](50) NULL,
	[home-stats-team-pyds] [varchar](50) NULL,
	[home-stats-team-ryds] [varchar](50) NULL,
	[home-stats-team-totyds] [varchar](50) NULL,
	[home-stats-team-ptavg] [varchar](50) NULL,
	[home-stats-team-pen] [varchar](50) NULL,
	[home-stats-team-penyds] [varchar](50) NULL,
	[home-stats-team-top] [varchar](50) NULL,
 CONSTRAINT [PK_game] PRIMARY KEY CLUSTERED 
(
	[eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [LandNFL].[game_vw]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [LandNFL].[game_vw]

AS 


SELECT g.eid,
	   g.[home-abbr],
	   g.[home-players],
	   g.[away-to],
	   g.[away-score-1],
	   g.[away-score-2],
	   g.[away-score-3],
	   g.[away-score-4],
	   g.[away-score-5],
	   g.[away-score-T],
	   g.[away-stats-team-totfd],
	   g.[away-stats-team-pt],
	   g.[away-stats-team-ptyds],
	   g.[away-stats-team-trnovr],
	   g.[away-stats-team-pyds],
	   g.[away-stats-team-ryds],
	   g.[away-stats-team-totyds],
	   g.[away-stats-team-ptavg],
	   g.[away-stats-team-pen],
	   g.[away-stats-team-penyds],
	   g.[away-stats-team-top],
	   g.[away-abbr],
	   g.[away-players],
	   g.[home-to],
	   g.[home-score-1],
	   g.[home-score-2],
	   g.[home-score-3],
	   g.[home-score-4],
	   g.[home-score-5],
	   g.[home-score-T],
	   g.[home-stats-team-totfd],
	   g.[home-stats-team-pt],
	   g.[home-stats-team-ptyds],
	   g.[home-stats-team-trnovr],
	   g.[home-stats-team-pyds],
	   g.[home-stats-team-ryds],
	   g.[home-stats-team-totyds],
	   g.[home-stats-team-ptavg],
	   g.[home-stats-team-pen],
	   g.[home-stats-team-penyds],
	   g.[home-stats-team-top],
	   g.[current-quarter] FROM LandNFL.game AS g
GO
/****** Object:  Table [LandNFL].[play]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LandNFL].[play](
	[eid] [int] NOT NULL,
	[objectnamedrive] [varchar](50) NULL,
	[drivenumber] [int] NOT NULL,
	[objectnameplay] [varchar](50) NULL,
	[playnumber] [int] NOT NULL,
	[posteam] [varchar](50) NULL,
	[desc] [varchar](5000) NULL,
	[ydstogo] [varchar](50) NULL,
	[note] [varchar](50) NULL,
	[qtr] [varchar](50) NULL,
	[yrdln] [varchar](50) NULL,
	[sp] [varchar](50) NULL,
	[down] [varchar](50) NULL,
	[time] [varchar](50) NULL,
	[ydsnet] [varchar](50) NULL,
 CONSTRAINT [PK_pplay] PRIMARY KEY CLUSTERED 
(
	[eid] ASC,
	[drivenumber] ASC,
	[playnumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [LandNFL].[play_vw]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [LandNFL].[play_vw]
AS 


SELECT p.eid,
	   p.drivenumber,
	   p.playnumber,
	   p.posteam,
	   p.[desc],
	   p.ydstogo,
	   p.note,
	   p.qtr,
	   p.yrdln,
	   p.sp,
	   p.down,
	   p.time,
	   p.ydsnet FROM LandNFL.play AS p
GO
/****** Object:  Table [LandNFL].[playplayer]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LandNFL].[playplayer](
	[eid] [int] NOT NULL,
	[objectnamedrive] [varchar](50) NULL,
	[drivenumber] [int] NOT NULL,
	[objectplaydrive] [varchar](50) NULL,
	[playnumber] [int] NOT NULL,
	[objectnameplayer] [varchar](50) NULL,
	[playerid] [varchar](50) NOT NULL,
	[objectnamesequence] [varchar](50) NULL,	
	[sequence] [varchar](50) NOT NULL,
	[statId] [varchar](50) NULL,
	[yards] [varchar](50) NULL,
	[clubcode] [varchar](50) NULL,	
	[playerName] [varchar](50) NULL,
 CONSTRAINT [PK_pplayplayer] PRIMARY KEY CLUSTERED 
(
	[eid] ASC,
	[drivenumber] ASC,
	[playnumber] ASC,
	[playerid] ASC,
	[sequence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [LandNFL].[playplayer_vw]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [LandNFL].[playplayer_vw]
as

SELECT 
	p.eid, 
	p.drivenumber, 
	p.playnumber, 
	p.playerid, 
	p.statId, 
	p.sequence, 
	p.playerName, 
	p.clubcode, 
	p.yards
FROM LandNFL.playplayer AS p;
GO
/****** Object:  View [Deploy].[LandRef_Franchise]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Deploy].[LandRef_Franchise]
as
SELECT *
  FROM (
VALUES
( 1, N'Franchise', N'Arizona Cardinals', 1920, 2017, 542, 732, 40, 0.426, N'Hart', N'Hart', N'Anderson', N'Fitzgerald', N'Whisenhunt', 10, 2, 0, 1, 8 ), 
( 2, N'Arizona Cardinals', N'Chicago Cardinals', 1920, 1943, 99, 141, 21, 0.413, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 1 ), 
( 2, N'Arizona Cardinals', N'Chi/Pit Cards/Steelers', 1944, 1944, 0, 10, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0 ), 
( 2, N'Arizona Cardinals', N'Chicago Cardinals', 1945, 1959, 66, 107, 4, 0.382, NULL, NULL, NULL, NULL, NULL, 2, 1, 0, 0, 2 ), 
( 2, N'Arizona Cardinals', N'St. Louis Cardinals', 1960, 1987, 186, 202, 14, 0.48, NULL, NULL, NULL, NULL, NULL, 3, 0, 0, 0, 2 ), 
( 2, N'Arizona Cardinals', N'Phoenix Cardinals', 1988, 1993, 32, 64, 0, 0.333, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0 ), 
( 2, N'Arizona Cardinals', N'Arizona Cardinals', 1994, 2017, 159, 208, 1, 0.433, NULL, NULL, NULL, NULL, NULL, 5, 0, 0, 1, 3 ), 
( 3, N'Franchise', N'Atlanta Falcons', 1966, 2017, 341, 437, 6, 0.438, N'Kenn', N'Ryan', N'Riggs', N'White', N'Smith', 13, 0, 0, 2, 7 ), 
( 3, N'Franchise', N'Baltimore Ravens', 1996, 2017, 181, 154, 1, 0.54, N'Lewis', N'Flacco', N'Lewis', N'Mason', N'Harbaugh', 10, 2, 2, 2, 4 ), 
( 3, N'Franchise', N'Buffalo Bills', 1960, 2017, 400, 460, 8, 0.465, N'Smith', N'Kelly', N'Thomas', N'Reed', N'Levy', 17, 2, 0, 4, 11 ), 
( 3, N'Franchise', N'Carolina Panthers', 1995, 2017, 172, 179, 1, 0.49, N'Smith', N'Newton', N'Williams', N'Smith', N'Fox', 7, 0, 0, 2, 6 ), 
( 1, N'Franchise', N'Chicago Bears', 1920, 2017, 744, 568, 42, 0.567, N'Payton', N'Cutler', N'Payton', N'Morris', N'Halas', 25, 9, 1, 2, 23 ), 
( 2, N'Chicago Bears', N'Decatur Staleys', 1920, 1920, 10, 1, 2, 0.909, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0 ), 
( 2, N'Chicago Bears', N'Chicago Staleys', 1921, 1921, 9, 1, 1, 0.9, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 1 ), 
( 2, N'Chicago Bears', N'Chicago Bears', 1922, 2017, 725, 566, 39, 0.562, NULL, NULL, NULL, NULL, NULL, 25, 8, 1, 2, 22 ), 
( 3, N'Franchise', N'Cincinnati Bengals', 1968, 2017, 344, 408, 4, 0.458, N'Munoz', N'Anderson', N'Dillon', N'Johnson', N'Lewis', 14, 0, 0, 2, 10 ), 
( 3, N'Franchise', N'Cleveland Browns', 1946, 2017, 509, 470, 13, 0.52, N'Matthews', N'Sipe', N'Brown', N'Newsome', N'Brown', 28, 8, 0, 0, 23 ), 
( 3, N'Franchise', N'Dallas Cowboys', 1960, 2017, 493, 367, 6, 0.573, N'Smith', N'Romo', N'Smith', N'Irvin', N'Landry', 32, 5, 5, 8, 23 ), 
( 3, N'Franchise', N'Denver Broncos', 1960, 2017, 465, 393, 10, 0.542, N'Elway', N'Elway', N'Davis', N'Smith', N'Shanahan', 22, 3, 3, 8, 15 ), 
( 1, N'Franchise', N'Detroit Lions', 1930, 2017, 544, 641, 32, 0.459, N'Sanders', N'Stafford', N'Sanders', N'Johnson', N'Fontes', 17, 4, 0, 0, 8 ), 
( 2, N'Detroit Lions', N'Portsmouth Spartans', 1930, 1933, 28, 16, 7, 0.636, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0 ), 
( 2, N'Detroit Lions', N'Detroit Lions', 1934, 2017, 516, 625, 25, 0.452, NULL, NULL, NULL, NULL, NULL, 17, 4, 0, 0, 8 ), 
( 3, N'Franchise', N'Green Bay Packers', 1921, 2017, 730, 553, 37, 0.569, N'Favre', N'Favre', N'Green', N'Driver', N'Lambeau', 32, 13, 4, 5, 28 ), 
( 3, N'Franchise', N'Houston Texans', 2002, 2017, 106, 134, 0, 0.442, N'Johnson', N'Schaub', N'Foster', N'Johnson', N'Kubiak', 4, 0, 0, 0, 4 ), 
( 1, N'Franchise', N'Indianapolis Colts', 1953, 2017, 502, 441, 7, 0.532, N'Manning', N'Manning', N'James', N'Harrison', N'Dungy', 27, 4, 2, 4, 21 ), 
( 2, N'Indianapolis Colts', N'Baltimore Colts', 1953, 1983, 222, 194, 7, 0.534, NULL, NULL, NULL, NULL, NULL, 10, 3, 1, 2, 10 ), 
( 2, N'Indianapolis Colts', N'Indianapolis Colts', 1984, 2017, 280, 247, 0, 0.531, NULL, NULL, NULL, NULL, NULL, 17, 1, 1, 2, 11 ), 
( 3, N'Franchise', N'Jacksonville Jaguars', 1995, 2017, 155, 197, 0, 0.44, N'Smith', N'Brunell', N'Taylor', N'Smith', N'Coughlin', 6, 0, 0, 0, 2 ), 
( 1, N'Franchise', N'Kansas City Chiefs', 1960, 2017, 447, 409, 12, 0.522, N'Shields', N'Dawson', N'Charles', N'Gonzalez', N'Stram', 19, 2, 1, 2, 10 ), 
( 2, N'Kansas City Chiefs', N'Dallas Texans', 1960, 1962, 25, 17, 0, 0.595, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, 1 ), 
( 2, N'Kansas City Chiefs', N'Kansas City Chiefs', 1963, 2017, 422, 392, 12, 0.518, NULL, NULL, NULL, NULL, NULL, 18, 1, 1, 2, 9 ), 
( 1, N'Franchise', N'Los Angeles Chargers', 1960, 2017, 426, 431, 11, 0.497, N'Seau', N'Rivers', N'Tomlinson', N'Gates', N'Gillman', 18, 1, 0, 1, 15 ), 
( 2, N'Los Angeles Chargers', N'Los Angeles Chargers', 1960, 1960, 10, 4, 0, 0.714, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 1 ), 
( 2, N'Los Angeles Chargers', N'San Diego Chargers', 1961, 2016, 416, 427, 11, 0.493, NULL, NULL, NULL, NULL, NULL, 17, 1, 0, 1, 14 ), 
( 2, N'Los Angeles Chargers', N'Los Angeles Chargers', 2017, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL ), 
( 1, N'Franchise', N'Los Angeles Rams', 1937, 2017, 544, 554, 21, 0.495, N'Olsen', N'Everett', N'Jackson', N'Bruce', N'Robinson', 27, 3, 1, 3, 20 ), 
( 2, N'Los Angeles Rams', N'Cleveland Rams', 1937, 1945, 34, 50, 2, 0.405, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, 2 ), 
( 2, N'Los Angeles Rams', N'Los Angeles Rams', 1946, 1994, 364, 299, 18, 0.549, NULL, NULL, NULL, NULL, NULL, 21, 1, 0, 1, 15 ), 
( 2, N'Los Angeles Rams', N'St. Louis Rams', 1995, 2015, 142, 193, 1, 0.424, NULL, NULL, NULL, NULL, NULL, 5, 1, 1, 2, 3 ), 
( 2, N'Los Angeles Rams', N'Los Angeles Rams', 2016, 2017, 4, 12, 0, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0 ), 
( 3, N'Franchise', N'Miami Dolphins', 1966, 2017, 439, 341, 4, 0.563, N'Marino', N'Marino', N'Csonka', N'Duper', N'Shula', 23, 2, 2, 5, 14 ), 
( 3, N'Franchise', N'Minnesota Vikings', 1961, 2017, 457, 387, 10, 0.541, N'Eller', N'Tarkenton', N'Peterson', N'Carter', N'Grant', 28, 0, 0, 4, 19 ), 
( 1, N'Franchise', N'New England Patriots', 1960, 2017, 476, 383, 9, 0.554, N'Brady', N'Brady', N'Cunningham', N'Morgan', N'Belichick', 24, 5, 5, 9, 19 ), 
( 2, N'New England Patriots', N'Boston Patriots', 1960, 1970, 65, 80, 9, 0.448, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 1 ), 
( 2, N'New England Patriots', N'New England Patriots', 1971, 2017, 411, 303, 0, 0.576, NULL, NULL, NULL, NULL, NULL, 23, 5, 5, 9, 18 ), 
( 1, N'Franchise', N'New Orleans Saints', 1967, 2017, 338, 427, 5, 0.442, N'Brees', N'Brees', N'McAllister', N'Colston', N'Payton', 10, 1, 1, 1, 5 ), 
( 1, N'Franchise', N'New York Giants', 1925, 2017, 684, 572, 33, 0.544, N'Taylor', N'Manning', N'Barber', N'Toomer', N'Owen', 32, 8, 4, 5, 25 ), 
( 3, N'Franchise', N'New York Jets', 1960, 2017, 392, 468, 8, 0.456, N'Maynard', N'Namath', N'Martin', N'Maynard', N'Ewbank', 14, 1, 1, 1, 4 ), 
( 2, N'New York Jets', N'New York Titans', 1960, 1962, 19, 23, 0, 0.452, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0 ), 
( 2, N'New York Jets', N'New York Jets', 1963, 2017, 373, 445, 8, 0.456, NULL, NULL, NULL, NULL, NULL, 14, 1, 1, 1, 4 ), 
( 3, N'Franchise', N'Oakland Raiders', 1960, 2017, 456, 401, 11, 0.532, N'Otto', N'Stabler', N'Allen', N'Brown', N'Madden', 22, 3, 3, 5, 16 ), 
( 2, N'Oakland Raiders', N'Oakland Raiders', 1960, 1981, 195, 110, 11, 0.638, NULL, NULL, NULL, NULL, NULL, 11, 2, 2, 3, 9 ), 
( 2, N'Oakland Raiders', N'Los Angeles Raiders', 1982, 1994, 118, 82, 0, 0.59, NULL, NULL, NULL, NULL, NULL, 7, 1, 1, 1, 4 ), 
( 2, N'Oakland Raiders', N'Oakland Raiders', 1995, 2017, 143, 209, 0, 0.406, NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 1, 3 ), 
( 3, N'Franchise', N'Philadelphia Eagles', 1933, 2017, 555, 591, 26, 0.484, N'McNabb', N'McNabb', N'McCoy', N'Carmichael', N'Reid', 24, 3, 0, 2, 13 ), 
( 2, N'Philadelphia Eagles', N'Philadelphia Eagles', 1933, 1942, 23, 82, 4, 0.219, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0 ), 
( 2, N'Philadelphia Eagles', N'Phi/Pit Eagles/Steelers', 1943, 1943, 5, 4, 1, 0.556, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0 ), 
( 2, N'Philadelphia Eagles', N'Philadelphia Eagles', 1944, 2017, 527, 505, 21, 0.511, NULL, NULL, NULL, NULL, NULL, 24, 3, 0, 2, 13 ), 
( 3, N'Franchise', N'Pittsburgh Steelers', 1933, 2017, 606, 549, 21, 0.525, N'Roethlisberger', N'Roethlisberger', N'Harris', N'Ward', N'Noll', 30, 6, 6, 8, 23 ), 
( 2, N'Pittsburgh Steelers', N'Pittsburgh Pirates', 1933, 1939, 22, 55, 3, 0.286, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0 ), 
( 2, N'Pittsburgh Steelers', N'Pittsburgh Steelers', 1940, 1942, 10, 20, 3, 0.333, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0 ), 
( 2, N'Pittsburgh Steelers', N'Phi/Pit Eagles/Steelers', 1943, 1943, 5, 4, 1, 0.556, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0 ), 
( 2, N'Pittsburgh Steelers', N'Chi/Pit Cards/Steelers', 1944, 1944, 0, 10, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0 ), 
( 2, N'Pittsburgh Steelers', N'Pittsburgh Steelers', 1945, 2017, 569, 460, 14, 0.553, NULL, NULL, NULL, NULL, NULL, 30, 6, 6, 8, 23 ), 
( 1, N'Franchise', N'San Francisco 49ers', 1946, 2017, 560, 464, 16, 0.547, N'Rice', N'Montana', N'Gore', N'Rice', N'Seifert', 26, 5, 5, 6, 20 ), 
( 1, N'Franchise', N'Seattle Seahawks', 1976, 2017, 325, 318, 1, 0.505, N'Largent', N'Hasselbeck', N'Alexander', N'Largent', N'Holmgren', 16, 1, 1, 3, 10 ), 
( 1, N'Franchise', N'Tampa Bay Buccaneers', 1976, 2017, 250, 393, 1, 0.389, N'Brooks', N'Testaverde', N'Wilder', N'Carrier', N'Gruden', 10, 1, 1, 1, 6 ), 
( 3, N'Franchise', N'Tennessee Titans', 1960, 2017, 413, 449, 6, 0.479, N'Matthews', N'Moon', N'George', N'Givins', N'Fisher', 21, 2, 0, 1, 9 ), 
( 2, N'Tennessee Titans', N'Houston Oilers', 1960, 1996, 251, 291, 6, 0.463, NULL, NULL, NULL, NULL, NULL, 15, 2, 0, 0, 6 ), 
( 2, N'Tennessee Titans', N'Tennessee Oilers', 1997, 1998, 16, 16, 0, 0.5, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0 ), 
( 2, N'Tennessee Titans', N'Tennessee Titans', 1999, 2017, 146, 142, 0, 0.507, NULL, NULL, NULL, NULL, NULL, 6, 0, 0, 1, 3 ), 
( 3, N'Franchise', N'Washington Redskins', 1932, 2017, 586, 572, 28, 0.506, N'Green', N'Theismann', N'Riggins', N'Monk', N'Gibbs', 24, 5, 3, 5, 15 ), 
( 2, N'Washington Redskins', N'Boston Braves', 1932, 1932, 4, 4, 2, 0.5, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0 ), 
( 2, N'Washington Redskins', N'Boston Redskins', 1933, 1936, 20, 24, 3, 0.455, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 1 ), 
( 2, N'Washington Redskins', N'Washington Redskins', 1937, 2017, 562, 544, 23, 0.508, NULL, NULL, NULL, NULL, NULL, 23, 5, 3, 5, 14 )

)t ( [Franchisetype], [Parent], [Team], [From], [To] , [W] , [L] , [T] , [W-L%] , [AV] , [Passer] , [Rusher] , [Receiver] , [Coaching] , [Yrplyf] , [Chmp], [SBwl] , [Conf] , [Div] )
GO
/****** Object:  View [Deploy].[Mapping_team]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE TABLE #temptable ( [TeamKey] int, [TeamSuperKey] int, [SOURCE] nvarchar(50), [TeamID] nvarchar(50), [City] nvarchar(50), [Name] nvarchar(50), [isPrimary] bit, [Conference] nvarchar(50), [Division] nvarchar(50), [isSourceDup] bit )


CREATE VIEW [Deploy].[Mapping_team]
as
SELECT *
  FROM (
VALUES
( 1, 1, N'LandNFL', N'ARI', N'Arizona', N'Cardinals', 0, N'AFC', N'West', 0 ), 
( 2, 2, N'LandNFL', N'ATL', N'Atlanta', N'Falcons', 0, N'NFC', N'South', 0 ), 
( 3, 3, N'LandNFL', N'BAL', N'Baltimore', N'Ravens', 0, N'AFC', N'North', 0 ), 
( 4, 4, N'LandNFL', N'BUF', N'Buffalo', N'Bills', 0, N'AFC', N'East', 0 ), 
( 5, 5, N'LandNFL', N'CAR', N'Carolina', N'Panthers', 0, N'NFC', N'South', 0 ), 
( 6, 6, N'LandNFL', N'CHI', N'Chicago', N'Bears', 0, N'NFC', N'North', 0 ), 
( 7, 7, N'LandNFL', N'CIN', N'Cincinnati', N'Bengals', 0, N'AFC', N'North', 0 ), 
( 8, 8, N'LandNFL', N'CLE', N'Cleveland', N'Browns', 0, N'AFC', N'North', 0 ), 
( 9, 9, N'LandNFL', N'DAL', N'Dallas', N'Cowboys', 0, N'NFC', N'East', 0 ), 
( 10, 10, N'LandNFL', N'DEN', N'Denver', N'Broncos', 0, N'AFC', N'West', 0 ), 
( 11, 11, N'LandNFL', N'DET', N'Detroit', N'Lions', 0, N'NFC', N'North', 0 ), 
( 12, 12, N'LandNFL', N'GB', N'Green Bay', N'Packers', 0, N'NFC', N'North', 0 ), 
( 13, 13, N'LandNFL', N'HOU', N'Houston', N'Texans', 0, N'AFC', N'South', 0 ), 
( 14, 14, N'LandNFL', N'IND', N'Indianapolis', N'Colts', 0, N'AFC', N'South', 0 ), 
( 15, 15, N'LandNFL', N'JAC', N'Jacksonville', N'Jaguars', 0, N'AFC', N'South', 0 ), 
( 16, 15, N'LandNFL', N'JAX', N'Jacksonville', N'Jaguars', 0, NULL, NULL, 1 ), 
( 17, 16, N'LandNFL', N'KC', N'Kansas City', N'Chiefs', 0, N'AFC', N'West', 0 ), 
( 18, 34, N'LandNFL', N'LA', N'Los Angeles', N'Rams', 0, N'NFC', N'West', 0 ), 
( 19, 35, N'LandNFL', N'LAC', N'Los Angeles', N'Chargers', 0, N'AFC', N'West', 0 ), 
( 20, 19, N'LandNFL', N'MIA', N'Miami', N'Dolphins', 0, N'AFC', N'East', 0 ), 
( 21, 20, N'LandNFL', N'MIN', N'Minnesota', N'Vikings', 0, N'NFC', N'North', 0 ), 
( 22, 21, N'LandNFL', N'NE', N'New England', N'Patriots', 0, N'AFC', N'East', 0 ), 
( 23, 22, N'LandNFL', N'NO', N'New Orleans', N'Saints', 0, N'NFC', N'South', 0 ), 
( 24, 23, N'LandNFL', N'NYG', N'New York', N'Giants', 0, N'NFC', N'East', 0 ), 
( 25, 24, N'LandNFL', N'NYJ', N'New York', N'Jets', 0, N'AFC', N'East', 0 ), 
( 26, 25, N'LandNFL', N'OAK', N'Oakland', N'Raiders', 0, N'AFC', N'West', 0 ), 
( 27, 26, N'LandNFL', N'PHI', N'Philadelphia', N'Eagles', 0, N'NFC', N'East', 0 ), 
( 28, 27, N'LandNFL', N'PIT', N'Pittsburgh', N'Steelers', 0, N'AFC', N'North', 0 ), 
( 29, 18, N'LandNFL', N'SD', N'San Diego', N'Chargers', 0, N'AFC', N'West', 0 ), 
( 30, 28, N'LandNFL', N'SEA', N'Seattle', N'Seahawks', 0, N'NFC', N'West', 0 ), 
( 31, 29, N'LandNFL', N'SF', N'San Francisco', N'49ers', 0, N'NFC', N'West', 0 ), 
( 32, 17, N'LandNFL', N'STL', N'St. Louis', N'Rams', 0, N'NFC', N'West', 0 ), 
( 33, 30, N'LandNFL', N'TB', N'Tampa Bay', N'Buccaneers', 0, N'NFC', N'South', 0 ), 
( 34, 31, N'LandNFL', N'TEN', N'Tennessee', N'Titans', 0, N'AFC', N'South', 0 ), 
( 35, 32, N'LandNFL', N'UNK', N'UNK', N'UNK', 1, NULL, NULL, 0 ), 
( 36, 33, N'LandNFL', N'WAS', N'Washington', N'Redskins', 0, N'NFC', N'East', 0 ), 
( 241, 1, N'LandRNK.Franchise', N'Arizona Cardinals', NULL, N'Arizona Cardinals', 1, NULL, NULL, 0 ), 
( 242, 2, N'LandRNK.Franchise', N'Atlanta Falcons', NULL, N'Atlanta Falcons', 1, NULL, NULL, 0 ), 
( 243, 3, N'LandRNK.Franchise', N'Baltimore Ravens', NULL, N'Baltimore Ravens', 1, NULL, NULL, 0 ), 
( 244, 4, N'LandRNK.Franchise', N'Buffalo Bills', NULL, N'Buffalo Bills', 1, NULL, NULL, 0 ), 
( 245, 5, N'LandRNK.Franchise', N'Carolina Panthers', NULL, N'Carolina Panthers', 1, NULL, NULL, 0 ), 
( 247, 7, N'LandRNK.Franchise', N'Cincinnati Bengals', NULL, N'Cincinnati Bengals', 1, NULL, NULL, 0 ), 
( 248, 8, N'LandRNK.Franchise', N'Cleveland Browns', NULL, N'Cleveland Browns', 1, NULL, NULL, 0 ), 
( 249, 9, N'LandRNK.Franchise', N'Dallas Cowboys', NULL, N'Dallas Cowboys', 1, NULL, NULL, 0 ), 
( 250, 10, N'LandRNK.Franchise', N'Denver Broncos', NULL, N'Denver Broncos', 1, NULL, NULL, 0 ), 
( 251, 11, N'LandRNK.Franchise', N'Detroit Lions', NULL, N'Detroit Lions', 1, NULL, NULL, 0 ), 
( 252, 12, N'LandRNK.Franchise', N'Green Bay Packers', NULL, N'Green Bay Packers', 1, NULL, NULL, 0 ), 
( 253, 13, N'LandRNK.Franchise', N'Houston Texans', NULL, N'Houston Texans', 1, NULL, NULL, 0 ), 
( 254, 14, N'LandRNK.Franchise', N'Indianapolis Colts', NULL, N'Indianapolis Colts', 1, NULL, NULL, 0 ), 
( 255, 15, N'LandRNK.Franchise', N'Jacksonville Jaguars', NULL, N'Jacksonville Jaguars', 1, NULL, NULL, 0 ), 
( 256, 16, N'LandRNK.Franchise', N'Kansas City Chiefs', NULL, N'Kansas City Chiefs', 1, NULL, NULL, 0 ), 
( 257, 35, N'LandRNK.Franchise', N'Los Angeles Chargers', NULL, N'Los Angeles Chargers', 1, NULL, NULL, 0 ), 
( 258, 34, N'LandRNK.Franchise', N'Los Angeles Rams', NULL, N'Los Angeles Rams', 1, NULL, NULL, 0 ), 
( 259, 19, N'LandRNK.Franchise', N'Miami Dolphins', NULL, N'Miami Dolphins', 1, NULL, NULL, 0 ), 
( 260, 20, N'LandRNK.Franchise', N'Minnesota Vikings', NULL, N'Minnesota Vikings', 1, NULL, NULL, 0 ), 
( 261, 21, N'LandRNK.Franchise', N'New England Patriots', NULL, N'New England Patriots', 1, NULL, NULL, 0 ), 
( 262, 22, N'LandRNK.Franchise', N'New Orleans Saints', NULL, N'New Orleans Saints', 1, NULL, NULL, 0 ), 
( 263, 23, N'LandRNK.Franchise', N'New York Giants', NULL, N'New York Giants', 1, NULL, NULL, 0 ), 
( 264, 24, N'LandRNK.Franchise', N'New York Jets', NULL, N'New York Jets', 1, NULL, NULL, 0 ), 
( 265, 25, N'LandRNK.Franchise', N'Oakland Raiders', NULL, N'Oakland Raiders', 1, NULL, NULL, 0 ), 
( 266, 26, N'LandRNK.Franchise', N'Philadelphia Eagles', NULL, N'Philadelphia Eagles', 1, NULL, NULL, 0 ), 
( 267, 27, N'LandRNK.Franchise', N'Pittsburgh Steelers', NULL, N'Pittsburgh Steelers', 1, NULL, NULL, 0 ), 
( 268, 29, N'LandRNK.Franchise', N'San Francisco 49ers', NULL, N'San Francisco 49ers', 1, NULL, NULL, 0 ), 
( 269, 28, N'LandRNK.Franchise', N'Seattle Seahawks', NULL, N'Seattle Seahawks', 1, NULL, NULL, 0 ), 
( 270, 30, N'LandRNK.Franchise', N'Tampa Bay Buccaneers', NULL, N'Tampa Bay Buccaneers', 1, NULL, NULL, 0 ), 
( 272, 33, N'LandRNK.Franchise', N'Washington Redskins', NULL, N'Washington Redskins', 1, NULL, NULL, 0 ), 
( 277, NULL, N'LandRNK.Franchise', N'Chicago Cardinals', NULL, N'Chicago Cardinals', 0, NULL, NULL, 0 ), 
( 278, NULL, N'LandRNK.Franchise', N'St. Louis Cardinals', NULL, N'St. Louis Cardinals', 0, NULL, NULL, 0 ), 
( 279, NULL, N'LandRNK.Franchise', N'Phoenix Cardinals', NULL, N'Phoenix Cardinals', 0, NULL, NULL, 0 ), 
( 281, NULL, N'LandRNK.Franchise', N'Decatur Staleys', NULL, N'Decatur Staleys', 0, NULL, NULL, 0 ), 
( 282, NULL, N'LandRNK.Franchise', N'Chicago Staleys', NULL, N'Chicago Staleys', 0, NULL, NULL, 0 ), 
( 283, 6, N'LandRNK.Franchise', N'Chicago Bears', NULL, N'Chicago Bears', 1, NULL, NULL, 0 ), 
( 284, NULL, N'LandRNK.Franchise', N'Portsmouth Spartans', NULL, N'Portsmouth Spartans', 0, NULL, NULL, 0 ), 
( 286, NULL, N'LandRNK.Franchise', N'Baltimore Colts', NULL, N'Baltimore Colts', 0, NULL, NULL, 0 ), 
( 288, NULL, N'LandRNK.Franchise', N'Dallas Texans', NULL, N'Dallas Texans', 0, NULL, NULL, 0 ), 
( 291, 18, N'LandRNK.Franchise', N'San Diego Chargers', NULL, N'San Diego Chargers', 1, NULL, NULL, 0 ), 
( 293, NULL, N'LandRNK.Franchise', N'Cleveland Rams', NULL, N'Cleveland Rams', 0, NULL, NULL, 0 ), 
( 295, 17, N'LandRNK.Franchise', N'St. Louis Rams', NULL, N'St. Louis Rams', 1, NULL, NULL, 0 ), 
( 297, NULL, N'LandRNK.Franchise', N'Boston Patriots', NULL, N'Boston Patriots', 0, NULL, NULL, 0 ), 
( 299, NULL, N'LandRNK.Franchise', N'New York Titans', NULL, N'New York Titans', 0, NULL, NULL, 0 ), 
( 302, NULL, N'LandRNK.Franchise', N'Los Angeles Raiders', NULL, N'Los Angeles Raiders', 0, NULL, NULL, 0 ), 
( 305, NULL, N'LandRNK.Franchise', N'Phi/Pit Eagles/Steelers', NULL, N'Phi/Pit Eagles/Steelers', 0, NULL, NULL, 0 ), 
( 307, NULL, N'LandRNK.Franchise', N'Pittsburgh Pirates', NULL, N'Pittsburgh Pirates', 0, NULL, NULL, 0 ), 
( 310, NULL, N'LandRNK.Franchise', N'Chi/Pit Cards/Steelers', NULL, N'Chi/Pit Cards/Steelers', 0, NULL, NULL, 0 ), 
( 312, NULL, N'LandRNK.Franchise', N'Houston Oilers', NULL, N'Houston Oilers', 0, NULL, NULL, 0 ), 
( 313, NULL, N'LandRNK.Franchise', N'Tennessee Oilers', NULL, N'Tennessee Oilers', 0, NULL, NULL, 0 ), 
( 314, 31, N'LandRNK.Franchise', N'Tennessee Titans', NULL, N'Tennessee Titans', 1, NULL, NULL, 0 ), 
( 315, NULL, N'LandRNK.Franchise', N'Boston Braves', NULL, N'Boston Braves', 0, NULL, NULL, 0 ), 
( 316, NULL, N'LandRNK.Franchise', N'Boston Redskins', NULL, N'Boston Redskins', 0, NULL, NULL, 0 )

)t  ( [TeamKey] , [TeamSuperKey] , [SOURCE] , [TeamID] , [City] , [Name] , [isPrimary] , [Conference] , [Division] , [isSourceDup]  )
GO
/****** Object:  View [Deploy].[NFLDB_ScheduleDefinition]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create VIEW [Deploy].[NFLDB_ScheduleDefinition]
as
SELECT *
  FROM (
VALUES
( 1, 0, 'PRE', 'Preseason' ), 
( 2, 1, 'PRE', 'Preseason' ), 
( 3, 2, 'PRE', 'Preseason' ), 
( 4, 3, 'PRE', 'Preseason' ), 
( 5, 4, 'PRE', 'Preseason' ), 
( 6, 1, 'REG', 'Regular' ), 
( 7, 2, 'REG', 'Regular' ), 
( 8, 3, 'REG', 'Regular' ), 
( 9, 4, 'REG', 'Regular' ), 
( 10, 5, 'REG', 'Regular' ), 
( 11, 6, 'REG', 'Regular' ), 
( 12, 7, 'REG', 'Regular' ), 
( 13, 8, 'REG', 'Regular' ), 
( 14, 9, 'REG', 'Regular' ), 
( 15, 10, 'REG', 'Regular' ), 
( 16, 11, 'REG', 'Regular' ), 
( 17, 12, 'REG', 'Regular' ), 
( 18, 13, 'REG', 'Regular' ), 
( 19, 14, 'REG', 'Regular' ), 
( 20, 15, 'REG', 'Regular' ), 
( 21, 16, 'REG', 'Regular' ), 
( 22, 17, 'REG', 'Regular' ), 
( 23, 18, 'POST', 'Wild Card' ), 
( 24, 19, 'POST', 'Divisional' ), 
( 25, 20, 'POST', 'Conference ' ), 
( 26, 22, 'POST', 'Super Bowl' )

) t ([ScheduleDefinitionKey] , [Week] , [SeasonType] , [DESCRIPTION] )
GO
/****** Object:  View [Deploy].[Reference_Statistic]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE TABLE #temptable  ( [StatisticKey] int, [StatID] int, [Category] nvarchar(30), [FieldsValue] nvarchar(25), [FieldsYds] nvarchar(25), [Description] nvarchar(500), [LongDescription] nvarchar(500), [Negative] bit )
--INSERT INTO #temptable

CREATE VIEW [Deploy].[Reference_Statistic]
AS

SELECT * FROM (

VALUES
( 1, 10, N'rushing', N'rushing_att', N'rushing_yds', N'Rushing yards', N'Rushing yards and credit for a rushing attempt.', 0 ), 
( 2, 100, N'', N'', N'', N'', N'See Extra point - safety', 0 ), 
( 3, 102, N'team', N'kicking_downed', N'', N'Kickoff - kick downed', N'SuperStat didn"t have this code. A kickoff is downed when touched by an offensive player within the 10 yard free zone, and the ball is awarded to the receivers at the spot of the touch.', 0 ), 
( 4, 103, N'passing', N'', N'passing_sk_yds', N'Sack yards (offense), No sack', N'This stat will be used when the passer fumbles, then recovers, then laterals. The receiver of the lateral gets sack yardage but no sack.', 0 ), 
( 5, 104, N'receiving', N'receiving_twopta', N'', N'2 point pass reception - good', N'', 0 ), 
( 6, 104, N'receiving', N'receiving_twoptm', N'', N'2 point pass reception - good', N'', 0 ), 
( 7, 105, N'receiving', N'receiving_twopta', N'', N'2 point pass reception - failed', N'', 0 ), 
( 8, 105, N'receiving', N'receiving_twoptmissed', N'', N'2 point pass reception - failed', N'', 0 ), 
( 9, 106, N'fumbles', N'fumbles_lost', N'', N'Fumble - lost', N'', 0 ), 
( 10, 107, N'kicking', N'kicking_rec', N'', N'Own kickoff recovery', N'Direct recovery of own kickoff, whether or not the kickoff is onside', 0 ), 
( 11, 108, N'kicking', N'kicking_rec', N'', N'Own kickoff recovery, TD', N'Direct recovery in endzone of own kickoff, whether or not the kickoff is onside.', 0 ), 
( 12, 108, N'kicking', N'kicking_rec_tds', N'', N'Own kickoff recovery, TD', N'Direct recovery in endzone of own kickoff, whether or not the kickoff is onside.', 0 ), 
( 13, 11, N'rushing', N'rushing_att', N'rushing_yds', N'Rushing yards, TD', N'Rushing yards and credit for a rushing attempt where the result of the play was a touchdown.', 0 ), 
( 14, 11, N'rushing', N'rushing_tds', N'rushing_yds', N'Rushing yards, TD', N'Rushing yards and credit for a rushing attempt where the result of the play was a touchdown.', 0 ), 
( 15, 110, N'defense', N'defense_qbhit', N'', N'Quarterback hit', N'Player knocked the quarterback to the ground, quarterback was not the ball carrier. Not available for games before 2006 season.', 0 ), 
( 16, 111, N'passing', N'', N'passing_cmp_air_yds', N'Pass length, completion', N'Length of the pass, not including the yards gained by the receiver after the catch. Unofficial stat. Not available for games before 2006 season.', 0 ), 
( 17, 112, N'passing', N'', N'passing_incmp_air_yds', N'Pass length, No completion', N'Length of the pass, if it would have been a completion. Unofficial stat. Not available for games before 2006 season.', 0 ), 
( 18, 113, N'receiving', N'', N'receiving_yac_yds', N'Yardage gained after the catch', N'Yardage from where the ball was caught until the player"s action was over. Unofficial stat. Not available for games before 2006 season.', 0 ), 
( 19, 115, N'receiving', N'receiving_tar', N'', N'Pass target', N'Player was the target of a pass attempt. Unofficial stat. Not available for games before 2009 season.', 0 ), 
( 20, 12, N'rushing', N'', N'rushing_yds', N'Rushing yards, No rush', N'Rushing yards with no rushing attempt. This will occur when the initial runner laterals to a second runner, and the second runner possesses the lateral beyond the line of scrimmage. Both players get rushing yards, but only the first player gets a rushing attempt.', 0 ), 
( 21, 120, N'defense', N'defense_tkl_loss', N'', N'Tackle for a loss', N'Player tackled the runner behind the line of scrimmage. Play must have ended, player must have received a tackle stat, has to be an offensive player tackled. Unofficial stat. Not available for games before 2008 season.', 0 ), 
( 22, 13, N'rushing', N'rushing_tds', N'rushing_yds', N'Rushing yards, TD, No rush', N'Rushing yards and no rushing attempt, where the result of the play was a touchdown. (See id 12.)', 0 ), 
( 23, 14, N'passing', N'passing_att', N'', N'Pass incomplete', N'Pass atempt, incomplete.', 0 ), 
( 24, 14, N'passing', N'passing_incmp', N'', N'Pass incomplete', N'Pass atempt, incomplete.', 0 ), 
( 25, 15, N'passing', N'passing_att', N'passing_yds', N'Passing yards', N'Passing yards and a pass attempt completed.', 0 ), 
( 26, 15, N'passing', N'passing_cmp', N'passing_yds', N'Passing yards', N'Passing yards and a pass attempt completed.', 0 ), 
( 27, 16, N'passing', N'passing_att', N'passing_yds', N'Passing yards, TD', N'Passing yards and a pass attempt completed that resulted in a touchdown.', 0 ), 
( 28, 16, N'passing', N'passing_cmp', N'passing_yds', N'Passing yards, TD', N'Passing yards and a pass attempt completed that resulted in a touchdown.', 0 ), 
( 29, 16, N'passing', N'passing_tds', N'passing_yds', N'Passing yards, TD', N'Passing yards and a pass attempt completed that resulted in a touchdown.', 0 ), 
( 30, 17, N'passing', N'No Pass', N'', N'', N'In SuperStat, this code was used when the initial pass receiver lateraled to a teammate. It was later combined with the Passing Yards code to determine the passers (quarterbacks) total passing yardage on the play. This stat is not in use at this time.', 0 ), 
( 31, 17, N'passing', N'Passing Yards', N'', N'', N'In SuperStat, this code was used when the initial pass receiver lateraled to a teammate. It was later combined with the Passing Yards code to determine the passers (quarterbacks) total passing yardage on the play. This stat is not in use at this time.', 0 ), 
( 32, 18, N'passing', N'No Pass', N'', N'', N'Passing yards, no pass attempt, with a result of touchdown. This stat is not in use at this time.', 0 ), 
( 33, 18, N'passing', N'Passing Yards', N'', N'', N'Passing yards, no pass attempt, with a result of touchdown. This stat is not in use at this time.', 0 ), 
( 34, 18, N'passing', N'YD', N'', N'', N'Passing yards, no pass attempt, with a result of touchdown. This stat is not in use at this time.', 0 ), 
( 35, 19, N'passing', N'passing_att', N'', N'Interception (by passer)', N'Pass attempt that resulted in an interception.', 1 ), 
( 36, 19, N'passing', N'passing_incmp', N'', N'Interception (by passer)', N'Pass attempt that resulted in an interception.', 1 ), 
( 37, 19, N'passing', N'passing_int', N'', N'Interception (by passer)', N'Pass attempt that resulted in an interception.', 1 ), 
( 38, 2, N'punting', N'punting_blk', N'', N'Punt blocked (offense)', N'Punt was blocked. A blocked punt is a punt that is touched behind the line of scrimmage, and is recovered, or goes out of bounds, behind the line of scrimmage. If the impetus of the punt takes it beyond the line of scrimmage, it is not a blocked punt.', 1 ), 
( 39, 20, N'passing', N'passing_sk', N'passing_sk_yds', N'Sack yards (offense)', N'Number of yards lost on a pass play that resulted in a sack.', 1 ), 
( 40, 21, N'receiving', N'receiving_rec', N'receiving_yds', N'Pass reception yards', N'Pass reception and yards.', 0 ), 
( 41, 22, N'receiving', N'receiving_rec', N'receiving_yds', N'Pass reception yards, TD', N'Same as previous (21), except when the play results in a touchdown.', 0 ), 
( 42, 22, N'receiving', N'receiving_tds', N'receiving_yds', N'Pass reception yards, TD', N'Same as previous (21), except when the play results in a touchdown.', 0 ), 
( 43, 23, N'receiving', N'', N'receiving_yds', N'Pass reception yards, No reception', N'Pass reception yards, no pass reception. This will occur when the pass receiver laterals to a teammate. The teammate gets pass reception yards, but no credit for a pass reception.', 0 ), 
( 44, 24, N'receiving', N'receiving_tds', N'receiving_yds', N'Pass reception yards, TD, No reception', N'Same as previous (23), except when the play results in a touchdown.', 0 ), 
( 45, 25, N'defense', N'defense_int', N'defense_int_yds', N'Interception yards', N'Interception and return yards.', 0 ), 
( 46, 26, N'defense', N'defense_int', N'defense_int_yds', N'Interception yards, TD', N'Same as previous (25), except when the play results in a touchdown.', 0 ), 
( 47, 26, N'defense', N'defense_int_tds', N'defense_int_yds', N'Interception yards, TD', N'Same as previous (25), except when the play results in a touchdown.', 0 ), 
( 48, 26, N'defense', N'defense_tds', N'defense_int_yds', N'Interception yards, TD', N'Same as previous (25), except when the play results in a touchdown.', 0 ), 
( 49, 27, N'defense', N'', N'defense_int_yds', N'Interception yards, No interception', N'Interception yards, with no credit for an interception. This will occur when the player who intercepted the pass laterals to a teammate. The teammate gets interception return yards, but no credit for a pass interception.', 0 ), 
( 50, 28, N'defense', N'defense_int_tds', N'defense_int_yds', N'Interception yards, TD, No interception', N'Same as previous (27), except when the play results in a touchdown.', 0 ), 
( 51, 28, N'defense', N'defense_tds', N'defense_int_yds', N'Interception yards, TD, No interception', N'Same as previous (27), except when the play results in a touchdown.', 0 ), 
( 52, 29, N'punting', N'punting_tot', N'punting_yds', N'Punting yards', N'Punt and length of the punt. This stat is not used if the punt results in a touchback; or the punt is received in the endzone and run out; or the punt is blocked. This stat is used exclusively of the PU_EZ, PU_TB and PU_BK stats.', 0 ), 
( 53, 3, N'team', N'first_down', N'', N'1st down (rushing)', N'A first down or TD occurred due to a rush.', 0 ), 
( 54, 3, N'team', N'rushing_first_down', N'', N'1st down (rushing)', N'A first down or TD occurred due to a rush.', 0 ), 
( 55, 30, N'punting', N'punting_i20', N'', N'Punt inside 20', N'This stat is recorded when the punt return ended inside the opponent"s 20 yard line. This is not counted as a punt or towards punting yards. This stat is used solely to calculate inside 20 stats. This stat is used in addition to either a PU or PU_EZ stat.', 0 ), 
( 56, 301, N'team', N'xp_aborted', N'', N'Extra point - aborted', N'', 0 ), 
( 57, 31, N'punting', N'punting_tot', N'punting_yds', N'Punt into endzone', N'SuperStat records this stat when the punt is received in the endzone, and then run out of the endzone. If the play ends in the endzone for a touchback, the stat is not recorded. This stat is used exclusively of the PU, PU_TB and PU_BK stats.', 0 ), 
( 58, 32, N'punting', N'punting_tot', N'punting_yds', N'Punt with touchback', N'Punt and length of the punt when the play results in a touchback. This stat is used exclusively of the PU, PU_EZ and PU_BK stats.', 0 ), 
( 59, 32, N'punting', N'punting_touchback', N'punting_yds', N'Punt with touchback', N'Punt and length of the punt when the play results in a touchback. This stat is used exclusively of the PU, PU_EZ and PU_BK stats.', 0 ), 
( 60, 33, N'puntret', N'puntret_tot', N'puntret_yds', N'Punt return yards', N'Punt return and yards.', 0 ), 
( 61, 34, N'puntret', N'puntret_tds', N'puntret_yds', N'Punt return yards, TD', N'Same as previous (33), except when the play results in a touchdown.', 0 ), 
( 62, 34, N'puntret', N'puntret_tot', N'puntret_yds', N'Punt return yards, TD', N'Same as previous (33), except when the play results in a touchdown.', 0 ), 
( 63, 35, N'puntret', N'', N'puntret_yds', N'Punt return yards, No return', N'Punt return yards with no credit for a punt return. This will occur when the player who received the punt laterals to a teammate. The teammate gets punt return yards, but no credit for a return.', 0 ), 
( 64, 36, N'puntret', N'puntret_tds', N'puntret_yds', N'Punt return yards, TD, No return', N'Same as previous (35), except when the play results in a touchdown.', 0 ), 
( 65, 37, N'team', N'puntret_oob', N'', N'Punt out of bounds', N'Punt went out of bounds, no return on the play.', 0 ), 
( 66, 38, N'team', N'puntret_downed', N'', N'Punt downed (no return)', N'Punt was downed by kicking team, no return on the play. The player column this stat will always be NULL.', 1 ), 
( 67, 39, N'puntret', N'puntret_fair', N'', N'Punt - fair catch', N'Punt resulted in a fair catch.', 0 ), 
( 68, 4, N'team', N'first_down', N'', N'1st down (passing)', N'A first down or TD occurred due to a pass.', 0 ), 
( 69, 4, N'team', N'passing_first_down', N'', N'1st down (passing)', N'A first down or TD occurred due to a pass.', 0 ), 
( 70, 40, N'team', N'puntret_touchback', N'', N'Punt - touchback (no return)', N'Punt resulted in a touchback. This is the receiving team"s version of code 1504/28 (32) above. Both are needed for stat calculations, especially in season cumulative analysis.', 0 ), 
( 71, 402, N'defense', N'', N'defense_tkl_loss_yds', N'Tackle for a loss yards', N'', 0 ), 
( 72, 41, N'kicking', N'kicking_tot', N'kicking_yds', N'Kickoff yards', N'Kickoff and length of kick.', 0 ), 
( 73, 410, N'kicking', N'', N'kicking_all_yds', N'Kickoff and length of kick', N'Kickoff and length of kick. Includes end zone yards for all kicks into the end zone, including kickoffs ending in a touchback.', 0 ), 
( 74, 42, N'kicking', N'kicking_i20', N'', N'Kickoff inside 20', N'Kickoff and length of kick, where return ended inside opponent"s 20 yard line. This is not counted as a kick or towards kicking yards. This code is used solely to calculate inside 20 stats. used in addition to a 1701 code.', 0 ), 
( 75, 43, N'kicking', N'kicking_tot', N'kicking_yds', N'Kickff into endzone', N'SuperStat records this stat when the kickoff is received in the endzone, and then run out of the endzone. If the play ends in the endzone for a touchback, the stat is not recorded. Compare to Punt into endzone.', 0 ), 
( 76, 44, N'kicking', N'kicking_tot', N'kicking_yds', N'Kickoff with touchback', N'Kickoff resulted in a touchback.', 0 ), 
( 77, 44, N'kicking', N'kicking_touchback', N'kicking_yds', N'Kickoff with touchback', N'Kickoff resulted in a touchback.', 0 ), 
( 78, 45, N'kickret', N'kickret_ret', N'kickret_yds', N'Kickoff return yards', N'Kickoff return and yards.', 0 ), 
( 79, 46, N'kickret', N'kickret_ret', N'kickret_yds', N'Kickoff return yards, TD', N'Same as previous (45), except when the play results in a touchdown.', 0 ), 
( 80, 46, N'kickret', N'kickret_tds', N'kickret_yds', N'Kickoff return yards, TD', N'Same as previous (45), except when the play results in a touchdown.', 0 ), 
( 81, 47, N'kickret', N'', N'kickret_yds', N'Kickoff return yards, No return', N'Kickoff yards with no return. This will occur when the player who is credited with the return laterals to a teammate. The teammate gets kickoff return yards, but no credit for a kickoff return.', 0 ), 
( 82, 48, N'kickret', N'kickret_tds', N'kickret_yds', N'Kickoff return yards, TD, No return', N'Same as previous (47), except when the play results in a touchdown.', 0 ), 
( 83, 49, N'team', N'kickret_oob', N'', N'Kickoff out of bounds', N'Kicked ball went out of bounds.', 1 ), 
( 84, 5, N'team', N'first_down', N'', N'1st down (penalty)', N'A first down or TD occurred due to a penalty. A play can have a first down from a pass or rush and from a penalty.', 1 ), 
( 85, 5, N'team', N'penalty_first_down', N'', N'1st down (penalty)', N'A first down or TD occurred due to a penalty. A play can have a first down from a pass or rush and from a penalty.', 1 ), 
( 86, 50, N'kickret', N'kickret_fair', N'', N'Kickoff - fair catch', N'Kick resulted in a fair catch (no return).', 0 ), 
( 87, 51, N'team', N'kickret_touchback', N'', N'Kickoff - touchback', N'Kick resulted in a touchback. A touchback implies that there is no return.', 0 ), 
( 88, 52, N'fumbles', N'fumbles_forced', N'', N'Fumble - forced', N'Player fumbled the ball, fumble was forced by another player.', 1 ), 
( 89, 52, N'fumbles', N'fumbles_tot', N'', N'Fumble - forced', N'Player fumbled the ball, fumble was forced by another player.', 1 ), 
( 90, 53, N'fumbles', N'fumbles_notforced', N'', N'Fumble - not forced', N'Player fumbled the ball, fumble was not forced by another player.', 1 ), 
( 91, 53, N'fumbles', N'fumbles_tot', N'', N'Fumble - not forced', N'Player fumbled the ball, fumble was not forced by another player.', 1 ), 
( 92, 54, N'fumbles', N'fumbles_oob', N'', N'Fumble - out of bounds', N'Player fumbled the ball, and the ball went out of bounds.', 1 ), 
( 93, 55, N'fumbles', N'fumbles_rec', N'fumbles_rec_yds', N'Own recovery yards', N'Yardage gained/lost by a player after he recovered a fumble by his own team.', 0 ), 
( 94, 56, N'fumbles', N'fumbles_rec', N'fumbles_rec_yds', N'Own recovery yards, TD', N'Same as previous (55), except when the play results in a touchdown.', 0 ), 
( 95, 56, N'fumbles', N'fumbles_rec_tds', N'fumbles_rec_yds', N'Own recovery yards, TD', N'Same as previous (55), except when the play results in a touchdown.', 0 ), 
( 96, 57, N'fumbles', N'', N'fumbles_rec_yds', N'Own recovery yards, No recovery', N'If a player recovered a fumble by his own team, then lateraled to a teammate, the yardage gained/lost by teammate would be recorded with this stat.', 0 ), 
( 97, 58, N'fumbles', N'fumbles_rec_tds', N'fumbles_rec_yds', N'Own recovery yards, TD, No recovery', N'Same as previous (57), except when the play results in a touchdown.', 0 ), 
( 98, 59, N'defense', N'defense_frec', N'defense_frec_yds', N'Opponent recovery yards', N'Yardage gained/lost by a player after he recovered a fumble by the opposing team.', 0 ), 
( 99, 6, N'team', N'third_down_att', N'', N'3rd down attempt converted', N'3rd down play resulted in a first down or touchdown.', 0 ), 
( 100, 6, N'team', N'third_down_conv', N'', N'3rd down attempt converted', N'3rd down play resulted in a first down or touchdown.', 0 ), 
( 101, 60, N'defense', N'defense_frec', N'defense_frec_yds', N'Opponent recovery yards, TD', N'Same as previous (59), except when the play results in a touchdown.', 0 ), 
( 102, 60, N'defense', N'defense_frec_tds', N'defense_frec_yds', N'Opponent recovery yards, TD', N'Same as previous (59), except when the play results in a touchdown.', 0 ), 
( 103, 60, N'defense', N'defense_tds', N'defense_frec_yds', N'Opponent recovery yards, TD', N'Same as previous (59), except when the play results in a touchdown.', 0 ), 
( 104, 61, N'defense', N'', N'defense_frec_yds', N'Opponent recovery yards, No recovery', N'If a player recovered a fumble by the opposing team, then lateraled to a teammate, the yardage gained/lost by the teammate would be recorded with this stat.', 0 ), 
( 105, 62, N'defense', N'defense_frec_tds', N'defense_frec_yds', N'Opponent recovery yards, TD, No recovery', N'Same as previous, except when the play results in a touchdown.', 0 ), 
( 106, 62, N'defense', N'defense_tds', N'defense_frec_yds', N'Opponent recovery yards, TD, No recovery', N'Same as previous, except when the play results in a touchdown.', 0 ), 
( 107, 63, N'defense', N'', N'defense_misc_yds', N'Miscellaneous yards', N'This is sort of a catch-all for yardage that doesn"t fall into any other category. According to Elias, it does not include loose ball yardage. Examples are yardage on missed field goal, blocked punt. This stat is not used to balance the books.', 0 ), 
( 108, 64, N'defense', N'defense_misc_tds', N'defense_misc_yds', N'Miscellaneous yards, TD', N'Same as previous (63), except when the play results in a touchdown.', 0 ), 
( 109, 64, N'defense', N'defense_tds', N'defense_misc_yds', N'Miscellaneous yards, TD', N'Same as previous (63), except when the play results in a touchdown.', 0 ), 
( 110, 68, N'team', N'timeout', N'', N'Timeout', N'Team took a time out.', 1 ), 
( 111, 69, N'kicking', N'kicking_fga', N'kicking_fgmissed_yds', N'Field goal missed yards', N'The length of a missed field goal.', 1 ), 
( 112, 69, N'kicking', N'kicking_fgmissed', N'kicking_fgmissed_yds', N'Field goal missed yards', N'The length of a missed field goal.', 1 ), 
( 113, 7, N'team', N'third_down_att', N'', N'3rd down attempt failed', N'3rd down play did not result in a first down or touchdown.', 1 ), 
( 114, 7, N'team', N'third_down_failed', N'', N'3rd down attempt failed', N'3rd down play did not result in a first down or touchdown.', 1 ), 
( 115, 70, N'kicking', N'kicking_fga', N'kicking_fgm_yds', N'Field goal yards', N'The length of a successful field goal.', 0 ), 
( 116, 70, N'kicking', N'kicking_fgm', N'kicking_fgm_yds', N'Field goal yards', N'The length of a successful field goal.', 0 ), 
( 117, 71, N'kicking', N'kicking_fga', N'kicking_fgmissed_yds', N'Field goal blocked (offense)', N'The length of an attempted field goal that was blocked. Unlike a punt, a field goal is statistically blocked even if the ball does go beyond the line of scrimmage.', 1 ), 
( 118, 71, N'kicking', N'kicking_fgb', N'kicking_fgmissed_yds', N'Field goal blocked (offense)', N'The length of an attempted field goal that was blocked. Unlike a punt, a field goal is statistically blocked even if the ball does go beyond the line of scrimmage.', 1 ), 
( 119, 71, N'kicking', N'kicking_fgmissed', N'kicking_fgmissed_yds', N'Field goal blocked (offense)', N'The length of an attempted field goal that was blocked. Unlike a punt, a field goal is statistically blocked even if the ball does go beyond the line of scrimmage.', 1 ), 
( 120, 72, N'kicking', N'kicking_xpa', N'', N'Extra point - good', N'Extra point good. SuperStat uses one code for both successful and unsuccessful extra points. I think it might be better to use 2 codes.', 0 ), 
( 121, 72, N'kicking', N'kicking_xpmade', N'', N'Extra point - good', N'Extra point good. SuperStat uses one code for both successful and unsuccessful extra points. I think it might be better to use 2 codes.', 0 ), 
( 122, 73, N'kicking', N'kicking_xpa', N'', N'Extra point - failed', N'Extra point failed.', 1 ), 
( 123, 73, N'kicking', N'kicking_xpmissed', N'', N'Extra point - failed', N'Extra point failed.', 1 ), 
( 124, 74, N'kicking', N'kicking_xpa', N'', N'Extra point - blocked', N'Extra point blocked. Exclusive of the extra point failed stat.', 1 ), 
( 125, 74, N'kicking', N'kicking_xpb', N'', N'Extra point - blocked', N'Extra point blocked. Exclusive of the extra point failed stat.', 1 ), 
( 126, 74, N'kicking', N'kicking_xpmissed', N'', N'Extra point - blocked', N'Extra point blocked. Exclusive of the extra point failed stat.', 1 ), 
( 127, 75, N'rushing', N'rushing_twopta', N'', N'2 point rush - good', N'Extra points by run good (old version has 0/1 in yards for failed/good).', 0 ), 
( 128, 75, N'rushing', N'rushing_twoptm', N'', N'2 point rush - good', N'Extra points by run good (old version has 0/1 in yards for failed/good).', 0 ), 
( 129, 76, N'rushing', N'rushing_twopta', N'', N'2 point rush - failed', N'', 0 ), 
( 130, 76, N'rushing', N'rushing_twoptmissed', N'', N'2 point rush - failed', N'', 0 ), 
( 131, 77, N'passing', N'passing_twopta', N'', N'2 point pass - good', N'Extra points by pass good (old version has 0/1 in yards for failed/good).', 0 ), 
( 132, 77, N'passing', N'passing_twoptm', N'', N'2 point pass - good', N'Extra points by pass good (old version has 0/1 in yards for failed/good).', 0 ), 
( 133, 78, N'passing', N'passing_twopta', N'', N'2 point pass - failed', N'Extra point by pass failed.', 1 ), 
( 134, 78, N'passing', N'passing_twoptmissed', N'', N'2 point pass - failed', N'Extra point by pass failed.', 1 ), 
( 135, 79, N'defense', N'defense_tkl', N'', N'Solo tackle', N'Tackle with no assists. Note: There are no official defensive statistics except for sacks.', 0 ), 
( 136, 8, N'team', N'fourth_down_att', N'', N'4th down attempt converted', N'4th down play resulted in a first down or touchdown.', 0 ), 
( 137, 8, N'team', N'fourth_down_conv', N'', N'4th down attempt converted', N'4th down play resulted in a first down or touchdown.', 0 ), 
( 138, 80, N'defense', N'defense_tkl', N'', N'Assisted tackle', N'Tackle with one or more assists.', 0 ), 
( 139, 80, N'defense', N'defense_tkl_primary', N'', N'Assisted tackle', N'Tackle with one or more assists.', 0 ), 
( 140, 81, N'', N'', N'', N'1/2 tackle', N'Tackle split equally between two players. This stat is not in use at this time.', 0 ), 
( 141, 82, N'defense', N'defense_ast', N'', N'Tackle assist', N'Assist to a tackle.', 0 ), 
( 142, 83, N'defense', N'defense_sk', N'defense_sk_yds', N'Sack yards (defense)', N'Unassisted sack.', 0 ), 
( 143, 84, N'defense', N'defense_sk', N'defense_sk_yds', N'1/2 sack yards (defense)', N'Sack split equally between two players.', 0 ), 
( 144, 85, N'defense', N'defense_pass_def', N'', N'Pass defensed', N'Incomplete pass was due primarily to the player"s action.', 0 ), 
( 145, 86, N'defense', N'defense_puntblk', N'', N'Punt blocked (defense)', N'Player blocked a punt.', 0 ), 
( 146, 87, N'defense', N'defense_xpblk', N'', N'Extra point blocked (defense)', N'Player blocked the extra point.', 0 ), 
( 147, 88, N'defense', N'defense_fgblk', N'', N'Field goal blocked (defense)', N'', 0 ), 
( 148, 89, N'defense', N'defense_safe', N'', N'Safety (defense)', N'Tackle that resulted in a safety. This is in addition to a tackle.', 0 ), 
( 149, 9, N'team', N'fourth_down_att', N'', N'4th down attempt failed', N'4th down play did not result in a first down or touchdown.', 1 ), 
( 150, 9, N'team', N'fourth_down_failed', N'', N'4th down attempt failed', N'4th down play did not result in a first down or touchdown.', 1 ), 
( 151, 90, N'defense', N'', N'', N'1/2 safety (defense)', N'This stat was used by SuperStat when a 1/2 tackle resulted in a safety. This stat is not in use at this time.', 0 ), 
( 152, 91, N'defense', N'defense_ffum', N'', N'Forced fumble (defense)', N'Player forced a fumble.', 0 ), 
( 153, 93, N'penalty', N'penalty', N'penalty_yds', N'Penalty', N'', 0 ), 
( 154, 95, N'team', N'rushing_loss', N'rushing_loss_yds', N'Tackled for a loss', N'Tackled for a loss (TFL) is an offensive stat. A team is charged with a TFL if its rush ends behind the line of scrimmage, and at least one defensive player is credited with ending the rush with a tackle, or tackle assist. The stat will contain yardage.', 0 ), 
( 155, 96, N'', N'', N'', N'Extra point - safety', N'If there is a fumble on an extra point attempt, and the loose ball goes into the endzone from impetus provided by the defensive team, and becomes dead in the endzone, the offense is awarded 1 point.', 0 ), 
( 156, 99, N'', N'', N'', N'2  point rush - safety', N'See Extra point - safety', 0 )

) t  ( [StatisticKey] , [StatID] , [Category] , [FieldsValue] , [FieldsYds] , [Description] , [LongDescription] , [Negative]  )
GO
/****** Object:  Table [dbo].[CommandLog]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommandLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DatabaseName] [sysname] NULL,
	[SchemaName] [sysname] NULL,
	[ObjectName] [sysname] NULL,
	[ObjectType] [char](2) NULL,
	[IndexName] [sysname] NULL,
	[IndexType] [tinyint] NULL,
	[StatisticsName] [sysname] NULL,
	[PartitionNumber] [int] NULL,
	[ExtendedInfo] [xml] NULL,
	[Command] [nvarchar](max) NOT NULL,
	[CommandType] [nvarchar](60) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[ErrorNumber] [int] NULL,
	[ErrorMessage] [nvarchar](max) NULL,
 CONSTRAINT [PK_CommandLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Injury]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Injury](
	[Year] [nchar](10) NULL,
	[TeamAbbr] [nchar](10) NULL,
	[LastName] [nvarchar](50) NULL,
	[FirstName] [nvarchar](50) NULL,
	[InjuryLevel] [nchar](10) NULL,
	[Week] [nchar](10) NULL,
	[InjuryLevelDesc] [nvarchar](50) NULL,
	[InjuryType] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teamdata]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teamdata](
	[Conference] [varchar](50) NULL,
	[Division] [varchar](50) NULL,
	[Club] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[Stadium] [varchar](50) NULL,
	[Capacity] [numeric](18, 0) NULL,
	[Coordinates] [varchar](50) NULL,
	[First season] [varchar](50) NULL,
	[Head coach] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [MasterNFL].[playplayer]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MasterNFL].[playplayer](
	[eid] [int] NOT NULL,
	[drivenumber] [int] NOT NULL,
	[playnumber] [int] NOT NULL,
	[playerid] [varchar](50) NOT NULL,
	[statId] [varchar](50) NULL,
	[sequence] [varchar](50) NULL,
	[playerName] [varchar](50) NULL,
	[clubcode] [varchar](50) NULL,
	[yards] [varchar](50) NULL,
	[createts] [datetime] NULL,
	[modifyts] [datetime] NULL,
	[deletets] [datetime] NULL,
 CONSTRAINT [PK_pplayplayer] PRIMARY KEY CLUSTERED 
(
	[eid] ASC,
	[drivenumber] ASC,
	[playnumber] ASC,
	[playerid] ASC,
	[sequence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NFLDB].[Drive]    Script Date: 9/8/2019 8:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NFLDB].[Drive](
	[DriveKey] [int] IDENTITY(1,1) NOT NULL,
	[ScheduleKey] [int] NOT NULL,
	[DriveNumber] [int] NOT NULL,
	[StartTeam] [varchar](50) NULL,
	[StartQtr] [varchar](50) NULL,
	[StartTime] [varchar](50) NULL,
	[StartTimeSec] [int] NULL,
	[StartYardLine] [varchar](50) NULL,
	[StartRelativeYardLine] [int] NULL,
	[EndTeam] [varchar](50) NULL,
	[EndQtr] [varchar](50) NULL,
	[EndTime] [varchar](50) NULL,
	[EndTimeSec] [int] NULL,
	[EndYardLine] [varchar](50) NULL,
	[EndRelativeYardLine] [int] NULL,
	[PossessionTeam] [varchar](50) NULL,
	[PossessionTime] [varchar](50) NULL,
	[PossessionTimeSec] [int] NULL,
	[Qtr] [varchar](50) NULL,
	[PlayCount] [varchar](50) NULL,
	[Result] [varchar](50) NULL,
	[YardsGained] [varchar](50) NULL,
	[FirstDowns] [varchar](50) NULL,
	[PenaltyYards] [varchar](50) NULL,
	[RedZone] [varchar](50) NULL,
 CONSTRAINT [PK_Drive] PRIMARY KEY CLUSTERED 
(
	[DriveKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NFLDB].[Play]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NFLDB].[Play](
	[PlayKey] [int] IDENTITY(1,1) NOT NULL,
	[ScheduleKey] [int] NULL,
	[DriveNumber] [int] NULL,
	[PlayNumber] [int] NULL,
	[Qtr] [varchar](50) NULL,
	[PlayStartTime] [varchar](50) NULL,
	[PlayStartTimeSeconds] [int] NULL,
	[PossessionTeam] [varchar](50) NULL,
	[RelativeYardLine] [int] NULL,
	[YardsToGo] [varchar](50) NULL,
	[YardsNet] [varchar](50) NULL,
	[ScoredPoint] [varchar](50) NULL,
	[Down] [varchar](50) NULL,
	[Description] [varchar](5000) NULL,
	[Note] [varchar](50) NULL,
 CONSTRAINT [PK_Play] PRIMARY KEY CLUSTERED 
(
	[PlayKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NFLDB].[ScheduleDefinition]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NFLDB].[ScheduleDefinition](
	[ScheduleDefinitionKey] [int] IDENTITY(1,1) NOT NULL,
	[Week] [int] NOT NULL,
	[SeasonType] [varchar](4) NOT NULL,
	[DESCRIPTION] [varchar](20) NOT NULL,
 CONSTRAINT [PK_ScheduleDefinition] PRIMARY KEY CLUSTERED 
(
	[ScheduleDefinitionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reference].[player]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reference].[player](
	[PlayerKey] [int] NOT NULL,
	[player_id] [varchar](10) NOT NULL,
	[gsis_name] [varchar](75) NULL,
	[full_name] [varchar](100) NULL,
	[first_name] [varchar](100) NULL,
	[last_name] [varchar](100) NULL,
	[team] [varchar](3) NOT NULL,
	[position] [varchar](20) NOT NULL,
	[profile_id] [int] NULL,
	[profile_url] [varchar](255) NULL,
	[uniform_number] [smallint] NULL,
	[birthdate] [varchar](75) NULL,
	[college] [varchar](255) NULL,
	[height] [smallint] NULL,
	[weight] [smallint] NULL,
	[years_pro] [smallint] NULL,
	[status] [varchar](20) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reference].[Statistic]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reference].[Statistic](
	[StatisticKey] [int] IDENTITY(1,1) NOT NULL,
	[StatID] [int] NULL,
	[Category] [nvarchar](30) NULL,
	[FieldsValue] [nvarchar](25) NULL,
	[FieldsYds] [nvarchar](25) NULL,
	[Description] [nvarchar](500) NULL,
	[LongDescription] [nvarchar](500) NULL,
	[Negative] [bit] NULL,
 CONSTRAINT [PK_Statistic] PRIMARY KEY CLUSTERED 
(
	[StatisticKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[bulkloaddrive]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[bulkloaddrive] @filePath nvarchar(100) = NULL, @fileName nvarchar(100) = NULL, @eid nvarchar(12) = NULL, @fmt bit = 0

AS
--Delete all where same records exsit 
DECLARE @bulkcmd AS VARCHAR(max)


--If a fmt file is provided then use it
if @fmt = 1

BEGIN  
SET @bulkcmd = 
'DELETE FROM LandNFL.drive where eid='''+@eid+''';
BULK INSERT LandNFL.drive
FROM '''+ @filePath +  @fileName + '''
WITH(
        DATA_SOURCE = ''nflgenstorage'',
		FORMAT=''CSV'',
        FORMATFILE = ''gamedayshred/lib/fmt/drive.xml'',
        FORMATFILE_DATA_SOURCE = ''nflgenstorage''
    );'

EXEC (@bulkcmd)
--PRINT @bulkcmd
end

--otherwise try loading with no fmt file 
ELSE 
BEGIN 
SET @bulkcmd = 
'DELETE FROM LandNFL.drive where eid='''+@eid+''';
BULK INSERT LandNFL.drive
FROM '''+ @filePath +  @fileName + '''
WITH(
        DATA_SOURCE = ''nflgenstorage'',
		FORMAT=''CSV''
    );'

EXEC (@bulkcmd)
END

GO
/****** Object:  StoredProcedure [dbo].[bulkloaddrive_old]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[bulkloaddrive_old] @filePath nvarchar(100) = NULL, @fileName nvarchar(100) = NULL

AS
--Delete all where same records exsit 
DECLARE @bulkcmd AS VARCHAR(max)

SET @bulkcmd = 
'BULK INSERT LandNFL.drive
FROM '''+ @filePath +  @fileName + '''
WITH(
        DATA_SOURCE = ''nflgenstorage'',
		FIRSTROW = 4,
        FORMATFILE = ''gamedayshred/lib/fmt/drive.xml'',
        FORMATFILE_DATA_SOURCE = ''nflgenstorage''
    );'

EXEC (@bulkcmd)
--PRINT @bulkcmd


GO
/****** Object:  StoredProcedure [dbo].[bulkloadgame]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[bulkloadgame] @filePath nvarchar(100) = NULL, @fileName nvarchar(100) = NULL, @eid nvarchar(12) = NULL, @fmt bit = 0

AS
--Delete all where same records exsit 
DECLARE @bulkcmd AS VARCHAR(max)

--If a fmt file is provided then use it
if @fmt = 1
BEGIN
SET @bulkcmd = 
'DELETE FROM LandNFL.game where eid='''+@eid+''';
BULK INSERT LandNFL.game
FROM '''+ @filePath +  @fileName + '''
WITH(
        DATA_SOURCE = ''nflgenstorage'',
		FORMAT=''CSV'',
        FORMATFILE = ''gamedayshred/lib/fmt/game.xml'',
        FORMATFILE_DATA_SOURCE = ''nflgenstorage''
    );'
	
	EXEC (@bulkcmd)
END

ELSE
BEGIN 
SET @bulkcmd = 
'DELETE FROM LandNFL.game where eid='''+@eid+''';
BULK INSERT LandNFL.game
FROM '''+ @filePath +  @fileName + '''
WITH(
        DATA_SOURCE = ''nflgenstorage'',
		FORMAT=''CSV''
    );'
	
	EXEC (@bulkcmd)
END

EXEC (@bulkcmd)
--PRINT @bulkcmd



GO
/****** Object:  StoredProcedure [dbo].[bulkloadplay]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[bulkloadplay] @filePath nvarchar(100) = NULL, @fileName nvarchar(100) = NULL, @eid nvarchar(100) = NULL, @fmt bit = 0

AS
--Delete all where same records exsit 
DECLARE @bulkcmd AS VARCHAR(max)

--If a fmt file is provided then use it
if @fmt = 1
BEGIN
SET @bulkcmd = 
'DELETE FROM LandNFL.play where eid='''+@eid+''';
BULK INSERT LandNFL.play
FROM '''+ @filePath +  @fileName + '''
WITH(
        DATA_SOURCE = ''nflgenstorage'',
		FORMAT=''CSV'',
        FORMATFILE = ''gamedayshred/lib/fmt/play.xml'',
        FORMATFILE_DATA_SOURCE = ''nflgenstorage''
    );'

EXEC (@bulkcmd)
--PRINT @bulkcmd

END

ELSE BEGIN
SET @bulkcmd = 
'DELETE FROM LandNFL.play where eid='''+@eid+''';
BULK INSERT LandNFL.play
FROM '''+ @filePath +  @fileName + '''
WITH(
        DATA_SOURCE = ''nflgenstorage'',
		FORMAT=''CSV''
    );'

EXEC (@bulkcmd)
--PRINT @bulkcmd

END



GO
/****** Object:  StoredProcedure [dbo].[bulkloadplayplayer]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[bulkloadplayplayer] @filePath nvarchar(100) = NULL, @fileName nvarchar(100) = NULL, @eid nvarchar(12) = NULL, @fmt bit = 0

AS
--Delete all where same records exsit 
DECLARE @bulkcmd AS VARCHAR(max)

--If a fmt file is provided then use it
if @fmt = 1
BEGIN
SET @bulkcmd = 
'DELETE FROM LandNFL.playplayer where eid='''+@eid+''';
BULK INSERT LandNFL.playplayer
FROM '''+ @filePath +  @fileName + '''
WITH(
        DATA_SOURCE = ''nflgenstorage'',
		FORMAT=''CSV'',
        FORMATFILE = ''gamedayshred/lib/fmt/playplayer.xml'',
        FORMATFILE_DATA_SOURCE = ''nflgenstorage''
    );'

EXEC (@bulkcmd)
--PRINT @bulkcmd
END

ELSE
BEGIN
SET @bulkcmd = 
'DELETE FROM LandNFL.playplayer where eid='''+@eid+''';
BULK INSERT LandNFL.playplayer
FROM '''+ @filePath +  @fileName + '''
WITH(
        DATA_SOURCE = ''nflgenstorage'',
		FORMAT=''CSV''
    );'

EXEC (@bulkcmd)
--PRINT @bulkcmd
END



GO
/****** Object:  StoredProcedure [dbo].[CheckForIncompleteGames]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[CheckForIncompleteGames]  @Season int = 0
as 
BEGIN  
   IF ((
   
   SELECT count(1) FROM NFLDB.Schedule AS s
   LEFT JOIN MasterNFL.game AS g ON g.eid=s.GameID
		WHERE 
		s.SeasonYear = @Season
		AND ISNULL(g.[current-quarter], '1')not like '%Final%' 
		AND s.GameDay <= GETDATE()+1
   
   ) > 0)  
   RETURN 1  
ELSE  
   RETURN 0

END
--SELECT case when count(1)> 1 then 1 else 0 end as isworktodo 
--FROM NFLDB.Schedule AS s
--LEFT JOIN NFLDB.DRIVE AS D ON D.ScheduleKey = S.ScheduleKey AND d.Result =  'End of Game'
--WHERE D.DriveKey IS  NULL
--AND s.SeasonYear = @Season
--AND s.GameDay <= GETDATE()
GO
/****** Object:  StoredProcedure [dbo].[CommandExecute]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CommandExecute]

@Command nvarchar(max),
@CommandType nvarchar(max),
@Mode int,
@Comment nvarchar(max) = NULL,
@DatabaseName nvarchar(max) = NULL,
@SchemaName nvarchar(max) = NULL,
@ObjectName nvarchar(max) = NULL,
@ObjectType nvarchar(max) = NULL,
@IndexName nvarchar(max) = NULL,
@IndexType int = NULL,
@StatisticsName nvarchar(max) = NULL,
@PartitionNumber int = NULL,
@ExtendedInfo xml = NULL,
@LockMessageSeverity int = 16,
@LogToTable nvarchar(max),
@Execute nvarchar(max)

AS

BEGIN

  ----------------------------------------------------------------------------------------------------
  --// Source:  https://ola.hallengren.com                                                        //--
  --// License: https://ola.hallengren.com/license.html                                           //--
  --// GitHub:  https://github.com/olahallengren/sql-server-maintenance-solution                  //--
  --// Version: 2018-07-16 18:32:21                                                               //--
  ----------------------------------------------------------------------------------------------------

  SET NOCOUNT ON

  DECLARE @StartMessage nvarchar(max)
  DECLARE @EndMessage nvarchar(max)
  DECLARE @ErrorMessage nvarchar(max)
  DECLARE @ErrorMessageOriginal nvarchar(max)
  DECLARE @Severity int

  DECLARE @StartTime datetime
  DECLARE @EndTime datetime

  DECLARE @StartTimeSec datetime
  DECLARE @EndTimeSec datetime

  DECLARE @ID int

  DECLARE @Error int
  DECLARE @ReturnCode int

  SET @Error = 0
  SET @ReturnCode = 0

  ----------------------------------------------------------------------------------------------------
  --// Check core requirements                                                                    //--
  ----------------------------------------------------------------------------------------------------

  IF NOT (SELECT [compatibility_level] FROM sys.databases WHERE database_id = DB_ID()) >= 90
  BEGIN
    SET @ErrorMessage = 'The database ' + QUOTENAME(DB_NAME(DB_ID())) + ' has to be in compatibility level 90 or higher.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF NOT (SELECT uses_ansi_nulls FROM sys.sql_modules WHERE [object_id] = @@PROCID) = 1
  BEGIN
    SET @ErrorMessage = 'ANSI_NULLS has to be set to ON for the stored procedure.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF NOT (SELECT uses_quoted_identifier FROM sys.sql_modules WHERE [object_id] = @@PROCID) = 1
  BEGIN
    SET @ErrorMessage = 'QUOTED_IDENTIFIER has to be set to ON for the stored procedure.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LogToTable = 'Y' AND NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'U' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandLog')
  BEGIN
    SET @ErrorMessage = 'The table CommandLog is missing. Download https://ola.hallengren.com/scripts/CommandLog.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Error <> 0
  BEGIN
    SET @ReturnCode = @Error
    GOTO ReturnCode
  END

  ----------------------------------------------------------------------------------------------------
  --// Check input parameters                                                                     //--
  ----------------------------------------------------------------------------------------------------

  IF @Command IS NULL OR @Command = ''
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Command is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @CommandType IS NULL OR @CommandType = '' OR LEN(@CommandType) > 60
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CommandType is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Mode NOT IN(1,2) OR @Mode IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Mode is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LockMessageSeverity NOT IN(10,16) OR @LockMessageSeverity IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LockMessageSeverity is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LogToTable NOT IN('Y','N') OR @LogToTable IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LogToTable is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Execute NOT IN('Y','N') OR @Execute IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Execute is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Error <> 0
  BEGIN
    SET @ReturnCode = @Error
    GOTO ReturnCode
  END

  ----------------------------------------------------------------------------------------------------
  --// Log initial information                                                                    //--
  ----------------------------------------------------------------------------------------------------

  SET @StartTime = GETDATE()
  SET @StartTimeSec = CONVERT(datetime,CONVERT(nvarchar,@StartTime,120),120)

  SET @StartMessage = 'Date and time: ' + CONVERT(nvarchar,@StartTimeSec,120)
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Command: ' + @Command
  SET @StartMessage = REPLACE(@StartMessage,'%','%%')
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  IF @Comment IS NOT NULL
  BEGIN
    SET @StartMessage = 'Comment: ' + @Comment
    SET @StartMessage = REPLACE(@StartMessage,'%','%%')
    RAISERROR(@StartMessage,10,1) WITH NOWAIT
  END

  IF @LogToTable = 'Y'
  BEGIN
    INSERT INTO dbo.CommandLog (DatabaseName, SchemaName, ObjectName, ObjectType, IndexName, IndexType, StatisticsName, PartitionNumber, ExtendedInfo, CommandType, Command, StartTime)
    VALUES (@DatabaseName, @SchemaName, @ObjectName, @ObjectType, @IndexName, @IndexType, @StatisticsName, @PartitionNumber, @ExtendedInfo, @CommandType, @Command, @StartTime)
  END

  SET @ID = SCOPE_IDENTITY()

  ----------------------------------------------------------------------------------------------------
  --// Execute command                                                                            //--
  ----------------------------------------------------------------------------------------------------

  IF @Mode = 1 AND @Execute = 'Y'
  BEGIN
    EXECUTE(@Command)
    SET @Error = @@ERROR
    SET @ReturnCode = @Error
  END

  IF @Mode = 2 AND @Execute = 'Y'
  BEGIN
    BEGIN TRY
      EXECUTE(@Command)
    END TRY
    BEGIN CATCH
      SET @Error = ERROR_NUMBER()
      SET @ErrorMessageOriginal = ERROR_MESSAGE()

      SET @ErrorMessage = 'Msg ' + CAST(ERROR_NUMBER() AS nvarchar) + ', ' + ISNULL(ERROR_MESSAGE(),'')
      SET @Severity = CASE WHEN ERROR_NUMBER() IN(1205,1222) THEN @LockMessageSeverity ELSE 16 END
      RAISERROR(@ErrorMessage,@Severity,1) WITH NOWAIT

      IF NOT (ERROR_NUMBER() IN(1205,1222) AND @LockMessageSeverity = 10)
      BEGIN
        SET @ReturnCode = ERROR_NUMBER()
      END
    END CATCH
  END

  ----------------------------------------------------------------------------------------------------
  --// Log completing information                                                                 //--
  ----------------------------------------------------------------------------------------------------

  SET @EndTime = GETDATE()
  SET @EndTimeSec = CONVERT(datetime,CONVERT(varchar,@EndTime,120),120)

  SET @EndMessage = 'Outcome: ' + CASE WHEN @Execute = 'N' THEN 'Not Executed' WHEN @Error = 0 THEN 'Succeeded' ELSE 'Failed' END
  RAISERROR(@EndMessage,10,1) WITH NOWAIT

  SET @EndMessage = 'Duration: ' + CASE WHEN DATEDIFF(ss,@StartTimeSec, @EndTimeSec)/(24*3600) > 0 THEN CAST(DATEDIFF(ss,@StartTimeSec, @EndTimeSec)/(24*3600) AS nvarchar) + '.' ELSE '' END + CONVERT(nvarchar,@EndTimeSec - @StartTimeSec,108)
  RAISERROR(@EndMessage,10,1) WITH NOWAIT

  SET @EndMessage = 'Date and time: ' + CONVERT(nvarchar,@EndTimeSec,120) + CHAR(13) + CHAR(10) + ' '
  RAISERROR(@EndMessage,10,1) WITH NOWAIT

  IF @LogToTable = 'Y'
  BEGIN
    UPDATE dbo.CommandLog
    SET EndTime = @EndTime,
        ErrorNumber = CASE WHEN @Execute = 'N' THEN NULL ELSE @Error END,
        ErrorMessage = @ErrorMessageOriginal
    WHERE ID = @ID
  END

  ReturnCode:
  IF @ReturnCode <> 0
  BEGIN
    RETURN @ReturnCode
  END

  ----------------------------------------------------------------------------------------------------

END
GO
/****** Object:  StoredProcedure [dbo].[IndexOptimize]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IndexOptimize]

@Databases nvarchar(max) = NULL,
@FragmentationLow nvarchar(max) = NULL,
@FragmentationMedium nvarchar(max) = 'INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationHigh nvarchar(max) = 'INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationLevel1 int = 5,
@FragmentationLevel2 int = 30,
@MinNumberOfPages int = 1000,
@MaxNumberOfPages int = NULL,
@SortInTempdb nvarchar(max) = 'N',
@MaxDOP int = NULL,
@FillFactor int = NULL,
@PadIndex nvarchar(max) = NULL,
@LOBCompaction nvarchar(max) = 'Y',
@UpdateStatistics nvarchar(max) = NULL,
@OnlyModifiedStatistics nvarchar(max) = 'N',
@StatisticsModificationLevel int = NULL,
@StatisticsSample int = NULL,
@StatisticsResample nvarchar(max) = 'N',
@PartitionLevel nvarchar(max) = 'Y',
@MSShippedObjects nvarchar(max) = 'N',
@Indexes nvarchar(max) = NULL,
@TimeLimit int = NULL,
@Delay int = NULL,
@WaitAtLowPriorityMaxDuration int = NULL,
@WaitAtLowPriorityAbortAfterWait nvarchar(max) = NULL,
@Resumable nvarchar(max) = 'N',
@AvailabilityGroups nvarchar(max) = NULL,
@LockTimeout int = NULL,
@LockMessageSeverity int = 16,
@DatabaseOrder nvarchar(max) = NULL,
@DatabasesInParallel nvarchar(max) = 'N',
@LogToTable nvarchar(max) = 'N',
@Execute nvarchar(max) = 'Y'

AS

BEGIN

  ----------------------------------------------------------------------------------------------------
  --// Source:  https://ola.hallengren.com                                                        //--
  --// License: https://ola.hallengren.com/license.html                                           //--
  --// GitHub:  https://github.com/olahallengren/sql-server-maintenance-solution                  //--
  --// Version: 2018-07-16 18:32:21                                                               //--
  ----------------------------------------------------------------------------------------------------

  SET NOCOUNT ON

  SET ARITHABORT ON

  SET NUMERIC_ROUNDABORT OFF

  DECLARE @StartMessage nvarchar(max)
  DECLARE @EndMessage nvarchar(max)
  DECLARE @DatabaseMessage nvarchar(max)
  DECLARE @ErrorMessage nvarchar(max)
  DECLARE @Severity int

  DECLARE @StartTime datetime
  DECLARE @SchemaName nvarchar(max)
  DECLARE @ObjectName nvarchar(max)
  DECLARE @VersionTimestamp nvarchar(max)
  DECLARE @Parameters nvarchar(max)

  DECLARE @Version numeric(18,10)
  DECLARE @HostPlatform nvarchar(max)
  DECLARE @AmazonRDS bit

  DECLARE @PartitionLevelStatistics bit

  DECLARE @QueueID int
  DECLARE @QueueStartTime datetime

  DECLARE @CurrentDBID int
  DECLARE @CurrentDatabaseID int
  DECLARE @CurrentDatabaseName nvarchar(max)
  DECLARE @CurrentIsDatabaseAccessible bit
  DECLARE @CurrentAvailabilityGroup nvarchar(max)
  DECLARE @CurrentAvailabilityGroupRole nvarchar(max)
  DECLARE @CurrentDatabaseMirroringRole nvarchar(max)
  DECLARE @CurrentIsReadOnly bit

  DECLARE @CurrentCommand01 nvarchar(max)
  DECLARE @CurrentCommand02 nvarchar(max)
  DECLARE @CurrentCommand03 nvarchar(max)
  DECLARE @CurrentCommand04 nvarchar(max)
  DECLARE @CurrentCommand05 nvarchar(max)
  DECLARE @CurrentCommand06 nvarchar(max)
  DECLARE @CurrentCommand07 nvarchar(max)

  DECLARE @CurrentCommandOutput06 int
  DECLARE @CurrentCommandOutput07 int

  DECLARE @CurrentCommandType06 nvarchar(max)
  DECLARE @CurrentCommandType07 nvarchar(max)

  DECLARE @CurrentComment06 nvarchar(max)
  DECLARE @CurrentComment07 nvarchar(max)

  DECLARE @CurrentExtendedInfo06 xml
  DECLARE @CurrentExtendedInfo07 xml

  DECLARE @CurrentIxID int
  DECLARE @CurrentSchemaID int
  DECLARE @CurrentSchemaName nvarchar(max)
  DECLARE @CurrentObjectID int
  DECLARE @CurrentObjectName nvarchar(max)
  DECLARE @CurrentObjectType nvarchar(max)
  DECLARE @CurrentIsMemoryOptimized bit
  DECLARE @CurrentIndexID int
  DECLARE @CurrentIndexName nvarchar(max)
  DECLARE @CurrentIndexType int
  DECLARE @CurrentStatisticsID int
  DECLARE @CurrentStatisticsName nvarchar(max)
  DECLARE @CurrentPartitionID bigint
  DECLARE @CurrentPartitionNumber int
  DECLARE @CurrentPartitionCount int
  DECLARE @CurrentIsPartition bit
  DECLARE @CurrentIndexExists bit
  DECLARE @CurrentStatisticsExists bit
  DECLARE @CurrentIsImageText bit
  DECLARE @CurrentIsNewLOB bit
  DECLARE @CurrentIsFileStream bit
  DECLARE @CurrentIsColumnStore bit
  DECLARE @CurrentIsComputed bit
  DECLARE @CurrentIsTimestamp bit
  DECLARE @CurrentAllowPageLocks bit
  DECLARE @CurrentNoRecompute bit
  DECLARE @CurrentIsIncremental bit
  DECLARE @CurrentRowCount bigint
  DECLARE @CurrentModificationCounter bigint
  DECLARE @CurrentOnReadOnlyFileGroup bit
  DECLARE @CurrentResumableIndexOperation bit
  DECLARE @CurrentFragmentationLevel float
  DECLARE @CurrentPageCount bigint
  DECLARE @CurrentFragmentationGroup nvarchar(max)
  DECLARE @CurrentAction nvarchar(max)
  DECLARE @CurrentMaxDOP int
  DECLARE @CurrentUpdateStatistics nvarchar(max)
  DECLARE @CurrentStatisticsSample int
  DECLARE @CurrentStatisticsResample nvarchar(max)
  DECLARE @CurrentDelay datetime

  DECLARE @tmpDatabases TABLE (ID int IDENTITY,
                               DatabaseName nvarchar(max),
                               DatabaseType nvarchar(max),
                               AvailabilityGroup bit,
                               StartPosition int,
                               DatabaseSize bigint,
                               [Order] int,
                               Selected bit,
                               Completed bit,
                               PRIMARY KEY(Selected, Completed, [Order], ID))

  DECLARE @tmpAvailabilityGroups TABLE (ID int IDENTITY PRIMARY KEY,
                                        AvailabilityGroupName nvarchar(max),
                                        StartPosition int,
                                        Selected bit)

  DECLARE @tmpDatabasesAvailabilityGroups TABLE (DatabaseName nvarchar(max),
                                                 AvailabilityGroupName nvarchar(max))

  DECLARE @tmpIndexesStatistics TABLE (ID int IDENTITY,
                                       SchemaID int,
                                       SchemaName nvarchar(max),
                                       ObjectID int,
                                       ObjectName nvarchar(max),
                                       ObjectType nvarchar(max),
                                       IsMemoryOptimized bit,
                                       IndexID int,
                                       IndexName nvarchar(max),
                                       IndexType int,
                                       AllowPageLocks bit,
                                       IsImageText bit,
                                       IsNewLOB bit,
                                       IsFileStream bit,
                                       IsColumnStore bit,
                                       IsComputed bit,
                                       IsTimestamp bit,
                                       OnReadOnlyFileGroup bit,
                                       ResumableIndexOperation bit,
                                       StatisticsID int,
                                       StatisticsName nvarchar(max),
                                       [NoRecompute] bit,
                                       IsIncremental bit,
                                       PartitionID bigint,
                                       PartitionNumber int,
                                       PartitionCount int,
                                       StartPosition int,
                                       [Order] int,
                                       Selected bit,
                                       Completed bit,
                                       PRIMARY KEY(Selected, Completed, [Order], ID))

  DECLARE @SelectedDatabases TABLE (DatabaseName nvarchar(max),
                                    DatabaseType nvarchar(max),
                                    AvailabilityGroup nvarchar(max),
                                    StartPosition int,
                                    Selected bit)

  DECLARE @SelectedAvailabilityGroups TABLE (AvailabilityGroupName nvarchar(max),
                                             StartPosition int,
                                             Selected bit)

  DECLARE @SelectedIndexes TABLE (DatabaseName nvarchar(max),
                                  SchemaName nvarchar(max),
                                  ObjectName nvarchar(max),
                                  IndexName nvarchar(max),
                                  StartPosition int,
                                  Selected bit)

  DECLARE @Actions TABLE ([Action] nvarchar(max))

  INSERT INTO @Actions([Action]) VALUES('INDEX_REBUILD_ONLINE')
  INSERT INTO @Actions([Action]) VALUES('INDEX_REBUILD_OFFLINE')
  INSERT INTO @Actions([Action]) VALUES('INDEX_REORGANIZE')

  DECLARE @ActionsPreferred TABLE (FragmentationGroup nvarchar(max),
                                   [Priority] int,
                                   [Action] nvarchar(max))

  DECLARE @CurrentActionsAllowed TABLE ([Action] nvarchar(max))


  DECLARE @CurrentAlterIndexWithClauseArguments TABLE (ID int IDENTITY,
                                                       Argument nvarchar(max))

  DECLARE @CurrentAlterIndexWithClause nvarchar(max)

  DECLARE @CurrentUpdateStatisticsWithClauseArguments TABLE (ID int IDENTITY,
                                                             Argument nvarchar(max))

  DECLARE @CurrentUpdateStatisticsWithClause nvarchar(max)

  DECLARE @Error int
  DECLARE @ReturnCode int

  SET @Error = 0
  SET @ReturnCode = 0

  SET @Version = CAST(LEFT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)),CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - 1) + '.' + REPLACE(RIGHT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)), LEN(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)))),'.','') AS numeric(18,10))

  IF @Version >= 14
  BEGIN
    SELECT @HostPlatform = host_platform
    FROM sys.dm_os_host_info
  END
  ELSE
  BEGIN
    SET @HostPlatform = 'Windows'
  END

  SET @AmazonRDS = CASE WHEN DB_ID('rdsadmin') IS NOT NULL AND SUSER_SNAME(0x01) = 'rdsa' THEN 1 ELSE 0 END

  ----------------------------------------------------------------------------------------------------
  --// Log initial information                                                                    //--
  ----------------------------------------------------------------------------------------------------

  SET @StartTime = GETDATE()
  SET @SchemaName = (SELECT schemas.name FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID)
  SET @ObjectName = OBJECT_NAME(@@PROCID)
  SET @VersionTimestamp = SUBSTRING(OBJECT_DEFINITION(@@PROCID),CHARINDEX('--// Version: ',OBJECT_DEFINITION(@@PROCID)) + LEN('--// Version: ') + 1, 19)

  SET @Parameters = '@Databases = ' + ISNULL('''' + REPLACE(@Databases,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @FragmentationLow = ' + ISNULL('''' + REPLACE(@FragmentationLow,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @FragmentationMedium = ' + ISNULL('''' + REPLACE(@FragmentationMedium,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @FragmentationHigh = ' + ISNULL('''' + REPLACE(@FragmentationHigh,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @FragmentationLevel1 = ' + ISNULL(CAST(@FragmentationLevel1 AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @FragmentationLevel2 = ' + ISNULL(CAST(@FragmentationLevel2 AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @MinNumberOfPages = ' + ISNULL(CAST(@MinNumberOfPages AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @MaxNumberOfPages = ' + ISNULL(CAST(@MaxNumberOfPages AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @SortInTempdb = ' + ISNULL('''' + REPLACE(@SortInTempdb,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @MaxDOP = ' + ISNULL(CAST(@MaxDOP AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @FillFactor = ' + ISNULL(CAST(@FillFactor AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @PadIndex = ' + ISNULL('''' + REPLACE(@PadIndex,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @LOBCompaction = ' + ISNULL('''' + REPLACE(@LOBCompaction,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @UpdateStatistics = ' + ISNULL('''' + REPLACE(@UpdateStatistics,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @OnlyModifiedStatistics = ' + ISNULL('''' + REPLACE(@OnlyModifiedStatistics,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @StatisticsModificationLevel = ' + ISNULL(CAST(@StatisticsModificationLevel AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @StatisticsSample = ' + ISNULL(CAST(@StatisticsSample AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @StatisticsResample = ' + ISNULL('''' + REPLACE(@StatisticsResample,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @PartitionLevel = ' + ISNULL('''' + REPLACE(@PartitionLevel,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @MSShippedObjects = ' + ISNULL('''' + REPLACE(@MSShippedObjects,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @Indexes = ' + ISNULL('''' + REPLACE(@Indexes,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @TimeLimit = ' + ISNULL(CAST(@TimeLimit AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @Delay = ' + ISNULL(CAST(@Delay AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @WaitAtLowPriorityMaxDuration = ' + ISNULL(CAST(@WaitAtLowPriorityMaxDuration AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @WaitAtLowPriorityAbortAfterWait = ' + ISNULL('''' + REPLACE(@WaitAtLowPriorityAbortAfterWait,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @Resumable = ' + ISNULL('''' + REPLACE(@Resumable,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @AvailabilityGroups = ' + ISNULL('''' + REPLACE(@AvailabilityGroups,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @LockTimeout = ' + ISNULL(CAST(@LockTimeout AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @LockMessageSeverity = ' + ISNULL(CAST(@LockMessageSeverity AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @DatabaseOrder = ' + ISNULL('''' + REPLACE(@DatabaseOrder,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @DatabasesInParallel = ' + ISNULL('''' + REPLACE(@DatabasesInParallel,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @LogToTable = ' + ISNULL('''' + REPLACE(@LogToTable,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @Execute = ' + ISNULL('''' + REPLACE(@Execute,'''','''''') + '''','NULL')

  SET @StartMessage = 'Date and time: ' + CONVERT(nvarchar,@StartTime,120)
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Server: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar(max))
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Version: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar(max))
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Platform: ' + @HostPlatform
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Procedure: ' + QUOTENAME(DB_NAME(DB_ID())) + '.' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@ObjectName)
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Parameters: ' + @Parameters
  SET @StartMessage = REPLACE(@StartMessage,'%','%%')
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Version: ' + @VersionTimestamp
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Source: https://ola.hallengren.com' + CHAR(13) + CHAR(10) + ' '
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  ----------------------------------------------------------------------------------------------------
  --// Check core requirements                                                                    //--
  ----------------------------------------------------------------------------------------------------

  IF NOT (SELECT [compatibility_level] FROM sys.databases WHERE database_id = DB_ID()) >= 90
  BEGIN
    SET @ErrorMessage = 'The database ' + QUOTENAME(DB_NAME(DB_ID())) + ' has to be in compatibility level 90 or higher.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF NOT (SELECT uses_ansi_nulls FROM sys.sql_modules WHERE [object_id] = @@PROCID) = 1
  BEGIN
    SET @ErrorMessage = 'ANSI_NULLS has to be set to ON for the stored procedure.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF NOT (SELECT uses_quoted_identifier FROM sys.sql_modules WHERE [object_id] = @@PROCID) = 1
  BEGIN
    SET @ErrorMessage = 'QUOTED_IDENTIFIER has to be set to ON for the stored procedure.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'P' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandExecute')
  BEGIN
    SET @ErrorMessage = 'The stored procedure CommandExecute is missing. Download https://ola.hallengren.com/scripts/CommandExecute.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'P' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandExecute' AND OBJECT_DEFINITION(objects.[object_id]) NOT LIKE '%@LockMessageSeverity%')
  BEGIN
    SET @ErrorMessage = 'The stored procedure CommandExecute needs to be updated. Download https://ola.hallengren.com/scripts/CommandExecute.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LogToTable = 'Y' AND NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'U' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandLog')
  BEGIN
    SET @ErrorMessage = 'The table CommandLog is missing. Download https://ola.hallengren.com/scripts/CommandLog.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DatabasesInParallel = 'Y' AND NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'U' AND schemas.[name] = 'dbo' AND objects.[name] = 'Queue')
  BEGIN
    SET @ErrorMessage = 'The table Queue is missing. Download https://ola.hallengren.com/scripts/Queue.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DatabasesInParallel = 'Y' AND NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'U' AND schemas.[name] = 'dbo' AND objects.[name] = 'QueueDatabase')
  BEGIN
    SET @ErrorMessage = 'The table QueueDatabase is missing. Download https://ola.hallengren.com/scripts/QueueDatabase.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @@TRANCOUNT <> 0
  BEGIN
    SET @ErrorMessage = 'The transaction count is not 0.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Error <> 0
  BEGIN
    SET @ReturnCode = @Error
    GOTO Logging
  END

  ----------------------------------------------------------------------------------------------------
  --// Select databases                                                                           //--
  ----------------------------------------------------------------------------------------------------

  SET @Databases = REPLACE(@Databases, CHAR(10), '')
  SET @Databases = REPLACE(@Databases, CHAR(13), '')

  WHILE CHARINDEX(', ',@Databases) > 0 SET @Databases = REPLACE(@Databases,', ',',')
  WHILE CHARINDEX(' ,',@Databases) > 0 SET @Databases = REPLACE(@Databases,' ,',',')

  SET @Databases = LTRIM(RTRIM(@Databases));

  WITH Databases1 (StartPosition, EndPosition, DatabaseItem) AS
  (
  SELECT 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @Databases, 1), 0), LEN(@Databases) + 1) AS EndPosition,
         SUBSTRING(@Databases, 1, ISNULL(NULLIF(CHARINDEX(',', @Databases, 1), 0), LEN(@Databases) + 1) - 1) AS DatabaseItem
  WHERE @Databases IS NOT NULL
  UNION ALL
  SELECT CAST(EndPosition AS int) + 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @Databases, EndPosition + 1), 0), LEN(@Databases) + 1) AS EndPosition,
         SUBSTRING(@Databases, EndPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @Databases, EndPosition + 1), 0), LEN(@Databases) + 1) - EndPosition - 1) AS DatabaseItem
  FROM Databases1
  WHERE EndPosition < LEN(@Databases) + 1
  ),
  Databases2 (DatabaseItem, StartPosition, Selected) AS
  (
  SELECT CASE WHEN DatabaseItem LIKE '-%' THEN RIGHT(DatabaseItem,LEN(DatabaseItem) - 1) ELSE DatabaseItem END AS DatabaseItem,
         StartPosition,
         CASE WHEN DatabaseItem LIKE '-%' THEN 0 ELSE 1 END AS Selected
  FROM Databases1
  ),
  Databases3 (DatabaseItem, DatabaseType, AvailabilityGroup, StartPosition, Selected) AS
  (
  SELECT CASE WHEN DatabaseItem IN('ALL_DATABASES','SYSTEM_DATABASES','USER_DATABASES','AVAILABILITY_GROUP_DATABASES') THEN '%' ELSE DatabaseItem END AS DatabaseItem,
         CASE WHEN DatabaseItem = 'SYSTEM_DATABASES' THEN 'S' WHEN DatabaseItem = 'USER_DATABASES' THEN 'U' ELSE NULL END AS DatabaseType,
         CASE WHEN DatabaseItem = 'AVAILABILITY_GROUP_DATABASES' THEN 1 ELSE NULL END AvailabilityGroup,
         StartPosition,
         Selected
  FROM Databases2
  ),
  Databases4 (DatabaseName, DatabaseType, AvailabilityGroup, StartPosition, Selected) AS
  (
  SELECT CASE WHEN LEFT(DatabaseItem,1) = '[' AND RIGHT(DatabaseItem,1) = ']' THEN PARSENAME(DatabaseItem,1) ELSE DatabaseItem END AS DatabaseItem,
         DatabaseType,
         AvailabilityGroup,
         StartPosition,
         Selected
  FROM Databases3
  )
  INSERT INTO @SelectedDatabases (DatabaseName, DatabaseType, AvailabilityGroup, StartPosition, Selected)
  SELECT DatabaseName,
         DatabaseType,
         AvailabilityGroup,
         StartPosition,
         Selected
  FROM Databases4
  OPTION (MAXRECURSION 0)

  IF @Version >= 11 AND SERVERPROPERTY('IsHadrEnabled') = 1
  BEGIN
    INSERT INTO @tmpAvailabilityGroups (AvailabilityGroupName, Selected)
    SELECT name AS AvailabilityGroupName,
           0 AS Selected
    FROM sys.availability_groups

    INSERT INTO @tmpDatabasesAvailabilityGroups (DatabaseName, AvailabilityGroupName)
    SELECT availability_databases_cluster.database_name, availability_groups.name
    FROM sys.availability_databases_cluster availability_databases_cluster
    INNER JOIN sys.availability_groups availability_groups ON availability_databases_cluster.group_id = availability_groups.group_id
  END

  INSERT INTO @tmpDatabases (DatabaseName, DatabaseType, AvailabilityGroup, [Order], Selected, Completed)
  SELECT [name] AS DatabaseName,
         CASE WHEN name IN('master','msdb','model') THEN 'S' ELSE 'U' END AS DatabaseType,
         NULL AS AvailabilityGroup,
         0 AS [Order],
         0 AS Selected,
         0 AS Completed
  FROM sys.databases
  WHERE [name] <> 'tempdb'
  AND source_database_id IS NULL
  ORDER BY [name] ASC

  UPDATE tmpDatabases
  SET AvailabilityGroup = CASE WHEN EXISTS (SELECT * FROM @tmpDatabasesAvailabilityGroups WHERE DatabaseName = tmpDatabases.DatabaseName) THEN 1 ELSE 0 END
  FROM @tmpDatabases tmpDatabases

  UPDATE tmpDatabases
  SET tmpDatabases.Selected = SelectedDatabases.Selected
  FROM @tmpDatabases tmpDatabases
  INNER JOIN @SelectedDatabases SelectedDatabases
  ON tmpDatabases.DatabaseName LIKE REPLACE(SelectedDatabases.DatabaseName,'_','[_]')
  AND (tmpDatabases.DatabaseType = SelectedDatabases.DatabaseType OR SelectedDatabases.DatabaseType IS NULL)
  AND (tmpDatabases.AvailabilityGroup = SelectedDatabases.AvailabilityGroup OR SelectedDatabases.AvailabilityGroup IS NULL)
  WHERE SelectedDatabases.Selected = 1

  UPDATE tmpDatabases
  SET tmpDatabases.Selected = SelectedDatabases.Selected
  FROM @tmpDatabases tmpDatabases
  INNER JOIN @SelectedDatabases SelectedDatabases
  ON tmpDatabases.DatabaseName LIKE REPLACE(SelectedDatabases.DatabaseName,'_','[_]')
  AND (tmpDatabases.DatabaseType = SelectedDatabases.DatabaseType OR SelectedDatabases.DatabaseType IS NULL)
  AND (tmpDatabases.AvailabilityGroup = SelectedDatabases.AvailabilityGroup OR SelectedDatabases.AvailabilityGroup IS NULL)
  WHERE SelectedDatabases.Selected = 0

  UPDATE tmpDatabases
  SET tmpDatabases.StartPosition = SelectedDatabases2.StartPosition
  FROM @tmpDatabases tmpDatabases
  INNER JOIN (SELECT tmpDatabases.DatabaseName, MIN(SelectedDatabases.StartPosition) AS StartPosition
              FROM @tmpDatabases tmpDatabases
              INNER JOIN @SelectedDatabases SelectedDatabases
              ON tmpDatabases.DatabaseName LIKE REPLACE(SelectedDatabases.DatabaseName,'_','[_]')
              AND (tmpDatabases.DatabaseType = SelectedDatabases.DatabaseType OR SelectedDatabases.DatabaseType IS NULL)
              AND (tmpDatabases.AvailabilityGroup = SelectedDatabases.AvailabilityGroup OR SelectedDatabases.AvailabilityGroup IS NULL)
              WHERE SelectedDatabases.Selected = 1
              GROUP BY tmpDatabases.DatabaseName) SelectedDatabases2
  ON tmpDatabases.DatabaseName = SelectedDatabases2.DatabaseName

  IF @Databases IS NOT NULL AND (NOT EXISTS(SELECT * FROM @SelectedDatabases) OR EXISTS(SELECT * FROM @SelectedDatabases WHERE DatabaseName IS NULL OR DatabaseName = ''))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Databases is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Select availability groups                                                                 //--
  ----------------------------------------------------------------------------------------------------

  IF @AvailabilityGroups IS NOT NULL AND @Version >= 11 AND SERVERPROPERTY('IsHadrEnabled') = 1
  BEGIN

    SET @AvailabilityGroups = REPLACE(@AvailabilityGroups, CHAR(10), '')
    SET @AvailabilityGroups = REPLACE(@AvailabilityGroups, CHAR(13), '')

    WHILE CHARINDEX(', ',@AvailabilityGroups) > 0 SET @AvailabilityGroups = REPLACE(@AvailabilityGroups,', ',',')
    WHILE CHARINDEX(' ,',@AvailabilityGroups) > 0 SET @AvailabilityGroups = REPLACE(@AvailabilityGroups,' ,',',')

    SET @AvailabilityGroups = LTRIM(RTRIM(@AvailabilityGroups));

    WITH AvailabilityGroups1 (StartPosition, EndPosition, AvailabilityGroupItem) AS
    (
    SELECT 1 AS StartPosition,
           ISNULL(NULLIF(CHARINDEX(',', @AvailabilityGroups, 1), 0), LEN(@AvailabilityGroups) + 1) AS EndPosition,
           SUBSTRING(@AvailabilityGroups, 1, ISNULL(NULLIF(CHARINDEX(',', @AvailabilityGroups, 1), 0), LEN(@AvailabilityGroups) + 1) - 1) AS AvailabilityGroupItem
    WHERE @AvailabilityGroups IS NOT NULL
    UNION ALL
    SELECT CAST(EndPosition AS int) + 1 AS StartPosition,
           ISNULL(NULLIF(CHARINDEX(',', @AvailabilityGroups, EndPosition + 1), 0), LEN(@AvailabilityGroups) + 1) AS EndPosition,
           SUBSTRING(@AvailabilityGroups, EndPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @AvailabilityGroups, EndPosition + 1), 0), LEN(@AvailabilityGroups) + 1) - EndPosition - 1) AS AvailabilityGroupItem
    FROM AvailabilityGroups1
    WHERE EndPosition < LEN(@AvailabilityGroups) + 1
    ),
    AvailabilityGroups2 (AvailabilityGroupItem, StartPosition, Selected) AS
    (
    SELECT CASE WHEN AvailabilityGroupItem LIKE '-%' THEN RIGHT(AvailabilityGroupItem,LEN(AvailabilityGroupItem) - 1) ELSE AvailabilityGroupItem END AS AvailabilityGroupItem,
           StartPosition,
           CASE WHEN AvailabilityGroupItem LIKE '-%' THEN 0 ELSE 1 END AS Selected
    FROM AvailabilityGroups1
    ),
    AvailabilityGroups3 (AvailabilityGroupItem, StartPosition, Selected) AS
    (
    SELECT CASE WHEN AvailabilityGroupItem = 'ALL_AVAILABILITY_GROUPS' THEN '%' ELSE AvailabilityGroupItem END AS AvailabilityGroupItem,
           StartPosition,
           Selected
    FROM AvailabilityGroups2
    ),
    AvailabilityGroups4 (AvailabilityGroupName, StartPosition, Selected) AS
    (
    SELECT CASE WHEN LEFT(AvailabilityGroupItem,1) = '[' AND RIGHT(AvailabilityGroupItem,1) = ']' THEN PARSENAME(AvailabilityGroupItem,1) ELSE AvailabilityGroupItem END AS AvailabilityGroupItem,
           StartPosition,
           Selected
    FROM AvailabilityGroups3
    )
    INSERT INTO @SelectedAvailabilityGroups (AvailabilityGroupName, StartPosition, Selected)
    SELECT AvailabilityGroupName, StartPosition, Selected
    FROM AvailabilityGroups4
    OPTION (MAXRECURSION 0)

    UPDATE tmpAvailabilityGroups
    SET tmpAvailabilityGroups.Selected = SelectedAvailabilityGroups.Selected
    FROM @tmpAvailabilityGroups tmpAvailabilityGroups
    INNER JOIN @SelectedAvailabilityGroups SelectedAvailabilityGroups
    ON tmpAvailabilityGroups.AvailabilityGroupName LIKE REPLACE(SelectedAvailabilityGroups.AvailabilityGroupName,'_','[_]')
    WHERE SelectedAvailabilityGroups.Selected = 1

    UPDATE tmpAvailabilityGroups
    SET tmpAvailabilityGroups.Selected = SelectedAvailabilityGroups.Selected
    FROM @tmpAvailabilityGroups tmpAvailabilityGroups
    INNER JOIN @SelectedAvailabilityGroups SelectedAvailabilityGroups
    ON tmpAvailabilityGroups.AvailabilityGroupName LIKE REPLACE(SelectedAvailabilityGroups.AvailabilityGroupName,'_','[_]')
    WHERE SelectedAvailabilityGroups.Selected = 0

    UPDATE tmpAvailabilityGroups
    SET tmpAvailabilityGroups.StartPosition = SelectedAvailabilityGroups2.StartPosition
    FROM @tmpAvailabilityGroups tmpAvailabilityGroups
    INNER JOIN (SELECT tmpAvailabilityGroups.AvailabilityGroupName, MIN(SelectedAvailabilityGroups.StartPosition) AS StartPosition
                FROM @tmpAvailabilityGroups tmpAvailabilityGroups
                INNER JOIN @SelectedAvailabilityGroups SelectedAvailabilityGroups
                ON tmpAvailabilityGroups.AvailabilityGroupName LIKE REPLACE(SelectedAvailabilityGroups.AvailabilityGroupName,'_','[_]')
                WHERE SelectedAvailabilityGroups.Selected = 1
                GROUP BY tmpAvailabilityGroups.AvailabilityGroupName) SelectedAvailabilityGroups2
    ON tmpAvailabilityGroups.AvailabilityGroupName = SelectedAvailabilityGroups2.AvailabilityGroupName

    UPDATE tmpDatabases
    SET tmpDatabases.StartPosition = tmpAvailabilityGroups.StartPosition,
        tmpDatabases.Selected = 1
    FROM @tmpDatabases tmpDatabases
    INNER JOIN @tmpDatabasesAvailabilityGroups tmpDatabasesAvailabilityGroups ON tmpDatabases.DatabaseName = tmpDatabasesAvailabilityGroups.DatabaseName
    INNER JOIN @tmpAvailabilityGroups tmpAvailabilityGroups ON tmpDatabasesAvailabilityGroups.AvailabilityGroupName = tmpAvailabilityGroups.AvailabilityGroupName
    WHERE tmpAvailabilityGroups.Selected = 1

  END

  IF @AvailabilityGroups IS NOT NULL AND (NOT EXISTS(SELECT * FROM @SelectedAvailabilityGroups) OR EXISTS(SELECT * FROM @SelectedAvailabilityGroups WHERE AvailabilityGroupName IS NULL OR AvailabilityGroupName = '') OR @Version < 11 OR SERVERPROPERTY('IsHadrEnabled') = 0)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @AvailabilityGroups is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@Databases IS NULL AND @AvailabilityGroups IS NULL)
  BEGIN
    SET @ErrorMessage = 'You need to specify one of the parameters @Databases and @AvailabilityGroups.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@Databases IS NOT NULL AND @AvailabilityGroups IS NOT NULL)
  BEGIN
    SET @ErrorMessage = 'You can only specify one of the parameters @Databases and @AvailabilityGroups.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Select indexes                                                                             //--
  ----------------------------------------------------------------------------------------------------

  SET @Indexes = REPLACE(@Indexes, CHAR(10), '')
  SET @Indexes = REPLACE(@Indexes, CHAR(13), '')

  WHILE CHARINDEX(', ',@Indexes) > 0 SET @Indexes = REPLACE(@Indexes,', ',',')
  WHILE CHARINDEX(' ,',@Indexes) > 0 SET @Indexes = REPLACE(@Indexes,' ,',',')

  SET @Indexes = LTRIM(RTRIM(@Indexes));

  WITH Indexes1 (StartPosition, EndPosition, IndexItem) AS
  (
  SELECT 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @Indexes, 1), 0), LEN(@Indexes) + 1) AS EndPosition,
         SUBSTRING(@Indexes, 1, ISNULL(NULLIF(CHARINDEX(',', @Indexes, 1), 0), LEN(@Indexes) + 1) - 1) AS IndexItem
  WHERE @Indexes IS NOT NULL
  UNION ALL
  SELECT CAST(EndPosition AS int) + 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @Indexes, EndPosition + 1), 0), LEN(@Indexes) + 1) AS EndPosition,
         SUBSTRING(@Indexes, EndPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @Indexes, EndPosition + 1), 0), LEN(@Indexes) + 1) - EndPosition - 1) AS IndexItem
  FROM Indexes1
  WHERE EndPosition < LEN(@Indexes) + 1
  ),
  Indexes2 (IndexItem, StartPosition, Selected) AS
  (
  SELECT CASE WHEN IndexItem LIKE '-%' THEN RIGHT(IndexItem,LEN(IndexItem) - 1) ELSE IndexItem END AS IndexItem,
         StartPosition,
         CASE WHEN IndexItem LIKE '-%' THEN 0 ELSE 1 END AS Selected
  FROM Indexes1
  ),
  Indexes3 (IndexItem, StartPosition, Selected) AS
  (
  SELECT CASE WHEN IndexItem = 'ALL_INDEXES' THEN '%.%.%.%' ELSE IndexItem END AS IndexItem,
         StartPosition,
         Selected
  FROM Indexes2
  ),
  Indexes4 (DatabaseName, SchemaName, ObjectName, IndexName, StartPosition, Selected) AS
  (
  SELECT CASE WHEN PARSENAME(IndexItem,4) IS NULL THEN PARSENAME(IndexItem,3) ELSE PARSENAME(IndexItem,4) END AS DatabaseName,
         CASE WHEN PARSENAME(IndexItem,4) IS NULL THEN PARSENAME(IndexItem,2) ELSE PARSENAME(IndexItem,3) END AS SchemaName,
         CASE WHEN PARSENAME(IndexItem,4) IS NULL THEN PARSENAME(IndexItem,1) ELSE PARSENAME(IndexItem,2) END AS ObjectName,
         CASE WHEN PARSENAME(IndexItem,4) IS NULL THEN '%' ELSE PARSENAME(IndexItem,1) END AS IndexName,
         StartPosition,
         Selected
  FROM Indexes3
  )
  INSERT INTO @SelectedIndexes (DatabaseName, SchemaName, ObjectName, IndexName, StartPosition, Selected)
  SELECT DatabaseName, SchemaName, ObjectName, IndexName, StartPosition, Selected
  FROM Indexes4
  OPTION (MAXRECURSION 0);

  ----------------------------------------------------------------------------------------------------
  --// Select actions                                                                             //--
  ----------------------------------------------------------------------------------------------------

  WITH FragmentationLow (StartPosition, EndPosition, [Action]) AS
  (
  SELECT 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @FragmentationLow, 1), 0), LEN(@FragmentationLow) + 1) AS EndPosition,
         SUBSTRING(@FragmentationLow, 1, ISNULL(NULLIF(CHARINDEX(',', @FragmentationLow, 1), 0), LEN(@FragmentationLow) + 1) - 1) AS [Action]
  WHERE @FragmentationLow IS NOT NULL
  UNION ALL
  SELECT CAST(EndPosition AS int) + 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @FragmentationLow, EndPosition + 1), 0), LEN(@FragmentationLow) + 1) AS EndPosition,
         SUBSTRING(@FragmentationLow, EndPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @FragmentationLow, EndPosition + 1), 0), LEN(@FragmentationLow) + 1) - EndPosition - 1) AS [Action]
  FROM FragmentationLow
  WHERE EndPosition < LEN(@FragmentationLow) + 1
  )
  INSERT INTO @ActionsPreferred(FragmentationGroup, [Priority], [Action])
  SELECT 'Low' AS FragmentationGroup,
         ROW_NUMBER() OVER(ORDER BY StartPosition ASC) AS [Priority],
         [Action]
  FROM FragmentationLow
  OPTION (MAXRECURSION 0);

  WITH FragmentationMedium (StartPosition, EndPosition, [Action]) AS
  (
  SELECT 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @FragmentationMedium, 1), 0), LEN(@FragmentationMedium) + 1) AS EndPosition,
         SUBSTRING(@FragmentationMedium, 1, ISNULL(NULLIF(CHARINDEX(',', @FragmentationMedium, 1), 0), LEN(@FragmentationMedium) + 1) - 1) AS [Action]
  WHERE @FragmentationMedium IS NOT NULL
  UNION ALL
  SELECT CAST(EndPosition AS int) + 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @FragmentationMedium, EndPosition + 1), 0), LEN(@FragmentationMedium) + 1) AS EndPosition,
         SUBSTRING(@FragmentationMedium, EndPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @FragmentationMedium, EndPosition + 1), 0), LEN(@FragmentationMedium) + 1) - EndPosition - 1) AS [Action]
  FROM FragmentationMedium
  WHERE EndPosition < LEN(@FragmentationMedium) + 1
  )
  INSERT INTO @ActionsPreferred(FragmentationGroup, [Priority], [Action])
  SELECT 'Medium' AS FragmentationGroup,
         ROW_NUMBER() OVER(ORDER BY StartPosition ASC) AS [Priority],
         [Action]
  FROM FragmentationMedium
  OPTION (MAXRECURSION 0);

  WITH FragmentationHigh (StartPosition, EndPosition, [Action]) AS
  (
  SELECT 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @FragmentationHigh, 1), 0), LEN(@FragmentationHigh) + 1) AS EndPosition,
         SUBSTRING(@FragmentationHigh, 1, ISNULL(NULLIF(CHARINDEX(',', @FragmentationHigh, 1), 0), LEN(@FragmentationHigh) + 1) - 1) AS [Action]
  WHERE @FragmentationHigh IS NOT NULL
  UNION ALL
  SELECT CAST(EndPosition AS int) + 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @FragmentationHigh, EndPosition + 1), 0), LEN(@FragmentationHigh) + 1) AS EndPosition,
         SUBSTRING(@FragmentationHigh, EndPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @FragmentationHigh, EndPosition + 1), 0), LEN(@FragmentationHigh) + 1) - EndPosition - 1) AS [Action]
  FROM FragmentationHigh
  WHERE EndPosition < LEN(@FragmentationHigh) + 1
  )
  INSERT INTO @ActionsPreferred(FragmentationGroup, [Priority], [Action])
  SELECT 'High' AS FragmentationGroup,
         ROW_NUMBER() OVER(ORDER BY StartPosition ASC) AS [Priority],
         [Action]
  FROM FragmentationHigh
  OPTION (MAXRECURSION 0)

  ----------------------------------------------------------------------------------------------------
  --// Check input parameters                                                                     //--
  ----------------------------------------------------------------------------------------------------

  IF EXISTS (SELECT [Action] FROM @ActionsPreferred WHERE FragmentationGroup = 'Low' AND [Action] NOT IN(SELECT * FROM @Actions))
  OR EXISTS(SELECT * FROM @ActionsPreferred WHERE FragmentationGroup = 'Low' GROUP BY [Action] HAVING COUNT(*) > 1)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @FragmentationLow is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF EXISTS (SELECT [Action] FROM @ActionsPreferred WHERE FragmentationGroup = 'Medium' AND [Action] NOT IN(SELECT * FROM @Actions))
  OR EXISTS(SELECT * FROM @ActionsPreferred WHERE FragmentationGroup = 'Medium' GROUP BY [Action] HAVING COUNT(*) > 1)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @FragmentationMedium is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF EXISTS (SELECT [Action] FROM @ActionsPreferred WHERE FragmentationGroup = 'High' AND [Action] NOT IN(SELECT * FROM @Actions))
  OR EXISTS(SELECT * FROM @ActionsPreferred WHERE FragmentationGroup = 'High' GROUP BY [Action] HAVING COUNT(*) > 1)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @FragmentationHigh is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FragmentationLevel1 <= 0 OR @FragmentationLevel1 >= 100 OR @FragmentationLevel1 >= @FragmentationLevel2 OR @FragmentationLevel1 IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @FragmentationLevel1 is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FragmentationLevel2 <= 0 OR @FragmentationLevel2 >= 100 OR @FragmentationLevel2 <= @FragmentationLevel1 OR @FragmentationLevel2 IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @FragmentationLevel2 is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @MinNumberOfPages < 0 OR @MinNumberOfPages IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @MinNumberOfPages is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @MaxNumberOfPages < 0
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @MaxNumberOfPages is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @SortInTempdb NOT IN('Y','N') OR @SortInTempdb IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @SortInTempdb is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @MaxDOP < 0 OR @MaxDOP > 64
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @MaxDOP is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FillFactor <= 0 OR @FillFactor > 100
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @FillFactor is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @PadIndex NOT IN('Y','N')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @PadIndex is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LOBCompaction NOT IN('Y','N') OR @LOBCompaction IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LOBCompaction is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @UpdateStatistics NOT IN('ALL','COLUMNS','INDEX')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @UpdateStatistics is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @OnlyModifiedStatistics NOT IN('Y','N') OR @OnlyModifiedStatistics IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @OnlyModifiedStatistics is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @StatisticsModificationLevel <= 0 OR @StatisticsModificationLevel > 100
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @StatisticsModificationLevel is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @OnlyModifiedStatistics = 'Y' AND @StatisticsModificationLevel IS NOT NULL
  BEGIN
    SET @ErrorMessage = 'You can only specify one of the parameters @OnlyModifiedStatistics and @StatisticsModificationLevel.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @StatisticsSample <= 0 OR @StatisticsSample  > 100
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @StatisticsSample is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @StatisticsResample NOT IN('Y','N') OR @StatisticsResample IS NULL OR (@StatisticsResample = 'Y' AND @StatisticsSample IS NOT NULL)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @StatisticsResample is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @PartitionLevel NOT IN('Y','N') OR @PartitionLevel IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @PartitionLevel is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @MSShippedObjects NOT IN('Y','N') OR @MSShippedObjects IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @MSShippedObjects is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF EXISTS(SELECT * FROM @SelectedIndexes WHERE DatabaseName IS NULL OR SchemaName IS NULL OR ObjectName IS NULL OR IndexName IS NULL) OR (@Indexes IS NOT NULL AND NOT EXISTS(SELECT * FROM @SelectedIndexes))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Indexes is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @TimeLimit < 0
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @TimeLimit is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Delay < 0
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Delay is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @WaitAtLowPriorityMaxDuration < 0 OR (@WaitAtLowPriorityMaxDuration IS NOT NULL AND @Version < 12) OR (@WaitAtLowPriorityMaxDuration IS NOT NULL AND @WaitAtLowPriorityAbortAfterWait IS NULL) OR (@WaitAtLowPriorityMaxDuration IS NULL AND @WaitAtLowPriorityAbortAfterWait IS NOT NULL)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @WaitAtLowPriorityMaxDuration is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @WaitAtLowPriorityAbortAfterWait NOT IN('NONE','SELF','BLOCKERS') OR (@WaitAtLowPriorityAbortAfterWait IS NOT NULL AND @Version < 12) OR (@WaitAtLowPriorityAbortAfterWait IS NOT NULL AND @WaitAtLowPriorityMaxDuration IS NULL) OR (@WaitAtLowPriorityAbortAfterWait IS NULL AND @WaitAtLowPriorityMaxDuration IS NOT NULL)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @WaitAtLowPriorityAbortAfterWait is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Resumable NOT IN('Y','N') OR @Resumable IS NULL OR (@Resumable = 'Y' AND NOT (@Version >= 14 OR SERVERPROPERTY('EngineEdition') IN (5,8)))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Resumable is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Resumable = 'Y' AND @SortInTempdb = 'Y'
  BEGIN
    SET @ErrorMessage = 'You can only specify one of the parameters @Resumable and @SortInTempdb.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LockTimeout < 0
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LockTimeout is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LockMessageSeverity NOT IN(10,16)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LockMessageSeverity is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DatabaseOrder NOT IN('DATABASE_NAME_ASC','DATABASE_NAME_DESC','DATABASE_SIZE_ASC','DATABASE_SIZE_DESC') OR (@DatabaseOrder IS NOT NULL AND SERVERPROPERTY('EngineEdition') = 5)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @DatabaseOrder is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DatabasesInParallel NOT IN('Y','N') OR @DatabasesInParallel IS NULL OR (@DatabasesInParallel = 'Y' AND SERVERPROPERTY('EngineEdition') = 5)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @DatabasesInParallel is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LogToTable NOT IN('Y','N') OR @LogToTable IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LogToTable is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Execute NOT IN('Y','N') OR @Execute IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Execute is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Error <> 0
  BEGIN
    SET @ErrorMessage = 'The documentation is available at https://ola.hallengren.com/sql-server-index-and-statistics-maintenance.html.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @ReturnCode = @Error
    GOTO Logging
  END

  ----------------------------------------------------------------------------------------------------
  --// Check that selected databases and availability groups exist                                //--
  ----------------------------------------------------------------------------------------------------

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + ', '
  FROM @SelectedDatabases
  WHERE DatabaseName NOT LIKE '%[%]%'
  AND DatabaseName NOT IN (SELECT DatabaseName FROM @tmpDatabases)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The following databases in the @Databases parameter do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + ', '
  FROM @SelectedIndexes
  WHERE DatabaseName NOT LIKE '%[%]%'
  AND DatabaseName NOT IN (SELECT DatabaseName FROM @tmpDatabases)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The following databases in the @Indexes parameter do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(AvailabilityGroupName) + ', '
  FROM @SelectedAvailabilityGroups
  WHERE AvailabilityGroupName NOT LIKE '%[%]%'
  AND AvailabilityGroupName NOT IN (SELECT AvailabilityGroupName FROM @tmpAvailabilityGroups)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The following availability groups do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + ', '
  FROM @SelectedIndexes
  WHERE DatabaseName NOT LIKE '%[%]%'
  AND DatabaseName IN (SELECT DatabaseName FROM @tmpDatabases)
  AND DatabaseName NOT IN (SELECT DatabaseName FROM @tmpDatabases WHERE Selected = 1)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The following databases have been selected in the @Indexes parameter, but not in the @Databases or @AvailabilityGroups parameters: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Should statistics be updated on the partition level?                                       //--
  ----------------------------------------------------------------------------------------------------

  SET @PartitionLevelStatistics = CASE WHEN @PartitionLevel = 'Y' AND ((@Version >= 12.05 AND @Version < 13) OR @Version >= 13.04422 OR SERVERPROPERTY('EngineEdition') IN (5,8)) THEN 1 ELSE 0 END

  ----------------------------------------------------------------------------------------------------
  --// Update database order                                                                      //--
  ----------------------------------------------------------------------------------------------------

  IF @DatabaseOrder IN('DATABASE_SIZE_ASC','DATABASE_SIZE_DESC')
  BEGIN
    UPDATE tmpDatabases
    SET DatabaseSize = (SELECT SUM(size) FROM sys.master_files WHERE [type] = 0 AND database_id = DB_ID(tmpDatabases.DatabaseName))
    FROM @tmpDatabases tmpDatabases
  END

  IF @DatabaseOrder IS NULL
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY StartPosition ASC, DatabaseName ASC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_NAME_ASC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY DatabaseName ASC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_NAME_DESC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY DatabaseName DESC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_SIZE_ASC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY DatabaseSize ASC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_SIZE_DESC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY DatabaseSize DESC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END

  ----------------------------------------------------------------------------------------------------
  --// Update the queue                                                                           //--
  ----------------------------------------------------------------------------------------------------

  IF @DatabasesInParallel = 'Y'
  BEGIN

    BEGIN TRY

      SELECT @QueueID = QueueID
      FROM dbo.[Queue]
      WHERE SchemaName = @SchemaName
      AND ObjectName = @ObjectName
      AND [Parameters] = @Parameters

      IF @QueueID IS NULL
      BEGIN
        BEGIN TRANSACTION

        SELECT @QueueID = QueueID
        FROM dbo.[Queue] WITH (UPDLOCK, TABLOCK)
        WHERE SchemaName = @SchemaName
        AND ObjectName = @ObjectName
        AND [Parameters] = @Parameters

        IF @QueueID IS NULL
        BEGIN
          INSERT INTO dbo.[Queue] (SchemaName, ObjectName, [Parameters])
          SELECT @SchemaName, @ObjectName, @Parameters

          SET @QueueID = SCOPE_IDENTITY()
        END

        COMMIT TRANSACTION
      END

      BEGIN TRANSACTION

      UPDATE [Queue]
      SET QueueStartTime = GETDATE(),
          SessionID = @@SPID,
          RequestID = (SELECT request_id FROM sys.dm_exec_requests WHERE session_id = @@SPID),
          RequestStartTime = (SELECT start_time FROM sys.dm_exec_requests WHERE session_id = @@SPID)
      FROM dbo.[Queue] [Queue]
      WHERE QueueID = @QueueID
      AND NOT EXISTS (SELECT *
                      FROM sys.dm_exec_requests
                      WHERE session_id = [Queue].SessionID
                      AND request_id = [Queue].RequestID
                      AND start_time = [Queue].RequestStartTime)
      AND NOT EXISTS (SELECT *
                      FROM dbo.QueueDatabase QueueDatabase
                      INNER JOIN sys.dm_exec_requests ON QueueDatabase.SessionID = session_id AND QueueDatabase.RequestID = request_id AND QueueDatabase.RequestStartTime = start_time
                      WHERE QueueDatabase.QueueID = @QueueID)

      IF @@ROWCOUNT = 1
      BEGIN
        INSERT INTO dbo.QueueDatabase (QueueID, DatabaseName)
        SELECT @QueueID AS QueueID,
               DatabaseName
        FROM @tmpDatabases tmpDatabases
        WHERE Selected = 1
        AND NOT EXISTS (SELECT * FROM dbo.QueueDatabase WHERE DatabaseName = tmpDatabases.DatabaseName AND QueueID = @QueueID)

        DELETE QueueDatabase
        FROM dbo.QueueDatabase QueueDatabase
        WHERE QueueID = @QueueID
        AND NOT EXISTS (SELECT * FROM @tmpDatabases tmpDatabases WHERE DatabaseName = QueueDatabase.DatabaseName AND Selected = 1)

        UPDATE QueueDatabase
        SET DatabaseOrder = tmpDatabases.[Order]
        FROM dbo.QueueDatabase QueueDatabase
        INNER JOIN @tmpDatabases tmpDatabases ON QueueDatabase.DatabaseName = tmpDatabases.DatabaseName
      END

      COMMIT TRANSACTION

      SELECT @QueueStartTime = QueueStartTime
      FROM dbo.[Queue]
      WHERE QueueID = @QueueID

    END TRY

    BEGIN CATCH
      IF XACT_STATE() <> 0
      BEGIN
        ROLLBACK TRANSACTION
      END
      SET @ErrorMessage = 'Msg ' + CAST(ERROR_NUMBER() AS nvarchar) + ', ' + ISNULL(ERROR_MESSAGE(),'') + CHAR(13) + CHAR(10) + ' '
      RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
      SET @ReturnCode = ERROR_NUMBER()
      GOTO Logging
    END CATCH

  END

  ----------------------------------------------------------------------------------------------------
  --// Execute commands                                                                           //--
  ----------------------------------------------------------------------------------------------------

  WHILE (1 = 1)
  BEGIN

    IF @DatabasesInParallel = 'Y'
    BEGIN
      UPDATE QueueDatabase
      SET DatabaseStartTime = NULL,
          SessionID = NULL,
          RequestID = NULL,
          RequestStartTime = NULL
      FROM dbo.QueueDatabase QueueDatabase
      WHERE QueueID = @QueueID
      AND DatabaseStartTime IS NOT NULL
      AND DatabaseEndTime IS NULL
      AND NOT EXISTS (SELECT * FROM sys.dm_exec_requests WHERE session_id = QueueDatabase.SessionID AND request_id = QueueDatabase.RequestID AND start_time = QueueDatabase.RequestStartTime)

      UPDATE QueueDatabase
      SET DatabaseStartTime = GETDATE(),
          DatabaseEndTime = NULL,
          SessionID = @@SPID,
          RequestID = (SELECT request_id FROM sys.dm_exec_requests WHERE session_id = @@SPID),
          RequestStartTime = (SELECT start_time FROM sys.dm_exec_requests WHERE session_id = @@SPID),
          @CurrentDatabaseName = DatabaseName
      FROM (SELECT TOP 1 DatabaseStartTime,
                         DatabaseEndTime,
                         SessionID,
                         RequestID,
                         RequestStartTime,
                         DatabaseName
            FROM dbo.QueueDatabase
            WHERE QueueID = @QueueID
            AND (DatabaseStartTime < @QueueStartTime OR DatabaseStartTime IS NULL)
            AND NOT (DatabaseStartTime IS NOT NULL AND DatabaseEndTime IS NULL)
            ORDER BY DatabaseOrder ASC
            ) QueueDatabase
    END
    ELSE
    BEGIN
      SELECT TOP 1 @CurrentDBID = ID,
                   @CurrentDatabaseName = DatabaseName
      FROM @tmpDatabases
      WHERE Selected = 1
      AND Completed = 0
      ORDER BY [Order] ASC
    END

    IF @@ROWCOUNT = 0
    BEGIN
      BREAK
    END

    SET @CurrentDatabaseID = DB_ID(@CurrentDatabaseName)

    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'ONLINE' AND SERVERPROPERTY('EngineEdition') <> 5
    BEGIN
      IF EXISTS (SELECT * FROM sys.database_recovery_status WHERE database_id = @CurrentDatabaseID AND database_guid IS NOT NULL)
      BEGIN
        SET @CurrentIsDatabaseAccessible = 1
      END
      ELSE
      BEGIN
        SET @CurrentIsDatabaseAccessible = 0
      END
    END

    IF @Version >= 11 AND SERVERPROPERTY('IsHadrEnabled') = 1
    BEGIN
      SELECT @CurrentAvailabilityGroup = availability_groups.name,
             @CurrentAvailabilityGroupRole = dm_hadr_availability_replica_states.role_desc
      FROM sys.databases databases
      INNER JOIN sys.availability_databases_cluster availability_databases_cluster ON databases.group_database_id = availability_databases_cluster.group_database_id
      INNER JOIN sys.availability_groups availability_groups ON availability_databases_cluster.group_id = availability_groups.group_id
      INNER JOIN sys.dm_hadr_availability_replica_states dm_hadr_availability_replica_states ON availability_groups.group_id = dm_hadr_availability_replica_states.group_id AND databases.replica_id = dm_hadr_availability_replica_states.replica_id
      WHERE databases.name = @CurrentDatabaseName
    END

    IF SERVERPROPERTY('EngineEdition') <> 5
    BEGIN
      SELECT @CurrentDatabaseMirroringRole = UPPER(mirroring_role_desc)
      FROM sys.database_mirroring
      WHERE database_id = @CurrentDatabaseID
    END

    SELECT @CurrentIsReadOnly = is_read_only
    FROM sys.databases
    WHERE name = @CurrentDatabaseName

    SET @DatabaseMessage = 'Date and time: ' + CONVERT(nvarchar,GETDATE(),120)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'Database: ' + QUOTENAME(@CurrentDatabaseName)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'Status: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') AS nvarchar)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'Standby: ' + CASE WHEN DATABASEPROPERTYEX(@CurrentDatabaseName,'IsInStandBy') = 1 THEN 'Yes' ELSE 'No' END
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'Updateability: ' + CASE WHEN @CurrentIsReadOnly = 1 THEN 'READ_ONLY' WHEN  @CurrentIsReadOnly = 0 THEN 'READ_WRITE' END
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'User access: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabaseName,'UserAccess') AS nvarchar)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    IF @CurrentIsDatabaseAccessible IS NOT NULL
    BEGIN
      SET @DatabaseMessage = 'Is accessible: ' + CASE WHEN @CurrentIsDatabaseAccessible = 1 THEN 'Yes' ELSE 'No' END
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT
    END

    SET @DatabaseMessage = 'Recovery model: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabaseName,'Recovery') AS nvarchar)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    IF @CurrentAvailabilityGroup IS NOT NULL
    BEGIN
      SET @DatabaseMessage = 'Availability group: ' + @CurrentAvailabilityGroup
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

      SET @DatabaseMessage = 'Availability group role: ' + @CurrentAvailabilityGroupRole
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT
    END

    IF @CurrentDatabaseMirroringRole IS NOT NULL
    BEGIN
      SET @DatabaseMessage = 'Database mirroring role: ' + @CurrentDatabaseMirroringRole
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT
    END

    RAISERROR('',10,1) WITH NOWAIT

    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'ONLINE'
    AND (@CurrentIsDatabaseAccessible = 1 OR @CurrentIsDatabaseAccessible IS NULL)
    AND DATABASEPROPERTYEX(@CurrentDatabaseName,'Updateability') = 'READ_WRITE'
    BEGIN

      -- Select indexes in the current database
      IF (EXISTS(SELECT * FROM @ActionsPreferred) OR @UpdateStatistics IS NOT NULL) AND (GETDATE() < DATEADD(ss,@TimeLimit,@StartTime) OR @TimeLimit IS NULL)
      BEGIN
        SET @CurrentCommand01 = 'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;'
                              + 'USE ' + QUOTENAME(@CurrentDatabaseName) + ';'
                              + ' SELECT SchemaID, SchemaName, ObjectID, ObjectName, ObjectType, IsMemoryOptimized, IndexID, IndexName, IndexType, AllowPageLocks, IsImageText, IsNewLOB, IsFileStream, IsColumnStore, IsComputed, IsTimestamp, OnReadOnlyFileGroup, ResumableIndexOperation, StatisticsID, StatisticsName, NoRecompute, IsIncremental, PartitionID, PartitionNumber, PartitionCount, [Order], Selected, Completed'
                              + ' FROM ('

        IF EXISTS(SELECT * FROM @ActionsPreferred) OR @UpdateStatistics IN('ALL','INDEX')
        BEGIN
          SET @CurrentCommand01 = @CurrentCommand01 + 'SELECT schemas.[schema_id] AS SchemaID'
                                                    + ', schemas.[name] AS SchemaName'
                                                    + ', objects.[object_id] AS ObjectID'
                                                    + ', objects.[name] AS ObjectName'
                                                    + ', RTRIM(objects.[type]) AS ObjectType'
                                                    + ', ' + CASE WHEN @Version >= 12 THEN 'tables.is_memory_optimized' ELSE '0' END + ' AS IsMemoryOptimized'
                                                    + ', indexes.index_id AS IndexID'
                                                    + ', indexes.[name] AS IndexName'
                                                    + ', indexes.[type] AS IndexType'
                                                    + ', indexes.allow_page_locks AS AllowPageLocks'

                                                    + ', CASE WHEN indexes.[type] = 1 AND EXISTS(SELECT * FROM sys.columns columns INNER JOIN sys.types types ON columns.system_type_id = types.user_type_id WHERE columns.[object_id] = objects.object_id AND types.name IN(''image'',''text'',''ntext'')) THEN 1 ELSE 0 END AS IsImageText'

                                                    + ', CASE WHEN indexes.[type] = 1 AND EXISTS(SELECT * FROM sys.columns columns INNER JOIN sys.types types ON columns.system_type_id = types.user_type_id OR (columns.user_type_id = types.user_type_id AND types.is_assembly_type = 1) WHERE columns.[object_id] = objects.object_id AND (types.name IN(''xml'') OR (types.name IN(''varchar'',''nvarchar'',''varbinary'') AND columns.max_length = -1) OR (types.is_assembly_type = 1 AND columns.max_length = -1))) THEN 1'
                                                    + ' WHEN indexes.[type] = 2 AND EXISTS(SELECT * FROM sys.index_columns index_columns INNER JOIN sys.columns columns ON index_columns.[object_id] = columns.[object_id] AND index_columns.column_id = columns.column_id INNER JOIN sys.types types ON columns.system_type_id = types.user_type_id OR (columns.user_type_id = types.user_type_id AND types.is_assembly_type = 1) WHERE index_columns.[object_id] = objects.object_id AND index_columns.index_id = indexes.index_id AND (types.[name] IN(''xml'') OR (types.[name] IN(''varchar'',''nvarchar'',''varbinary'') AND columns.max_length = -1) OR (types.is_assembly_type = 1 AND columns.max_length = -1))) THEN 1 ELSE 0 END AS IsNewLOB'

                                                    + ', CASE WHEN indexes.[type] = 1 AND EXISTS(SELECT * FROM sys.columns columns WHERE columns.[object_id] = objects.object_id  AND columns.is_filestream = 1) THEN 1 ELSE 0 END AS IsFileStream'

                                                    + ', CASE WHEN EXISTS(SELECT * FROM sys.indexes indexes WHERE indexes.[object_id] = objects.object_id AND [type] IN(5,6)) THEN 1 ELSE 0 END AS IsColumnStore'

                                                    + ', CASE WHEN EXISTS(SELECT * FROM sys.index_columns index_columns INNER JOIN sys.columns columns ON index_columns.object_id = columns.object_id AND index_columns.column_id = columns.column_id WHERE (index_columns.key_ordinal > 0 OR index_columns.partition_ordinal > 0) AND columns.is_computed = 1 AND index_columns.object_id = indexes.object_id AND index_columns.index_id = indexes.index_id) THEN 1 ELSE 0 END AS IsComputed'

                                                    + ', CASE WHEN EXISTS(SELECT * FROM sys.index_columns index_columns INNER JOIN sys.columns columns ON index_columns.[object_id] = columns.[object_id] AND index_columns.column_id = columns.column_id INNER JOIN sys.types types ON columns.system_type_id = types.system_type_id WHERE index_columns.[object_id] = objects.object_id AND index_columns.index_id = indexes.index_id AND types.[name] = ''timestamp'') THEN 1 ELSE 0 END AS IsTimestamp'

                                                    + ', CASE WHEN EXISTS (SELECT * FROM sys.indexes indexes2 INNER JOIN sys.destination_data_spaces destination_data_spaces ON indexes.data_space_id = destination_data_spaces.partition_scheme_id INNER JOIN sys.filegroups filegroups ON destination_data_spaces.data_space_id = filegroups.data_space_id WHERE filegroups.is_read_only = 1 AND indexes2.[object_id] = indexes.[object_id] AND indexes2.[index_id] = indexes.index_id' + CASE WHEN @PartitionLevel = 'Y' THEN ' AND destination_data_spaces.destination_id = partitions.partition_number' ELSE '' END + ') THEN 1'
                                                    + ' WHEN EXISTS (SELECT * FROM sys.indexes indexes2 INNER JOIN sys.filegroups filegroups ON indexes.data_space_id = filegroups.data_space_id WHERE filegroups.is_read_only = 1 AND indexes.[object_id] = indexes2.[object_id] AND indexes.[index_id] = indexes2.index_id) THEN 1'
                                                    + ' WHEN indexes.[type] = 1 AND EXISTS (SELECT * FROM sys.tables tables INNER JOIN sys.filegroups filegroups ON tables.lob_data_space_id = filegroups.data_space_id WHERE filegroups.is_read_only = 1 AND tables.[object_id] = objects.[object_id]) THEN 1 ELSE 0 END AS OnReadOnlyFileGroup'

                                                    + ', ' + CASE WHEN @Version >= 14 THEN 'CASE WHEN EXISTS(SELECT * FROM sys.index_resumable_operations index_resumable_operations WHERE state_desc = ''PAUSED'' AND index_resumable_operations.object_id = indexes.object_id AND index_resumable_operations.index_id = indexes.index_id AND (index_resumable_operations.partition_number = partitions.partition_number OR index_resumable_operations.partition_number IS NULL)) THEN 1 ELSE 0 END' ELSE '0' END + ' AS ResumableIndexOperation'

                                                    + ', stats.stats_id AS StatisticsID'
                                                    + ', stats.name AS StatisticsName'
                                                    + ', stats.no_recompute AS NoRecompute'
                                                    + ', ' + CASE WHEN @Version >= 12 THEN 'stats.is_incremental' ELSE '0' END + ' AS IsIncremental'
                                                    + ', ' + CASE WHEN @PartitionLevel = 'Y' THEN 'partitions.partition_id AS PartitionID' WHEN @PartitionLevel = 'N' THEN 'NULL AS PartitionID' END
                                                    + ', ' + CASE WHEN @PartitionLevel = 'Y' THEN 'partitions.partition_number AS PartitionNumber' WHEN @PartitionLevel = 'N' THEN 'NULL AS PartitionNumber' END
                                                    + ', ' + CASE WHEN @PartitionLevel = 'Y' THEN 'IndexPartitions.partition_count AS PartitionCount' WHEN @PartitionLevel = 'N' THEN 'NULL AS PartitionCount' END
                                                    + ', 0 AS [Order]'
                                                    + ', 0 AS Selected'
                                                    + ', 0 AS Completed'
                                                    + ' FROM sys.indexes indexes'
                                                    + ' INNER JOIN sys.objects objects ON indexes.[object_id] = objects.[object_id]'
                                                    + ' INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id]'
                                                    + ' LEFT OUTER JOIN sys.tables tables ON objects.[object_id] = tables.[object_id]'
                                                    + ' LEFT OUTER JOIN sys.stats stats ON indexes.[object_id] = stats.[object_id] AND indexes.[index_id] = stats.[stats_id]'
          IF @PartitionLevel = 'Y'
          BEGIN
            SET @CurrentCommand01 = @CurrentCommand01 + ' LEFT OUTER JOIN sys.partitions partitions ON indexes.[object_id] = partitions.[object_id] AND indexes.index_id = partitions.index_id'
                                                      + ' LEFT OUTER JOIN (SELECT partitions.[object_id], partitions.index_id, COUNT(DISTINCT partitions.partition_number) AS partition_count FROM sys.partitions partitions GROUP BY partitions.[object_id], partitions.index_id) IndexPartitions ON partitions.[object_id] = IndexPartitions.[object_id] AND partitions.[index_id] = IndexPartitions.[index_id]'
          END

          SET @CurrentCommand01 = @CurrentCommand01 + ' WHERE objects.[type] IN(''U'',''V'')'
                                                    + CASE WHEN @MSShippedObjects = 'N' THEN ' AND objects.is_ms_shipped = 0' ELSE '' END
                                                    + ' AND indexes.[type] IN(1,2,3,4,5,6,7)'
                                                    + ' AND indexes.is_disabled = 0 AND indexes.is_hypothetical = 0'
        END

        IF (EXISTS(SELECT * FROM @ActionsPreferred) AND @UpdateStatistics = 'COLUMNS') OR @UpdateStatistics = 'ALL'
        BEGIN
          SET @CurrentCommand01 = @CurrentCommand01 + ' UNION '
        END

        IF @UpdateStatistics IN('ALL','COLUMNS')
        BEGIN
          SET @CurrentCommand01 = @CurrentCommand01 + 'SELECT schemas.[schema_id] AS SchemaID'
                                                    + ', schemas.[name] AS SchemaName'
                                                    + ', objects.[object_id] AS ObjectID'
                                                    + ', objects.[name] AS ObjectName'
                                                    + ', RTRIM(objects.[type]) AS ObjectType'
                                                    + ', ' + CASE WHEN @Version >= 12 THEN 'tables.is_memory_optimized' ELSE '0' END + ' AS IsMemoryOptimized'
                                                    + ', NULL AS IndexID, NULL AS IndexName'
                                                    + ', NULL AS IndexType'
                                                    + ', NULL AS AllowPageLocks'
                                                    + ', NULL AS IsImageText'
                                                    + ', NULL AS IsNewLOB'
                                                    + ', NULL AS IsFileStream'
                                                    + ', NULL AS IsColumnStore'
                                                    + ', NULL AS IsComputed'
                                                    + ', NULL AS IsTimestamp'
                                                    + ', NULL AS OnReadOnlyFileGroup'
                                                    + ', NULL AS ResumableIndexOperation'
                                                    + ', stats.stats_id AS StatisticsID'
                                                    + ', stats.name AS StatisticsName'
                                                    + ', stats.no_recompute AS NoRecompute'
                                                    + ', ' + CASE WHEN @Version >= 12 THEN 'stats.is_incremental' ELSE '0' END + ' AS IsIncremental'
                                                    + ', NULL AS PartitionID'
                                                    + ', ' + CASE WHEN @PartitionLevelStatistics = 1 THEN 'dm_db_incremental_stats_properties.partition_number' ELSE 'NULL' END + ' AS PartitionNumber'
                                                    + ', NULL AS PartitionCount'
                                                    + ', 0 AS [Order]'
                                                    + ', 0 AS Selected'
                                                    + ', 0 AS Completed'
                                                    + ' FROM sys.stats stats'
                                                    + ' INNER JOIN sys.objects objects ON stats.[object_id] = objects.[object_id]'
                                                    + ' INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id]'
                                                    + ' LEFT OUTER JOIN sys.tables tables ON objects.[object_id] = tables.[object_id]'

          IF @PartitionLevelStatistics = 1
          BEGIN
            SET @CurrentCommand01 = @CurrentCommand01 + ' OUTER APPLY sys.dm_db_incremental_stats_properties(stats.object_id, stats.stats_id) dm_db_incremental_stats_properties'
          END

          SET @CurrentCommand01 = @CurrentCommand01 + ' WHERE objects.[type] IN(''U'',''V'')'
                                                    + CASE WHEN @MSShippedObjects = 'N' THEN ' AND objects.is_ms_shipped = 0' ELSE '' END
                                                    + ' AND NOT EXISTS(SELECT * FROM sys.indexes indexes WHERE indexes.[object_id] = stats.[object_id] AND indexes.index_id = stats.stats_id)'
        END

        SET @CurrentCommand01 = @CurrentCommand01 + ') IndexesStatistics'

        INSERT INTO @tmpIndexesStatistics (SchemaID, SchemaName, ObjectID, ObjectName, ObjectType, IsMemoryOptimized, IndexID, IndexName, IndexType, AllowPageLocks, IsImageText, IsNewLOB, IsFileStream, IsColumnStore, IsComputed, IsTimestamp, OnReadOnlyFileGroup, ResumableIndexOperation, StatisticsID, StatisticsName, [NoRecompute], IsIncremental, PartitionID, PartitionNumber, PartitionCount, [Order], Selected, Completed)
        EXECUTE sp_executesql @statement = @CurrentCommand01
        SET @Error = @@ERROR
        IF @Error <> 0
        BEGIN
          SET @ReturnCode = @Error
        END
      END

      IF @Indexes IS NULL
      BEGIN
        UPDATE tmpIndexesStatistics
        SET tmpIndexesStatistics.Selected = 1
        FROM @tmpIndexesStatistics tmpIndexesStatistics
      END
      ELSE
      BEGIN
        UPDATE tmpIndexesStatistics
        SET tmpIndexesStatistics.Selected = SelectedIndexes.Selected
        FROM @tmpIndexesStatistics tmpIndexesStatistics
        INNER JOIN @SelectedIndexes SelectedIndexes
        ON @CurrentDatabaseName LIKE REPLACE(SelectedIndexes.DatabaseName,'_','[_]') AND tmpIndexesStatistics.SchemaName LIKE REPLACE(SelectedIndexes.SchemaName,'_','[_]') AND tmpIndexesStatistics.ObjectName LIKE REPLACE(SelectedIndexes.ObjectName,'_','[_]') AND COALESCE(tmpIndexesStatistics.IndexName,tmpIndexesStatistics.StatisticsName) LIKE REPLACE(SelectedIndexes.IndexName,'_','[_]')
        WHERE SelectedIndexes.Selected = 1

        UPDATE tmpIndexesStatistics
        SET tmpIndexesStatistics.Selected = SelectedIndexes.Selected
        FROM @tmpIndexesStatistics tmpIndexesStatistics
        INNER JOIN @SelectedIndexes SelectedIndexes
        ON @CurrentDatabaseName LIKE REPLACE(SelectedIndexes.DatabaseName,'_','[_]') AND tmpIndexesStatistics.SchemaName LIKE REPLACE(SelectedIndexes.SchemaName,'_','[_]') AND tmpIndexesStatistics.ObjectName LIKE REPLACE(SelectedIndexes.ObjectName,'_','[_]') AND COALESCE(tmpIndexesStatistics.IndexName,tmpIndexesStatistics.StatisticsName) LIKE REPLACE(SelectedIndexes.IndexName,'_','[_]')
        WHERE SelectedIndexes.Selected = 0

        UPDATE tmpIndexesStatistics
        SET tmpIndexesStatistics.StartPosition = SelectedIndexes2.StartPosition
        FROM @tmpIndexesStatistics tmpIndexesStatistics
        INNER JOIN (SELECT tmpIndexesStatistics.SchemaName, tmpIndexesStatistics.ObjectName, tmpIndexesStatistics.IndexName, tmpIndexesStatistics.StatisticsName, MIN(SelectedIndexes.StartPosition) AS StartPosition
                    FROM @tmpIndexesStatistics tmpIndexesStatistics
                    INNER JOIN @SelectedIndexes SelectedIndexes
                    ON @CurrentDatabaseName LIKE REPLACE(SelectedIndexes.DatabaseName,'_','[_]') AND tmpIndexesStatistics.SchemaName LIKE REPLACE(SelectedIndexes.SchemaName,'_','[_]') AND tmpIndexesStatistics.ObjectName LIKE REPLACE(SelectedIndexes.ObjectName,'_','[_]') AND COALESCE(tmpIndexesStatistics.IndexName,tmpIndexesStatistics.StatisticsName) LIKE REPLACE(SelectedIndexes.IndexName,'_','[_]')
                    WHERE SelectedIndexes.Selected = 1
                    GROUP BY tmpIndexesStatistics.SchemaName, tmpIndexesStatistics.ObjectName, tmpIndexesStatistics.IndexName, tmpIndexesStatistics.StatisticsName) SelectedIndexes2
        ON tmpIndexesStatistics.SchemaName = SelectedIndexes2.SchemaName
        AND tmpIndexesStatistics.ObjectName = SelectedIndexes2.ObjectName
        AND (tmpIndexesStatistics.IndexName = SelectedIndexes2.IndexName OR tmpIndexesStatistics.IndexName IS NULL)
        AND (tmpIndexesStatistics.StatisticsName = SelectedIndexes2.StatisticsName OR tmpIndexesStatistics.StatisticsName IS NULL)
      END;

      WITH tmpIndexesStatistics AS (
      SELECT SchemaName, ObjectName, [Order], ROW_NUMBER() OVER (ORDER BY ISNULL(ResumableIndexOperation,0) DESC, StartPosition ASC, SchemaName ASC, ObjectName ASC, CASE WHEN IndexType IS NULL THEN 1 ELSE 0 END ASC, IndexType ASC, IndexName ASC, StatisticsName ASC, PartitionNumber ASC) AS RowNumber
      FROM @tmpIndexesStatistics tmpIndexesStatistics
      WHERE Selected = 1
      )
      UPDATE tmpIndexesStatistics
      SET [Order] = RowNumber

      SET @ErrorMessage = ''
      SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + '.' + QUOTENAME(SchemaName) + '.' + QUOTENAME(ObjectName) + ', '
      FROM @SelectedIndexes SelectedIndexes
      WHERE DatabaseName = @CurrentDatabaseName
      AND SchemaName NOT LIKE '%[%]%'
      AND ObjectName NOT LIKE '%[%]%'
      AND IndexName LIKE '%[%]%'
      AND NOT EXISTS (SELECT * FROM @tmpIndexesStatistics WHERE SchemaName = SelectedIndexes.SchemaName AND ObjectName = SelectedIndexes.ObjectName)
      IF @@ROWCOUNT > 0
      BEGIN
        SET @ErrorMessage = 'The following objects in the @Indexes parameter do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
        RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
        SET @Error = @@ERROR
      END

      SET @ErrorMessage = ''
      SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + QUOTENAME(SchemaName) + '.' + QUOTENAME(ObjectName) + '.' + QUOTENAME(IndexName) + ', '
      FROM @SelectedIndexes SelectedIndexes
      WHERE DatabaseName = @CurrentDatabaseName
      AND SchemaName NOT LIKE '%[%]%'
      AND ObjectName NOT LIKE '%[%]%'
      AND IndexName NOT LIKE '%[%]%'
      AND NOT EXISTS (SELECT * FROM @tmpIndexesStatistics WHERE SchemaName = SelectedIndexes.SchemaName AND ObjectName = SelectedIndexes.ObjectName AND IndexName = SelectedIndexes.IndexName)
      IF @@ROWCOUNT > 0
      BEGIN
        SET @ErrorMessage = 'The following indexes in the @Indexes parameter do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
        RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
        SET @Error = @@ERROR
      END

      WHILE (GETDATE() < DATEADD(ss,@TimeLimit,@StartTime) OR @TimeLimit IS NULL)
      BEGIN
        SELECT TOP 1 @CurrentIxID = ID,
                     @CurrentSchemaID = SchemaID,
                     @CurrentSchemaName = SchemaName,
                     @CurrentObjectID = ObjectID,
                     @CurrentObjectName = ObjectName,
                     @CurrentObjectType = ObjectType,
                     @CurrentIsMemoryOptimized = IsMemoryOptimized,
                     @CurrentIndexID = IndexID,
                     @CurrentIndexName = IndexName,
                     @CurrentIndexType = IndexType,
                     @CurrentAllowPageLocks = AllowPageLocks,
                     @CurrentIsImageText = IsImageText,
                     @CurrentIsNewLOB = IsNewLOB,
                     @CurrentIsFileStream = IsFileStream,
                     @CurrentIsColumnStore = IsColumnStore,
                     @CurrentIsComputed = IsComputed,
                     @CurrentIsTimestamp = IsTimestamp,
                     @CurrentOnReadOnlyFileGroup = OnReadOnlyFileGroup,
                     @CurrentResumableIndexOperation = ResumableIndexOperation,
                     @CurrentStatisticsID = StatisticsID,
                     @CurrentStatisticsName = StatisticsName,
                     @CurrentNoRecompute = [NoRecompute],
                     @CurrentIsIncremental = IsIncremental,
                     @CurrentPartitionID = PartitionID,
                     @CurrentPartitionNumber = PartitionNumber,
                     @CurrentPartitionCount = PartitionCount
        FROM @tmpIndexesStatistics
        WHERE Selected = 1
        AND Completed = 0
        ORDER BY [Order] ASC

        IF @@ROWCOUNT = 0
        BEGIN
          BREAK
        END

        -- Is the index a partition?
        IF @CurrentPartitionNumber IS NULL OR @CurrentPartitionCount = 1 BEGIN SET @CurrentIsPartition = 0 END ELSE BEGIN SET @CurrentIsPartition = 1 END

        -- Does the index exist?
        IF @CurrentIndexID IS NOT NULL AND EXISTS(SELECT * FROM @ActionsPreferred)
        BEGIN
          SET @CurrentCommand02 = ''

          IF @LockTimeout IS NOT NULL SET @CurrentCommand02 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '
          SET @CurrentCommand02 = @CurrentCommand02 + 'USE ' + QUOTENAME(@CurrentDatabaseName) + '; '

          IF @CurrentIsPartition = 0 SET @CurrentCommand02 = @CurrentCommand02 + 'IF EXISTS(SELECT * FROM sys.indexes indexes INNER JOIN sys.objects objects ON indexes.[object_id] = objects.[object_id] INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] IN(''U'',''V'') AND indexes.[type] IN(1,2,3,4,5,6,7) AND indexes.is_disabled = 0 AND indexes.is_hypothetical = 0 AND schemas.[schema_id] = @ParamSchemaID AND schemas.[name] = @ParamSchemaName AND objects.[object_id] = @ParamObjectID AND objects.[name] = @ParamObjectName AND objects.[type] = @ParamObjectType AND indexes.index_id = @ParamIndexID AND indexes.[name] = @ParamIndexName AND indexes.[type] = @ParamIndexType) BEGIN SET @ParamIndexExists = 1 END'
          IF @CurrentIsPartition = 1 SET @CurrentCommand02 = @CurrentCommand02 + 'IF EXISTS(SELECT * FROM sys.indexes indexes INNER JOIN sys.objects objects ON indexes.[object_id] = objects.[object_id] INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] INNER JOIN sys.partitions partitions ON indexes.[object_id] = partitions.[object_id] AND indexes.index_id = partitions.index_id WHERE objects.[type] IN(''U'',''V'') AND indexes.[type] IN(1,2,3,4,5,6,7) AND indexes.is_disabled = 0 AND indexes.is_hypothetical = 0 AND schemas.[schema_id] = @ParamSchemaID AND schemas.[name] = @ParamSchemaName AND objects.[object_id] = @ParamObjectID AND objects.[name] = @ParamObjectName AND objects.[type] = @ParamObjectType AND indexes.index_id = @ParamIndexID AND indexes.[name] = @ParamIndexName AND indexes.[type] = @ParamIndexType AND partitions.partition_id = @ParamPartitionID AND partitions.partition_number = @ParamPartitionNumber) BEGIN SET @ParamIndexExists = 1 END'

          BEGIN TRY
            EXECUTE sp_executesql @statement = @CurrentCommand02, @params = N'@ParamSchemaID int, @ParamSchemaName sysname, @ParamObjectID int, @ParamObjectName sysname, @ParamObjectType sysname, @ParamIndexID int, @ParamIndexName sysname, @ParamIndexType int, @ParamPartitionID bigint, @ParamPartitionNumber int, @ParamIndexExists bit OUTPUT', @ParamSchemaID = @CurrentSchemaID, @ParamSchemaName = @CurrentSchemaName, @ParamObjectID = @CurrentObjectID, @ParamObjectName = @CurrentObjectName, @ParamObjectType = @CurrentObjectType, @ParamIndexID = @CurrentIndexID, @ParamIndexName = @CurrentIndexName, @ParamIndexType = @CurrentIndexType, @ParamPartitionID = @CurrentPartitionID, @ParamPartitionNumber = @CurrentPartitionNumber, @ParamIndexExists = @CurrentIndexExists OUTPUT

            IF @CurrentIndexExists IS NULL
            BEGIN
              SET @CurrentIndexExists = 0
              GOTO NoAction
            END
          END TRY
          BEGIN CATCH
            SET @ErrorMessage = 'Msg ' + CAST(ERROR_NUMBER() AS nvarchar) + ', ' + ISNULL(ERROR_MESSAGE(),'') + CASE WHEN ERROR_NUMBER() = 1222 THEN ' The index ' + QUOTENAME(@CurrentIndexName) + ' on the object ' + QUOTENAME(@CurrentDatabaseName) + '.' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentObjectName) + ' is locked. It could not be checked if the index exists.' ELSE '' END + CHAR(13) + CHAR(10) + ' '
            SET @Severity = CASE WHEN ERROR_NUMBER() IN(1205,1222) THEN @LockMessageSeverity ELSE 16 END
            RAISERROR(@ErrorMessage,@Severity,1) WITH NOWAIT

            IF NOT (ERROR_NUMBER() IN(1205,1222) AND @LockMessageSeverity = 10)
            BEGIN
              SET @ReturnCode = ERROR_NUMBER()
            END

            GOTO NoAction
          END CATCH
        END

        -- Does the statistics exist?
        IF @CurrentStatisticsID IS NOT NULL AND @UpdateStatistics IS NOT NULL
        BEGIN
          SET @CurrentCommand03 = ''

          IF @LockTimeout IS NOT NULL SET @CurrentCommand03 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '
          SET @CurrentCommand03 = @CurrentCommand03 + 'USE ' + QUOTENAME(@CurrentDatabaseName) + '; '

          SET @CurrentCommand03 = @CurrentCommand03 + 'IF EXISTS(SELECT * FROM sys.stats stats INNER JOIN sys.objects objects ON stats.[object_id] = objects.[object_id] INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] IN(''U'',''V'')' + CASE WHEN @MSShippedObjects = 'N' THEN ' AND objects.is_ms_shipped = 0' ELSE '' END + ' AND schemas.[schema_id] = @ParamSchemaID AND schemas.[name] = @ParamSchemaName AND objects.[object_id] = @ParamObjectID AND objects.[name] = @ParamObjectName AND objects.[type] = @ParamObjectType AND stats.stats_id = @ParamStatisticsID AND stats.[name] = @ParamStatisticsName) BEGIN SET @ParamStatisticsExists = 1 END'

          BEGIN TRY
            EXECUTE sp_executesql @statement = @CurrentCommand03, @params = N'@ParamSchemaID int, @ParamSchemaName sysname, @ParamObjectID int, @ParamObjectName sysname, @ParamObjectType sysname, @ParamStatisticsID int, @ParamStatisticsName sysname, @ParamStatisticsExists bit OUTPUT', @ParamSchemaID = @CurrentSchemaID, @ParamSchemaName = @CurrentSchemaName, @ParamObjectID = @CurrentObjectID, @ParamObjectName = @CurrentObjectName, @ParamObjectType = @CurrentObjectType, @ParamStatisticsID = @CurrentStatisticsID, @ParamStatisticsName = @CurrentStatisticsName, @ParamStatisticsExists = @CurrentStatisticsExists OUTPUT

            IF @CurrentStatisticsExists IS NULL
            BEGIN
              SET @CurrentStatisticsExists = 0
              GOTO NoAction
            END
          END TRY
          BEGIN CATCH
            SET @ErrorMessage = 'Msg ' + CAST(ERROR_NUMBER() AS nvarchar) + ', ' + ISNULL(ERROR_MESSAGE(),'') + CASE WHEN ERROR_NUMBER() = 1222 THEN ' The statistics ' + QUOTENAME(@CurrentStatisticsName) + ' on the object ' + QUOTENAME(@CurrentDatabaseName) + '.' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentObjectName) + ' is locked. It could not be checked if the statistics exists.' ELSE '' END + CHAR(13) + CHAR(10) + ' '
            SET @Severity = CASE WHEN ERROR_NUMBER() IN(1205,1222) THEN @LockMessageSeverity ELSE 16 END
            RAISERROR(@ErrorMessage,@Severity,1) WITH NOWAIT

            IF NOT (ERROR_NUMBER() IN(1205,1222) AND @LockMessageSeverity = 10)
            BEGIN
              SET @ReturnCode = ERROR_NUMBER()
            END

            GOTO NoAction
          END CATCH
        END

        -- Has the data in the statistics been modified since the statistics was last updated?
        IF @CurrentStatisticsID IS NOT NULL AND @UpdateStatistics IS NOT NULL
        BEGIN
          SET @CurrentCommand04 = ''

          IF @LockTimeout IS NOT NULL SET @CurrentCommand04 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '
          SET @CurrentCommand04 = @CurrentCommand04 + 'USE ' + QUOTENAME(@CurrentDatabaseName) + '; '

          IF @PartitionLevelStatistics = 1 AND @CurrentIsIncremental = 1
          BEGIN
            SET @CurrentCommand04 = @CurrentCommand04 + 'SELECT @ParamRowCount = [rows], @ParamModificationCounter = modification_counter FROM sys.dm_db_incremental_stats_properties (@ParamObjectID, @ParamStatisticsID) WHERE partition_number = @ParamPartitionNumber'
          END
          ELSE
          IF (@Version >= 10.504000 AND @Version < 11) OR @Version >= 11.03000
          BEGIN
            SET @CurrentCommand04 = @CurrentCommand04 + 'SELECT @ParamRowCount = [rows], @ParamModificationCounter = modification_counter FROM sys.dm_db_stats_properties (@ParamObjectID, @ParamStatisticsID)'
          END
          ELSE
          BEGIN
            SET @CurrentCommand04 = @CurrentCommand04 + 'SELECT @ParamRowCount = rowcnt, @ParamModificationCounter = rowmodctr FROM sys.sysindexes sysindexes WHERE sysindexes.[id] = @ParamObjectID AND sysindexes.[indid] = @ParamStatisticsID'
          END

          BEGIN TRY
            EXECUTE sp_executesql @statement = @CurrentCommand04, @params = N'@ParamObjectID int, @ParamStatisticsID int, @ParamPartitionNumber int, @ParamRowCount bigint OUTPUT, @ParamModificationCounter bigint OUTPUT', @ParamObjectID = @CurrentObjectID, @ParamStatisticsID = @CurrentStatisticsID, @ParamPartitionNumber = @CurrentPartitionNumber, @ParamRowCount = @CurrentRowCount OUTPUT, @ParamModificationCounter = @CurrentModificationCounter OUTPUT

            IF @CurrentRowCount IS NULL SET @CurrentRowCount = 0
            IF @CurrentModificationCounter IS NULL SET @CurrentModificationCounter = 0
          END TRY
          BEGIN CATCH
            SET @ErrorMessage = 'Msg ' + CAST(ERROR_NUMBER() AS nvarchar) + ', ' + ISNULL(ERROR_MESSAGE(),'') + CASE WHEN ERROR_NUMBER() = 1222 THEN ' The statistics ' + QUOTENAME(@CurrentStatisticsName) + ' on the object ' + QUOTENAME(@CurrentDatabaseName) + '.' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentObjectName) + ' is locked. The rows and modification_counter could not be checked.' ELSE '' END + CHAR(13) + CHAR(10) + ' '
            SET @Severity = CASE WHEN ERROR_NUMBER() IN(1205,1222) THEN @LockMessageSeverity ELSE 16 END
            RAISERROR(@ErrorMessage,@Severity,1) WITH NOWAIT

            IF NOT (ERROR_NUMBER() IN(1205,1222) AND @LockMessageSeverity = 10)
            BEGIN
              SET @ReturnCode = ERROR_NUMBER()
            END

            GOTO NoAction
          END CATCH
        END

        -- Is the index fragmented?
        IF @CurrentIndexID IS NOT NULL
        AND @CurrentOnReadOnlyFileGroup = 0
        AND EXISTS(SELECT * FROM @ActionsPreferred)
        AND (EXISTS(SELECT [Priority], [Action], COUNT(*) FROM @ActionsPreferred GROUP BY [Priority], [Action] HAVING COUNT(*) <> 3) OR @MinNumberOfPages > 0 OR @MaxNumberOfPages IS NOT NULL)
        BEGIN
          SET @CurrentCommand05 = ''

          IF @LockTimeout IS NOT NULL SET @CurrentCommand05 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '

          SET @CurrentCommand05 = @CurrentCommand05 + 'SELECT @ParamFragmentationLevel = MAX(avg_fragmentation_in_percent), @ParamPageCount = SUM(page_count) FROM sys.dm_db_index_physical_stats(@ParamDatabaseID, @ParamObjectID, @ParamIndexID, @ParamPartitionNumber, ''LIMITED'') WHERE alloc_unit_type_desc = ''IN_ROW_DATA'' AND index_level = 0'

          BEGIN TRY
            EXECUTE sp_executesql @statement = @CurrentCommand05, @params = N'@ParamDatabaseID int, @ParamObjectID int, @ParamIndexID int, @ParamPartitionNumber int, @ParamFragmentationLevel float OUTPUT, @ParamPageCount bigint OUTPUT', @ParamDatabaseID = @CurrentDatabaseID, @ParamObjectID = @CurrentObjectID, @ParamIndexID = @CurrentIndexID, @ParamPartitionNumber = @CurrentPartitionNumber, @ParamFragmentationLevel = @CurrentFragmentationLevel OUTPUT, @ParamPageCount = @CurrentPageCount OUTPUT
          END TRY
          BEGIN CATCH
            SET @ErrorMessage = 'Msg ' + CAST(ERROR_NUMBER() AS nvarchar) + ', ' + ISNULL(ERROR_MESSAGE(),'') + CASE WHEN ERROR_NUMBER() = 1222 THEN ' The index ' + QUOTENAME(@CurrentIndexName) + ' on the object ' + QUOTENAME(@CurrentDatabaseName) + '.' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentObjectName) + ' is locked. The page_count and avg_fragmentation_in_percent could not be checked.' ELSE '' END + CHAR(13) + CHAR(10) + ' '
            SET @Severity = CASE WHEN ERROR_NUMBER() IN(1205,1222) THEN @LockMessageSeverity ELSE 16 END
            RAISERROR(@ErrorMessage,@Severity,1) WITH NOWAIT

            IF NOT (ERROR_NUMBER() IN(1205,1222) AND @LockMessageSeverity = 10)
            BEGIN
              SET @ReturnCode = ERROR_NUMBER()
            END

            GOTO NoAction
          END CATCH
        END

        -- Select fragmentation group
        IF @CurrentIndexID IS NOT NULL AND @CurrentOnReadOnlyFileGroup = 0 AND EXISTS(SELECT * FROM @ActionsPreferred)
        BEGIN
          SET @CurrentFragmentationGroup = CASE
          WHEN @CurrentFragmentationLevel >= @FragmentationLevel2 THEN 'High'
          WHEN @CurrentFragmentationLevel >= @FragmentationLevel1 AND @CurrentFragmentationLevel < @FragmentationLevel2 THEN 'Medium'
          WHEN @CurrentFragmentationLevel < @FragmentationLevel1 THEN 'Low'
          END
        END

        -- Which actions are allowed?
        IF @CurrentIndexID IS NOT NULL AND EXISTS(SELECT * FROM @ActionsPreferred)
        BEGIN
          IF @CurrentOnReadOnlyFileGroup = 0 AND @CurrentIndexType IN (1,2,3,4,5) AND (@CurrentIsMemoryOptimized = 0 OR @CurrentIsMemoryOptimized IS NULL) AND (@CurrentAllowPageLocks = 1 OR @CurrentIndexType = 5)
          BEGIN
            INSERT INTO @CurrentActionsAllowed ([Action])
            VALUES ('INDEX_REORGANIZE')
          END
          IF @CurrentOnReadOnlyFileGroup = 0 AND @CurrentIndexType IN (1,2,3,4,5) AND (@CurrentIsMemoryOptimized = 0 OR @CurrentIsMemoryOptimized IS NULL)
          BEGIN
            INSERT INTO @CurrentActionsAllowed ([Action])
            VALUES ('INDEX_REBUILD_OFFLINE')
          END
          IF @CurrentOnReadOnlyFileGroup = 0
          AND (@CurrentIsMemoryOptimized = 0 OR @CurrentIsMemoryOptimized IS NULL)
          AND (@CurrentIsPartition = 0 OR @Version >= 12)
          AND ((@CurrentIndexType = 1 AND @CurrentIsImageText = 0 AND @CurrentIsNewLOB = 0)
          OR (@CurrentIndexType = 2 AND @CurrentIsNewLOB = 0)
          OR (@CurrentIndexType = 1 AND @CurrentIsImageText = 0 AND @CurrentIsFileStream = 0 AND @Version >= 11)
          OR (@CurrentIndexType = 2 AND @Version >= 11))
          AND (@CurrentIsColumnStore = 0 OR @Version < 11)
          AND SERVERPROPERTY('EngineEdition') IN (3,5,8)
          BEGIN
            INSERT INTO @CurrentActionsAllowed ([Action])
            VALUES ('INDEX_REBUILD_ONLINE')
          END
        END

        -- Decide action
        IF @CurrentIndexID IS NOT NULL
        AND EXISTS(SELECT * FROM @ActionsPreferred)
        AND (@CurrentPageCount >= @MinNumberOfPages OR @MinNumberOfPages = 0)
        AND (@CurrentPageCount <= @MaxNumberOfPages OR @MaxNumberOfPages IS NULL)
        AND @CurrentResumableIndexOperation = 0
        BEGIN
          IF EXISTS(SELECT [Priority], [Action], COUNT(*) FROM @ActionsPreferred GROUP BY [Priority], [Action] HAVING COUNT(*) <> 3)
          BEGIN
            SELECT @CurrentAction = [Action]
            FROM @ActionsPreferred
            WHERE FragmentationGroup = @CurrentFragmentationGroup
            AND [Priority] = (SELECT MIN([Priority])
                              FROM @ActionsPreferred
                              WHERE FragmentationGroup = @CurrentFragmentationGroup
                              AND [Action] IN (SELECT [Action] FROM @CurrentActionsAllowed))
          END
          ELSE
          BEGIN
            SELECT @CurrentAction = [Action]
            FROM @ActionsPreferred
            WHERE [Priority] = (SELECT MIN([Priority])
                                FROM @ActionsPreferred
                                WHERE [Action] IN (SELECT [Action] FROM @CurrentActionsAllowed))
          END
        END

        IF @CurrentResumableIndexOperation = 1
        BEGIN
          SET @CurrentAction = 'INDEX_REBUILD_ONLINE'
        END

        -- Workaround for limitation in SQL Server, http://support.microsoft.com/kb/2292737
        IF @CurrentIndexID IS NOT NULL
        BEGIN
          SET @CurrentMaxDOP = @MaxDOP

          IF @CurrentAction = 'INDEX_REBUILD_ONLINE' AND @CurrentAllowPageLocks = 0
          BEGIN
            SET @CurrentMaxDOP = 1
          END
        END

        -- Update statistics?
        IF @CurrentStatisticsID IS NOT NULL
        AND ((@UpdateStatistics = 'ALL' AND (@CurrentIndexType IN (1,2,3,4,7) OR @CurrentIndexID IS NULL)) OR (@UpdateStatistics = 'INDEX' AND @CurrentIndexID IS NOT NULL AND @CurrentIndexType IN (1,2,3,4,7)) OR (@UpdateStatistics = 'COLUMNS' AND @CurrentIndexID IS NULL))
        AND ((@OnlyModifiedStatistics = 'N' AND @StatisticsModificationLevel IS NULL) OR (@OnlyModifiedStatistics = 'Y' AND @CurrentModificationCounter > 0) OR ((@CurrentModificationCounter * 1. / NULLIF(@CurrentRowCount,0)) * 100 >= @StatisticsModificationLevel) OR (@StatisticsModificationLevel IS NOT NULL AND @CurrentModificationCounter > 0 AND (@CurrentModificationCounter >= SQRT(@CurrentRowCount * 1000))) OR (@CurrentIsMemoryOptimized = 1 AND NOT (@Version >= 13 OR SERVERPROPERTY('EngineEdition') IN (5,8))))
        AND ((@CurrentIsPartition = 0 AND (@CurrentAction NOT IN('INDEX_REBUILD_ONLINE','INDEX_REBUILD_OFFLINE') OR @CurrentAction IS NULL)) OR (@CurrentIsPartition = 1 AND (@CurrentPartitionNumber = @CurrentPartitionCount OR (@PartitionLevelStatistics = 1 AND @CurrentIsIncremental = 1))))
        BEGIN
          SET @CurrentUpdateStatistics = 'Y'
        END
        ELSE
        BEGIN
          SET @CurrentUpdateStatistics = 'N'
        END

        SET @CurrentStatisticsSample = @StatisticsSample
        SET @CurrentStatisticsResample = @StatisticsResample

        -- Memory-optimized tables only supports FULLSCAN and RESAMPLE in SQL Server 2014
        IF @CurrentIsMemoryOptimized = 1 AND NOT (@Version >= 13 OR SERVERPROPERTY('EngineEdition') IN (5,8)) AND (@CurrentStatisticsSample <> 100 OR @CurrentStatisticsSample IS NULL)
        BEGIN
          SET @CurrentStatisticsSample = NULL
          SET @CurrentStatisticsResample = 'Y'
        END

        -- Incremental statistics only supports RESAMPLE
        IF @PartitionLevelStatistics = 1 AND @CurrentIsIncremental = 1
        BEGIN
          SET @CurrentStatisticsSample = NULL
          SET @CurrentStatisticsResample = 'Y'
        END

        -- Create index comment
        IF @CurrentIndexID IS NOT NULL
        BEGIN
          SET @CurrentComment06 = 'ObjectType: ' + CASE WHEN @CurrentObjectType = 'U' THEN 'Table' WHEN @CurrentObjectType = 'V' THEN 'View' ELSE 'N/A' END + ', '
          SET @CurrentComment06 = @CurrentComment06 + 'IndexType: ' + CASE WHEN @CurrentIndexType = 1 THEN 'Clustered' WHEN @CurrentIndexType = 2 THEN 'NonClustered' WHEN @CurrentIndexType = 3 THEN 'XML' WHEN @CurrentIndexType = 4 THEN 'Spatial' WHEN @CurrentIndexType = 5 THEN 'Clustered Columnstore' WHEN @CurrentIndexType = 6 THEN 'NonClustered Columnstore' WHEN @CurrentIndexType = 7 THEN 'NonClustered Hash' ELSE 'N/A' END + ', '
          SET @CurrentComment06 = @CurrentComment06 + 'ImageText: ' + CASE WHEN @CurrentIsImageText = 1 THEN 'Yes' WHEN @CurrentIsImageText = 0 THEN 'No' ELSE 'N/A' END + ', '
          SET @CurrentComment06 = @CurrentComment06 + 'NewLOB: ' + CASE WHEN @CurrentIsNewLOB = 1 THEN 'Yes' WHEN @CurrentIsNewLOB = 0 THEN 'No' ELSE 'N/A' END + ', '
          SET @CurrentComment06 = @CurrentComment06 + 'FileStream: ' + CASE WHEN @CurrentIsFileStream = 1 THEN 'Yes' WHEN @CurrentIsFileStream = 0 THEN 'No' ELSE 'N/A' END + ', '
          IF @Version >= 11 SET @CurrentComment06 = @CurrentComment06 + 'ColumnStore: ' + CASE WHEN @CurrentIsColumnStore = 1 THEN 'Yes' WHEN @CurrentIsColumnStore = 0 THEN 'No' ELSE 'N/A' END + ', '
          IF @Version >= 14 AND @Resumable = 'Y' SET @CurrentComment06 = @CurrentComment06 + 'Computed: ' + CASE WHEN @CurrentIsComputed = 1 THEN 'Yes' WHEN @CurrentIsComputed = 0 THEN 'No' ELSE 'N/A' END + ', '
          IF @Version >= 14 AND @Resumable = 'Y' SET @CurrentComment06 = @CurrentComment06 + 'Timestamp: ' + CASE WHEN @CurrentIsTimestamp = 1 THEN 'Yes' WHEN @CurrentIsTimestamp = 0 THEN 'No' ELSE 'N/A' END + ', '
          SET @CurrentComment06 = @CurrentComment06 + 'AllowPageLocks: ' + CASE WHEN @CurrentAllowPageLocks = 1 THEN 'Yes' WHEN @CurrentAllowPageLocks = 0 THEN 'No' ELSE 'N/A' END + ', '
          SET @CurrentComment06 = @CurrentComment06 + 'PageCount: ' + ISNULL(CAST(@CurrentPageCount AS nvarchar),'N/A') + ', '
          SET @CurrentComment06 = @CurrentComment06 + 'Fragmentation: ' + ISNULL(CAST(@CurrentFragmentationLevel AS nvarchar),'N/A')
        END

        IF @CurrentIndexID IS NOT NULL AND (@CurrentPageCount IS NOT NULL OR @CurrentFragmentationLevel IS NOT NULL)
        BEGIN
        SET @CurrentExtendedInfo06 = (SELECT *
                                      FROM (SELECT CAST(@CurrentPageCount AS nvarchar) AS [PageCount],
                                                   CAST(@CurrentFragmentationLevel AS nvarchar) AS Fragmentation
                                      ) ExtendedInfo FOR XML AUTO, ELEMENTS)
        END

        -- Create statistics comment
        IF @CurrentStatisticsID IS NOT NULL
        BEGIN
          SET @CurrentComment07 = 'ObjectType: ' + CASE WHEN @CurrentObjectType = 'U' THEN 'Table' WHEN @CurrentObjectType = 'V' THEN 'View' ELSE 'N/A' END + ', '
          SET @CurrentComment07 = @CurrentComment07 + 'IndexType: ' + CASE WHEN @CurrentIndexID IS NOT NULL THEN 'Index' ELSE 'Column' END + ', '
          IF @CurrentIndexID IS NOT NULL SET @CurrentComment07 = @CurrentComment07 + 'IndexType: ' + CASE WHEN @CurrentIndexType = 1 THEN 'Clustered' WHEN @CurrentIndexType = 2 THEN 'NonClustered' WHEN @CurrentIndexType = 3 THEN 'XML' WHEN @CurrentIndexType = 4 THEN 'Spatial' WHEN @CurrentIndexType = 5 THEN 'Clustered Columnstore' WHEN @CurrentIndexType = 6 THEN 'NonClustered Columnstore' WHEN @CurrentIndexType = 7 THEN 'NonClustered Hash' ELSE 'N/A' END + ', '
          SET @CurrentComment07 = @CurrentComment07 + 'Incremental: ' + CASE WHEN @CurrentIsIncremental = 1 THEN 'Y' WHEN @CurrentIsIncremental = 0 THEN 'N' ELSE 'N/A' END + ', '
          SET @CurrentComment07 = @CurrentComment07 + 'RowCount: ' + ISNULL(CAST(@CurrentRowCount AS nvarchar),'N/A') + ', '
          SET @CurrentComment07 = @CurrentComment07 + 'ModificationCounter: ' + ISNULL(CAST(@CurrentModificationCounter AS nvarchar),'N/A')
        END

        IF @CurrentStatisticsID IS NOT NULL AND (@CurrentRowCount IS NOT NULL OR @CurrentModificationCounter IS NOT NULL)
        BEGIN
        SET @CurrentExtendedInfo07 = (SELECT *
                                      FROM (SELECT CAST(@CurrentRowCount AS nvarchar) AS [RowCount],
                                                   CAST(@CurrentModificationCounter AS nvarchar) AS ModificationCounter
                                      ) ExtendedInfo FOR XML AUTO, ELEMENTS)
        END

        IF @CurrentIndexID IS NOT NULL AND @CurrentAction IS NOT NULL AND (GETDATE() < DATEADD(ss,@TimeLimit,@StartTime) OR @TimeLimit IS NULL)
        BEGIN
          SET @CurrentCommandType06 = 'ALTER_INDEX'

          SET @CurrentCommand06 = ''
          IF @LockTimeout IS NOT NULL SET @CurrentCommand06 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '
          SET @CurrentCommand06 = @CurrentCommand06 + 'ALTER INDEX ' + QUOTENAME(@CurrentIndexName) + ' ON ' + QUOTENAME(@CurrentDatabaseName) + '.' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentObjectName)
          IF @CurrentResumableIndexOperation = 1 SET @CurrentCommand06 = @CurrentCommand06 + ' RESUME'
          IF @CurrentAction IN('INDEX_REBUILD_ONLINE','INDEX_REBUILD_OFFLINE') AND @CurrentResumableIndexOperation = 0 SET @CurrentCommand06 = @CurrentCommand06 + ' REBUILD'
          IF @CurrentAction IN('INDEX_REORGANIZE') AND @CurrentResumableIndexOperation = 0 SET @CurrentCommand06 = @CurrentCommand06 + ' REORGANIZE'
          IF @CurrentIsPartition = 1 AND @CurrentResumableIndexOperation = 0 SET @CurrentCommand06 = @CurrentCommand06 + ' PARTITION = ' + CAST(@CurrentPartitionNumber AS nvarchar)

          IF @CurrentAction IN('INDEX_REBUILD_ONLINE','INDEX_REBUILD_OFFLINE') AND @SortInTempdb = 'Y' AND @CurrentIndexType IN(1,2,3,4) AND @CurrentResumableIndexOperation = 0
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'SORT_IN_TEMPDB = ON'
          END

          IF @CurrentAction IN('INDEX_REBUILD_ONLINE','INDEX_REBUILD_OFFLINE') AND @SortInTempdb = 'N' AND @CurrentIndexType IN(1,2,3,4) AND @CurrentResumableIndexOperation = 0
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'SORT_IN_TEMPDB = OFF'
          END

          IF @CurrentAction = 'INDEX_REBUILD_ONLINE' AND (@CurrentIsPartition = 0 OR @Version >= 12) AND @CurrentResumableIndexOperation = 0
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'ONLINE = ON' + CASE WHEN @WaitAtLowPriorityMaxDuration IS NOT NULL THEN ' (WAIT_AT_LOW_PRIORITY (MAX_DURATION = ' + CAST(@WaitAtLowPriorityMaxDuration AS nvarchar) + ', ABORT_AFTER_WAIT = ' + UPPER(@WaitAtLowPriorityAbortAfterWait) + '))' ELSE '' END
          END

          IF @CurrentAction = 'INDEX_REBUILD_OFFLINE' AND (@CurrentIsPartition = 0 OR @Version >= 12) AND @CurrentResumableIndexOperation = 0
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'ONLINE = OFF'
          END

          IF @CurrentAction IN('INDEX_REBUILD_ONLINE','INDEX_REBUILD_OFFLINE') AND @CurrentMaxDOP IS NOT NULL
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'MAXDOP = ' + CAST(@CurrentMaxDOP AS nvarchar)
          END

          IF @CurrentAction IN('INDEX_REBUILD_ONLINE','INDEX_REBUILD_OFFLINE') AND @FillFactor IS NOT NULL AND @CurrentIsPartition = 0 AND @CurrentIndexType IN(1,2,3,4) AND @CurrentResumableIndexOperation = 0
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'FILLFACTOR = ' + CAST(@FillFactor AS nvarchar)
          END

          IF @CurrentAction IN('INDEX_REBUILD_ONLINE','INDEX_REBUILD_OFFLINE') AND @PadIndex = 'Y' AND @CurrentIsPartition = 0 AND @CurrentIndexType IN(1,2,3,4) AND @CurrentResumableIndexOperation = 0
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'PAD_INDEX = ON'
          END

          IF (@Version >= 14 OR SERVERPROPERTY('EngineEdition') IN (5,8)) AND @CurrentAction = 'INDEX_REBUILD_ONLINE' AND @CurrentResumableIndexOperation = 0
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT CASE WHEN @Resumable = 'Y' AND @CurrentIndexType IN(1,2) AND @CurrentIsComputed = 0 AND @CurrentIsTimestamp = 0 THEN 'RESUMABLE = ON' ELSE 'RESUMABLE = OFF' END
          END

          IF (@Version >= 14 OR SERVERPROPERTY('EngineEdition') IN (5,8)) AND @CurrentAction = 'INDEX_REBUILD_ONLINE' AND @CurrentResumableIndexOperation = 0 AND @Resumable = 'Y'  AND @CurrentIndexType IN(1,2) AND @CurrentIsComputed = 0 AND @CurrentIsTimestamp = 0 AND @TimeLimit IS NOT NULL
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'MAX_DURATION = ' + CAST(DATEDIFF(MINUTE,GETDATE(),DATEADD(ss,@TimeLimit,@StartTime)) AS nvarchar(max))
          END

          IF @CurrentAction IN('INDEX_REORGANIZE') AND @LOBCompaction = 'Y'
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'LOB_COMPACTION = ON'
          END

          IF @CurrentAction IN('INDEX_REORGANIZE') AND @LOBCompaction = 'N'
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'LOB_COMPACTION = OFF'
          END

          IF EXISTS (SELECT * FROM @CurrentAlterIndexWithClauseArguments)
          BEGIN
            SET @CurrentAlterIndexWithClause = ' WITH ('
          END

          SELECT @CurrentAlterIndexWithClause = @CurrentAlterIndexWithClause + Argument + ', '
          FROM @CurrentAlterIndexWithClauseArguments
          ORDER BY ID ASC

          SET @CurrentAlterIndexWithClause = LEFT(@CurrentAlterIndexWithClause,LEN(@CurrentAlterIndexWithClause) - 1)

          IF EXISTS (SELECT * FROM @CurrentAlterIndexWithClauseArguments)
          BEGIN
            SET @CurrentAlterIndexWithClause = @CurrentAlterIndexWithClause + ')'
          END

          IF @CurrentAlterIndexWithClause IS NOT NULL SET @CurrentCommand06 = @CurrentCommand06 + @CurrentAlterIndexWithClause

          EXECUTE @CurrentCommandOutput06 = [dbo].[CommandExecute] @Command = @CurrentCommand06, @CommandType = @CurrentCommandType06, @Mode = 2, @Comment = @CurrentComment06, @DatabaseName = @CurrentDatabaseName, @SchemaName = @CurrentSchemaName, @ObjectName = @CurrentObjectName, @ObjectType = @CurrentObjectType, @IndexName = @CurrentIndexName, @IndexType = @CurrentIndexType, @PartitionNumber = @CurrentPartitionNumber, @ExtendedInfo = @CurrentExtendedInfo06, @LockMessageSeverity = @LockMessageSeverity, @LogToTable = @LogToTable, @Execute = @Execute
          SET @Error = @@ERROR
          IF @Error <> 0 SET @CurrentCommandOutput06 = @Error
          IF @CurrentCommandOutput06 <> 0 SET @ReturnCode = @CurrentCommandOutput06

          IF @Delay > 0
          BEGIN
            SET @CurrentDelay = DATEADD(ss,@Delay,'1900-01-01')
            WAITFOR DELAY @CurrentDelay
          END
        END

        SET @CurrentMaxDOP = @MaxDOP

        IF @CurrentStatisticsID IS NOT NULL AND @CurrentUpdateStatistics = 'Y' AND (GETDATE() < DATEADD(ss,@TimeLimit,@StartTime) OR @TimeLimit IS NULL)
        BEGIN
          SET @CurrentCommandType07 = 'UPDATE_STATISTICS'

          SET @CurrentCommand07 = ''
          IF @LockTimeout IS NOT NULL SET @CurrentCommand07 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '
          SET @CurrentCommand07 = @CurrentCommand07 + 'UPDATE STATISTICS ' + QUOTENAME(@CurrentDatabaseName) + '.' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentObjectName) + ' ' + QUOTENAME(@CurrentStatisticsName)

          IF @CurrentMaxDOP IS NOT NULL AND ((@Version >= 13.05026 AND @Version < 14) OR @Version >= 14.030154)
          BEGIN
            INSERT INTO @CurrentUpdateStatisticsWithClauseArguments (Argument)
            SELECT 'MAXDOP = ' + CAST(@CurrentMaxDOP AS nvarchar)
          END

          IF @CurrentStatisticsSample = 100
          BEGIN
            INSERT INTO @CurrentUpdateStatisticsWithClauseArguments (Argument)
            SELECT 'FULLSCAN'
          END

          IF @CurrentStatisticsSample IS NOT NULL AND @CurrentStatisticsSample <> 100
          BEGIN
            INSERT INTO @CurrentUpdateStatisticsWithClauseArguments (Argument)
            SELECT 'SAMPLE ' + CAST(@CurrentStatisticsSample AS nvarchar) + ' PERCENT'
          END

          IF @CurrentStatisticsResample = 'Y'
          BEGIN
            INSERT INTO @CurrentUpdateStatisticsWithClauseArguments (Argument)
            SELECT 'RESAMPLE'
          END

          IF @CurrentNoRecompute = 1
          BEGIN
            INSERT INTO @CurrentUpdateStatisticsWithClauseArguments (Argument)
            SELECT 'NORECOMPUTE'
          END

          IF EXISTS (SELECT * FROM @CurrentUpdateStatisticsWithClauseArguments)
          BEGIN
            SET @CurrentUpdateStatisticsWithClause = ' WITH'

            SELECT @CurrentUpdateStatisticsWithClause = @CurrentUpdateStatisticsWithClause + ' ' + Argument + ','
            FROM @CurrentUpdateStatisticsWithClauseArguments
            ORDER BY ID ASC

            SET @CurrentUpdateStatisticsWithClause = LEFT(@CurrentUpdateStatisticsWithClause,LEN(@CurrentUpdateStatisticsWithClause) - 1)
          END

          IF @CurrentUpdateStatisticsWithClause IS NOT NULL SET @CurrentCommand07 = @CurrentCommand07 + @CurrentUpdateStatisticsWithClause

          IF @PartitionLevelStatistics = 1 AND @CurrentIsIncremental = 1 AND @CurrentPartitionNumber IS NOT NULL SET @CurrentCommand07 = @CurrentCommand07 + ' ON PARTITIONS(' + CAST(@CurrentPartitionNumber AS nvarchar(max)) + ')'

          EXECUTE @CurrentCommandOutput07 = [dbo].[CommandExecute] @Command = @CurrentCommand07, @CommandType = @CurrentCommandType07, @Mode = 2, @Comment = @CurrentComment07, @DatabaseName = @CurrentDatabaseName, @SchemaName = @CurrentSchemaName, @ObjectName = @CurrentObjectName, @ObjectType = @CurrentObjectType, @IndexName = @CurrentIndexName, @IndexType = @CurrentIndexType, @StatisticsName = @CurrentStatisticsName, @ExtendedInfo = @CurrentExtendedInfo07, @LockMessageSeverity = @LockMessageSeverity, @LogToTable = @LogToTable, @Execute = @Execute
          SET @Error = @@ERROR
          IF @Error <> 0 SET @CurrentCommandOutput07 = @Error
          IF @CurrentCommandOutput07 <> 0 SET @ReturnCode = @CurrentCommandOutput07
        END

        NoAction:

        -- Update that the index or statistics is completed
        UPDATE @tmpIndexesStatistics
        SET Completed = 1
        WHERE Selected = 1
        AND Completed = 0
        AND ID = @CurrentIxID

        -- Clear variables
        SET @CurrentCommand02 = NULL
        SET @CurrentCommand03 = NULL
        SET @CurrentCommand04 = NULL
        SET @CurrentCommand05 = NULL
        SET @CurrentCommand06 = NULL
        SET @CurrentCommand07 = NULL

        SET @CurrentCommandOutput06 = NULL
        SET @CurrentCommandOutput07 = NULL

        SET @CurrentCommandType06 = NULL
        SET @CurrentCommandType07 = NULL

        SET @CurrentComment06 = NULL
        SET @CurrentComment07 = NULL

        SET @CurrentExtendedInfo06 = NULL
        SET @CurrentExtendedInfo07 = NULL

        SET @CurrentIxID = NULL
        SET @CurrentSchemaID = NULL
        SET @CurrentSchemaName = NULL
        SET @CurrentObjectID = NULL
        SET @CurrentObjectName = NULL
        SET @CurrentObjectType = NULL
        SET @CurrentIsMemoryOptimized = NULL
        SET @CurrentIndexID = NULL
        SET @CurrentIndexName = NULL
        SET @CurrentIndexType = NULL
        SET @CurrentStatisticsID = NULL
        SET @CurrentStatisticsName = NULL
        SET @CurrentPartitionID = NULL
        SET @CurrentPartitionNumber = NULL
        SET @CurrentPartitionCount = NULL
        SET @CurrentIsPartition = NULL
        SET @CurrentIndexExists = NULL
        SET @CurrentStatisticsExists = NULL
        SET @CurrentIsImageText = NULL
        SET @CurrentIsNewLOB = NULL
        SET @CurrentIsFileStream = NULL
        SET @CurrentIsColumnStore = NULL
        SET @CurrentIsComputed = NULL
        SET @CurrentIsTimestamp = NULL
        SET @CurrentAllowPageLocks = NULL
        SET @CurrentNoRecompute = NULL
        SET @CurrentIsIncremental = NULL
        SET @CurrentRowCount = NULL
        SET @CurrentModificationCounter = NULL
        SET @CurrentOnReadOnlyFileGroup = NULL
        SET @CurrentResumableIndexOperation = NULL
        SET @CurrentFragmentationLevel = NULL
        SET @CurrentPageCount = NULL
        SET @CurrentFragmentationGroup = NULL
        SET @CurrentAction = NULL
        SET @CurrentMaxDOP = NULL
        SET @CurrentUpdateStatistics = NULL
        SET @CurrentStatisticsSample = NULL
        SET @CurrentStatisticsResample = NULL
        SET @CurrentAlterIndexWithClause = NULL
        SET @CurrentUpdateStatisticsWithClause = NULL

        DELETE FROM @CurrentActionsAllowed
        DELETE FROM @CurrentAlterIndexWithClauseArguments
        DELETE FROM @CurrentUpdateStatisticsWithClauseArguments

      END

    END

    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'SUSPECT'
    BEGIN
      SET @ErrorMessage = 'The database ' + QUOTENAME(@CurrentDatabaseName) + ' is in a SUSPECT state.' + CHAR(13) + CHAR(10) + ' '
      RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
      SET @Error = @@ERROR
    END

    -- Update that the database is completed
    IF @DatabasesInParallel = 'Y'
    BEGIN
      UPDATE dbo.QueueDatabase
      SET DatabaseEndTime = GETDATE()
      WHERE QueueID = @QueueID
      AND DatabaseName = @CurrentDatabaseName
    END
    ELSE
    BEGIN
      UPDATE @tmpDatabases
      SET Completed = 1
      WHERE Selected = 1
      AND Completed = 0
      AND ID = @CurrentDBID
    END

    -- Clear variables
    SET @CurrentDBID = NULL
    SET @CurrentDatabaseID = NULL
    SET @CurrentDatabaseName = NULL
    SET @CurrentIsDatabaseAccessible = NULL
    SET @CurrentAvailabilityGroup = NULL
    SET @CurrentAvailabilityGroupRole = NULL
    SET @CurrentDatabaseMirroringRole = NULL
    SET @CurrentIsReadOnly = NULL

    SET @CurrentCommand01 = NULL

    DELETE FROM @tmpIndexesStatistics

  END

  ----------------------------------------------------------------------------------------------------
  --// Log completing information                                                                 //--
  ----------------------------------------------------------------------------------------------------

  Logging:
  SET @EndMessage = 'Date and time: ' + CONVERT(nvarchar,GETDATE(),120)
  SET @EndMessage = REPLACE(@EndMessage,'%','%%')
  RAISERROR(@EndMessage,10,1) WITH NOWAIT

  IF @ReturnCode <> 0
  BEGIN
    RETURN @ReturnCode
  END

  ----------------------------------------------------------------------------------------------------

END

GO
/****** Object:  StoredProcedure [dbo].[LogProcedure]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[LogProcedure]

@ProcID INT = NULL,
@TableName nvarchar(256) = NULL,
@RowCount INT = NULL,
@insert INT = NULL,
@update INT = NULL,
@delete INT = NULL,
@starttime DATETIMEOFFSET = NULL,
@isStart BIT = 1


AS

BEGIN

    ----------------------------------------------------------------------------------------------------
    --//  Process Values                                                  //--
    ----------------------------------------------------------------------------------------------------

    SET NOCOUNT ON;

    DECLARE @EndTime DATETIMEOFFSET;
    SET @EndTime = GETDATE();

    DECLARE @Duration INT;
    SET @Duration = DATEDIFF(SECOND, @starttime, @EndTime);

	DECLARE @ProcName NVARCHAR(300) = OBJECT_NAME(@ProcID),
	@SchemaName NVARCHAR(300)= OBJECT_SCHEMA_NAME(@ProcID);

	DECLARE @ProcessName NVARCHAR(300) = CASE WHEN @ProcName LIKE 'writelogproctest' THEN 'Test Proc'
											  WHEN @ProcName LIKE 'CDCProcess%'  THEN 'CDC'
											  WHEN @ProcName LIKE 'Process%' THEN 'Merge'
											  ELSE 'Unknown'
											  END
												




    ----------------------------------------------------------------------------------------------------
    --// Log initial information                                                                    //--
    ----------------------------------------------------------------------------------------------------
    IF @isStart = 1
    BEGIN
        INSERT INTO dbo.ProcedureLog
        (
            ProcedureName,
            ProcessName,
            SchemaName,
            TableName,
            StartTime
        )
        VALUES
        (   @ProcName,    -- ProcedureName - varchar(300)
            @ProcessName, -- ProcessName - nvarchar(256)
            @SchemaName,  -- SchemaName - nvarchar(256)
            @TableName,   -- TableName - nvarchar(256)
            @starttime    -- StartTime - datetime
        );

    END;


    ----------------------------------------------------------------------------------------------------
    --// Log completing information                                                                 //--
    ----------------------------------------------------------------------------------------------------

    IF @isStart = 0
    BEGIN
        UPDATE dbo.ProcedureLog
        SET RecordsReceived = @RowCount,
            RecordsInserted = @insert,
            RecordsUpdated = @update,
            RecordsDeleted = @delete,
            EndTime = @EndTime,
            Duration = @Duration
        WHERE ProcedureName = @ProcName
              AND StartTime = @starttime;
    END;


----------------------------------------------------------------------------------------------------
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_generate_merge]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Turn system object marking on

CREATE PROC [dbo].[sp_generate_merge]
(
 @table_name varchar(776), -- The table/view for which the MERGE statement will be generated using the existing data
 @target_table varchar(776) = NULL, -- Use this parameter to specify a different table name into which the data will be inserted/updated/deleted
 @from varchar(800) = NULL, -- Use this parameter to filter the rows based on a filter condition (using WHERE)
 @include_timestamp bit = 0, -- Specify 1 for this parameter, if you want to include the TIMESTAMP/ROWVERSION column's data in the MERGE statement
 @debug_mode bit = 0, -- If @debug_mode is set to 1, the SQL statements constructed by this procedure will be printed for later examination
 @schema varchar(64) = NULL, -- Use this parameter if you are not the owner of the table
 @srcSchema VARCHAR(64) = NULL,	-- source schema for merge 
 @ommit_images bit = 0, -- Use this parameter to generate MERGE statement by omitting the 'image' columns
 @ommit_identity bit = 0, -- Use this parameter to ommit the identity columns
 @top int = NULL, -- Use this parameter to generate a MERGE statement only for the TOP n rows
 @cols_to_include varchar(8000) = NULL, -- List of columns to be included in the MERGE statement
 @cols_to_exclude varchar(8000) = NULL, -- List of columns to be excluded from the MERGE statement
 @update_only_if_changed bit = 1, -- When 1, only performs an UPDATE operation if an included column in a matched row has changed.
 @delete_if_not_matched bit = 1, -- When 1, deletes unmatched source rows from target, when 0 source rows will only be used to update existing rows or insert new.
 @disable_constraints bit = 0, -- When 1, disables foreign key constraints and enables them after the MERGE statement
 @ommit_computed_cols bit = 0, -- When 1, computed columns will not be included in the MERGE statement
 @include_use_db bit = 1, -- When 1, includes a USE [DatabaseName] statement at the beginning of the generated batch
 @results_to_text bit = 0, -- When 1, outputs results to grid/messages window. When 0, outputs MERGE statement in an XML fragment.
 @include_rowsaffected bit = 1, -- When 1, a section is added to the end of the batch which outputs rows affected by the MERGE
 @nologo bit = 0, -- When 1, the "About" comment is suppressed from output
 @batch_separator VARCHAR(50) = ';' -- Batch separator to use
)
AS
BEGIN

/***********************************************************************************************************
Procedure: sp_generate_merge (Version 0.93)
 (Adapted by Daniel Nolan for SQL Server 2008/2012)

Adapted from: sp_generate_inserts (Build 22) 
 (Copyright © 2002 Narayana Vyas Kondreddi. All rights reserved.)

Purpose: To generate a MERGE statement from existing data, which will INSERT/UPDATE/DELETE data based
 on matching primary key values in the source/target table.
 
 The generated statements can be executed to replicate the data in some other location.
 
 Typical use cases:
 * Generate statements for static data tables, store the .SQL file in source control and use 
 it as part of your Dev/Test/Prod deployment. The generated statements are re-runnable, so 
 you can make changes to the file and migrate those changes between environments.
 
 * Generate statements from your Production tables and then run those statements in your 
 Dev/Test environments. Schedule this as part of a SQL Job to keep all of your environments 
 in-sync.
 
 * Enter test data into your Dev environment, and then generate statements from the Dev
 tables so that you can always reproduce your test database with valid sample data.
 

Written by: Narayana Vyas Kondreddi
 http://vyaskn.tripod.com

 Daniel Nolan
 http://danere.com
 @dan3r3

Acknowledgements (sp_generate_merge):
 Nathan Skerl -- StackOverflow answer that provided a workaround for the output truncation problem
 http://stackoverflow.com/a/10489767/266882

 Bill Gibson -- Blog that detailed the static data table use case; the inspiration for this proc
 http://blogs.msdn.com/b/ssdt/archive/2012/02/02/including-data-in-an-sql-server-database-project.aspx
 
 Bill Graziano -- Blog that provided the groundwork for MERGE statement generation
 http://weblogs.sqlteam.com/billg/archive/2011/02/15/generate-merge-statements-from-a-table.aspx 

Acknowledgements (sp_generate_inserts):
 Divya Kalra -- For beta testing
 Mark Charsley -- For reporting a problem with scripting uniqueidentifier columns with NULL values
 Artur Zeygman -- For helping me simplify a bit of code for handling non-dbo owned tables
 Joris Laperre -- For reporting a regression bug in handling text/ntext columns

Tested on: SQL Server 2008 (10.50.1600), SQL Server 2012 (11.0.2100)

Date created: January 17th 2001 21:52 GMT
Modified: May 1st 2002 19:50 GMT
Last Modified: September 27th 2012 10:00 AEDT

Email: dan@danere.com, vyaskn@hotmail.com

NOTE: This procedure may not work with tables with a large number of columns (> 500).
 Results can be unpredictable with huge text columns or SQL Server 2000's sql_variant data types
 IMPORTANT: This procedure has not been extensively tested with international data (Extended characters or Unicode). If needed
 you might want to convert the datatypes of character variables in this procedure to their respective unicode counterparts
 like nchar and nvarchar

Get Started: Ensure that your SQL client is configured to send results to grid (default SSMS behaviour).
This ensures that the generated MERGE statement can be output in full, getting around SSMS's 4000 nchar limit.
After running this proc, click the hyperlink within the single row returned to copy the generated MERGE statement.

Example 1: To generate a MERGE statement for table 'titles':
 
 EXEC sp_generate_merge 'titles'

Example 2: To generate a MERGE statement for 'titlesCopy' table from 'titles' table:

 EXEC sp_generate_merge 'titles', 'titlesCopy'

Example 3: To generate a MERGE statement for table 'titles' that will unconditionally UPDATE matching rows 
 (ie. not perform a "has data changed?" check prior to going ahead with an UPDATE):
 
 EXEC sp_generate_merge 'titles', @update_only_if_changed = 0

Example 4: To generate a MERGE statement for 'titles' table for only those titles 
 which contain the word 'Computer' in them:
 NOTE: Do not complicate the FROM or WHERE clause here. It's assumed that you are good with T-SQL if you are using this parameter

 EXEC sp_generate_merge 'titles', @from = "from titles where title like '%Computer%'"

Example 5: To specify that you want to include TIMESTAMP column's data as well in the MERGE statement:
 (By default TIMESTAMP column's data is not scripted)

 EXEC sp_generate_merge 'titles', @include_timestamp = 1

Example 6: To print the debug information:

 EXEC sp_generate_merge 'titles', @debug_mode = 1

Example 7: If the table is in a different schema to the default, use @schema parameter to specify the schema name
 To use this option, you must have SELECT permissions on that table

 EXEC sp_generate_merge 'Nickstable', @schema = 'Nick'

Example 8: To generate a MERGE statement for the rest of the columns excluding images

 EXEC sp_generate_merge 'imgtable', @ommit_images = 1

Example 9: To generate a MERGE statement excluding (omitting) IDENTITY columns:
 (By default IDENTITY columns are included in the MERGE statement)

 EXEC sp_generate_merge 'mytable', @ommit_identity = 1

Example 10: To generate a MERGE statement for the TOP 10 rows in the table:
 
 EXEC sp_generate_merge 'mytable', @top = 10

Example 11: To generate a MERGE statement with only those columns you want:
 
 EXEC sp_generate_merge 'titles', @cols_to_include = "'title','title_id','au_id'"

Example 12: To generate a MERGE statement by omitting certain columns:
 
 EXEC sp_generate_merge 'titles', @cols_to_exclude = "'title','title_id','au_id'"

Example 13: To avoid checking the foreign key constraints while loading data with a MERGE statement:
 
 EXEC sp_generate_merge 'titles', @disable_constraints = 1

Example 14: To exclude computed columns from the MERGE statement:

 EXEC sp_generate_merge 'MyTable', @ommit_computed_cols = 1
 
***********************************************************************************************************/

SET NOCOUNT ON


--Making sure user only uses either @cols_to_include or @cols_to_exclude
IF ((@cols_to_include IS NOT NULL) AND (@cols_to_exclude IS NOT NULL))
 BEGIN
 RAISERROR('Use either @cols_to_include or @cols_to_exclude. Do not use both the parameters at once',16,1)
 RETURN -1 --Failure. Reason: Both @cols_to_include and @cols_to_exclude parameters are specified
 END


--Making sure the @cols_to_include and @cols_to_exclude parameters are receiving values in proper format
IF ((@cols_to_include IS NOT NULL) AND (PATINDEX('''%''',@cols_to_include) = 0))
 BEGIN
 RAISERROR('Invalid use of @cols_to_include property',16,1)
 PRINT 'Specify column names surrounded by single quotes and separated by commas'
 PRINT 'Eg: EXEC sp_generate_merge titles, @cols_to_include = "''title_id'',''title''"'
 RETURN -1 --Failure. Reason: Invalid use of @cols_to_include property
 END

IF ((@cols_to_exclude IS NOT NULL) AND (PATINDEX('''%''',@cols_to_exclude) = 0))
 BEGIN
 RAISERROR('Invalid use of @cols_to_exclude property',16,1)
 PRINT 'Specify column names surrounded by single quotes and separated by commas'
 PRINT 'Eg: EXEC sp_generate_merge titles, @cols_to_exclude = "''title_id'',''title''"'
 RETURN -1 --Failure. Reason: Invalid use of @cols_to_exclude property
 END


--Checking to see if the database name is specified along wih the table name
--Your database context should be local to the table for which you want to generate a MERGE statement
--specifying the database name is not allowed
IF (PARSENAME(@table_name,3)) IS NOT NULL
 BEGIN
 RAISERROR('Do not specify the database name. Be in the required database and just specify the table name.',16,1)
 RETURN -1 --Failure. Reason: Database name is specified along with the table name, which is not allowed
 END


--Checking for the existence of 'user table' or 'view'
--This procedure is not written to work on system tables
--To script the data in system tables, just create a view on the system tables and script the view instead
IF @schema IS NULL
 BEGIN
 IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @table_name AND (TABLE_TYPE = 'BASE TABLE' OR TABLE_TYPE = 'VIEW') AND TABLE_SCHEMA = SCHEMA_NAME())
 BEGIN
 RAISERROR('User table or view not found.',16,1)
 PRINT 'You may see this error if the specified table is not in your default schema (' + SCHEMA_NAME() + '). In that case use @schema parameter to specify the schema name.'
 PRINT 'Make sure you have SELECT permission on that table or view.'
 RETURN -1 --Failure. Reason: There is no user table or view with this name
 END
 END
ELSE
 BEGIN
 IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @table_name AND (TABLE_TYPE = 'BASE TABLE' OR TABLE_TYPE = 'VIEW') AND TABLE_SCHEMA = @schema)
 BEGIN
 RAISERROR('User table or view not found.',16,1)
 PRINT 'Make sure you have SELECT permission on that table or view.'
 RETURN -1 --Failure. Reason: There is no user table or view with this name 
 END
 END


--Variable declarations
DECLARE @Column_ID int, 
 @Column_List varchar(max), 
 @Column_List_For_Update varchar(max), 
 @Column_List_For_Check varchar(max), 
 @Column_Name varchar(128), 
 @Column_Name_Unquoted varchar(128), 
 @Data_Type varchar(128), 
 @Actual_Values nvarchar(max), --This is the string that will be finally executed to generate a MERGE statement
 @IDN varchar(128), --Will contain the IDENTITY column's name in the table
 @Target_Table_For_Output varchar(776),
 @Source_Table_Qualified varchar(776)
 
 

--Variable Initialization
SET @IDN = ''
SET @Column_ID = 0
SET @Column_Name = ''
SET @Column_Name_Unquoted = ''
SET @Column_List = ''
SET @Column_List_For_Update = ''
SET @Column_List_For_Check = ''
SET @Actual_Values = ''

--Variable Defaults
IF @schema IS NULL
 BEGIN
 SET @Target_Table_For_Output = QUOTENAME(COALESCE(@target_table, @table_name))
 END
ELSE
 BEGIN
 SET @Target_Table_For_Output = QUOTENAME(@schema) + '.' + QUOTENAME(COALESCE(@target_table, @table_name))
 END

SET @Source_Table_Qualified

 = QUOTENAME(COALESCE(@srcSchema,SCHEMA_NAME())) + '.' + QUOTENAME(@table_name)

--To get the first column's ID
SELECT @Column_ID = MIN(ORDINAL_POSITION) 
FROM INFORMATION_SCHEMA.COLUMNS (NOLOCK) 
WHERE TABLE_NAME = @table_name
AND TABLE_SCHEMA = COALESCE(@schema, SCHEMA_NAME())


--Loop through all the columns of the table, to get the column names and their data types
WHILE @Column_ID IS NOT NULL
 BEGIN
 SELECT @Column_Name = QUOTENAME(COLUMN_NAME), 
 @Column_Name_Unquoted = COLUMN_NAME,
 @Data_Type = DATA_TYPE 
 FROM INFORMATION_SCHEMA.COLUMNS (NOLOCK) 
 WHERE ORDINAL_POSITION = @Column_ID
 AND TABLE_NAME = @table_name
 AND TABLE_SCHEMA = COALESCE(@schema, SCHEMA_NAME())

 IF @cols_to_include IS NOT NULL --Selecting only user specified columns
 BEGIN
 IF CHARINDEX( '''' + SUBSTRING(@Column_Name,2,LEN(@Column_Name)-2) + '''',@cols_to_include) = 0 
 BEGIN
 GOTO SKIP_LOOP
 END
 END

 IF @cols_to_exclude IS NOT NULL --Selecting only user specified columns
 BEGIN
 IF CHARINDEX( '''' + SUBSTRING(@Column_Name,2,LEN(@Column_Name)-2) + '''',@cols_to_exclude) <> 0 
 BEGIN
 GOTO SKIP_LOOP
 END
 END

 --Making sure to output SET IDENTITY_INSERT ON/OFF in case the table has an IDENTITY column
 IF (SELECT COLUMNPROPERTY( OBJECT_ID(@Source_Table_Qualified),SUBSTRING(@Column_Name,2,LEN(@Column_Name) - 2),'IsIdentity')) = 1 
 BEGIN
 IF @ommit_identity = 0 --Determing whether to include or exclude the IDENTITY column
 SET @IDN = @Column_Name
 ELSE
 GOTO SKIP_LOOP 
 END
 
 --Making sure whether to output computed columns or not
 IF @ommit_computed_cols = 1
 BEGIN
 IF (SELECT COLUMNPROPERTY( OBJECT_ID(@Source_Table_Qualified),SUBSTRING(@Column_Name,2,LEN(@Column_Name) - 2),'IsComputed')) = 1 
 BEGIN
 GOTO SKIP_LOOP 
 END
 END
 
 --Tables with columns of IMAGE data type are not supported for obvious reasons
 IF(@Data_Type in ('image'))
 BEGIN
 IF (@ommit_images = 0)
 BEGIN
 RAISERROR('Tables with image columns are not supported.',16,1)
 PRINT 'Use @ommit_images = 1 parameter to generate a MERGE for the rest of the columns.'
 RETURN -1 --Failure. Reason: There is a column with image data type
 END
 ELSE
 BEGIN
 GOTO SKIP_LOOP
 END
 END

 --Determining the data type of the column and depending on the data type, the VALUES part of
 --the MERGE statement is generated. Care is taken to handle columns with NULL values. Also
 --making sure, not to lose any data from flot, real, money, smallmomey, datetime columns
 SET @Actual_Values = @Actual_Values +
 CASE 
 WHEN @Data_Type IN ('char','nchar') 
 THEN 
 'COALESCE(''N'''''' + REPLACE(RTRIM(' + @Column_Name + '),'''''''','''''''''''')+'''''''',''NULL'')'
 WHEN @Data_Type IN ('varchar','nvarchar') 
 THEN 
 'COALESCE(''N'''''' + REPLACE(' + @Column_Name + ','''''''','''''''''''')+'''''''',''NULL'')'
 WHEN @Data_Type IN ('datetime','smalldatetime','datetime2','date') 
 THEN 
 'COALESCE('''''''' + RTRIM(CONVERT(char,' + @Column_Name + ',127))+'''''''',''NULL'')'
 WHEN @Data_Type IN ('uniqueidentifier') 
 THEN 
 'COALESCE(''N'''''' + REPLACE(CONVERT(char(36),RTRIM(' + @Column_Name + ')),'''''''','''''''''''')+'''''''',''NULL'')'
 WHEN @Data_Type IN ('text') 
 THEN 
 'COALESCE(''N'''''' + REPLACE(CONVERT(varchar(max),' + @Column_Name + '),'''''''','''''''''''')+'''''''',''NULL'')' 
 WHEN @Data_Type IN ('ntext') 
 THEN 
 'COALESCE('''''''' + REPLACE(CONVERT(nvarchar(max),' + @Column_Name + '),'''''''','''''''''''')+'''''''',''NULL'')' 
 WHEN @Data_Type IN ('xml') 
 THEN 
 'COALESCE('''''''' + REPLACE(CONVERT(nvarchar(max),' + @Column_Name + '),'''''''','''''''''''')+'''''''',''NULL'')' 
 WHEN @Data_Type IN ('binary','varbinary') 
 THEN 
 'COALESCE(RTRIM(CONVERT(varchar(max),' + @Column_Name + ', 1))),''NULL'')' 
 WHEN @Data_Type IN ('timestamp','rowversion') 
 THEN 
 CASE 
 WHEN @include_timestamp = 0 
 THEN 
 '''DEFAULT''' 
 ELSE 
 'COALESCE(RTRIM(CONVERT(char,' + 'CONVERT(int,' + @Column_Name + '))),''NULL'')' 
 END
 WHEN @Data_Type IN ('float','real','money','smallmoney')
 THEN
 'COALESCE(LTRIM(RTRIM(' + 'CONVERT(char, ' + @Column_Name + ',2)' + ')),''NULL'')' 
 WHEN @Data_Type IN ('hierarchyid')
 THEN 
  'COALESCE(''hierarchyid::Parse(''+'''''''' + LTRIM(RTRIM(' + 'CONVERT(char, ' + @Column_Name + ')' + '))+''''''''+'')'',''NULL'')' 
 ELSE 
 'COALESCE(LTRIM(RTRIM(' + 'CONVERT(char, ' + @Column_Name + ')' + ')),''NULL'')' 
 END + '+' + ''',''' + ' + '
 
 --Generating the column list for the MERGE statement
 SET @Column_List = @Column_List + @Column_Name + ',' 
 
 --Don't update Primary Key or Identity columns
 IF NOT EXISTS(
 SELECT 1
 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk ,
 INFORMATION_SCHEMA.KEY_COLUMN_USAGE c
 WHERE pk.TABLE_NAME = @table_name
 AND pk.TABLE_SCHEMA = COALESCE(@schema, SCHEMA_NAME())
 AND CONSTRAINT_TYPE = 'PRIMARY KEY'
 AND c.TABLE_NAME = pk.TABLE_NAME
 AND c.TABLE_SCHEMA = pk.TABLE_SCHEMA
 AND c.CONSTRAINT_NAME = pk.CONSTRAINT_NAME
 AND c.COLUMN_NAME = @Column_Name_Unquoted 
 )
 BEGIN
 SET @Column_List_For_Update = @Column_List_For_Update + @Column_Name + ' = Source.' + @Column_Name + ', 
  ' 
 SET @Column_List_For_Check = @Column_List_For_Check +
 CASE @Data_Type 
 WHEN 'text' THEN CHAR(10) + CHAR(9) + 'NULLIF(CAST(Source.' + @Column_Name + ' AS VARCHAR(MAX)), CAST(Target.' + @Column_Name + ' AS VARCHAR(MAX))) IS NOT NULL OR NULLIF(CAST(Target.' + @Column_Name + ' AS VARCHAR(MAX)), CAST(Source.' + @Column_Name + ' AS VARCHAR(MAX))) IS NOT NULL OR '
 WHEN 'ntext' THEN CHAR(10) + CHAR(9) + 'NULLIF(CAST(Source.' + @Column_Name + ' AS NVARCHAR(MAX)), CAST(Target.' + @Column_Name + ' AS NVARCHAR(MAX))) IS NOT NULL OR NULLIF(CAST(Target.' + @Column_Name + ' AS NVARCHAR(MAX)), CAST(Source.' + @Column_Name + ' AS NVARCHAR(MAX))) IS NOT NULL OR ' 
 ELSE CHAR(10) + CHAR(9) + 'NULLIF(Source.' + @Column_Name + ', Target.' + @Column_Name + ') IS NOT NULL OR NULLIF(Target.' + @Column_Name + ', Source.' + @Column_Name + ') IS NOT NULL OR '
 END 
 END

 SKIP_LOOP: --The label used in GOTO

 SELECT @Column_ID = MIN(ORDINAL_POSITION) 
 FROM INFORMATION_SCHEMA.COLUMNS (NOLOCK) 
 WHERE TABLE_NAME = @table_name
 AND TABLE_SCHEMA = COALESCE(@schema, SCHEMA_NAME())
 AND ORDINAL_POSITION > @Column_ID

 END --Loop ends here!


--To get rid of the extra characters that got concatenated during the last run through the loop
IF LEN(@Column_List_For_Update) <> 0
 BEGIN
 SET @Column_List_For_Update = ' ' + LEFT(@Column_List_For_Update,len(@Column_List_For_Update) - 4)
 END

IF LEN(@Column_List_For_Check) <> 0
 BEGIN
 SET @Column_List_For_Check = LEFT(@Column_List_For_Check,len(@Column_List_For_Check) - 3)
 END

SET @Actual_Values = LEFT(@Actual_Values,len(@Actual_Values) - 6)

SET @Column_List = LEFT(@Column_List,len(@Column_List) - 1)
IF LEN(LTRIM(@Column_List)) = 0
 BEGIN
 RAISERROR('No columns to select. There should at least be one column to generate the output',16,1)
 RETURN -1 --Failure. Reason: Looks like all the columns are ommitted using the @cols_to_exclude parameter
 END


--Get the join columns ----------------------------------------------------------
DECLARE @PK_column_list VARCHAR(8000)
DECLARE @PK_column_joins VARCHAR(8000)
SET @PK_column_list = ''
SET @PK_column_joins = ''

SELECT @PK_column_list = @PK_column_list + '[' + c.COLUMN_NAME + '], '
, @PK_column_joins = @PK_column_joins + 'Target.[' + c.COLUMN_NAME + '] = Source.[' + c.COLUMN_NAME + '] AND '
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk ,
INFORMATION_SCHEMA.KEY_COLUMN_USAGE c
WHERE pk.TABLE_NAME = @table_name
AND pk.TABLE_SCHEMA = COALESCE(@schema, SCHEMA_NAME())
AND CONSTRAINT_TYPE = 'PRIMARY KEY'
AND c.TABLE_NAME = pk.TABLE_NAME
AND c.TABLE_SCHEMA = pk.TABLE_SCHEMA
AND c.CONSTRAINT_NAME = pk.CONSTRAINT_NAME

IF IsNull(@PK_column_list, '') = '' 
 BEGIN
 RAISERROR('Table has no primary keys. There should at least be one column in order to have a valid join.',16,1)
 RETURN -1 --Failure. Reason: looks like table doesn't have any primary keys
 END

SET @PK_column_list = LEFT(@PK_column_list, LEN(@PK_column_list) -1)
SET @PK_column_joins = LEFT(@PK_column_joins, LEN(@PK_column_joins) -4)


--Forming the final string that will be executed, to output the a MERGE statement
SET @Actual_Values = 
 'SELECT ' + 
 CASE WHEN @top IS NULL OR @top < 0 THEN '' ELSE ' TOP ' + LTRIM(STR(@top)) + ' ' END + 
 '''' + 
 ' '' + CASE WHEN ROW_NUMBER() OVER (ORDER BY ' + @PK_column_list + ') = 1 THEN '' '' ELSE '','' END + ''(''+ ' + @Actual_Values + '+'')''' + ' ' + 
 COALESCE(@from,' FROM ' + @Source_Table_Qualified + ' (NOLOCK) ORDER BY ' + @PK_column_list)

 DECLARE @output VARCHAR(MAX) = ''
 DECLARE @b CHAR(1) = CHAR(13)

--Determining whether to ouput any debug information
IF @debug_mode =1
 BEGIN
 SET @output += @b + '/*****START OF DEBUG INFORMATION*****'
 SET @output += @b + ''
 SET @output += @b + 'The primary key column list:'
 SET @output += @b + @PK_column_list
 SET @output += @b + ''
 SET @output += @b + 'The INSERT column list:'
 SET @output += @b + @Column_List
 SET @output += @b + ''
 SET @output += @b + 'The UPDATE column list:'
 SET @output += @b + @Column_List_For_Update
 SET @output += @b + ''
 SET @output += @b + 'The SELECT statement executed to generate the MERGE:'
 SET @output += @b + @Actual_Values
 SET @output += @b + ''
 SET @output += @b + '*****END OF DEBUG INFORMATION*****/'
 SET @output += @b + ''
 END
 
IF (@include_use_db = 1)
BEGIN
	SET @output +=      'USE ' + DB_NAME()
	SET @output += @b + @batch_separator
	SET @output += @b + @b
END

IF (@nologo = 0)
BEGIN
 SET @output += @b + '--MERGE generated by ''sp_generate_merge'' stored procedure, Version 0.93'
 SET @output += @b + '--Originally by Vyas (http://vyaskn.tripod.com): sp_generate_inserts (build 22)'
 SET @output += @b + '--Adapted for SQL Server 2008/2012 by Daniel Nolan (http://danere.com)'
 SET @output += @b + ''
END

IF (@include_rowsaffected = 1) -- If the caller has elected not to include the "rows affected" section, let MERGE output the row count as it is executed.
 SET @output += @b + 'SET NOCOUNT ON'
 SET @output += @b + ''


--Determining whether to print IDENTITY_INSERT or not
IF (LEN(@IDN) <> 0)
 BEGIN
 SET @output += @b + 'SET IDENTITY_INSERT ' + @Target_Table_For_Output + ' ON'
 SET @output += @b + ''
 END


--Temporarily disable constraints on the target table
IF @disable_constraints = 1 AND (OBJECT_ID(@Source_Table_Qualified, 'U') IS NOT NULL)
 BEGIN
 SET @output += @b + 'ALTER TABLE ' + @Target_Table_For_Output + ' NOCHECK CONSTRAINT ALL' --Code to disable constraints temporarily
 END


--Add record keeping timestamps to statement 
SET @output += @b + 'DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));' 
SET @output += @b + 'DECLARE @datetime DATETIMEOFFSET = GETDATE(); '

-- Write start to log 
SET @output += @b + 'EXEC dbo.LogProcedure @ProcID =  @@PROCID, @TableName = '''+ @Target_Table_For_Output +''', @starttime = @datetime, @isStart = true'
SET @output += @b + @batch_separator

--Output the start of the MERGE statement, qualifying with the schema name only if the caller explicitly specified it
SET @output += @b + 'MERGE INTO ' + @Target_Table_For_Output + ' AS Target'
SET @output += @b + 'USING  ( '--VALUES'
SET @output += @b + 'Select ' + @Column_List 
SET @output += @b + ' From' + @Source_Table_Qualified

--All the hard work pays off here!!! You'll get your MERGE statement, when the next line executes!
--DECLARE @tab TABLE (ID INT NOT NULL PRIMARY KEY IDENTITY(1,1), val NVARCHAR(max));
--INSERT INTO @tab (val)
--EXEC (@Actual_Values)

--IF (SELECT COUNT(*) FROM @tab) <> 0 -- Ensure that rows were returned, otherwise the MERGE statement will get nullified.
--BEGIN
-- SET @output += CAST((SELECT @b + val FROM @tab ORDER BY ID FOR XML PATH('')) AS XML).value('.', 'VARCHAR(MAX)');
--END


--Output the columns to correspond with each of the values above--------------------
SET @output += @b + ') AS Source (' + @Column_List + ')'


--Output the join columns ----------------------------------------------------------
SET @output += @b + 'ON (' + @PK_column_joins + ')'


--When matched, perform an UPDATE on any metadata columns only (ie. not on PK)------
IF LEN(@Column_List_For_Update) <> 0
BEGIN
 SET @output += @b + 'WHEN MATCHED ' + CASE WHEN @update_only_if_changed = 1 THEN 'AND (' + @Column_List_For_Check + ' OR ' ELSE '' END 
 SET @output += @b + '  Target.deletets IS NOT NULL) THEN'
 SET @output += @b + ' UPDATE SET'
 SET @output += @b + '  ' + LTRIM(@Column_List_For_Update) + ','
 SET @output += @b + '   [modifyts] = @datetime,'
 SET @output += @b + '    deletets = NULL ' 
END


--When NOT matched by target, perform an INSERT------------------------------------
SET @output += @b + 'WHEN NOT MATCHED BY TARGET THEN';
SET @output += @b + ' INSERT(' + @Column_List + ',[createts],[modifyts],[deletets])'
SET @output += @b + ' VALUES(' + REPLACE(@Column_List, '[', 'Source.[') + ',@datetime,@datetime,NULL)'


--When NOT matched by source, DELETE the row
IF @delete_if_not_matched=1 BEGIN
 SET @output += @b + 'WHEN NOT MATCHED BY SOURCE AND Target.deletets IS NULL AND Target.eid IN  (SELECT DISTINCT eid FROM ' +  @Source_Table_Qualified   +')  THEN  '
 --SET @output += @b + ' DELETE'
 SET @output += @b + '  UPDATE SET	deletets = @datetime'
 SET @output += @b + 'OUTPUT $action INTO @SummaryOfChanges'
END;
--SET @output += @b + ';'
SET @output += @b + @batch_separator

--Display the number of affected rows to the user, or report if an error occurred---
IF @include_rowsaffected = 1
BEGIN
 SET @output += @b + 'DECLARE @mergeError int'
 SET @output += @b + ' , @mergeCount int'
 SET @output += @b + 'SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT'
 SET @output += @b + 'IF @mergeError != 0'
 SET @output += @b + ' BEGIN'
 SET @output += @b + ' PRINT ''ERROR OCCURRED IN MERGE FOR ' + @Target_Table_For_Output + '. Rows affected: '' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected';
 SET @output += @b + ' END'
 SET @output += @b + 'ELSE'
 SET @output += @b + ' BEGIN'
 SET @output += @b + ' PRINT ''' + @Target_Table_For_Output + ' rows affected by MERGE: '' + CAST(@mergeCount AS VARCHAR(100));';
 SET @output += @b + ' END'
 SET @output += @b + @batch_separator
 SET @output += @b + @b
END

--Log end and results---
 SET @output += @b + 'DECLARE @rowcount int = @mergeCount, '
 SET @output += @b + '		@insert INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = ''INSERT''), '
 SET @output += @b + '		@update INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = ''update''), '
 SET @output += @b + '		@delete INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = ''DELETE'')  '
 SET @output += @b + ' EXEC dbo.LogProcedure @ProcID = @@PROCID, @RowCount = @rowcount,@insert = @insert,@update = @update, @delete = @delete, @starttime = @datetime, @isStart = false'

 SET @output += @b + @batch_separator
 SET @output += @b + @b

--Re-enable the previously disabled constraints-------------------------------------
IF @disable_constraints = 1 AND (OBJECT_ID(@Source_Table_Qualified, 'U') IS NOT NULL)
 BEGIN
 SET @output +=      'ALTER TABLE ' + @Target_Table_For_Output + ' CHECK CONSTRAINT ALL' --Code to enable the previously disabled constraints
 SET @output += @b + @batch_separator
 SET @output += @b
 END


--Switch-off identity inserting------------------------------------------------------
IF (LEN(@IDN) <> 0)
 BEGIN
 SET @output +=      'SET IDENTITY_INSERT ' + @Target_Table_For_Output + ' OFF'
 SET @output += @b + @batch_separator
 SET @output += @b
 END

IF (@include_rowsaffected = 1)
BEGIN
 SET @output +=      'SET NOCOUNT OFF'
 SET @output += @b + @batch_separator
 SET @output += @b
END

SET @output += @b + ''
SET @output += @b + ''

IF @results_to_text = 1
BEGIN
	--output the statement to the Grid/Messages tab
	SELECT @output;
END
ELSE
BEGIN
	--output the statement as xml (to overcome SSMS 4000/8000 char limitation)
	SELECT [processing-instruction(x)]=@output FOR XML PATH(''),TYPE;
	PRINT 'MERGE statement has been wrapped in an XML fragment and output successfully.'
	PRINT 'Ensure you have Results to Grid enabled and then click the hyperlink to copy the statement within the fragment.'
	PRINT ''
	PRINT 'If you would prefer to have results output directly (without XML) specify @results_to_text = 1, however please'
	PRINT 'note that the results may be truncated by your SQL client to 4000 nchars.'
END

SET NOCOUNT OFF
RETURN 0 --Success. We are done!
END

GO
/****** Object:  StoredProcedure [dbo].[sp_generate_merge_build]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Turn system object marking on

CREATE PROC [dbo].[sp_generate_merge_build]
(
 @table_name VARCHAR(776), -- The table/view for which the MERGE statement will be generated using the existing data
 @target_table VARCHAR(776) = NULL, -- Use this parameter to specify a different table name into which the data will be inserted/updated/deleted
 @from VARCHAR(800) = NULL, -- Use this parameter to filter the rows based on a filter condition (using WHERE)
 @include_timestamp BIT = 0, -- Specify 1 for this parameter, if you want to include the TIMESTAMP/ROWVERSION column's data in the MERGE statement
 @debug_mode BIT = 0, -- If @debug_mode is set to 1, the SQL statements constructed by this procedure will be printed for later examination
 @schema VARCHAR(64) = NULL, -- Use this parameter if you are not the owner of the table
 @srcSchema VARCHAR(64) = NULL,	-- source schema for merge 
 @ommit_images BIT = 0, -- Use this parameter to generate MERGE statement by omitting the 'image' columns
 @ommit_identity BIT = 0, -- Use this parameter to ommit the identity columns
 @top INT = NULL, -- Use this parameter to generate a MERGE statement only for the TOP n rows
 @cols_to_include VARCHAR(8000) = NULL, -- List of columns to be included in the MERGE statement
 @cols_to_exclude VARCHAR(8000) = NULL, -- List of columns to be excluded from the MERGE statement
 @update_only_if_changed BIT = 1, -- When 1, only performs an UPDATE operation if an included column in a matched row has changed.
 @delete_if_not_matched BIT = 1, -- When 1, deletes unmatched source rows from target, when 0 source rows will only be used to update existing rows or insert new.
 @disable_constraints BIT = 0, -- When 1, disables foreign key constraints and enables them after the MERGE statement
 @ommit_computed_cols BIT = 0, -- When 1, computed columns will not be included in the MERGE statement
 @include_use_db BIT = 1, -- When 1, includes a USE [DatabaseName] statement at the beginning of the generated batch
 @results_to_text BIT = 0, -- When 1, outputs results to grid/messages window. When 0, outputs MERGE statement in an XML fragment.
 @include_rowsaffected BIT = 1, -- When 1, a section is added to the end of the batch which outputs rows affected by the MERGE
 @nologo BIT = 0, -- When 1, the "About" comment is suppressed from output
 @batch_separator VARCHAR(50) = ';', -- Batch separator to use,
 @useUX BIT = 0
)
AS
BEGIN

/***********************************************************************************************************
Procedure: sp_generate_merge (Version 0.93)
 (Adapted by Daniel Nolan for SQL Server 2008/2012)

Adapted from: sp_generate_inserts (Build 22) 
 (Copyright © 2002 Narayana Vyas Kondreddi. All rights reserved.)

Purpose: To generate a MERGE statement from existing data, which will INSERT/UPDATE/DELETE data based
 on matching primary key values in the source/target table.
 
 The generated statements can be executed to replicate the data in some other location.
 
 Typical use cases:
 * Generate statements for static data tables, store the .SQL file in source control and use 
 it as part of your Dev/Test/Prod deployment. The generated statements are re-runnable, so 
 you can make changes to the file and migrate those changes between environments.
 
 * Generate statements from your Production tables and then run those statements in your 
 Dev/Test environments. Schedule this as part of a SQL Job to keep all of your environments 
 in-sync.
 
 * Enter test data into your Dev environment, and then generate statements from the Dev
 tables so that you can always reproduce your test database with valid sample data.
 

Written by: Narayana Vyas Kondreddi
 http://vyaskn.tripod.com

 Daniel Nolan
 http://danere.com
 @dan3r3

Acknowledgements (sp_generate_merge):
 Nathan Skerl -- StackOverflow answer that provided a workaround for the output truncation problem
 http://stackoverflow.com/a/10489767/266882

 Bill Gibson -- Blog that detailed the static data table use case; the inspiration for this proc
 http://blogs.msdn.com/b/ssdt/archive/2012/02/02/including-data-in-an-sql-server-database-project.aspx
 
 Bill Graziano -- Blog that provided the groundwork for MERGE statement generation
 http://weblogs.sqlteam.com/billg/archive/2011/02/15/generate-merge-statements-from-a-table.aspx 

Acknowledgements (sp_generate_inserts):
 Divya Kalra -- For beta testing
 Mark Charsley -- For reporting a problem with scripting uniqueidentifier columns with NULL values
 Artur Zeygman -- For helping me simplify a bit of code for handling non-dbo owned tables
 Joris Laperre -- For reporting a regression bug in handling text/ntext columns

Tested on: SQL Server 2008 (10.50.1600), SQL Server 2012 (11.0.2100)

Date created: January 17th 2001 21:52 GMT
Modified: May 1st 2002 19:50 GMT
Last Modified: September 27th 2012 10:00 AEDT

Email: dan@danere.com, vyaskn@hotmail.com

NOTE: This procedure may not work with tables with a large number of columns (> 500).
 Results can be unpredictable with huge text columns or SQL Server 2000's sql_variant data types
 IMPORTANT: This procedure has not been extensively tested with international data (Extended characters or Unicode). If needed
 you might want to convert the datatypes of character variables in this procedure to their respective unicode counterparts
 like nchar and nvarchar

Get Started: Ensure that your SQL client is configured to send results to grid (default SSMS behaviour).
This ensures that the generated MERGE statement can be output in full, getting around SSMS's 4000 nchar limit.
After running this proc, click the hyperlink within the single row returned to copy the generated MERGE statement.

Example 1: To generate a MERGE statement for table 'titles':
 
 EXEC sp_generate_merge 'titles'

Example 2: To generate a MERGE statement for 'titlesCopy' table from 'titles' table:

 EXEC sp_generate_merge 'titles', 'titlesCopy'

Example 3: To generate a MERGE statement for table 'titles' that will unconditionally UPDATE matching rows 
 (ie. not perform a "has data changed?" check prior to going ahead with an UPDATE):
 
 EXEC sp_generate_merge 'titles', @update_only_if_changed = 0

Example 4: To generate a MERGE statement for 'titles' table for only those titles 
 which contain the word 'Computer' in them:
 NOTE: Do not complicate the FROM or WHERE clause here. It's assumed that you are good with T-SQL if you are using this parameter

 EXEC sp_generate_merge 'titles', @from = "from titles where title like '%Computer%'"

Example 5: To specify that you want to include TIMESTAMP column's data as well in the MERGE statement:
 (By default TIMESTAMP column's data is not scripted)

 EXEC sp_generate_merge 'titles', @include_timestamp = 1

Example 6: To print the debug information:

 EXEC sp_generate_merge 'titles', @debug_mode = 1

Example 7: If the table is in a different schema to the default, use @schema parameter to specify the schema name
 To use this option, you must have SELECT permissions on that table

 EXEC sp_generate_merge 'Nickstable', @schema = 'Nick'

Example 8: To generate a MERGE statement for the rest of the columns excluding images

 EXEC sp_generate_merge 'imgtable', @ommit_images = 1

Example 9: To generate a MERGE statement excluding (omitting) IDENTITY columns:
 (By default IDENTITY columns are included in the MERGE statement)

 EXEC sp_generate_merge 'mytable', @ommit_identity = 1

Example 10: To generate a MERGE statement for the TOP 10 rows in the table:
 
 EXEC sp_generate_merge 'mytable', @top = 10

Example 11: To generate a MERGE statement with only those columns you want:
 
 EXEC sp_generate_merge 'titles', @cols_to_include = "'title','title_id','au_id'"

Example 12: To generate a MERGE statement by omitting certain columns:
 
 EXEC sp_generate_merge 'titles', @cols_to_exclude = "'title','title_id','au_id'"

Example 13: To avoid checking the foreign key constraints while loading data with a MERGE statement:
 
 EXEC sp_generate_merge 'titles', @disable_constraints = 1

Example 14: To exclude computed columns from the MERGE statement:

 EXEC sp_generate_merge 'MyTable', @ommit_computed_cols = 1
 
***********************************************************************************************************/

SET NOCOUNT ON


--Making sure user only uses either @cols_to_include or @cols_to_exclude
IF ((@cols_to_include IS NOT NULL) AND (@cols_to_exclude IS NOT NULL))
 BEGIN
 RAISERROR('Use either @cols_to_include or @cols_to_exclude. Do not use both the parameters at once',16,1)
 RETURN -1 --Failure. Reason: Both @cols_to_include and @cols_to_exclude parameters are specified
 END


--Making sure the @cols_to_include and @cols_to_exclude parameters are receiving values in proper format
IF ((@cols_to_include IS NOT NULL) AND (PATINDEX('''%''',@cols_to_include) = 0))
 BEGIN
 RAISERROR('Invalid use of @cols_to_include property',16,1)
 PRINT 'Specify column names surrounded by single quotes and separated by commas'
 PRINT 'Eg: EXEC sp_generate_merge titles, @cols_to_include = "''title_id'',''title''"'
 RETURN -1 --Failure. Reason: Invalid use of @cols_to_include property
 END

IF ((@cols_to_exclude IS NOT NULL) AND (PATINDEX('''%''',@cols_to_exclude) = 0))
 BEGIN
 RAISERROR('Invalid use of @cols_to_exclude property',16,1)
 PRINT 'Specify column names surrounded by single quotes and separated by commas'
 PRINT 'Eg: EXEC sp_generate_merge titles, @cols_to_exclude = "''title_id'',''title''"'
 RETURN -1 --Failure. Reason: Invalid use of @cols_to_exclude property
 END


--Checking to see if the database name is specified along wih the table name
--Your database context should be local to the table for which you want to generate a MERGE statement
--specifying the database name is not allowed
IF (PARSENAME(@table_name,3)) IS NOT NULL
 BEGIN
 RAISERROR('Do not specify the database name. Be in the required database and just specify the table name.',16,1)
 RETURN -1 --Failure. Reason: Database name is specified along with the table name, which is not allowed
 END


--Checking for the existence of 'user table' or 'view'
--This procedure is not written to work on system tables
--To script the data in system tables, just create a view on the system tables and script the view instead
IF @schema IS NULL
 BEGIN
 IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @table_name AND (TABLE_TYPE = 'BASE TABLE' OR TABLE_TYPE = 'VIEW') AND TABLE_SCHEMA = SCHEMA_NAME())
 BEGIN
 RAISERROR('User table or view not found.',16,1)
 PRINT 'You may see this error if the specified table is not in your default schema (' + SCHEMA_NAME() + '). In that case use @schema parameter to specify the schema name.'
 PRINT 'Make sure you have SELECT permission on that table or view.'
 RETURN -1 --Failure. Reason: There is no user table or view with this name
 END
 END
ELSE
 BEGIN
 IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @table_name AND (TABLE_TYPE = 'BASE TABLE' OR TABLE_TYPE = 'VIEW') AND TABLE_SCHEMA = @schema)
 BEGIN
 RAISERROR('User table or view not found.',16,1)
 PRINT 'Make sure you have SELECT permission on that table or view.'
 RETURN -1 --Failure. Reason: There is no user table or view with this name 
 END
 END


--Variable declarations
DECLARE @Column_ID int, 
 @Column_List varchar(max), 
 @Column_List_For_Update varchar(max), 
 @Column_List_For_Check varchar(max), 
 @Column_Name varchar(128), 
 @Column_Name_Unquoted varchar(128), 
 @Data_Type varchar(128), 
 @Actual_Values nvarchar(max), --This is the string that will be finally executed to generate a MERGE statement
 @IDN varchar(128), --Will contain the IDENTITY column's name in the table
 @Target_Table_For_Output varchar(776),
 @Source_Table_Qualified varchar(776)
 
 

--Variable Initialization
SET @IDN = ''
SET @Column_ID = 0
SET @Column_Name = ''
SET @Column_Name_Unquoted = ''
SET @Column_List = ''
SET @Column_List_For_Update = ''
SET @Column_List_For_Check = ''
SET @Actual_Values = ''

--Variable Defaults
IF @schema IS NULL
 BEGIN
 SET @Target_Table_For_Output = QUOTENAME(COALESCE(@target_table, @table_name))
 END
ELSE
 BEGIN
 SET @Target_Table_For_Output = QUOTENAME(@schema) + '.' + QUOTENAME(COALESCE(@target_table, @table_name))
 END

SET @Source_Table_Qualified

 = QUOTENAME(COALESCE(@srcSchema,SCHEMA_NAME())) + '.' + QUOTENAME(@table_name)

--To get the first column's ID
SELECT @Column_ID = MIN(ORDINAL_POSITION) 
FROM INFORMATION_SCHEMA.COLUMNS (NOLOCK) 
WHERE TABLE_NAME = @table_name
AND TABLE_SCHEMA = COALESCE(@schema, SCHEMA_NAME())


--Loop through all the columns of the table, to get the column names and their data types
WHILE @Column_ID IS NOT NULL
 BEGIN
 SELECT @Column_Name = QUOTENAME(COLUMN_NAME), 
 @Column_Name_Unquoted = COLUMN_NAME,
 @Data_Type = DATA_TYPE 
 FROM INFORMATION_SCHEMA.COLUMNS (NOLOCK) 
 WHERE ORDINAL_POSITION = @Column_ID
 AND TABLE_NAME = @table_name
 AND TABLE_SCHEMA = COALESCE(@schema, SCHEMA_NAME())

 IF @cols_to_include IS NOT NULL --Selecting only user specified columns
 BEGIN
 IF CHARINDEX( '''' + SUBSTRING(@Column_Name,2,LEN(@Column_Name)-2) + '''',@cols_to_include) = 0 
 BEGIN
 GOTO SKIP_LOOP
 END
 END

 IF @cols_to_exclude IS NOT NULL --Selecting only user specified columns
 BEGIN
 IF CHARINDEX( '''' + SUBSTRING(@Column_Name,2,LEN(@Column_Name)-2) + '''',@cols_to_exclude) <> 0 
 BEGIN
 GOTO SKIP_LOOP
 END
 END

 --Making sure to output SET IDENTITY_INSERT ON/OFF in case the table has an IDENTITY column
 IF (SELECT COLUMNPROPERTY( OBJECT_ID(@Source_Table_Qualified),SUBSTRING(@Column_Name,2,LEN(@Column_Name) - 2),'IsIdentity')) = 1 
 BEGIN
 IF @ommit_identity = 0 --Determing whether to include or exclude the IDENTITY column
 SET @IDN = @Column_Name
 ELSE
 GOTO SKIP_LOOP 
 END
 
 --Making sure whether to output computed columns or not
 IF @ommit_computed_cols = 1
 BEGIN
 IF (SELECT COLUMNPROPERTY( OBJECT_ID(@Source_Table_Qualified),SUBSTRING(@Column_Name,2,LEN(@Column_Name) - 2),'IsComputed')) = 1 
 BEGIN
 GOTO SKIP_LOOP 
 END
 END
 
 --Tables with columns of IMAGE data type are not supported for obvious reasons
 IF(@Data_Type in ('image'))
 BEGIN
 IF (@ommit_images = 0)
 BEGIN
 RAISERROR('Tables with image columns are not supported.',16,1)
 PRINT 'Use @ommit_images = 1 parameter to generate a MERGE for the rest of the columns.'
 RETURN -1 --Failure. Reason: There is a column with image data type
 END
 ELSE
 BEGIN
 GOTO SKIP_LOOP
 END
 END

 --Determining the data type of the column and depending on the data type, the VALUES part of
 --the MERGE statement is generated. Care is taken to handle columns with NULL values. Also
 --making sure, not to lose any data from flot, real, money, smallmomey, datetime columns
 SET @Actual_Values = @Actual_Values +
 CASE 
 WHEN @Data_Type IN ('char','nchar') 
 THEN 
 'COALESCE(''N'''''' + REPLACE(RTRIM(' + @Column_Name + '),'''''''','''''''''''')+'''''''',''NULL'')'
 WHEN @Data_Type IN ('varchar','nvarchar') 
 THEN 
 'COALESCE(''N'''''' + REPLACE(' + @Column_Name + ','''''''','''''''''''')+'''''''',''NULL'')'
 WHEN @Data_Type IN ('datetime','smalldatetime','datetime2','date') 
 THEN 
 'COALESCE('''''''' + RTRIM(CONVERT(char,' + @Column_Name + ',127))+'''''''',''NULL'')'
 WHEN @Data_Type IN ('uniqueidentifier') 
 THEN 
 'COALESCE(''N'''''' + REPLACE(CONVERT(char(36),RTRIM(' + @Column_Name + ')),'''''''','''''''''''')+'''''''',''NULL'')'
 WHEN @Data_Type IN ('text') 
 THEN 
 'COALESCE(''N'''''' + REPLACE(CONVERT(varchar(max),' + @Column_Name + '),'''''''','''''''''''')+'''''''',''NULL'')' 
 WHEN @Data_Type IN ('ntext') 
 THEN 
 'COALESCE('''''''' + REPLACE(CONVERT(nvarchar(max),' + @Column_Name + '),'''''''','''''''''''')+'''''''',''NULL'')' 
 WHEN @Data_Type IN ('xml') 
 THEN 
 'COALESCE('''''''' + REPLACE(CONVERT(nvarchar(max),' + @Column_Name + '),'''''''','''''''''''')+'''''''',''NULL'')' 
 WHEN @Data_Type IN ('binary','varbinary') 
 THEN 
 'COALESCE(RTRIM(CONVERT(varchar(max),' + @Column_Name + ', 1))),''NULL'')' 
 WHEN @Data_Type IN ('timestamp','rowversion') 
 THEN 
 CASE 
 WHEN @include_timestamp = 0 
 THEN 
 '''DEFAULT''' 
 ELSE 
 'COALESCE(RTRIM(CONVERT(char,' + 'CONVERT(int,' + @Column_Name + '))),''NULL'')' 
 END
 WHEN @Data_Type IN ('float','real','money','smallmoney')
 THEN
 'COALESCE(LTRIM(RTRIM(' + 'CONVERT(char, ' + @Column_Name + ',2)' + ')),''NULL'')' 
 WHEN @Data_Type IN ('hierarchyid')
 THEN 
  'COALESCE(''hierarchyid::Parse(''+'''''''' + LTRIM(RTRIM(' + 'CONVERT(char, ' + @Column_Name + ')' + '))+''''''''+'')'',''NULL'')' 
 ELSE 
 'COALESCE(LTRIM(RTRIM(' + 'CONVERT(char, ' + @Column_Name + ')' + ')),''NULL'')' 
 END + '+' + ''',''' + ' + '
 
 --Generating the column list for the MERGE statement
 SET @Column_List = @Column_List + @Column_Name + ',' 
 
 --Don't update Primary Key or Identity columns
 IF NOT EXISTS(
 SELECT 1
 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk ,
 INFORMATION_SCHEMA.KEY_COLUMN_USAGE c
 WHERE pk.TABLE_NAME = @table_name
 AND pk.TABLE_SCHEMA = COALESCE(@schema, SCHEMA_NAME())
 AND CONSTRAINT_TYPE = 'PRIMARY KEY'
 AND c.TABLE_NAME = pk.TABLE_NAME
 AND c.TABLE_SCHEMA = pk.TABLE_SCHEMA
 AND c.CONSTRAINT_NAME = pk.CONSTRAINT_NAME
 AND c.COLUMN_NAME = @Column_Name_Unquoted 
 )
 BEGIN
 SET @Column_List_For_Update = @Column_List_For_Update + @Column_Name + ' = Source.' + @Column_Name + ', 
  ' 
 SET @Column_List_For_Check = @Column_List_For_Check +
 CASE @Data_Type 
 WHEN 'text' THEN CHAR(10) + CHAR(9) + 'NULLIF(CAST(Source.' + @Column_Name + ' AS VARCHAR(MAX)), CAST(Target.' + @Column_Name + ' AS VARCHAR(MAX))) IS NOT NULL OR NULLIF(CAST(Target.' + @Column_Name + ' AS VARCHAR(MAX)), CAST(Source.' + @Column_Name + ' AS VARCHAR(MAX))) IS NOT NULL OR '
 WHEN 'ntext' THEN CHAR(10) + CHAR(9) + 'NULLIF(CAST(Source.' + @Column_Name + ' AS NVARCHAR(MAX)), CAST(Target.' + @Column_Name + ' AS NVARCHAR(MAX))) IS NOT NULL OR NULLIF(CAST(Target.' + @Column_Name + ' AS NVARCHAR(MAX)), CAST(Source.' + @Column_Name + ' AS NVARCHAR(MAX))) IS NOT NULL OR ' 
 ELSE CHAR(10) + CHAR(9) + 'NULLIF(Source.' + @Column_Name + ', Target.' + @Column_Name + ') IS NOT NULL OR NULLIF(Target.' + @Column_Name + ', Source.' + @Column_Name + ') IS NOT NULL OR '
 END 
 END

 SKIP_LOOP: --The label used in GOTO

 SELECT @Column_ID = MIN(ORDINAL_POSITION) 
 FROM INFORMATION_SCHEMA.COLUMNS (NOLOCK) 
 WHERE TABLE_NAME = @table_name
 AND TABLE_SCHEMA = COALESCE(@schema, SCHEMA_NAME())
 AND ORDINAL_POSITION > @Column_ID

 END --Loop ends here!


--To get rid of the extra characters that got concatenated during the last run through the loop
IF LEN(@Column_List_For_Update) <> 0
 BEGIN
 SET @Column_List_For_Update = ' ' + LEFT(@Column_List_For_Update,len(@Column_List_For_Update) - 4)
 END

IF LEN(@Column_List_For_Check) <> 0
 BEGIN
 SET @Column_List_For_Check = LEFT(@Column_List_For_Check,len(@Column_List_For_Check) - 3)
 END

SET @Actual_Values = LEFT(@Actual_Values,len(@Actual_Values) - 6)

SET @Column_List = LEFT(@Column_List,len(@Column_List) - 1)
IF LEN(LTRIM(@Column_List)) = 0
 BEGIN
 RAISERROR('No columns to select. There should at least be one column to generate the output',16,1)
 RETURN -1 --Failure. Reason: Looks like all the columns are ommitted using the @cols_to_exclude parameter
 END


--Get the join columns ----------------------------------------------------------

	BEGIN
	DECLARE @PK_column_list VARCHAR(8000)
	DECLARE @PK_column_joins VARCHAR(8000)
	SET @PK_column_list = ''
	SET @PK_column_joins = ''

	SELECT @PK_column_list = @PK_column_list + '[' + c.COLUMN_NAME + '], '
	, @PK_column_joins = @PK_column_joins + 'Target.[' + c.COLUMN_NAME + '] = Source.[' + c.COLUMN_NAME + '] AND '
	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk ,
	INFORMATION_SCHEMA.KEY_COLUMN_USAGE c
	WHERE pk.TABLE_NAME = @table_name
	AND pk.TABLE_SCHEMA = COALESCE(@schema, SCHEMA_NAME())
	AND CONSTRAINT_TYPE = 'PRIMARY KEY'
	AND c.TABLE_NAME = pk.TABLE_NAME
	AND c.TABLE_SCHEMA = pk.TABLE_SCHEMA
	AND c.CONSTRAINT_NAME = pk.CONSTRAINT_NAME

	IF IsNull(@PK_column_list, '') = '' 
	 BEGIN
	 RAISERROR('Table has no primary keys. There should at least be one column in order to have a valid join.',16,1)
	 RETURN -1 --Failure. Reason: looks like table doesn't have any primary keys
	 END

	SET @PK_column_list = LEFT(@PK_column_list, LEN(@PK_column_list) -1)
	SET @PK_column_joins = LEFT(@PK_column_joins, LEN(@PK_column_joins) -4)
END

 BEGIN
--Get UX join columns (when no PK)----------------------------------------------------------
DECLARE @UX_column_list VARCHAR(8000)
DECLARE @UX_column_joins VARCHAR(8000)
SET @UX_column_list = ''
SET @UX_column_joins = ''


SELECT @UX_column_list = @UX_column_list + '[' + col.name + '], '
, @UX_column_joins = @UX_column_joins + 'Target.[' + col.name + '] = Source.[' + col.name + '] AND '

FROM sys.indexes ind 
JOIN sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id 
JOIN sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
JOIN sys.tables t ON ind.object_id = t.object_id 
JOIN sys.schemas AS s ON s.schema_id = t.schema_id
WHERE 
         ind.name = 'ux_key'
	 AND t.name = @table_name
	 AND s.name = @schema
ORDER BY 
     t.name, ind.name, ind.index_id, ic.index_column_id;


IF IsNull(@UX_column_list, '') = '' 
 BEGIN
 RAISERROR('Table has no UX keys. There should at least be one column in order to have a valid join.',16,1)
 RETURN -1 --Failure. Reason: looks like table doesn't have any primary keys
 END
 
SET @UX_column_list = LEFT(@UX_column_list, LEN(@UX_column_list) -1)
SET @UX_column_joins = LEFT(@UX_column_joins, LEN(@UX_column_joins) -4)

END





--Forming the final string that will be executed, to output the a MERGE statement
SET @Actual_Values = 
 'SELECT ' + 
 CASE WHEN @top IS NULL OR @top < 0 THEN '' ELSE ' TOP ' + LTRIM(STR(@top)) + ' ' END + 
 '''' + 
 ' '' + CASE WHEN ROW_NUMBER() OVER (ORDER BY ' + @PK_column_list + ') = 1 THEN '' '' ELSE '','' END + ''(''+ ' + @Actual_Values + '+'')''' + ' ' + 
 COALESCE(@from,' FROM ' + @Source_Table_Qualified + ' (NOLOCK) ORDER BY ' + @PK_column_list)

 DECLARE @output VARCHAR(MAX) = ''
 DECLARE @b CHAR(1) = CHAR(13)

--Determining whether to ouput any debug information
IF @debug_mode =1
 BEGIN
 SET @output += @b + '/*****START OF DEBUG INFORMATION*****'
 SET @output += @b + ''
 SET @output += @b + 'The primary key column list:'
 SET @output += @b + @UX_column_list
 SET @output += @b + ''
 SET @output += @b + 'The INSERT column list:'
 SET @output += @b + @Column_List
 SET @output += @b + ''
 SET @output += @b + 'The UPDATE column list:'
 SET @output += @b + @Column_List_For_Update
 SET @output += @b + ''
 SET @output += @b + 'The SELECT statement executed to generate the MERGE:'
 SET @output += @b + @Actual_Values
 SET @output += @b + ''
 SET @output += @b + '*****END OF DEBUG INFORMATION*****/'
 SET @output += @b + ''
 END
 
IF (@include_use_db = 1)
BEGIN
	SET @output +=      'USE ' + DB_NAME()
	SET @output += @b + @batch_separator
	SET @output += @b + @b
END

IF (@nologo = 0)
BEGIN
 SET @output += @b + '--MERGE generated by ''sp_generate_merge'' stored procedure, Version 0.93'
 SET @output += @b + '--Originally by Vyas (http://vyaskn.tripod.com): sp_generate_inserts (build 22)'
 SET @output += @b + '--Adapted for SQL Server 2008/2012 by Daniel Nolan (http://danere.com)'
 SET @output += @b + ''
END

IF (@include_rowsaffected = 1) -- If the caller has elected not to include the "rows affected" section, let MERGE output the row count as it is executed.
 SET @output += @b + 'SET NOCOUNT ON'
 SET @output += @b + ''


--Determining whether to print IDENTITY_INSERT or not
IF (LEN(@IDN) <> 0)
 BEGIN
 SET @output += @b + 'SET IDENTITY_INSERT ' + @Target_Table_For_Output + ' ON'
 SET @output += @b + ''
 END


--Temporarily disable constraints on the target table
IF @disable_constraints = 1 AND (OBJECT_ID(@Source_Table_Qualified, 'U') IS NOT NULL)
 BEGIN
 SET @output += @b + 'ALTER TABLE ' + @Target_Table_For_Output + ' NOCHECK CONSTRAINT ALL' --Code to disable constraints temporarily
 END


--Add record keeping timestamps to statement 
SET @output += @b + 'DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));' 
SET @output += @b + 'DECLARE @datetime DATETIMEOFFSET = GETDATE(); '

-- Write start to log 
SET @output += @b + 'EXEC dbo.LogProcedure @ProcID =  @@PROCID, @TableName = '''+ @Target_Table_For_Output +''', @starttime = @datetime, @isStart = true'
SET @output += @b + @batch_separator

--Output the start of the MERGE statement, qualifying with the schema name only if the caller explicitly specified it
SET @output += @b + 'MERGE INTO ' + @Target_Table_For_Output + ' AS Target'
SET @output += @b + 'USING  ( '--VALUES'
SET @output += @b + 'Select ' + @Column_List 
SET @output += @b + ' From' + @Source_Table_Qualified

--All the hard work pays off here!!! You'll get your MERGE statement, when the next line executes!
--DECLARE @tab TABLE (ID INT NOT NULL PRIMARY KEY IDENTITY(1,1), val NVARCHAR(max));
--INSERT INTO @tab (val)
--EXEC (@Actual_Values)

--IF (SELECT COUNT(*) FROM @tab) <> 0 -- Ensure that rows were returned, otherwise the MERGE statement will get nullified.
--BEGIN
-- SET @output += CAST((SELECT @b + val FROM @tab ORDER BY ID FOR XML PATH('')) AS XML).value('.', 'VARCHAR(MAX)');
--END


--Output the columns to correspond with each of the values above--------------------
SET @output += @b + ') AS Source (' + @Column_List + ')'


--Output the join columns ----------------------------------------------------------
SET @output += @b + 'ON (' + @UX_column_joins + ')'


--When matched, perform an UPDATE on any metadata columns only (ie. not on UX)------
IF LEN(@Column_List_For_Update) <> 0
BEGIN
 SET @output += @b + 'WHEN MATCHED ' + CASE WHEN @update_only_if_changed = 1 THEN 'AND (' + @Column_List_For_Check + ') THEN ' ELSE '' END 
 SET @output += @b + ' UPDATE SET'
 SET @output += @b + '  ' + LTRIM(@Column_List_For_Update) 
END


--When NOT matched by target, perform an INSERT------------------------------------
SET @output += @b + 'WHEN NOT MATCHED BY TARGET THEN';
SET @output += @b + ' INSERT(' + @Column_List + ' )'
SET @output += @b + ' VALUES(' + REPLACE(@Column_List, '[', 'Source.[') + ')'


--When NOT matched by source, DELETE the row
IF @delete_if_not_matched=1 BEGIN
 SET @output += @b + 'WHEN NOT MATCHED BY SOURCE THEN '
 SET @output += @b + ' DELETE'
 SET @output += @b + ' OUTPUT $action INTO @SummaryOfChanges '

END;
--SET @output += @b + ';'
SET @output += @b + @batch_separator

--Display the number of affected rows to the user, or report if an error occurred---
IF @include_rowsaffected = 1
BEGIN
 SET @output += @b + 'DECLARE @mergeError int'
 SET @output += @b + ' , @mergeCount int'
 SET @output += @b + 'SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT'
 SET @output += @b + 'IF @mergeError != 0'
 SET @output += @b + ' BEGIN'
 SET @output += @b + ' PRINT ''ERROR OCCURRED IN MERGE FOR ' + @Target_Table_For_Output + '. Rows affected: '' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected';
 SET @output += @b + ' END'
 SET @output += @b + 'ELSE'
 SET @output += @b + ' BEGIN'
 SET @output += @b + ' PRINT ''' + @Target_Table_For_Output + ' rows affected by MERGE: '' + CAST(@mergeCount AS VARCHAR(100));';
 SET @output += @b + ' END'
 SET @output += @b + @batch_separator
 SET @output += @b + @b
END

--Log end and results---
 SET @output += @b + 'DECLARE @rowcount int = @mergeCount, '
 SET @output += @b + '		@insert INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = ''INSERT''), '
 SET @output += @b + '		@update INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = ''update''), '
 SET @output += @b + '		@delete INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = ''DELETE'')  '
 SET @output += @b + ' EXEC dbo.LogProcedure @ProcID = @@PROCID, @RowCount = @rowcount,@insert = @insert,@update = @update, @delete = @delete, @starttime = @datetime, @isStart = false'

 SET @output += @b + @batch_separator
 SET @output += @b + @b

--Re-enable the previously disabled constraints-------------------------------------
IF @disable_constraints = 1 AND (OBJECT_ID(@Source_Table_Qualified, 'U') IS NOT NULL)
 BEGIN
 SET @output +=      'ALTER TABLE ' + @Target_Table_For_Output + ' CHECK CONSTRAINT ALL' --Code to enable the previously disabled constraints
 SET @output += @b + @batch_separator
 SET @output += @b
 END


--Switch-off identity inserting------------------------------------------------------
IF (LEN(@IDN) <> 0)
 BEGIN
 SET @output +=      'SET IDENTITY_INSERT ' + @Target_Table_For_Output + ' OFF'
 SET @output += @b + @batch_separator
 SET @output += @b
 END

IF (@include_rowsaffected = 1)
BEGIN
 SET @output +=      'SET NOCOUNT OFF'
 SET @output += @b + @batch_separator
 SET @output += @b
END

SET @output += @b + ''
SET @output += @b + ''

IF @results_to_text = 1
BEGIN
	--output the statement to the Grid/Messages tab
	SELECT @output;
END
ELSE
BEGIN
	--output the statement as xml (to overcome SSMS 4000/8000 char limitation)
	SELECT [processing-instruction(x)]=@output FOR XML PATH(''),TYPE;
	PRINT 'MERGE statement has been wrapped in an XML fragment and output successfully.'
	PRINT 'Ensure you have Results to Grid enabled and then click the hyperlink to copy the statement within the fragment.'
	PRINT ''
	PRINT 'If you would prefer to have results output directly (without XML) specify @results_to_text = 1, however please'
	PRINT 'note that the results may be truncated by your SQL client to 4000 nchars.'
END

SET NOCOUNT OFF
RETURN 0 --Success. We are done!
END


GO
/****** Object:  StoredProcedure [dbo].[sp_WhoIsActive]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*********************************************************************************************
Who Is Active? v11.32 (2018-07-03)
(C) 2007-2018, Adam Machanic

Feedback: mailto:adam@dataeducation.com
Updates: http://whoisactive.com
Blog: http://dataeducation.com

License: 
	Who is Active? is free to download and use for personal, educational, and internal 
	corporate purposes, provided that this header is preserved. Redistribution or sale 
	of Who is Active?, in whole or in part, is prohibited without the author's express 
	written consent.
*********************************************************************************************/
CREATE PROC [dbo].[sp_WhoIsActive]
(
--~
	--Filters--Both inclusive and exclusive
	--Set either filter to '' to disable
	--Valid filter types are: session, program, database, login, and host
	--Session is a session ID, and either 0 or '' can be used to indicate "all" sessions
	--All other filter types support % or _ as wildcards
	@filter sysname = '',
	@filter_type VARCHAR(10) = 'session',
	@not_filter sysname = '',
	@not_filter_type VARCHAR(10) = 'session',

	--Retrieve data about the calling session?
	@show_own_spid BIT = 0,

	--Retrieve data about system sessions?
	@show_system_spids BIT = 0,

	--Controls how sleeping SPIDs are handled, based on the idea of levels of interest
	--0 does not pull any sleeping SPIDs
	--1 pulls only those sleeping SPIDs that also have an open transaction
	--2 pulls all sleeping SPIDs
	@show_sleeping_spids TINYINT = 1,

	--If 1, gets the full stored procedure or running batch, when available
	--If 0, gets only the actual statement that is currently running in the batch or procedure
	@get_full_inner_text BIT = 0,

	--Get associated query plans for running tasks, if available
	--If @get_plans = 1, gets the plan based on the request's statement offset
	--If @get_plans = 2, gets the entire plan based on the request's plan_handle
	@get_plans TINYINT = 0,

	--Get the associated outer ad hoc query or stored procedure call, if available
	@get_outer_command BIT = 0,

	--Enables pulling transaction log write info and transaction duration
	@get_transaction_info BIT = 0,

	--Get information on active tasks, based on three interest levels
	--Level 0 does not pull any task-related information
	--Level 1 is a lightweight mode that pulls the top non-CXPACKET wait, giving preference to blockers
	--Level 2 pulls all available task-based metrics, including: 
	--number of active tasks, current wait stats, physical I/O, context switches, and blocker information
	@get_task_info TINYINT = 1,

	--Gets associated locks for each request, aggregated in an XML format
	@get_locks BIT = 0,

	--Get average time for past runs of an active query
	--(based on the combination of plan handle, sql handle, and offset)
	@get_avg_time BIT = 0,

	--Get additional non-performance-related information about the session or request
	--text_size, language, date_format, date_first, quoted_identifier, arithabort, ansi_null_dflt_on, 
	--ansi_defaults, ansi_warnings, ansi_padding, ansi_nulls, concat_null_yields_null, 
	--transaction_isolation_level, lock_timeout, deadlock_priority, row_count, command_type
	--
	--If a SQL Agent job is running, an subnode called agent_info will be populated with some or all of
	--the following: job_id, job_name, step_id, step_name, msdb_query_error (in the event of an error)
	--
	--If @get_task_info is set to 2 and a lock wait is detected, a subnode called block_info will be
	--populated with some or all of the following: lock_type, database_name, object_id, file_id, hobt_id, 
	--applock_hash, metadata_resource, metadata_class_id, object_name, schema_name
	@get_additional_info BIT = 0,

	--Walk the blocking chain and count the number of 
	--total SPIDs blocked all the way down by a given session
	--Also enables task_info Level 1, if @get_task_info is set to 0
	@find_block_leaders BIT = 0,

	--Pull deltas on various metrics
	--Interval in seconds to wait before doing the second data pull
	@delta_interval TINYINT = 0,

	--List of desired output columns, in desired order
	--Note that the final output will be the intersection of all enabled features and all 
	--columns in the list. Therefore, only columns associated with enabled features will 
	--actually appear in the output. Likewise, removing columns from this list may effectively
	--disable features, even if they are turned on
	--
	--Each element in this list must be one of the valid output column names. Names must be
	--delimited by square brackets. White space, formatting, and additional characters are
	--allowed, as long as the list contains exact matches of delimited valid column names.
	@output_column_list VARCHAR(8000) = '[dd%][session_id][sql_text][sql_command][login_name][wait_info][tasks][tran_log%][cpu%][temp%][block%][reads%][writes%][context%][physical%][query_plan][locks][%]',

	--Column(s) by which to sort output, optionally with sort directions. 
		--Valid column choices:
		--session_id, physical_io, reads, physical_reads, writes, tempdb_allocations, 
		--tempdb_current, CPU, context_switches, used_memory, physical_io_delta, reads_delta, 
		--physical_reads_delta, writes_delta, tempdb_allocations_delta, tempdb_current_delta, 
		--CPU_delta, context_switches_delta, used_memory_delta, tasks, tran_start_time, 
		--open_tran_count, blocking_session_id, blocked_session_count, percent_complete, 
		--host_name, login_name, database_name, start_time, login_time, program_name
		--
		--Note that column names in the list must be bracket-delimited. Commas and/or white
		--space are not required. 
	@sort_order VARCHAR(500) = '[start_time] ASC',

	--Formats some of the output columns in a more "human readable" form
	--0 disables outfput format
	--1 formats the output for variable-width fonts
	--2 formats the output for fixed-width fonts
	@format_output TINYINT = 1,

	--If set to a non-blank value, the script will attempt to insert into the specified 
	--destination table. Please note that the script will not verify that the table exists, 
	--or that it has the correct schema, before doing the insert.
	--Table can be specified in one, two, or three-part format
	@destination_table VARCHAR(4000) = '',

	--If set to 1, no data collection will happen and no result set will be returned; instead,
	--a CREATE TABLE statement will be returned via the @schema parameter, which will match 
	--the schema of the result set that would be returned by using the same collection of the
	--rest of the parameters. The CREATE TABLE statement will have a placeholder token of 
	--<table_name> in place of an actual table name.
	@return_schema BIT = 0,
	@schema VARCHAR(MAX) = NULL OUTPUT,

	--Help! What do I do?
	@help BIT = 0
--~
)
/*
OUTPUT COLUMNS
--------------
Formatted/Non:	[session_id] [smallint] NOT NULL
	Session ID (a.k.a. SPID)

Formatted:		[dd hh:mm:ss.mss] [varchar](15) NULL
Non-Formatted:	<not returned>
	For an active request, time the query has been running
	For a sleeping session, time since the last batch completed

Formatted:		[dd hh:mm:ss.mss (avg)] [varchar](15) NULL
Non-Formatted:	[avg_elapsed_time] [int] NULL
	(Requires @get_avg_time option)
	How much time has the active portion of the query taken in the past, on average?

Formatted:		[physical_io] [varchar](30) NULL
Non-Formatted:	[physical_io] [bigint] NULL
	Shows the number of physical I/Os, for active requests

Formatted:		[reads] [varchar](30) NULL
Non-Formatted:	[reads] [bigint] NULL
	For an active request, number of reads done for the current query
	For a sleeping session, total number of reads done over the lifetime of the session

Formatted:		[physical_reads] [varchar](30) NULL
Non-Formatted:	[physical_reads] [bigint] NULL
	For an active request, number of physical reads done for the current query
	For a sleeping session, total number of physical reads done over the lifetime of the session

Formatted:		[writes] [varchar](30) NULL
Non-Formatted:	[writes] [bigint] NULL
	For an active request, number of writes done for the current query
	For a sleeping session, total number of writes done over the lifetime of the session

Formatted:		[tempdb_allocations] [varchar](30) NULL
Non-Formatted:	[tempdb_allocations] [bigint] NULL
	For an active request, number of TempDB writes done for the current query
	For a sleeping session, total number of TempDB writes done over the lifetime of the session

Formatted:		[tempdb_current] [varchar](30) NULL
Non-Formatted:	[tempdb_current] [bigint] NULL
	For an active request, number of TempDB pages currently allocated for the query
	For a sleeping session, number of TempDB pages currently allocated for the session

Formatted:		[CPU] [varchar](30) NULL
Non-Formatted:	[CPU] [int] NULL
	For an active request, total CPU time consumed by the current query
	For a sleeping session, total CPU time consumed over the lifetime of the session

Formatted:		[context_switches] [varchar](30) NULL
Non-Formatted:	[context_switches] [bigint] NULL
	Shows the number of context switches, for active requests

Formatted:		[used_memory] [varchar](30) NOT NULL
Non-Formatted:	[used_memory] [bigint] NOT NULL
	For an active request, total memory consumption for the current query
	For a sleeping session, total current memory consumption

Formatted:		[physical_io_delta] [varchar](30) NULL
Non-Formatted:	[physical_io_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of physical I/Os reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[reads_delta] [varchar](30) NULL
Non-Formatted:	[reads_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of reads reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[physical_reads_delta] [varchar](30) NULL
Non-Formatted:	[physical_reads_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of physical reads reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[writes_delta] [varchar](30) NULL
Non-Formatted:	[writes_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of writes reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[tempdb_allocations_delta] [varchar](30) NULL
Non-Formatted:	[tempdb_allocations_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of TempDB writes reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[tempdb_current_delta] [varchar](30) NULL
Non-Formatted:	[tempdb_current_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of allocated TempDB pages reported on the first and second 
	collections. If the request started after the first collection, the value will be NULL

Formatted:		[CPU_delta] [varchar](30) NULL
Non-Formatted:	[CPU_delta] [int] NULL
	(Requires @delta_interval option)
	Difference between the CPU time reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[context_switches_delta] [varchar](30) NULL
Non-Formatted:	[context_switches_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the context switches count reported on the first and second collections
	If the request started after the first collection, the value will be NULL

Formatted:		[used_memory_delta] [varchar](30) NULL
Non-Formatted:	[used_memory_delta] [bigint] NULL
	Difference between the memory usage reported on the first and second collections
	If the request started after the first collection, the value will be NULL

Formatted:		[tasks] [varchar](30) NULL
Non-Formatted:	[tasks] [smallint] NULL
	Number of worker tasks currently allocated, for active requests

Formatted/Non:	[status] [varchar](30) NOT NULL
	Activity status for the session (running, sleeping, etc)

Formatted/Non:	[wait_info] [nvarchar](4000) NULL
	Aggregates wait information, in the following format:
		(Ax: Bms/Cms/Dms)E
	A is the number of waiting tasks currently waiting on resource type E. B/C/D are wait
	times, in milliseconds. If only one thread is waiting, its wait time will be shown as B.
	If two tasks are waiting, each of their wait times will be shown (B/C). If three or more 
	tasks are waiting, the minimum, average, and maximum wait times will be shown (B/C/D).
	If wait type E is a page latch wait and the page is of a "special" type (e.g. PFS, GAM, SGAM), 
	the page type will be identified.
	If wait type E is CXPACKET, the nodeId from the query plan will be identified

Formatted/Non:	[locks] [xml] NULL
	(Requires @get_locks option)
	Aggregates lock information, in XML format.
	The lock XML includes the lock mode, locked object, and aggregates the number of requests. 
	Attempts are made to identify locked objects by name

Formatted/Non:	[tran_start_time] [datetime] NULL
	(Requires @get_transaction_info option)
	Date and time that the first transaction opened by a session caused a transaction log 
	write to occur.

Formatted/Non:	[tran_log_writes] [nvarchar](4000) NULL
	(Requires @get_transaction_info option)
	Aggregates transaction log write information, in the following format:
	A:wB (C kB)
	A is a database that has been touched by an active transaction
	B is the number of log writes that have been made in the database as a result of the transaction
	C is the number of log kilobytes consumed by the log records

Formatted:		[open_tran_count] [varchar](30) NULL
Non-Formatted:	[open_tran_count] [smallint] NULL
	Shows the number of open transactions the session has open

Formatted:		[sql_command] [xml] NULL
Non-Formatted:	[sql_command] [nvarchar](max) NULL
	(Requires @get_outer_command option)
	Shows the "outer" SQL command, i.e. the text of the batch or RPC sent to the server, 
	if available

Formatted:		[sql_text] [xml] NULL
Non-Formatted:	[sql_text] [nvarchar](max) NULL
	Shows the SQL text for active requests or the last statement executed
	for sleeping sessions, if available in either case.
	If @get_full_inner_text option is set, shows the full text of the batch.
	Otherwise, shows only the active statement within the batch.
	If the query text is locked, a special timeout message will be sent, in the following format:
		<timeout_exceeded />
	If an error occurs, an error message will be sent, in the following format:
		<error message="message" />

Formatted/Non:	[query_plan] [xml] NULL
	(Requires @get_plans option)
	Shows the query plan for the request, if available.
	If the plan is locked, a special timeout message will be sent, in the following format:
		<timeout_exceeded />
	If an error occurs, an error message will be sent, in the following format:
		<error message="message" />

Formatted/Non:	[blocking_session_id] [smallint] NULL
	When applicable, shows the blocking SPID

Formatted:		[blocked_session_count] [varchar](30) NULL
Non-Formatted:	[blocked_session_count] [smallint] NULL
	(Requires @find_block_leaders option)
	The total number of SPIDs blocked by this session,
	all the way down the blocking chain.

Formatted:		[percent_complete] [varchar](30) NULL
Non-Formatted:	[percent_complete] [real] NULL
	When applicable, shows the percent complete (e.g. for backups, restores, and some rollbacks)

Formatted/Non:	[host_name] [sysname] NOT NULL
	Shows the host name for the connection

Formatted/Non:	[login_name] [sysname] NOT NULL
	Shows the login name for the connection

Formatted/Non:	[database_name] [sysname] NULL
	Shows the connected database

Formatted/Non:	[program_name] [sysname] NULL
	Shows the reported program/application name

Formatted/Non:	[additional_info] [xml] NULL
	(Requires @get_additional_info option)
	Returns additional non-performance-related session/request information
	If the script finds a SQL Agent job running, the name of the job and job step will be reported
	If @get_task_info = 2 and the script finds a lock wait, the locked object will be reported

Formatted/Non:	[start_time] [datetime] NOT NULL
	For active requests, shows the time the request started
	For sleeping sessions, shows the time the last batch completed

Formatted/Non:	[login_time] [datetime] NOT NULL
	Shows the time that the session connected

Formatted/Non:	[request_id] [int] NULL
	For active requests, shows the request_id
	Should be 0 unless MARS is being used

Formatted/Non:	[collection_time] [datetime] NOT NULL
	Time that this script's final SELECT ran
*/
AS
BEGIN;
	SET NOCOUNT ON; 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	SET QUOTED_IDENTIFIER ON;
	SET ANSI_PADDING ON;
	SET CONCAT_NULL_YIELDS_NULL ON;
	SET ANSI_WARNINGS ON;
	SET NUMERIC_ROUNDABORT OFF;
	SET ARITHABORT ON;

	IF
		@filter IS NULL
		OR @filter_type IS NULL
		OR @not_filter IS NULL
		OR @not_filter_type IS NULL
		OR @show_own_spid IS NULL
		OR @show_system_spids IS NULL
		OR @show_sleeping_spids IS NULL
		OR @get_full_inner_text IS NULL
		OR @get_plans IS NULL
		OR @get_outer_command IS NULL
		OR @get_transaction_info IS NULL
		OR @get_task_info IS NULL
		OR @get_locks IS NULL
		OR @get_avg_time IS NULL
		OR @get_additional_info IS NULL
		OR @find_block_leaders IS NULL
		OR @delta_interval IS NULL
		OR @format_output IS NULL
		OR @output_column_list IS NULL
		OR @sort_order IS NULL
		OR @return_schema IS NULL
		OR @destination_table IS NULL
		OR @help IS NULL
	BEGIN;
		RAISERROR('Input parameters cannot be NULL', 16, 1);
		RETURN;
	END;
	
	IF @filter_type NOT IN ('session', 'program', 'database', 'login', 'host')
	BEGIN;
		RAISERROR('Valid filter types are: session, program, database, login, host', 16, 1);
		RETURN;
	END;
	
	IF @filter_type = 'session' AND @filter LIKE '%[^0123456789]%'
	BEGIN;
		RAISERROR('Session filters must be valid integers', 16, 1);
		RETURN;
	END;
	
	IF @not_filter_type NOT IN ('session', 'program', 'database', 'login', 'host')
	BEGIN;
		RAISERROR('Valid filter types are: session, program, database, login, host', 16, 1);
		RETURN;
	END;
	
	IF @not_filter_type = 'session' AND @not_filter LIKE '%[^0123456789]%'
	BEGIN;
		RAISERROR('Session filters must be valid integers', 16, 1);
		RETURN;
	END;
	
	IF @show_sleeping_spids NOT IN (0, 1, 2)
	BEGIN;
		RAISERROR('Valid values for @show_sleeping_spids are: 0, 1, or 2', 16, 1);
		RETURN;
	END;
	
	IF @get_plans NOT IN (0, 1, 2)
	BEGIN;
		RAISERROR('Valid values for @get_plans are: 0, 1, or 2', 16, 1);
		RETURN;
	END;

	IF @get_task_info NOT IN (0, 1, 2)
	BEGIN;
		RAISERROR('Valid values for @get_task_info are: 0, 1, or 2', 16, 1);
		RETURN;
	END;

	IF @format_output NOT IN (0, 1, 2)
	BEGIN;
		RAISERROR('Valid values for @format_output are: 0, 1, or 2', 16, 1);
		RETURN;
	END;
	
	IF @help = 1
	BEGIN;
		DECLARE 
			@header VARCHAR(MAX),
			@params VARCHAR(MAX),
			@outputs VARCHAR(MAX);

		SELECT 
			@header =
				REPLACE
				(
					REPLACE
					(
						CONVERT
						(
							VARCHAR(MAX),
							SUBSTRING
							(
								t.text, 
								CHARINDEX('/' + REPLICATE('*', 93), t.text) + 94,
								CHARINDEX(REPLICATE('*', 93) + '/', t.text) - (CHARINDEX('/' + REPLICATE('*', 93), t.text) + 94)
							)
						),
						CHAR(13)+CHAR(10),
						CHAR(13)
					),
					'	',
					''
				),
			@params =
				CHAR(13) +
					REPLACE
					(
						REPLACE
						(
							CONVERT
							(
								VARCHAR(MAX),
								SUBSTRING
								(
									t.text, 
									CHARINDEX('--~', t.text) + 5, 
									CHARINDEX('--~', t.text, CHARINDEX('--~', t.text) + 5) - (CHARINDEX('--~', t.text) + 5)
								)
							),
							CHAR(13)+CHAR(10),
							CHAR(13)
						),
						'	',
						''
					),
				@outputs = 
					CHAR(13) +
						REPLACE
						(
							REPLACE
							(
								REPLACE
								(
									CONVERT
									(
										VARCHAR(MAX),
										SUBSTRING
										(
											t.text, 
											CHARINDEX('OUTPUT COLUMNS'+CHAR(13)+CHAR(10)+'--------------', t.text) + 32,
											CHARINDEX('*/', t.text, CHARINDEX('OUTPUT COLUMNS'+CHAR(13)+CHAR(10)+'--------------', t.text) + 32) - (CHARINDEX('OUTPUT COLUMNS'+CHAR(13)+CHAR(10)+'--------------', t.text) + 32)
										)
									),
									CHAR(9),
									CHAR(255)
								),
								CHAR(13)+CHAR(10),
								CHAR(13)
							),
							'	',
							''
						) +
						CHAR(13)
		FROM sys.dm_exec_requests AS r
		CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
		WHERE
			r.session_id = @@SPID;

		WITH
		a0 AS
		(SELECT 1 AS n UNION ALL SELECT 1),
		a1 AS
		(SELECT 1 AS n FROM a0 AS a, a0 AS b),
		a2 AS
		(SELECT 1 AS n FROM a1 AS a, a1 AS b),
		a3 AS
		(SELECT 1 AS n FROM a2 AS a, a2 AS b),
		a4 AS
		(SELECT 1 AS n FROM a3 AS a, a3 AS b),
		numbers AS
		(
			SELECT TOP(LEN(@header) - 1)
				ROW_NUMBER() OVER
				(
					ORDER BY (SELECT NULL)
				) AS number
			FROM a4
			ORDER BY
				number
		)
		SELECT
			RTRIM(LTRIM(
				SUBSTRING
				(
					@header,
					number + 1,
					CHARINDEX(CHAR(13), @header, number + 1) - number - 1
				)
			)) AS [------header---------------------------------------------------------------------------------------------------------------]
		FROM numbers
		WHERE
			SUBSTRING(@header, number, 1) = CHAR(13);

		WITH
		a0 AS
		(SELECT 1 AS n UNION ALL SELECT 1),
		a1 AS
		(SELECT 1 AS n FROM a0 AS a, a0 AS b),
		a2 AS
		(SELECT 1 AS n FROM a1 AS a, a1 AS b),
		a3 AS
		(SELECT 1 AS n FROM a2 AS a, a2 AS b),
		a4 AS
		(SELECT 1 AS n FROM a3 AS a, a3 AS b),
		numbers AS
		(
			SELECT TOP(LEN(@params) - 1)
				ROW_NUMBER() OVER
				(
					ORDER BY (SELECT NULL)
				) AS number
			FROM a4
			ORDER BY
				number
		),
		tokens AS
		(
			SELECT 
				RTRIM(LTRIM(
					SUBSTRING
					(
						@params,
						number + 1,
						CHARINDEX(CHAR(13), @params, number + 1) - number - 1
					)
				)) AS token,
				number,
				CASE
					WHEN SUBSTRING(@params, number + 1, 1) = CHAR(13) THEN number
					ELSE COALESCE(NULLIF(CHARINDEX(',' + CHAR(13) + CHAR(13), @params, number), 0), LEN(@params)) 
				END AS param_group,
				ROW_NUMBER() OVER
				(
					PARTITION BY
						CHARINDEX(',' + CHAR(13) + CHAR(13), @params, number),
						SUBSTRING(@params, number+1, 1)
					ORDER BY 
						number
				) AS group_order
			FROM numbers
			WHERE
				SUBSTRING(@params, number, 1) = CHAR(13)
		),
		parsed_tokens AS
		(
			SELECT
				MIN
				(
					CASE
						WHEN token LIKE '@%' THEN token
						ELSE NULL
					END
				) AS parameter,
				MIN
				(
					CASE
						WHEN token LIKE '--%' THEN RIGHT(token, LEN(token) - 2)
						ELSE NULL
					END
				) AS description,
				param_group,
				group_order
			FROM tokens
			WHERE
				NOT 
				(
					token = '' 
					AND group_order > 1
				)
			GROUP BY
				param_group,
				group_order
		)
		SELECT
			CASE
				WHEN description IS NULL AND parameter IS NULL THEN '-------------------------------------------------------------------------'
				WHEN param_group = MAX(param_group) OVER() THEN parameter
				ELSE COALESCE(LEFT(parameter, LEN(parameter) - 1), '')
			END AS [------parameter----------------------------------------------------------],
			CASE
				WHEN description IS NULL AND parameter IS NULL THEN '----------------------------------------------------------------------------------------------------------------------'
				ELSE COALESCE(description, '')
			END AS [------description-----------------------------------------------------------------------------------------------------]
		FROM parsed_tokens
		ORDER BY
			param_group, 
			group_order;
		
		WITH
		a0 AS
		(SELECT 1 AS n UNION ALL SELECT 1),
		a1 AS
		(SELECT 1 AS n FROM a0 AS a, a0 AS b),
		a2 AS
		(SELECT 1 AS n FROM a1 AS a, a1 AS b),
		a3 AS
		(SELECT 1 AS n FROM a2 AS a, a2 AS b),
		a4 AS
		(SELECT 1 AS n FROM a3 AS a, a3 AS b),
		numbers AS
		(
			SELECT TOP(LEN(@outputs) - 1)
				ROW_NUMBER() OVER
				(
					ORDER BY (SELECT NULL)
				) AS number
			FROM a4
			ORDER BY
				number
		),
		tokens AS
		(
			SELECT 
				RTRIM(LTRIM(
					SUBSTRING
					(
						@outputs,
						number + 1,
						CASE
							WHEN 
								COALESCE(NULLIF(CHARINDEX(CHAR(13) + 'Formatted', @outputs, number + 1), 0), LEN(@outputs)) < 
								COALESCE(NULLIF(CHARINDEX(CHAR(13) + CHAR(255) COLLATE Latin1_General_Bin2, @outputs, number + 1), 0), LEN(@outputs))
								THEN COALESCE(NULLIF(CHARINDEX(CHAR(13) + 'Formatted', @outputs, number + 1), 0), LEN(@outputs)) - number - 1
							ELSE
								COALESCE(NULLIF(CHARINDEX(CHAR(13) + CHAR(255) COLLATE Latin1_General_Bin2, @outputs, number + 1), 0), LEN(@outputs)) - number - 1
						END
					)
				)) AS token,
				number,
				COALESCE(NULLIF(CHARINDEX(CHAR(13) + 'Formatted', @outputs, number + 1), 0), LEN(@outputs)) AS output_group,
				ROW_NUMBER() OVER
				(
					PARTITION BY 
						COALESCE(NULLIF(CHARINDEX(CHAR(13) + 'Formatted', @outputs, number + 1), 0), LEN(@outputs))
					ORDER BY
						number
				) AS output_group_order
			FROM numbers
			WHERE
				SUBSTRING(@outputs, number, 10) = CHAR(13) + 'Formatted'
				OR SUBSTRING(@outputs, number, 2) = CHAR(13) + CHAR(255) COLLATE Latin1_General_Bin2
		),
		output_tokens AS
		(
			SELECT 
				*,
				CASE output_group_order
					WHEN 2 THEN MAX(CASE output_group_order WHEN 1 THEN token ELSE NULL END) OVER (PARTITION BY output_group)
					ELSE ''
				END COLLATE Latin1_General_Bin2 AS column_info
			FROM tokens
		)
		SELECT
			CASE output_group_order
				WHEN 1 THEN '-----------------------------------'
				WHEN 2 THEN 
					CASE
						WHEN CHARINDEX('Formatted/Non:', column_info) = 1 THEN
							SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info)+1, CHARINDEX(']', column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info)+2) - CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info))
						ELSE
							SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info)+2, CHARINDEX(']', column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info)+2) - CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info)-1)
					END
				ELSE ''
			END AS formatted_column_name,
			CASE output_group_order
				WHEN 1 THEN '-----------------------------------'
				WHEN 2 THEN 
					CASE
						WHEN CHARINDEX('Formatted/Non:', column_info) = 1 THEN
							SUBSTRING(column_info, CHARINDEX(']', column_info)+2, LEN(column_info))
						ELSE
							SUBSTRING(column_info, CHARINDEX(']', column_info)+2, CHARINDEX('Non-Formatted:', column_info, CHARINDEX(']', column_info)+2) - CHARINDEX(']', column_info)-3)
					END
				ELSE ''
			END AS formatted_column_type,
			CASE output_group_order
				WHEN 1 THEN '---------------------------------------'
				WHEN 2 THEN 
					CASE
						WHEN CHARINDEX('Formatted/Non:', column_info) = 1 THEN ''
						ELSE
							CASE
								WHEN SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1, 1) = '<' THEN
									SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1, CHARINDEX('>', column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1) - CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info)))
								ELSE
									SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1, CHARINDEX(']', column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1) - CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info)))
							END
					END
				ELSE ''
			END AS unformatted_column_name,
			CASE output_group_order
				WHEN 1 THEN '---------------------------------------'
				WHEN 2 THEN 
					CASE
						WHEN CHARINDEX('Formatted/Non:', column_info) = 1 THEN ''
						ELSE
							CASE
								WHEN SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1, 1) = '<' THEN ''
								ELSE
									SUBSTRING(column_info, CHARINDEX(']', column_info, CHARINDEX('Non-Formatted:', column_info))+2, CHARINDEX('Non-Formatted:', column_info, CHARINDEX(']', column_info)+2) - CHARINDEX(']', column_info)-3)
							END
					END
				ELSE ''
			END AS unformatted_column_type,
			CASE output_group_order
				WHEN 1 THEN '----------------------------------------------------------------------------------------------------------------------'
				ELSE REPLACE(token, CHAR(255) COLLATE Latin1_General_Bin2, '')
			END AS [------description-----------------------------------------------------------------------------------------------------]
		FROM output_tokens
		WHERE
			NOT 
			(
				output_group_order = 1 
				AND output_group = LEN(@outputs)
			)
		ORDER BY
			output_group,
			CASE output_group_order
				WHEN 1 THEN 99
				ELSE output_group_order
			END;

		RETURN;
	END;

	WITH
	a0 AS
	(SELECT 1 AS n UNION ALL SELECT 1),
	a1 AS
	(SELECT 1 AS n FROM a0 AS a, a0 AS b),
	a2 AS
	(SELECT 1 AS n FROM a1 AS a, a1 AS b),
	a3 AS
	(SELECT 1 AS n FROM a2 AS a, a2 AS b),
	a4 AS
	(SELECT 1 AS n FROM a3 AS a, a3 AS b),
	numbers AS
	(
		SELECT TOP(LEN(@output_column_list))
			ROW_NUMBER() OVER
			(
				ORDER BY (SELECT NULL)
			) AS number
		FROM a4
		ORDER BY
			number
	),
	tokens AS
	(
		SELECT 
			'|[' +
				SUBSTRING
				(
					@output_column_list,
					number + 1,
					CHARINDEX(']', @output_column_list, number) - number - 1
				) + '|]' AS token,
			number
		FROM numbers
		WHERE
			SUBSTRING(@output_column_list, number, 1) = '['
	),
	ordered_columns AS
	(
		SELECT
			x.column_name,
			ROW_NUMBER() OVER
			(
				PARTITION BY
					x.column_name
				ORDER BY
					tokens.number,
					x.default_order
			) AS r,
			ROW_NUMBER() OVER
			(
				ORDER BY
					tokens.number,
					x.default_order
			) AS s
		FROM tokens
		JOIN
		(
			SELECT '[session_id]' AS column_name, 1 AS default_order
			UNION ALL
			SELECT '[dd hh:mm:ss.mss]', 2
			WHERE
				@format_output IN (1, 2)
			UNION ALL
			SELECT '[dd hh:mm:ss.mss (avg)]', 3
			WHERE
				@format_output IN (1, 2)
				AND @get_avg_time = 1
			UNION ALL
			SELECT '[avg_elapsed_time]', 4
			WHERE
				@format_output = 0
				AND @get_avg_time = 1
			UNION ALL
			SELECT '[physical_io]', 5
			WHERE
				@get_task_info = 2
			UNION ALL
			SELECT '[reads]', 6
			UNION ALL
			SELECT '[physical_reads]', 7
			UNION ALL
			SELECT '[writes]', 8
			UNION ALL
			SELECT '[tempdb_allocations]', 9
			UNION ALL
			SELECT '[tempdb_current]', 10
			UNION ALL
			SELECT '[CPU]', 11
			UNION ALL
			SELECT '[context_switches]', 12
			WHERE
				@get_task_info = 2
			UNION ALL
			SELECT '[used_memory]', 13
			UNION ALL
			SELECT '[physical_io_delta]', 14
			WHERE
				@delta_interval > 0	
				AND @get_task_info = 2
			UNION ALL
			SELECT '[reads_delta]', 15
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[physical_reads_delta]', 16
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[writes_delta]', 17
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[tempdb_allocations_delta]', 18
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[tempdb_current_delta]', 19
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[CPU_delta]', 20
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[context_switches_delta]', 21
			WHERE
				@delta_interval > 0
				AND @get_task_info = 2
			UNION ALL
			SELECT '[used_memory_delta]', 22
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[tasks]', 23
			WHERE
				@get_task_info = 2
			UNION ALL
			SELECT '[status]', 24
			UNION ALL
			SELECT '[wait_info]', 25
			WHERE
				@get_task_info > 0
				OR @find_block_leaders = 1
			UNION ALL
			SELECT '[locks]', 26
			WHERE
				@get_locks = 1
			UNION ALL
			SELECT '[tran_start_time]', 27
			WHERE
				@get_transaction_info = 1
			UNION ALL
			SELECT '[tran_log_writes]', 28
			WHERE
				@get_transaction_info = 1
			UNION ALL
			SELECT '[open_tran_count]', 29
			UNION ALL
			SELECT '[sql_command]', 30
			WHERE
				@get_outer_command = 1
			UNION ALL
			SELECT '[sql_text]', 31
			UNION ALL
			SELECT '[query_plan]', 32
			WHERE
				@get_plans >= 1
			UNION ALL
			SELECT '[blocking_session_id]', 33
			WHERE
				@get_task_info > 0
				OR @find_block_leaders = 1
			UNION ALL
			SELECT '[blocked_session_count]', 34
			WHERE
				@find_block_leaders = 1
			UNION ALL
			SELECT '[percent_complete]', 35
			UNION ALL
			SELECT '[host_name]', 36
			UNION ALL
			SELECT '[login_name]', 37
			UNION ALL
			SELECT '[database_name]', 38
			UNION ALL
			SELECT '[program_name]', 39
			UNION ALL
			SELECT '[additional_info]', 40
			WHERE
				@get_additional_info = 1
			UNION ALL
			SELECT '[start_time]', 41
			UNION ALL
			SELECT '[login_time]', 42
			UNION ALL
			SELECT '[request_id]', 43
			UNION ALL
			SELECT '[collection_time]', 44
		) AS x ON 
			x.column_name LIKE token ESCAPE '|'
	)
	SELECT
		@output_column_list =
			STUFF
			(
				(
					SELECT
						',' + column_name as [text()]
					FROM ordered_columns
					WHERE
						r = 1
					ORDER BY
						s
					FOR XML
						PATH('')
				),
				1,
				1,
				''
			);
	
	IF COALESCE(RTRIM(@output_column_list), '') = ''
	BEGIN;
		RAISERROR('No valid column matches found in @output_column_list or no columns remain due to selected options.', 16, 1);
		RETURN;
	END;
	
	IF @destination_table <> ''
	BEGIN;
		SET @destination_table = 
			--database
			COALESCE(QUOTENAME(PARSENAME(@destination_table, 3)) + '.', '') +
			--schema
			COALESCE(QUOTENAME(PARSENAME(@destination_table, 2)) + '.', '') +
			--table
			COALESCE(QUOTENAME(PARSENAME(@destination_table, 1)), '');
			
		IF COALESCE(RTRIM(@destination_table), '') = ''
		BEGIN;
			RAISERROR('Destination table not properly formatted.', 16, 1);
			RETURN;
		END;
	END;

	WITH
	a0 AS
	(SELECT 1 AS n UNION ALL SELECT 1),
	a1 AS
	(SELECT 1 AS n FROM a0 AS a, a0 AS b),
	a2 AS
	(SELECT 1 AS n FROM a1 AS a, a1 AS b),
	a3 AS
	(SELECT 1 AS n FROM a2 AS a, a2 AS b),
	a4 AS
	(SELECT 1 AS n FROM a3 AS a, a3 AS b),
	numbers AS
	(
		SELECT TOP(LEN(@sort_order))
			ROW_NUMBER() OVER
			(
				ORDER BY (SELECT NULL)
			) AS number
		FROM a4
		ORDER BY
			number
	),
	tokens AS
	(
		SELECT 
			'|[' +
				SUBSTRING
				(
					@sort_order,
					number + 1,
					CHARINDEX(']', @sort_order, number) - number - 1
				) + '|]' AS token,
			SUBSTRING
			(
				@sort_order,
				CHARINDEX(']', @sort_order, number) + 1,
				COALESCE(NULLIF(CHARINDEX('[', @sort_order, CHARINDEX(']', @sort_order, number)), 0), LEN(@sort_order)) - CHARINDEX(']', @sort_order, number)
			) AS next_chunk,
			number
		FROM numbers
		WHERE
			SUBSTRING(@sort_order, number, 1) = '['
	),
	ordered_columns AS
	(
		SELECT
			x.column_name +
				CASE
					WHEN tokens.next_chunk LIKE '%asc%' THEN ' ASC'
					WHEN tokens.next_chunk LIKE '%desc%' THEN ' DESC'
					ELSE ''
				END AS column_name,
			ROW_NUMBER() OVER
			(
				PARTITION BY
					x.column_name
				ORDER BY
					tokens.number
			) AS r,
			tokens.number
		FROM tokens
		JOIN
		(
			SELECT '[session_id]' AS column_name
			UNION ALL
			SELECT '[physical_io]'
			UNION ALL
			SELECT '[reads]'
			UNION ALL
			SELECT '[physical_reads]'
			UNION ALL
			SELECT '[writes]'
			UNION ALL
			SELECT '[tempdb_allocations]'
			UNION ALL
			SELECT '[tempdb_current]'
			UNION ALL
			SELECT '[CPU]'
			UNION ALL
			SELECT '[context_switches]'
			UNION ALL
			SELECT '[used_memory]'
			UNION ALL
			SELECT '[physical_io_delta]'
			UNION ALL
			SELECT '[reads_delta]'
			UNION ALL
			SELECT '[physical_reads_delta]'
			UNION ALL
			SELECT '[writes_delta]'
			UNION ALL
			SELECT '[tempdb_allocations_delta]'
			UNION ALL
			SELECT '[tempdb_current_delta]'
			UNION ALL
			SELECT '[CPU_delta]'
			UNION ALL
			SELECT '[context_switches_delta]'
			UNION ALL
			SELECT '[used_memory_delta]'
			UNION ALL
			SELECT '[tasks]'
			UNION ALL
			SELECT '[tran_start_time]'
			UNION ALL
			SELECT '[open_tran_count]'
			UNION ALL
			SELECT '[blocking_session_id]'
			UNION ALL
			SELECT '[blocked_session_count]'
			UNION ALL
			SELECT '[percent_complete]'
			UNION ALL
			SELECT '[host_name]'
			UNION ALL
			SELECT '[login_name]'
			UNION ALL
			SELECT '[database_name]'
			UNION ALL
			SELECT '[start_time]'
			UNION ALL
			SELECT '[login_time]'
			UNION ALL
			SELECT '[program_name]'
		) AS x ON 
			x.column_name LIKE token ESCAPE '|'
	)
	SELECT
		@sort_order = COALESCE(z.sort_order, '')
	FROM
	(
		SELECT
			STUFF
			(
				(
					SELECT
						',' + column_name as [text()]
					FROM ordered_columns
					WHERE
						r = 1
					ORDER BY
						number
					FOR XML
						PATH('')
				),
				1,
				1,
				''
			) AS sort_order
	) AS z;

	CREATE TABLE #sessions
	(
		recursion SMALLINT NOT NULL,
		session_id SMALLINT NOT NULL,
		request_id INT NOT NULL,
		session_number INT NOT NULL,
		elapsed_time INT NOT NULL,
		avg_elapsed_time INT NULL,
		physical_io BIGINT NULL,
		reads BIGINT NULL,
		physical_reads BIGINT NULL,
		writes BIGINT NULL,
		tempdb_allocations BIGINT NULL,
		tempdb_current BIGINT NULL,
		CPU INT NULL,
		thread_CPU_snapshot BIGINT NULL,
		context_switches BIGINT NULL,
		used_memory BIGINT NOT NULL, 
		tasks SMALLINT NULL,
		status VARCHAR(30) NOT NULL,
		wait_info NVARCHAR(4000) NULL,
		locks XML NULL,
		transaction_id BIGINT NULL,
		tran_start_time DATETIME NULL,
		tran_log_writes NVARCHAR(4000) NULL,
		open_tran_count SMALLINT NULL,
		sql_command XML NULL,
		sql_handle VARBINARY(64) NULL,
		statement_start_offset INT NULL,
		statement_end_offset INT NULL,
		sql_text XML NULL,
		plan_handle VARBINARY(64) NULL,
		query_plan XML NULL,
		blocking_session_id SMALLINT NULL,
		blocked_session_count SMALLINT NULL,
		percent_complete REAL NULL,
		host_name sysname NULL,
		login_name sysname NOT NULL,
		database_name sysname NULL,
		program_name sysname NULL,
		additional_info XML NULL,
		start_time DATETIME NOT NULL,
		login_time DATETIME NULL,
		last_request_start_time DATETIME NULL,
		PRIMARY KEY CLUSTERED (session_id, request_id, recursion) WITH (IGNORE_DUP_KEY = ON),
		UNIQUE NONCLUSTERED (transaction_id, session_id, request_id, recursion) WITH (IGNORE_DUP_KEY = ON)
	);

	IF @return_schema = 0
	BEGIN;
		--Disable unnecessary autostats on the table
		CREATE STATISTICS s_session_id ON #sessions (session_id)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_request_id ON #sessions (request_id)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_transaction_id ON #sessions (transaction_id)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_session_number ON #sessions (session_number)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_status ON #sessions (status)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_start_time ON #sessions (start_time)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_last_request_start_time ON #sessions (last_request_start_time)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_recursion ON #sessions (recursion)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;

		DECLARE @recursion SMALLINT;
		SET @recursion = 
			CASE @delta_interval
				WHEN 0 THEN 1
				ELSE -1
			END;

		DECLARE @first_collection_ms_ticks BIGINT;
		DECLARE @last_collection_start DATETIME;
		DECLARE @sys_info BIT;
		SET @sys_info = ISNULL(CONVERT(BIT, SIGN(OBJECT_ID('sys.dm_os_sys_info'))), 0);

		--Used for the delta pull
		REDO:;
		
		IF 
			@get_locks = 1 
			AND @recursion = 1
			AND @output_column_list LIKE '%|[locks|]%' ESCAPE '|'
		BEGIN;
			SELECT
				y.resource_type,
				y.database_name,
				y.object_id,
				y.file_id,
				y.page_type,
				y.hobt_id,
				y.allocation_unit_id,
				y.index_id,
				y.schema_id,
				y.principal_id,
				y.request_mode,
				y.request_status,
				y.session_id,
				y.resource_description,
				y.request_count,
				s.request_id,
				s.start_time,
				CONVERT(sysname, NULL) AS object_name,
				CONVERT(sysname, NULL) AS index_name,
				CONVERT(sysname, NULL) AS schema_name,
				CONVERT(sysname, NULL) AS principal_name,
				CONVERT(NVARCHAR(2048), NULL) AS query_error
			INTO #locks
			FROM
			(
				SELECT
					sp.spid AS session_id,
					CASE sp.status
						WHEN 'sleeping' THEN CONVERT(INT, 0)
						ELSE sp.request_id
					END AS request_id,
					CASE sp.status
						WHEN 'sleeping' THEN sp.last_batch
						ELSE COALESCE(req.start_time, sp.last_batch)
					END AS start_time,
					sp.dbid
				FROM sys.sysprocesses AS sp
				OUTER APPLY
				(
					SELECT TOP(1)
						CASE
							WHEN 
							(
								sp.hostprocess > ''
								OR r.total_elapsed_time < 0
							) THEN
								r.start_time
							ELSE
								DATEADD
								(
									ms, 
									1000 * (DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())) / 500) - DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())), 
									DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())
								)
						END AS start_time
					FROM sys.dm_exec_requests AS r
					WHERE
						r.session_id = sp.spid
						AND r.request_id = sp.request_id
				) AS req
				WHERE
					--Process inclusive filter
					1 =
						CASE
							WHEN @filter <> '' THEN
								CASE @filter_type
									WHEN 'session' THEN
										CASE
											WHEN
												CONVERT(SMALLINT, @filter) = 0
												OR sp.spid = CONVERT(SMALLINT, @filter)
													THEN 1
											ELSE 0
										END
									WHEN 'program' THEN
										CASE
											WHEN sp.program_name LIKE @filter THEN 1
											ELSE 0
										END
									WHEN 'login' THEN
										CASE
											WHEN sp.loginame LIKE @filter THEN 1
											ELSE 0
										END
									WHEN 'host' THEN
										CASE
											WHEN sp.hostname LIKE @filter THEN 1
											ELSE 0
										END
									WHEN 'database' THEN
										CASE
											WHEN DB_NAME(sp.dbid) LIKE @filter THEN 1
											ELSE 0
										END
									ELSE 0
								END
							ELSE 1
						END
					--Process exclusive filter
					AND 0 =
						CASE
							WHEN @not_filter <> '' THEN
								CASE @not_filter_type
									WHEN 'session' THEN
										CASE
											WHEN sp.spid = CONVERT(SMALLINT, @not_filter) THEN 1
											ELSE 0
										END
									WHEN 'program' THEN
										CASE
											WHEN sp.program_name LIKE @not_filter THEN 1
											ELSE 0
										END
									WHEN 'login' THEN
										CASE
											WHEN sp.loginame LIKE @not_filter THEN 1
											ELSE 0
										END
									WHEN 'host' THEN
										CASE
											WHEN sp.hostname LIKE @not_filter THEN 1
											ELSE 0
										END
									WHEN 'database' THEN
										CASE
											WHEN DB_NAME(sp.dbid) LIKE @not_filter THEN 1
											ELSE 0
										END
									ELSE 0
								END
							ELSE 0
						END
					AND 
					(
						@show_own_spid = 1
						OR sp.spid <> @@SPID
					)
					AND 
					(
						@show_system_spids = 1
						OR sp.hostprocess > ''
					)
					AND sp.ecid = 0
			) AS s
			INNER HASH JOIN
			(
				SELECT
					x.resource_type,
					x.database_name,
					x.object_id,
					x.file_id,
					CASE
						WHEN x.page_no = 1 OR x.page_no % 8088 = 0 THEN 'PFS'
						WHEN x.page_no = 2 OR x.page_no % 511232 = 0 THEN 'GAM'
						WHEN x.page_no = 3 OR (x.page_no - 1) % 511232 = 0 THEN 'SGAM'
						WHEN x.page_no = 6 OR (x.page_no - 6) % 511232 = 0 THEN 'DCM'
						WHEN x.page_no = 7 OR (x.page_no - 7) % 511232 = 0 THEN 'BCM'
						WHEN x.page_no IS NOT NULL THEN '*'
						ELSE NULL
					END AS page_type,
					x.hobt_id,
					x.allocation_unit_id,
					x.index_id,
					x.schema_id,
					x.principal_id,
					x.request_mode,
					x.request_status,
					x.session_id,
					x.request_id,
					CASE
						WHEN COALESCE(x.object_id, x.file_id, x.hobt_id, x.allocation_unit_id, x.index_id, x.schema_id, x.principal_id) IS NULL THEN NULLIF(resource_description, '')
						ELSE NULL
					END AS resource_description,
					COUNT(*) AS request_count
				FROM
				(
					SELECT
						tl.resource_type +
							CASE
								WHEN tl.resource_subtype = '' THEN ''
								ELSE '.' + tl.resource_subtype
							END AS resource_type,
						COALESCE(DB_NAME(tl.resource_database_id), N'(null)') AS database_name,
						CONVERT
						(
							INT,
							CASE
								WHEN tl.resource_type = 'OBJECT' THEN tl.resource_associated_entity_id
								WHEN tl.resource_description LIKE '%object_id = %' THEN
									(
										SUBSTRING
										(
											tl.resource_description, 
											(CHARINDEX('object_id = ', tl.resource_description) + 12), 
											COALESCE
											(
												NULLIF
												(
													CHARINDEX(',', tl.resource_description, CHARINDEX('object_id = ', tl.resource_description) + 12),
													0
												), 
												DATALENGTH(tl.resource_description)+1
											) - (CHARINDEX('object_id = ', tl.resource_description) + 12)
										)
									)
								ELSE NULL
							END
						) AS object_id,
						CONVERT
						(
							INT,
							CASE 
								WHEN tl.resource_type = 'FILE' THEN CONVERT(INT, tl.resource_description)
								WHEN tl.resource_type IN ('PAGE', 'EXTENT', 'RID') THEN LEFT(tl.resource_description, CHARINDEX(':', tl.resource_description)-1)
								ELSE NULL
							END
						) AS file_id,
						CONVERT
						(
							INT,
							CASE
								WHEN tl.resource_type IN ('PAGE', 'EXTENT', 'RID') THEN 
									SUBSTRING
									(
										tl.resource_description, 
										CHARINDEX(':', tl.resource_description) + 1, 
										COALESCE
										(
											NULLIF
											(
												CHARINDEX(':', tl.resource_description, CHARINDEX(':', tl.resource_description) + 1), 
												0
											), 
											DATALENGTH(tl.resource_description)+1
										) - (CHARINDEX(':', tl.resource_description) + 1)
									)
								ELSE NULL
							END
						) AS page_no,
						CASE
							WHEN tl.resource_type IN ('PAGE', 'KEY', 'RID', 'HOBT') THEN tl.resource_associated_entity_id
							ELSE NULL
						END AS hobt_id,
						CASE
							WHEN tl.resource_type = 'ALLOCATION_UNIT' THEN tl.resource_associated_entity_id
							ELSE NULL
						END AS allocation_unit_id,
						CONVERT
						(
							INT,
							CASE
								WHEN
									/*TODO: Deal with server principals*/ 
									tl.resource_subtype <> 'SERVER_PRINCIPAL' 
									AND tl.resource_description LIKE '%index_id or stats_id = %' THEN
									(
										SUBSTRING
										(
											tl.resource_description, 
											(CHARINDEX('index_id or stats_id = ', tl.resource_description) + 23), 
											COALESCE
											(
												NULLIF
												(
													CHARINDEX(',', tl.resource_description, CHARINDEX('index_id or stats_id = ', tl.resource_description) + 23), 
													0
												), 
												DATALENGTH(tl.resource_description)+1
											) - (CHARINDEX('index_id or stats_id = ', tl.resource_description) + 23)
										)
									)
								ELSE NULL
							END 
						) AS index_id,
						CONVERT
						(
							INT,
							CASE
								WHEN tl.resource_description LIKE '%schema_id = %' THEN
									(
										SUBSTRING
										(
											tl.resource_description, 
											(CHARINDEX('schema_id = ', tl.resource_description) + 12), 
											COALESCE
											(
												NULLIF
												(
													CHARINDEX(',', tl.resource_description, CHARINDEX('schema_id = ', tl.resource_description) + 12), 
													0
												), 
												DATALENGTH(tl.resource_description)+1
											) - (CHARINDEX('schema_id = ', tl.resource_description) + 12)
										)
									)
								ELSE NULL
							END 
						) AS schema_id,
						CONVERT
						(
							INT,
							CASE
								WHEN tl.resource_description LIKE '%principal_id = %' THEN
									(
										SUBSTRING
										(
											tl.resource_description, 
											(CHARINDEX('principal_id = ', tl.resource_description) + 15), 
											COALESCE
											(
												NULLIF
												(
													CHARINDEX(',', tl.resource_description, CHARINDEX('principal_id = ', tl.resource_description) + 15), 
													0
												), 
												DATALENGTH(tl.resource_description)+1
											) - (CHARINDEX('principal_id = ', tl.resource_description) + 15)
										)
									)
								ELSE NULL
							END
						) AS principal_id,
						tl.request_mode,
						tl.request_status,
						tl.request_session_id AS session_id,
						tl.request_request_id AS request_id,

						/*TODO: Applocks, other resource_descriptions*/
						RTRIM(tl.resource_description) AS resource_description,
						tl.resource_associated_entity_id
						/*********************************************/
					FROM 
					(
						SELECT 
							request_session_id,
							CONVERT(VARCHAR(120), resource_type) COLLATE Latin1_General_Bin2 AS resource_type,
							CONVERT(VARCHAR(120), resource_subtype) COLLATE Latin1_General_Bin2 AS resource_subtype,
							resource_database_id,
							CONVERT(VARCHAR(512), resource_description) COLLATE Latin1_General_Bin2 AS resource_description,
							resource_associated_entity_id,
							CONVERT(VARCHAR(120), request_mode) COLLATE Latin1_General_Bin2 AS request_mode,
							CONVERT(VARCHAR(120), request_status) COLLATE Latin1_General_Bin2 AS request_status,
							request_request_id
						FROM sys.dm_tran_locks
					) AS tl
				) AS x
				GROUP BY
					x.resource_type,
					x.database_name,
					x.object_id,
					x.file_id,
					CASE
						WHEN x.page_no = 1 OR x.page_no % 8088 = 0 THEN 'PFS'
						WHEN x.page_no = 2 OR x.page_no % 511232 = 0 THEN 'GAM'
						WHEN x.page_no = 3 OR (x.page_no - 1) % 511232 = 0 THEN 'SGAM'
						WHEN x.page_no = 6 OR (x.page_no - 6) % 511232 = 0 THEN 'DCM'
						WHEN x.page_no = 7 OR (x.page_no - 7) % 511232 = 0 THEN 'BCM'
						WHEN x.page_no IS NOT NULL THEN '*'
						ELSE NULL
					END,
					x.hobt_id,
					x.allocation_unit_id,
					x.index_id,
					x.schema_id,
					x.principal_id,
					x.request_mode,
					x.request_status,
					x.session_id,
					x.request_id,
					CASE
						WHEN COALESCE(x.object_id, x.file_id, x.hobt_id, x.allocation_unit_id, x.index_id, x.schema_id, x.principal_id) IS NULL THEN NULLIF(resource_description, '')
						ELSE NULL
					END
			) AS y ON
				y.session_id = s.session_id
				AND y.request_id = s.request_id
			OPTION (HASH GROUP);

			--Disable unnecessary autostats on the table
			CREATE STATISTICS s_database_name ON #locks (database_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_object_id ON #locks (object_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_hobt_id ON #locks (hobt_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_allocation_unit_id ON #locks (allocation_unit_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_index_id ON #locks (index_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_schema_id ON #locks (schema_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_principal_id ON #locks (principal_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_request_id ON #locks (request_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_start_time ON #locks (start_time)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_resource_type ON #locks (resource_type)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_object_name ON #locks (object_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_schema_name ON #locks (schema_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_page_type ON #locks (page_type)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_request_mode ON #locks (request_mode)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_request_status ON #locks (request_status)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_resource_description ON #locks (resource_description)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_index_name ON #locks (index_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_principal_name ON #locks (principal_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
		END;
		
		DECLARE 
			@sql VARCHAR(MAX), 
			@sql_n NVARCHAR(MAX);

		SET @sql = 
			CONVERT(VARCHAR(MAX), '') +
			'DECLARE @blocker BIT;
			SET @blocker = 0;
			DECLARE @i INT;
			SET @i = 2147483647;

			DECLARE @sessions TABLE
			(
				session_id SMALLINT NOT NULL,
				request_id INT NOT NULL,
				login_time DATETIME,
				last_request_end_time DATETIME,
				status VARCHAR(30),
				statement_start_offset INT,
				statement_end_offset INT,
				sql_handle BINARY(20),
				host_name NVARCHAR(128),
				login_name NVARCHAR(128),
				program_name NVARCHAR(128),
				database_id SMALLINT,
				memory_usage INT,
				open_tran_count SMALLINT, 
				' +
				CASE
					WHEN 
					(
						@get_task_info <> 0 
						OR @find_block_leaders = 1 
					) THEN
						'wait_type NVARCHAR(32),
						wait_resource NVARCHAR(256),
						wait_time BIGINT, 
						'
					ELSE 
						''
				END +
				'blocked SMALLINT,
				is_user_process BIT,
				cmd VARCHAR(32),
				PRIMARY KEY CLUSTERED (session_id, request_id) WITH (IGNORE_DUP_KEY = ON)
			);

			DECLARE @blockers TABLE
			(
				session_id INT NOT NULL PRIMARY KEY WITH (IGNORE_DUP_KEY = ON)
			);

			BLOCKERS:;

			INSERT @sessions
			(
				session_id,
				request_id,
				login_time,
				last_request_end_time,
				status,
				statement_start_offset,
				statement_end_offset,
				sql_handle,
				host_name,
				login_name,
				program_name,
				database_id,
				memory_usage,
				open_tran_count, 
				' +
				CASE
					WHEN 
					(
						@get_task_info <> 0
						OR @find_block_leaders = 1 
					) THEN
						'wait_type,
						wait_resource,
						wait_time, 
						'
					ELSE
						''
				END +
				'blocked,
				is_user_process,
				cmd 
			)
			SELECT TOP(@i)
				spy.session_id,
				spy.request_id,
				spy.login_time,
				spy.last_request_end_time,
				spy.status,
				spy.statement_start_offset,
				spy.statement_end_offset,
				spy.sql_handle,
				spy.host_name,
				spy.login_name,
				spy.program_name,
				spy.database_id,
				spy.memory_usage,
				spy.open_tran_count,
				' +
				CASE
					WHEN 
					(
						@get_task_info <> 0  
						OR @find_block_leaders = 1 
					) THEN
						'spy.wait_type,
						CASE
							WHEN
								spy.wait_type LIKE N''PAGE%LATCH_%''
								OR spy.wait_type = N''CXPACKET''
								OR spy.wait_type LIKE N''LATCH[_]%''
								OR spy.wait_type = N''OLEDB'' THEN
									spy.wait_resource
							ELSE
								NULL
						END AS wait_resource,
						spy.wait_time, 
						'
					ELSE
						''
				END +
				'spy.blocked,
				spy.is_user_process,
				spy.cmd
			FROM
			(
				SELECT TOP(@i)
					spx.*, 
					' +
					CASE
						WHEN 
						(
							@get_task_info <> 0 
							OR @find_block_leaders = 1 
						) THEN
							'ROW_NUMBER() OVER
							(
								PARTITION BY
									spx.session_id,
									spx.request_id
								ORDER BY
									CASE
										WHEN spx.wait_type LIKE N''LCK[_]%'' THEN 
											1
										ELSE
											99
									END,
									spx.wait_time DESC,
									spx.blocked DESC
							) AS r 
							'
						ELSE 
							'1 AS r 
							'
					END +
				'FROM
				(
					SELECT TOP(@i)
						sp0.session_id,
						sp0.request_id,
						sp0.login_time,
						sp0.last_request_end_time,
						LOWER(sp0.status) AS status,
						CASE
							WHEN sp0.cmd = ''CREATE INDEX'' THEN
								0
							ELSE
								sp0.stmt_start
						END AS statement_start_offset,
						CASE
							WHEN sp0.cmd = N''CREATE INDEX'' THEN
								-1
							ELSE
								COALESCE(NULLIF(sp0.stmt_end, 0), -1)
						END AS statement_end_offset,
						sp0.sql_handle,
						sp0.host_name,
						sp0.login_name,
						sp0.program_name,
						sp0.database_id,
						sp0.memory_usage,
						sp0.open_tran_count, 
						' +
						CASE
							WHEN 
							(
								@get_task_info <> 0 
								OR @find_block_leaders = 1 
							) THEN
								'CASE
									WHEN sp0.wait_time > 0 AND sp0.wait_type <> N''CXPACKET'' THEN
										sp0.wait_type
									ELSE
										NULL
								END AS wait_type,
								CASE
									WHEN sp0.wait_time > 0 AND sp0.wait_type <> N''CXPACKET'' THEN 
										sp0.wait_resource
									ELSE
										NULL
								END AS wait_resource,
								CASE
									WHEN sp0.wait_type <> N''CXPACKET'' THEN
										sp0.wait_time
									ELSE
										0
								END AS wait_time, 
								'
							ELSE
								''
						END +
						'sp0.blocked,
						sp0.is_user_process,
						sp0.cmd
					FROM
					(
						SELECT TOP(@i)
							sp1.session_id,
							sp1.request_id,
							sp1.login_time,
							sp1.last_request_end_time,
							sp1.status,
							sp1.cmd,
							sp1.stmt_start,
							sp1.stmt_end,
							MAX(NULLIF(sp1.sql_handle, 0x00)) OVER (PARTITION BY sp1.session_id, sp1.request_id) AS sql_handle,
							sp1.host_name,
							MAX(sp1.login_name) OVER (PARTITION BY sp1.session_id, sp1.request_id) AS login_name,
							sp1.program_name,
							sp1.database_id,
							MAX(sp1.memory_usage)  OVER (PARTITION BY sp1.session_id, sp1.request_id) AS memory_usage,
							MAX(sp1.open_tran_count)  OVER (PARTITION BY sp1.session_id, sp1.request_id) AS open_tran_count,
							sp1.wait_type,
							sp1.wait_resource,
							sp1.wait_time,
							sp1.blocked,
							sp1.hostprocess,
							sp1.is_user_process
						FROM
						(
							SELECT TOP(@i)
								sp2.spid AS session_id,
								CASE sp2.status
									WHEN ''sleeping'' THEN
										CONVERT(INT, 0)
									ELSE
										sp2.request_id
								END AS request_id,
								MAX(sp2.login_time) AS login_time,
								MAX(sp2.last_batch) AS last_request_end_time,
								MAX(CONVERT(VARCHAR(30), RTRIM(sp2.status)) COLLATE Latin1_General_Bin2) AS status,
								MAX(CONVERT(VARCHAR(32), RTRIM(sp2.cmd)) COLLATE Latin1_General_Bin2) AS cmd,
								MAX(sp2.stmt_start) AS stmt_start,
								MAX(sp2.stmt_end) AS stmt_end,
								MAX(sp2.sql_handle) AS sql_handle,
								MAX(CONVERT(sysname, RTRIM(sp2.hostname)) COLLATE SQL_Latin1_General_CP1_CI_AS) AS host_name,
								MAX(CONVERT(sysname, RTRIM(sp2.loginame)) COLLATE SQL_Latin1_General_CP1_CI_AS) AS login_name,
								MAX
								(
									CASE
										WHEN blk.queue_id IS NOT NULL THEN
											N''Service Broker
												database_id: '' + CONVERT(NVARCHAR, blk.database_id) +
												N'' queue_id: '' + CONVERT(NVARCHAR, blk.queue_id)
										ELSE
											CONVERT
											(
												sysname,
												RTRIM(sp2.program_name)
											)
									END COLLATE SQL_Latin1_General_CP1_CI_AS
								) AS program_name,
								MAX(sp2.dbid) AS database_id,
								MAX(sp2.memusage) AS memory_usage,
								MAX(sp2.open_tran) AS open_tran_count,
								RTRIM(sp2.lastwaittype) AS wait_type,
								RTRIM(sp2.waitresource) AS wait_resource,
								MAX(sp2.waittime) AS wait_time,
								COALESCE(NULLIF(sp2.blocked, sp2.spid), 0) AS blocked,
								MAX
								(
									CASE
										WHEN blk.session_id = sp2.spid THEN
											''blocker''
										ELSE
											RTRIM(sp2.hostprocess)
									END
								) AS hostprocess,
								CONVERT
								(
									BIT,
									MAX
									(
										CASE
											WHEN sp2.hostprocess > '''' THEN
												1
											ELSE
												0
										END
									)
								) AS is_user_process
							FROM
							(
								SELECT TOP(@i)
									session_id,
									CONVERT(INT, NULL) AS queue_id,
									CONVERT(INT, NULL) AS database_id
								FROM @blockers

								UNION ALL

								SELECT TOP(@i)
									CONVERT(SMALLINT, 0),
									CONVERT(INT, NULL) AS queue_id,
									CONVERT(INT, NULL) AS database_id
								WHERE
									@blocker = 0

								UNION ALL

								SELECT TOP(@i)
									CONVERT(SMALLINT, spid),
									queue_id,
									database_id
								FROM sys.dm_broker_activated_tasks
								WHERE
									@blocker = 0
							) AS blk
							INNER JOIN sys.sysprocesses AS sp2 ON
								sp2.spid = blk.session_id
								OR
								(
									blk.session_id = 0
									AND @blocker = 0
								)
							' +
							CASE 
								WHEN 
								(
									@get_task_info = 0 
									AND @find_block_leaders = 0
								) THEN
									'WHERE
										sp2.ecid = 0 
									' 
								ELSE
									''
							END +
							'GROUP BY
								sp2.spid,
								CASE sp2.status
									WHEN ''sleeping'' THEN
										CONVERT(INT, 0)
									ELSE
										sp2.request_id
								END,
								RTRIM(sp2.lastwaittype),
								RTRIM(sp2.waitresource),
								COALESCE(NULLIF(sp2.blocked, sp2.spid), 0)
						) AS sp1
					) AS sp0
					WHERE
						@blocker = 1
						OR
						(1=1 
						' +
							--inclusive filter
							CASE
								WHEN @filter <> '' THEN
									CASE @filter_type
										WHEN 'session' THEN
											CASE
												WHEN CONVERT(SMALLINT, @filter) <> 0 THEN
													'AND sp0.session_id = CONVERT(SMALLINT, @filter) 
													'
												ELSE
													''
											END
										WHEN 'program' THEN
											'AND sp0.program_name LIKE @filter 
											'
										WHEN 'login' THEN
											'AND sp0.login_name LIKE @filter 
											'
										WHEN 'host' THEN
											'AND sp0.host_name LIKE @filter 
											'
										WHEN 'database' THEN
											'AND DB_NAME(sp0.database_id) LIKE @filter 
											'
										ELSE
											''
									END
								ELSE
									''
							END +
							--exclusive filter
							CASE
								WHEN @not_filter <> '' THEN
									CASE @not_filter_type
										WHEN 'session' THEN
											CASE
												WHEN CONVERT(SMALLINT, @not_filter) <> 0 THEN
													'AND sp0.session_id <> CONVERT(SMALLINT, @not_filter) 
													'
												ELSE
													''
											END
										WHEN 'program' THEN
											'AND sp0.program_name NOT LIKE @not_filter 
											'
										WHEN 'login' THEN
											'AND sp0.login_name NOT LIKE @not_filter 
											'
										WHEN 'host' THEN
											'AND sp0.host_name NOT LIKE @not_filter 
											'
										WHEN 'database' THEN
											'AND DB_NAME(sp0.database_id) NOT LIKE @not_filter 
											'
										ELSE
											''
									END
								ELSE
									''
							END +
							CASE @show_own_spid
								WHEN 1 THEN
									''
								ELSE
									'AND sp0.session_id <> @@spid 
									'
							END +
							CASE 
								WHEN @show_system_spids = 0 THEN
									'AND sp0.hostprocess > '''' 
									' 
								ELSE
									''
							END +
							CASE @show_sleeping_spids
								WHEN 0 THEN
									'AND sp0.status <> ''sleeping'' 
									'
								WHEN 1 THEN
									'AND
									(
										sp0.status <> ''sleeping''
										OR sp0.open_tran_count > 0
									)
									'
								ELSE
									''
							END +
						')
				) AS spx
			) AS spy
			WHERE
				spy.r = 1; 
			' + 
			CASE @recursion
				WHEN 1 THEN 
					'IF @@ROWCOUNT > 0
					BEGIN;
						INSERT @blockers
						(
							session_id
						)
						SELECT TOP(@i)
							blocked
						FROM @sessions
						WHERE
							NULLIF(blocked, 0) IS NOT NULL

						EXCEPT

						SELECT TOP(@i)
							session_id
						FROM @sessions; 
						' +

						CASE
							WHEN
							(
								@get_task_info > 0
								OR @find_block_leaders = 1
							) THEN
								'IF @@ROWCOUNT > 0
								BEGIN;
									SET @blocker = 1;
									GOTO BLOCKERS;
								END; 
								'
							ELSE 
								''
						END +
					'END; 
					'
				ELSE 
					''
			END +
			'SELECT TOP(@i)
				@recursion AS recursion,
				x.session_id,
				x.request_id,
				DENSE_RANK() OVER
				(
					ORDER BY
						x.session_id
				) AS session_number,
				' +
				CASE
					WHEN @output_column_list LIKE '%|[dd hh:mm:ss.mss|]%' ESCAPE '|' THEN 
						'x.elapsed_time '
					ELSE 
						'0 '
				END + 
					'AS elapsed_time, 
					' +
				CASE
					WHEN
						(
							@output_column_list LIKE '%|[dd hh:mm:ss.mss (avg)|]%' ESCAPE '|' OR 
							@output_column_list LIKE '%|[avg_elapsed_time|]%' ESCAPE '|'
						)
						AND @recursion = 1
							THEN 
								'x.avg_elapsed_time / 1000 '
					ELSE 
						'NULL '
				END + 
					'AS avg_elapsed_time, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[physical_io|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[physical_io_delta|]%' ESCAPE '|'
							THEN 
								'x.physical_io '
					ELSE 
						'NULL '
				END + 
					'AS physical_io, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[reads|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[reads_delta|]%' ESCAPE '|'
							THEN 
								'x.reads '
					ELSE 
						'0 '
				END + 
					'AS reads, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[physical_reads|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[physical_reads_delta|]%' ESCAPE '|'
							THEN 
								'x.physical_reads '
					ELSE 
						'0 '
				END + 
					'AS physical_reads, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[writes|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[writes_delta|]%' ESCAPE '|'
							THEN 
								'x.writes '
					ELSE 
						'0 '
				END + 
					'AS writes, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[tempdb_allocations|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[tempdb_allocations_delta|]%' ESCAPE '|'
							THEN 
								'x.tempdb_allocations '
					ELSE 
						'0 '
				END + 
					'AS tempdb_allocations, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[tempdb_current|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[tempdb_current_delta|]%' ESCAPE '|'
							THEN 
								'x.tempdb_current '
					ELSE 
						'0 '
				END + 
					'AS tempdb_current, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[CPU|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[CPU_delta|]%' ESCAPE '|'
							THEN
								'x.CPU '
					ELSE
						'0 '
				END + 
					'AS CPU, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[CPU_delta|]%' ESCAPE '|'
						AND @get_task_info = 2
						AND @sys_info = 1
							THEN 
								'x.thread_CPU_snapshot '
					ELSE 
						'0 '
				END + 
					'AS thread_CPU_snapshot, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[context_switches|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[context_switches_delta|]%' ESCAPE '|'
							THEN 
								'x.context_switches '
					ELSE 
						'NULL '
				END + 
					'AS context_switches, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[used_memory|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[used_memory_delta|]%' ESCAPE '|'
							THEN 
								'x.used_memory '
					ELSE 
						'0 '
				END + 
					'AS used_memory, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[tasks|]%' ESCAPE '|'
						AND @recursion = 1
							THEN 
								'x.tasks '
					ELSE 
						'NULL '
				END + 
					'AS tasks, 
					' +
				CASE
					WHEN 
						(
							@output_column_list LIKE '%|[status|]%' ESCAPE '|' 
							OR @output_column_list LIKE '%|[sql_command|]%' ESCAPE '|'
						)
						AND @recursion = 1
							THEN 
								'x.status '
					ELSE 
						''''' '
				END + 
					'AS status, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[wait_info|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								CASE @get_task_info
									WHEN 2 THEN
										'COALESCE(x.task_wait_info, x.sys_wait_info) '
									ELSE
										'x.sys_wait_info '
								END
					ELSE 
						'NULL '
				END + 
					'AS wait_info, 
					' +
				CASE
					WHEN 
						(
							@output_column_list LIKE '%|[tran_start_time|]%' ESCAPE '|' 
							OR @output_column_list LIKE '%|[tran_log_writes|]%' ESCAPE '|' 
						)
						AND @recursion = 1
							THEN 
								'x.transaction_id '
					ELSE 
						'NULL '
				END + 
					'AS transaction_id, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[open_tran_count|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.open_tran_count '
					ELSE 
						'NULL '
				END + 
					'AS open_tran_count, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[sql_text|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.sql_handle '
					ELSE 
						'NULL '
				END + 
					'AS sql_handle, 
					' +
				CASE
					WHEN 
						(
							@output_column_list LIKE '%|[sql_text|]%' ESCAPE '|' 
							OR @output_column_list LIKE '%|[query_plan|]%' ESCAPE '|' 
						)
						AND @recursion = 1
							THEN 
								'x.statement_start_offset '
					ELSE 
						'NULL '
				END + 
					'AS statement_start_offset, 
					' +
				CASE
					WHEN 
						(
							@output_column_list LIKE '%|[sql_text|]%' ESCAPE '|' 
							OR @output_column_list LIKE '%|[query_plan|]%' ESCAPE '|' 
						)
						AND @recursion = 1
							THEN 
								'x.statement_end_offset '
					ELSE 
						'NULL '
				END + 
					'AS statement_end_offset, 
					' +
				'NULL AS sql_text, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[query_plan|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.plan_handle '
					ELSE 
						'NULL '
				END + 
					'AS plan_handle, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[blocking_session_id|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'NULLIF(x.blocking_session_id, 0) '
					ELSE 
						'NULL '
				END + 
					'AS blocking_session_id, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[percent_complete|]%' ESCAPE '|'
						AND @recursion = 1
							THEN 
								'x.percent_complete '
					ELSE 
						'NULL '
				END + 
					'AS percent_complete, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[host_name|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.host_name '
					ELSE 
						''''' '
				END + 
					'AS host_name, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[login_name|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.login_name '
					ELSE 
						''''' '
				END + 
					'AS login_name, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[database_name|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'DB_NAME(x.database_id) '
					ELSE 
						'NULL '
				END + 
					'AS database_name, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[program_name|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.program_name '
					ELSE 
						''''' '
				END + 
					'AS program_name, 
					' +
				CASE
					WHEN
						@output_column_list LIKE '%|[additional_info|]%' ESCAPE '|'
						AND @recursion = 1
							THEN
								'(
									SELECT TOP(@i)
										x.text_size,
										x.language,
										x.date_format,
										x.date_first,
										CASE x.quoted_identifier
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS quoted_identifier,
										CASE x.arithabort
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS arithabort,
										CASE x.ansi_null_dflt_on
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS ansi_null_dflt_on,
										CASE x.ansi_defaults
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS ansi_defaults,
										CASE x.ansi_warnings
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS ansi_warnings,
										CASE x.ansi_padding
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS ansi_padding,
										CASE ansi_nulls
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS ansi_nulls,
										CASE x.concat_null_yields_null
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS concat_null_yields_null,
										CASE x.transaction_isolation_level
											WHEN 0 THEN ''Unspecified''
											WHEN 1 THEN ''ReadUncomitted''
											WHEN 2 THEN ''ReadCommitted''
											WHEN 3 THEN ''Repeatable''
											WHEN 4 THEN ''Serializable''
											WHEN 5 THEN ''Snapshot''
										END AS transaction_isolation_level,
										x.lock_timeout,
										x.deadlock_priority,
										x.row_count,
										x.command_type, 
										' +
										CASE
											WHEN OBJECT_ID('master.dbo.fn_varbintohexstr') IS NOT NULL THEN
												'master.dbo.fn_varbintohexstr(x.sql_handle) AS sql_handle,
												master.dbo.fn_varbintohexstr(x.plan_handle) AS plan_handle,'
											ELSE
												'CONVERT(VARCHAR(256), x.sql_handle, 1) AS sql_handle,
												CONVERT(VARCHAR(256), x.plan_handle, 1) AS plan_handle,'
										END +
										'
										x.statement_start_offset,
										x.statement_end_offset,
										' +
										CASE
											WHEN @output_column_list LIKE '%|[program_name|]%' ESCAPE '|' THEN
												'(
													SELECT TOP(1)
														CONVERT(uniqueidentifier, CONVERT(XML, '''').value(''xs:hexBinary( substring(sql:column("agent_info.job_id_string"), 0) )'', ''binary(16)'')) AS job_id,
														agent_info.step_id,
														(
															SELECT TOP(1)
																NULL
															FOR XML
																PATH(''job_name''),
																TYPE
														),
														(
															SELECT TOP(1)
																NULL
															FOR XML
																PATH(''step_name''),
																TYPE
														)
													FROM
													(
														SELECT TOP(1)
															SUBSTRING(x.program_name, CHARINDEX(''0x'', x.program_name) + 2, 32) AS job_id_string,
															SUBSTRING(x.program_name, CHARINDEX('': Step '', x.program_name) + 7, CHARINDEX('')'', x.program_name, CHARINDEX('': Step '', x.program_name)) - (CHARINDEX('': Step '', x.program_name) + 7)) AS step_id
														WHERE
															x.program_name LIKE N''SQLAgent - TSQL JobStep (Job 0x%''
													) AS agent_info
													FOR XML
														PATH(''agent_job_info''),
														TYPE
												),
												'
											ELSE ''
										END +
										CASE
											WHEN @get_task_info = 2 THEN
												'CONVERT(XML, x.block_info) AS block_info, 
												'
											ELSE
												''
										END + '
										x.host_process_id,
										x.group_id
									FOR XML
										PATH(''additional_info''),
										TYPE
								) '
					ELSE
						'NULL '
				END + 
					'AS additional_info, 
				x.start_time, 
					' +
				CASE
					WHEN
						@output_column_list LIKE '%|[login_time|]%' ESCAPE '|'
						AND @recursion = 1
							THEN
								'x.login_time '
					ELSE 
						'NULL '
				END + 
					'AS login_time, 
				x.last_request_start_time
			FROM
			(
				SELECT TOP(@i)
					y.*,
					CASE
						WHEN DATEDIFF(hour, y.start_time, GETDATE()) > 576 THEN
							DATEDIFF(second, GETDATE(), y.start_time)
						ELSE DATEDIFF(ms, y.start_time, GETDATE())
					END AS elapsed_time,
					COALESCE(tempdb_info.tempdb_allocations, 0) AS tempdb_allocations,
					COALESCE
					(
						CASE
							WHEN tempdb_info.tempdb_current < 0 THEN 0
							ELSE tempdb_info.tempdb_current
						END,
						0
					) AS tempdb_current, 
					' +
					CASE
						WHEN 
							(
								@get_task_info <> 0
								OR @find_block_leaders = 1
							) THEN
								'N''('' + CONVERT(NVARCHAR, y.wait_duration_ms) + N''ms)'' +
									y.wait_type +
										CASE
											WHEN y.wait_type LIKE N''PAGE%LATCH_%'' THEN
												N'':'' +
												COALESCE(DB_NAME(CONVERT(INT, LEFT(y.resource_description, CHARINDEX(N'':'', y.resource_description) - 1))), N''(null)'') +
												N'':'' +
												SUBSTRING(y.resource_description, CHARINDEX(N'':'', y.resource_description) + 1, LEN(y.resource_description) - CHARINDEX(N'':'', REVERSE(y.resource_description)) - CHARINDEX(N'':'', y.resource_description)) +
												N''('' +
													CASE
														WHEN
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) = 1 OR
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) % 8088 = 0
																THEN 
																	N''PFS''
														WHEN
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) = 2 OR
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) % 511232 = 0
																THEN 
																	N''GAM''
														WHEN
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) = 3 OR
															(CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) - 1) % 511232 = 0
																THEN
																	N''SGAM''
														WHEN
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) = 6 OR
															(CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) - 6) % 511232 = 0 
																THEN 
																	N''DCM''
														WHEN
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) = 7 OR
															(CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) - 7) % 511232 = 0 
																THEN 
																	N''BCM''
														ELSE 
															N''*''
													END +
												N'')''
											WHEN y.wait_type = N''CXPACKET'' THEN
												N'':'' + SUBSTRING(y.resource_description, CHARINDEX(N''nodeId'', y.resource_description) + 7, 4)
											WHEN y.wait_type LIKE N''LATCH[_]%'' THEN
												N'' ['' + LEFT(y.resource_description, COALESCE(NULLIF(CHARINDEX(N'' '', y.resource_description), 0), LEN(y.resource_description) + 1) - 1) + N'']''
											WHEN
												y.wait_type = N''OLEDB''
												AND y.resource_description LIKE N''%(SPID=%)'' THEN
													N''['' + LEFT(y.resource_description, CHARINDEX(N''(SPID='', y.resource_description) - 2) +
														N'':'' + SUBSTRING(y.resource_description, CHARINDEX(N''(SPID='', y.resource_description) + 6, CHARINDEX(N'')'', y.resource_description, (CHARINDEX(N''(SPID='', y.resource_description) + 6)) - (CHARINDEX(N''(SPID='', y.resource_description) + 6)) + '']''
											ELSE
												N''''
										END COLLATE Latin1_General_Bin2 AS sys_wait_info, 
										'
							ELSE
								''
						END +
						CASE
							WHEN @get_task_info = 2 THEN
								'tasks.physical_io,
								tasks.context_switches,
								tasks.tasks,
								tasks.block_info,
								tasks.wait_info AS task_wait_info,
								tasks.thread_CPU_snapshot,
								'
							ELSE
								'' 
					END +
					CASE 
						WHEN NOT (@get_avg_time = 1 AND @recursion = 1) THEN
							'CONVERT(INT, NULL) '
						ELSE 
							'qs.total_elapsed_time / qs.execution_count '
					END + 
						'AS avg_elapsed_time 
				FROM
				(
					SELECT TOP(@i)
						sp.session_id,
						sp.request_id,
						COALESCE(r.logical_reads, s.logical_reads) AS reads,
						COALESCE(r.reads, s.reads) AS physical_reads,
						COALESCE(r.writes, s.writes) AS writes,
						COALESCE(r.CPU_time, s.CPU_time) AS CPU,
						sp.memory_usage + COALESCE(r.granted_query_memory, 0) AS used_memory,
						LOWER(sp.status) AS status,
						COALESCE(r.sql_handle, sp.sql_handle) AS sql_handle,
						COALESCE(r.statement_start_offset, sp.statement_start_offset) AS statement_start_offset,
						COALESCE(r.statement_end_offset, sp.statement_end_offset) AS statement_end_offset,
						' +
						CASE
							WHEN 
							(
								@get_task_info <> 0
								OR @find_block_leaders = 1 
							) THEN
								'sp.wait_type COLLATE Latin1_General_Bin2 AS wait_type,
								sp.wait_resource COLLATE Latin1_General_Bin2 AS resource_description,
								sp.wait_time AS wait_duration_ms, 
								'
							ELSE
								''
						END +
						'NULLIF(sp.blocked, 0) AS blocking_session_id,
						r.plan_handle,
						NULLIF(r.percent_complete, 0) AS percent_complete,
						sp.host_name,
						sp.login_name,
						sp.program_name,
						s.host_process_id,
						COALESCE(r.text_size, s.text_size) AS text_size,
						COALESCE(r.language, s.language) AS language,
						COALESCE(r.date_format, s.date_format) AS date_format,
						COALESCE(r.date_first, s.date_first) AS date_first,
						COALESCE(r.quoted_identifier, s.quoted_identifier) AS quoted_identifier,
						COALESCE(r.arithabort, s.arithabort) AS arithabort,
						COALESCE(r.ansi_null_dflt_on, s.ansi_null_dflt_on) AS ansi_null_dflt_on,
						COALESCE(r.ansi_defaults, s.ansi_defaults) AS ansi_defaults,
						COALESCE(r.ansi_warnings, s.ansi_warnings) AS ansi_warnings,
						COALESCE(r.ansi_padding, s.ansi_padding) AS ansi_padding,
						COALESCE(r.ansi_nulls, s.ansi_nulls) AS ansi_nulls,
						COALESCE(r.concat_null_yields_null, s.concat_null_yields_null) AS concat_null_yields_null,
						COALESCE(r.transaction_isolation_level, s.transaction_isolation_level) AS transaction_isolation_level,
						COALESCE(r.lock_timeout, s.lock_timeout) AS lock_timeout,
						COALESCE(r.deadlock_priority, s.deadlock_priority) AS deadlock_priority,
						COALESCE(r.row_count, s.row_count) AS row_count,
						COALESCE(r.command, sp.cmd) AS command_type,
						COALESCE
						(
							CASE
								WHEN
								(
									s.is_user_process = 0
									AND r.total_elapsed_time >= 0
								) THEN
									DATEADD
									(
										ms,
										1000 * (DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())) / 500) - DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())),
										DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())
									)
							END,
							NULLIF(COALESCE(r.start_time, sp.last_request_end_time), CONVERT(DATETIME, ''19000101'', 112)),
							sp.login_time
						) AS start_time,
						sp.login_time,
						CASE
							WHEN s.is_user_process = 1 THEN
								s.last_request_start_time
							ELSE
								COALESCE
								(
									DATEADD
									(
										ms,
										1000 * (DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())) / 500) - DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())),
										DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())
									),
									s.last_request_start_time
								)
						END AS last_request_start_time,
						r.transaction_id,
						sp.database_id,
						sp.open_tran_count,
						' +
							CASE
								WHEN EXISTS
								(
									SELECT
										*
									FROM sys.all_columns AS ac
									WHERE
										ac.object_id = OBJECT_ID('sys.dm_exec_sessions')
										AND ac.name = 'group_id'
								)
									THEN 's.group_id'
								ELSE 'CONVERT(INT, NULL) AS group_id'
							END + '
					FROM @sessions AS sp
					LEFT OUTER LOOP JOIN sys.dm_exec_sessions AS s ON
						s.session_id = sp.session_id
						AND s.login_time = sp.login_time
					LEFT OUTER LOOP JOIN sys.dm_exec_requests AS r ON
						sp.status <> ''sleeping''
						AND r.session_id = sp.session_id
						AND r.request_id = sp.request_id
						AND
						(
							(
								s.is_user_process = 0
								AND sp.is_user_process = 0
							)
							OR
							(
								r.start_time = s.last_request_start_time
								AND s.last_request_end_time <= sp.last_request_end_time
							)
						)
				) AS y
				' + 
				CASE 
					WHEN @get_task_info = 2 THEN
						CONVERT(VARCHAR(MAX), '') +
						'LEFT OUTER HASH JOIN
						(
							SELECT TOP(@i)
								task_nodes.task_node.value(''(session_id/text())[1]'', ''SMALLINT'') AS session_id,
								task_nodes.task_node.value(''(request_id/text())[1]'', ''INT'') AS request_id,
								task_nodes.task_node.value(''(physical_io/text())[1]'', ''BIGINT'') AS physical_io,
								task_nodes.task_node.value(''(context_switches/text())[1]'', ''BIGINT'') AS context_switches,
								task_nodes.task_node.value(''(tasks/text())[1]'', ''INT'') AS tasks,
								task_nodes.task_node.value(''(block_info/text())[1]'', ''NVARCHAR(4000)'') AS block_info,
								task_nodes.task_node.value(''(waits/text())[1]'', ''NVARCHAR(4000)'') AS wait_info,
								task_nodes.task_node.value(''(thread_CPU_snapshot/text())[1]'', ''BIGINT'') AS thread_CPU_snapshot
							FROM
							(
								SELECT TOP(@i)
									CONVERT
									(
										XML,
										REPLACE
										(
											CONVERT(NVARCHAR(MAX), tasks_raw.task_xml_raw) COLLATE Latin1_General_Bin2,
											N''</waits></tasks><tasks><waits>'',
											N'', ''
										)
									) AS task_xml
								FROM
								(
									SELECT TOP(@i)
										CASE waits.r
											WHEN 1 THEN
												waits.session_id
											ELSE
												NULL
										END AS [session_id],
										CASE waits.r
											WHEN 1 THEN
												waits.request_id
											ELSE
												NULL
										END AS [request_id],											
										CASE waits.r
											WHEN 1 THEN
												waits.physical_io
											ELSE
												NULL
										END AS [physical_io],
										CASE waits.r
											WHEN 1 THEN
												waits.context_switches
											ELSE
												NULL
										END AS [context_switches],
										CASE waits.r
											WHEN 1 THEN
												waits.thread_CPU_snapshot
											ELSE
												NULL
										END AS [thread_CPU_snapshot],
										CASE waits.r
											WHEN 1 THEN
												waits.tasks
											ELSE
												NULL
										END AS [tasks],
										CASE waits.r
											WHEN 1 THEN
												waits.block_info
											ELSE
												NULL
										END AS [block_info],
										REPLACE
										(
											REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
											REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
											REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
												CONVERT
												(
													NVARCHAR(MAX),
													N''('' +
														CONVERT(NVARCHAR, num_waits) + N''x: '' +
														CASE num_waits
															WHEN 1 THEN
																CONVERT(NVARCHAR, min_wait_time) + N''ms''
															WHEN 2 THEN
																CASE
																	WHEN min_wait_time <> max_wait_time THEN
																		CONVERT(NVARCHAR, min_wait_time) + N''/'' + CONVERT(NVARCHAR, max_wait_time) + N''ms''
																	ELSE
																		CONVERT(NVARCHAR, max_wait_time) + N''ms''
																END
															ELSE
																CASE
																	WHEN min_wait_time <> max_wait_time THEN
																		CONVERT(NVARCHAR, min_wait_time) + N''/'' + CONVERT(NVARCHAR, avg_wait_time) + N''/'' + CONVERT(NVARCHAR, max_wait_time) + N''ms''
																	ELSE 
																		CONVERT(NVARCHAR, max_wait_time) + N''ms''
																END
														END +
													N'')'' + wait_type COLLATE Latin1_General_Bin2
												),
												NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''),
												NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''),
												NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''),
											NCHAR(0),
											N''''
										) AS [waits]
									FROM
									(
										SELECT TOP(@i)
											w1.*,
											ROW_NUMBER() OVER
											(
												PARTITION BY
													w1.session_id,
													w1.request_id
												ORDER BY
													w1.block_info DESC,
													w1.num_waits DESC,
													w1.wait_type
											) AS r
										FROM
										(
											SELECT TOP(@i)
												task_info.session_id,
												task_info.request_id,
												task_info.physical_io,
												task_info.context_switches,
												task_info.thread_CPU_snapshot,
												task_info.num_tasks AS tasks,
												CASE
													WHEN task_info.runnable_time IS NOT NULL THEN
														''RUNNABLE''
													ELSE
														wt2.wait_type
												END AS wait_type,
												NULLIF(COUNT(COALESCE(task_info.runnable_time, wt2.waiting_task_address)), 0) AS num_waits,
												MIN(COALESCE(task_info.runnable_time, wt2.wait_duration_ms)) AS min_wait_time,
												AVG(COALESCE(task_info.runnable_time, wt2.wait_duration_ms)) AS avg_wait_time,
												MAX(COALESCE(task_info.runnable_time, wt2.wait_duration_ms)) AS max_wait_time,
												MAX(wt2.block_info) AS block_info
											FROM
											(
												SELECT TOP(@i)
													t.session_id,
													t.request_id,
													SUM(CONVERT(BIGINT, t.pending_io_count)) OVER (PARTITION BY t.session_id, t.request_id) AS physical_io,
													SUM(CONVERT(BIGINT, t.context_switches_count)) OVER (PARTITION BY t.session_id, t.request_id) AS context_switches, 
													' +
													CASE
														WHEN 
															@output_column_list LIKE '%|[CPU_delta|]%' ESCAPE '|'
															AND @sys_info = 1
															THEN
																'SUM(tr.usermode_time + tr.kernel_time) OVER (PARTITION BY t.session_id, t.request_id) '
														ELSE
															'CONVERT(BIGINT, NULL) '
													END + 
														' AS thread_CPU_snapshot, 
													COUNT(*) OVER (PARTITION BY t.session_id, t.request_id) AS num_tasks,
													t.task_address,
													t.task_state,
													CASE
														WHEN
															t.task_state = ''RUNNABLE''
															AND w.runnable_time > 0 THEN
																w.runnable_time
														ELSE
															NULL
													END AS runnable_time
												FROM sys.dm_os_tasks AS t
												CROSS APPLY
												(
													SELECT TOP(1)
														sp2.session_id
													FROM @sessions AS sp2
													WHERE
														sp2.session_id = t.session_id
														AND sp2.request_id = t.request_id
														AND sp2.status <> ''sleeping''
												) AS sp20
												LEFT OUTER HASH JOIN
												( 
												' +
													CASE
														WHEN @sys_info = 1 THEN
															'SELECT TOP(@i)
																(
																	SELECT TOP(@i)
																		ms_ticks
																	FROM sys.dm_os_sys_info
																) -
																	w0.wait_resumed_ms_ticks AS runnable_time,
																w0.worker_address,
																w0.thread_address,
																w0.task_bound_ms_ticks
															FROM sys.dm_os_workers AS w0
															WHERE
																w0.state = ''RUNNABLE''
																OR @first_collection_ms_ticks >= w0.task_bound_ms_ticks'
														ELSE
															'SELECT
																CONVERT(BIGINT, NULL) AS runnable_time,
																CONVERT(VARBINARY(8), NULL) AS worker_address,
																CONVERT(VARBINARY(8), NULL) AS thread_address,
																CONVERT(BIGINT, NULL) AS task_bound_ms_ticks
															WHERE
																1 = 0'
														END +
												'
												) AS w ON
													w.worker_address = t.worker_address 
												' +
												CASE
													WHEN
														@output_column_list LIKE '%|[CPU_delta|]%' ESCAPE '|'
														AND @sys_info = 1
														THEN
															'LEFT OUTER HASH JOIN sys.dm_os_threads AS tr ON
																tr.thread_address = w.thread_address
																AND @first_collection_ms_ticks >= w.task_bound_ms_ticks
															'
													ELSE
														''
												END +
											') AS task_info
											LEFT OUTER HASH JOIN
											(
												SELECT TOP(@i)
													wt1.wait_type,
													wt1.waiting_task_address,
													MAX(wt1.wait_duration_ms) AS wait_duration_ms,
													MAX(wt1.block_info) AS block_info
												FROM
												(
													SELECT DISTINCT TOP(@i)
														wt.wait_type +
															CASE
																WHEN wt.wait_type LIKE N''PAGE%LATCH_%'' THEN
																	'':'' +
																	COALESCE(DB_NAME(CONVERT(INT, LEFT(wt.resource_description, CHARINDEX(N'':'', wt.resource_description) - 1))), N''(null)'') +
																	N'':'' +
																	SUBSTRING(wt.resource_description, CHARINDEX(N'':'', wt.resource_description) + 1, LEN(wt.resource_description) - CHARINDEX(N'':'', REVERSE(wt.resource_description)) - CHARINDEX(N'':'', wt.resource_description)) +
																	N''('' +
																		CASE
																			WHEN
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) = 1 OR
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) % 8088 = 0
																					THEN 
																						N''PFS''
																			WHEN
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) = 2 OR
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) % 511232 = 0 
																					THEN 
																						N''GAM''
																			WHEN
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) = 3 OR
																				(CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) - 1) % 511232 = 0 
																					THEN 
																						N''SGAM''
																			WHEN
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) = 6 OR
																				(CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) - 6) % 511232 = 0 
																					THEN 
																						N''DCM''
																			WHEN
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) = 7 OR
																				(CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) - 7) % 511232 = 0
																					THEN 
																						N''BCM''
																			ELSE
																				N''*''
																		END +
																	N'')''
																WHEN wt.wait_type = N''CXPACKET'' THEN
																	N'':'' + SUBSTRING(wt.resource_description, CHARINDEX(N''nodeId'', wt.resource_description) + 7, 4)
																WHEN wt.wait_type LIKE N''LATCH[_]%'' THEN
																	N'' ['' + LEFT(wt.resource_description, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description), 0), LEN(wt.resource_description) + 1) - 1) + N'']''
																ELSE 
																	N''''
															END COLLATE Latin1_General_Bin2 AS wait_type,
														CASE
															WHEN
															(
																wt.blocking_session_id IS NOT NULL
																AND wt.wait_type LIKE N''LCK[_]%''
															) THEN
																(
																	SELECT TOP(@i)
																		x.lock_type,
																		REPLACE
																		(
																			REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
																			REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
																			REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
																				DB_NAME
																				(
																					CONVERT
																					(
																						INT,
																						SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''dbid='', wt.resource_description), 0) + 5, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''dbid='', wt.resource_description) + 5), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''dbid='', wt.resource_description) - 5)
																					)
																				),
																				NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''),
																				NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''),
																				NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''),
																			NCHAR(0),
																			N''''
																		) AS database_name,
																		CASE x.lock_type
																			WHEN N''objectlock'' THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''objid='', wt.resource_description), 0) + 6, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''objid='', wt.resource_description) + 6), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''objid='', wt.resource_description) - 6)
																			ELSE
																				NULL
																		END AS object_id,
																		CASE x.lock_type
																			WHEN N''filelock'' THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''fileid='', wt.resource_description), 0) + 7, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''fileid='', wt.resource_description) + 7), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''fileid='', wt.resource_description) - 7)
																			ELSE
																				NULL
																		END AS file_id,
																		CASE
																			WHEN x.lock_type in (N''pagelock'', N''extentlock'', N''ridlock'') THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''associatedObjectId='', wt.resource_description), 0) + 19, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''associatedObjectId='', wt.resource_description) + 19), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''associatedObjectId='', wt.resource_description) - 19)
																			WHEN x.lock_type in (N''keylock'', N''hobtlock'', N''allocunitlock'') THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''hobtid='', wt.resource_description), 0) + 7, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''hobtid='', wt.resource_description) + 7), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''hobtid='', wt.resource_description) - 7)
																			ELSE
																				NULL
																		END AS hobt_id,
																		CASE x.lock_type
																			WHEN N''applicationlock'' THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''hash='', wt.resource_description), 0) + 5, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''hash='', wt.resource_description) + 5), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''hash='', wt.resource_description) - 5)
																			ELSE
																				NULL
																		END AS applock_hash,
																		CASE x.lock_type
																			WHEN N''metadatalock'' THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''subresource='', wt.resource_description), 0) + 12, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''subresource='', wt.resource_description) + 12), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''subresource='', wt.resource_description) - 12)
																			ELSE
																				NULL
																		END AS metadata_resource,
																		CASE x.lock_type
																			WHEN N''metadatalock'' THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''classid='', wt.resource_description), 0) + 8, COALESCE(NULLIF(CHARINDEX(N'' dbid='', wt.resource_description) - CHARINDEX(N''classid='', wt.resource_description), 0), LEN(wt.resource_description) + 1) - 8)
																			ELSE
																				NULL
																		END AS metadata_class_id
																	FROM
																	(
																		SELECT TOP(1)
																			LEFT(wt.resource_description, CHARINDEX(N'' '', wt.resource_description) - 1) COLLATE Latin1_General_Bin2 AS lock_type
																	) AS x
																	FOR XML
																		PATH('''')
																)
															ELSE NULL
														END AS block_info,
														wt.wait_duration_ms,
														wt.waiting_task_address
													FROM
													(
														SELECT TOP(@i)
															wt0.wait_type COLLATE Latin1_General_Bin2 AS wait_type,
															wt0.resource_description COLLATE Latin1_General_Bin2 AS resource_description,
															wt0.wait_duration_ms,
															wt0.waiting_task_address,
															CASE
																WHEN wt0.blocking_session_id = p.blocked THEN
																	wt0.blocking_session_id
																ELSE
																	NULL
															END AS blocking_session_id
														FROM sys.dm_os_waiting_tasks AS wt0
														CROSS APPLY
														(
															SELECT TOP(1)
																s0.blocked
															FROM @sessions AS s0
															WHERE
																s0.session_id = wt0.session_id
																AND COALESCE(s0.wait_type, N'''') <> N''OLEDB''
																AND wt0.wait_type <> N''OLEDB''
														) AS p
													) AS wt
												) AS wt1
												GROUP BY
													wt1.wait_type,
													wt1.waiting_task_address
											) AS wt2 ON
												wt2.waiting_task_address = task_info.task_address
												AND wt2.wait_duration_ms > 0
												AND task_info.runnable_time IS NULL
											GROUP BY
												task_info.session_id,
												task_info.request_id,
												task_info.physical_io,
												task_info.context_switches,
												task_info.thread_CPU_snapshot,
												task_info.num_tasks,
												CASE
													WHEN task_info.runnable_time IS NOT NULL THEN
														''RUNNABLE''
													ELSE
														wt2.wait_type
												END
										) AS w1
									) AS waits
									ORDER BY
										waits.session_id,
										waits.request_id,
										waits.r
									FOR XML
										PATH(N''tasks''),
										TYPE
								) AS tasks_raw (task_xml_raw)
							) AS tasks_final
							CROSS APPLY tasks_final.task_xml.nodes(N''/tasks'') AS task_nodes (task_node)
							WHERE
								task_nodes.task_node.exist(N''session_id'') = 1
						) AS tasks ON
							tasks.session_id = y.session_id
							AND tasks.request_id = y.request_id 
						'
					ELSE
						''
				END +
				'LEFT OUTER HASH JOIN
				(
					SELECT TOP(@i)
						t_info.session_id,
						COALESCE(t_info.request_id, -1) AS request_id,
						SUM(t_info.tempdb_allocations) AS tempdb_allocations,
						SUM(t_info.tempdb_current) AS tempdb_current
					FROM
					(
						SELECT TOP(@i)
							tsu.session_id,
							tsu.request_id,
							tsu.user_objects_alloc_page_count +
								tsu.internal_objects_alloc_page_count AS tempdb_allocations,
							tsu.user_objects_alloc_page_count +
								tsu.internal_objects_alloc_page_count -
								tsu.user_objects_dealloc_page_count -
								tsu.internal_objects_dealloc_page_count AS tempdb_current
						FROM sys.dm_db_task_space_usage AS tsu
						CROSS APPLY
						(
							SELECT TOP(1)
								s0.session_id
							FROM @sessions AS s0
							WHERE
								s0.session_id = tsu.session_id
						) AS p

						UNION ALL

						SELECT TOP(@i)
							ssu.session_id,
							NULL AS request_id,
							ssu.user_objects_alloc_page_count +
								ssu.internal_objects_alloc_page_count AS tempdb_allocations,
							ssu.user_objects_alloc_page_count +
								ssu.internal_objects_alloc_page_count -
								ssu.user_objects_dealloc_page_count -
								ssu.internal_objects_dealloc_page_count AS tempdb_current
						FROM sys.dm_db_session_space_usage AS ssu
						CROSS APPLY
						(
							SELECT TOP(1)
								s0.session_id
							FROM @sessions AS s0
							WHERE
								s0.session_id = ssu.session_id
						) AS p
					) AS t_info
					GROUP BY
						t_info.session_id,
						COALESCE(t_info.request_id, -1)
				) AS tempdb_info ON
					tempdb_info.session_id = y.session_id
					AND tempdb_info.request_id =
						CASE
							WHEN y.status = N''sleeping'' THEN
								-1
							ELSE
								y.request_id
						END
				' +
				CASE 
					WHEN 
						NOT 
						(
							@get_avg_time = 1 
							AND @recursion = 1
						) THEN 
							''
					ELSE
						'LEFT OUTER HASH JOIN
						(
							SELECT TOP(@i)
								*
							FROM sys.dm_exec_query_stats
						) AS qs ON
							qs.sql_handle = y.sql_handle
							AND qs.plan_handle = y.plan_handle
							AND qs.statement_start_offset = y.statement_start_offset
							AND qs.statement_end_offset = y.statement_end_offset
						'
				END + 
			') AS x
			OPTION (KEEPFIXED PLAN, OPTIMIZE FOR (@i = 1)); ';

		SET @sql_n = CONVERT(NVARCHAR(MAX), @sql);

		SET @last_collection_start = GETDATE();

		IF 
			@recursion = -1
			AND @sys_info = 1
		BEGIN;
			SELECT
				@first_collection_ms_ticks = ms_ticks
			FROM sys.dm_os_sys_info;
		END;

		INSERT #sessions
		(
			recursion,
			session_id,
			request_id,
			session_number,
			elapsed_time,
			avg_elapsed_time,
			physical_io,
			reads,
			physical_reads,
			writes,
			tempdb_allocations,
			tempdb_current,
			CPU,
			thread_CPU_snapshot,
			context_switches,
			used_memory,
			tasks,
			status,
			wait_info,
			transaction_id,
			open_tran_count,
			sql_handle,
			statement_start_offset,
			statement_end_offset,		
			sql_text,
			plan_handle,
			blocking_session_id,
			percent_complete,
			host_name,
			login_name,
			database_name,
			program_name,
			additional_info,
			start_time,
			login_time,
			last_request_start_time
		)
		EXEC sp_executesql 
			@sql_n,
			N'@recursion SMALLINT, @filter sysname, @not_filter sysname, @first_collection_ms_ticks BIGINT',
			@recursion, @filter, @not_filter, @first_collection_ms_ticks;

		--Collect transaction information?
		IF
			@recursion = 1
			AND
			(
				@output_column_list LIKE '%|[tran_start_time|]%' ESCAPE '|'
				OR @output_column_list LIKE '%|[tran_log_writes|]%' ESCAPE '|' 
			)
		BEGIN;	
			DECLARE @i INT;
			SET @i = 2147483647;

			UPDATE s
			SET
				tran_start_time =
					CONVERT
					(
						DATETIME,
						LEFT
						(
							x.trans_info,
							NULLIF(CHARINDEX(NCHAR(254) COLLATE Latin1_General_Bin2, x.trans_info) - 1, -1)
						),
						121
					),
				tran_log_writes =
					RIGHT
					(
						x.trans_info,
						LEN(x.trans_info) - CHARINDEX(NCHAR(254) COLLATE Latin1_General_Bin2, x.trans_info)
					)
			FROM
			(
				SELECT TOP(@i)
					trans_nodes.trans_node.value('(session_id/text())[1]', 'SMALLINT') AS session_id,
					COALESCE(trans_nodes.trans_node.value('(request_id/text())[1]', 'INT'), 0) AS request_id,
					trans_nodes.trans_node.value('(trans_info/text())[1]', 'NVARCHAR(4000)') AS trans_info				
				FROM
				(
					SELECT TOP(@i)
						CONVERT
						(
							XML,
							REPLACE
							(
								CONVERT(NVARCHAR(MAX), trans_raw.trans_xml_raw) COLLATE Latin1_General_Bin2, 
								N'</trans_info></trans><trans><trans_info>', N''
							)
						)
					FROM
					(
						SELECT TOP(@i)
							CASE u_trans.r
								WHEN 1 THEN u_trans.session_id
								ELSE NULL
							END AS [session_id],
							CASE u_trans.r
								WHEN 1 THEN u_trans.request_id
								ELSE NULL
							END AS [request_id],
							CONVERT
							(
								NVARCHAR(MAX),
								CASE
									WHEN u_trans.database_id IS NOT NULL THEN
										CASE u_trans.r
											WHEN 1 THEN COALESCE(CONVERT(NVARCHAR, u_trans.transaction_start_time, 121) + NCHAR(254), N'')
											ELSE N''
										END + 
											REPLACE
											(
												REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
												REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
												REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
													CONVERT(VARCHAR(128), COALESCE(DB_NAME(u_trans.database_id), N'(null)')),
													NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
													NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
													NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
												NCHAR(0),
												N'?'
											) +
											N': ' +
										CONVERT(NVARCHAR, u_trans.log_record_count) + N' (' + CONVERT(NVARCHAR, u_trans.log_kb_used) + N' kB)' +
										N','
									ELSE
										N'N/A,'
								END COLLATE Latin1_General_Bin2
							) AS [trans_info]
						FROM
						(
							SELECT TOP(@i)
								trans.*,
								ROW_NUMBER() OVER
								(
									PARTITION BY
										trans.session_id,
										trans.request_id
									ORDER BY
										trans.transaction_start_time DESC
								) AS r
							FROM
							(
								SELECT TOP(@i)
									session_tran_map.session_id,
									session_tran_map.request_id,
									s_tran.database_id,
									COALESCE(SUM(s_tran.database_transaction_log_record_count), 0) AS log_record_count,
									COALESCE(SUM(s_tran.database_transaction_log_bytes_used), 0) / 1024 AS log_kb_used,
									MIN(s_tran.database_transaction_begin_time) AS transaction_start_time
								FROM
								(
									SELECT TOP(@i)
										*
									FROM sys.dm_tran_active_transactions
									WHERE
										transaction_begin_time <= @last_collection_start
								) AS a_tran
								INNER HASH JOIN
								(
									SELECT TOP(@i)
										*
									FROM sys.dm_tran_database_transactions
									WHERE
										database_id < 32767
								) AS s_tran ON
									s_tran.transaction_id = a_tran.transaction_id
								LEFT OUTER HASH JOIN
								(
									SELECT TOP(@i)
										*
									FROM sys.dm_tran_session_transactions
								) AS tst ON
									s_tran.transaction_id = tst.transaction_id
								CROSS APPLY
								(
									SELECT TOP(1)
										s3.session_id,
										s3.request_id
									FROM
									(
										SELECT TOP(1)
											s1.session_id,
											s1.request_id
										FROM #sessions AS s1
										WHERE
											s1.transaction_id = s_tran.transaction_id
											AND s1.recursion = 1
											
										UNION ALL
									
										SELECT TOP(1)
											s2.session_id,
											s2.request_id
										FROM #sessions AS s2
										WHERE
											s2.session_id = tst.session_id
											AND s2.recursion = 1
									) AS s3
									ORDER BY
										s3.request_id
								) AS session_tran_map
								GROUP BY
									session_tran_map.session_id,
									session_tran_map.request_id,
									s_tran.database_id
							) AS trans
						) AS u_trans
						FOR XML
							PATH('trans'),
							TYPE
					) AS trans_raw (trans_xml_raw)
				) AS trans_final (trans_xml)
				CROSS APPLY trans_final.trans_xml.nodes('/trans') AS trans_nodes (trans_node)
			) AS x
			INNER HASH JOIN #sessions AS s ON
				s.session_id = x.session_id
				AND s.request_id = x.request_id
			OPTION (OPTIMIZE FOR (@i = 1));
		END;

		--Variables for text and plan collection
		DECLARE	
			@session_id SMALLINT,
			@request_id INT,
			@sql_handle VARBINARY(64),
			@plan_handle VARBINARY(64),
			@statement_start_offset INT,
			@statement_end_offset INT,
			@start_time DATETIME,
			@database_name sysname;

		IF 
			@recursion = 1
			AND @output_column_list LIKE '%|[sql_text|]%' ESCAPE '|'
		BEGIN;
			DECLARE sql_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR 
				SELECT 
					session_id,
					request_id,
					sql_handle,
					statement_start_offset,
					statement_end_offset
				FROM #sessions
				WHERE
					recursion = 1
					AND sql_handle IS NOT NULL
			OPTION (KEEPFIXED PLAN);

			OPEN sql_cursor;

			FETCH NEXT FROM sql_cursor
			INTO 
				@session_id,
				@request_id,
				@sql_handle,
				@statement_start_offset,
				@statement_end_offset;

			--Wait up to 5 ms for the SQL text, then give up
			SET LOCK_TIMEOUT 5;

			WHILE @@FETCH_STATUS = 0
			BEGIN;
				BEGIN TRY;
					UPDATE s
					SET
						s.sql_text =
						(
							SELECT
								REPLACE
								(
									REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
										N'--' + NCHAR(13) + NCHAR(10) +
										CASE 
											WHEN @get_full_inner_text = 1 THEN est.text
											WHEN LEN(est.text) < (@statement_end_offset / 2) + 1 THEN est.text
											WHEN SUBSTRING(est.text, (@statement_start_offset/2), 2) LIKE N'[a-zA-Z0-9][a-zA-Z0-9]' THEN est.text
											ELSE
												CASE
													WHEN @statement_start_offset > 0 THEN
														SUBSTRING
														(
															est.text,
															((@statement_start_offset/2) + 1),
															(
																CASE
																	WHEN @statement_end_offset = -1 THEN 2147483647
																	ELSE ((@statement_end_offset - @statement_start_offset)/2) + 1
																END
															)
														)
													ELSE RTRIM(LTRIM(est.text))
												END
										END +
										NCHAR(13) + NCHAR(10) + N'--' COLLATE Latin1_General_Bin2,
										NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
										NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
										NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
									NCHAR(0),
									N''
								) AS [processing-instruction(query)]
							FOR XML
								PATH(''),
								TYPE
						),
						s.statement_start_offset = 
							CASE 
								WHEN LEN(est.text) < (@statement_end_offset / 2) + 1 THEN 0
								WHEN SUBSTRING(CONVERT(VARCHAR(MAX), est.text), (@statement_start_offset/2), 2) LIKE '[a-zA-Z0-9][a-zA-Z0-9]' THEN 0
								ELSE @statement_start_offset
							END,
						s.statement_end_offset = 
							CASE 
								WHEN LEN(est.text) < (@statement_end_offset / 2) + 1 THEN -1
								WHEN SUBSTRING(CONVERT(VARCHAR(MAX), est.text), (@statement_start_offset/2), 2) LIKE '[a-zA-Z0-9][a-zA-Z0-9]' THEN -1
								ELSE @statement_end_offset
							END
					FROM 
						#sessions AS s,
						(
							SELECT TOP(1)
								text
							FROM
							(
								SELECT 
									text, 
									0 AS row_num
								FROM sys.dm_exec_sql_text(@sql_handle)
								
								UNION ALL
								
								SELECT 
									NULL,
									1 AS row_num
							) AS est0
							ORDER BY
								row_num
						) AS est
					WHERE 
						s.session_id = @session_id
						AND s.request_id = @request_id
						AND s.recursion = 1
					OPTION (KEEPFIXED PLAN);
				END TRY
				BEGIN CATCH;
					UPDATE s
					SET
						s.sql_text = 
							CASE ERROR_NUMBER() 
								WHEN 1222 THEN '<timeout_exceeded />'
								ELSE '<error message="' + ERROR_MESSAGE() + '" />'
							END
					FROM #sessions AS s
					WHERE 
						s.session_id = @session_id
						AND s.request_id = @request_id
						AND s.recursion = 1
					OPTION (KEEPFIXED PLAN);
				END CATCH;

				FETCH NEXT FROM sql_cursor
				INTO
					@session_id,
					@request_id,
					@sql_handle,
					@statement_start_offset,
					@statement_end_offset;
			END;

			--Return this to the default
			SET LOCK_TIMEOUT -1;

			CLOSE sql_cursor;
			DEALLOCATE sql_cursor;
		END;

		IF 
			@get_outer_command = 1 
			AND @recursion = 1
			AND @output_column_list LIKE '%|[sql_command|]%' ESCAPE '|'
		BEGIN;
			DECLARE @buffer_results TABLE
			(
				EventType VARCHAR(30),
				Parameters INT,
				EventInfo NVARCHAR(4000),
				start_time DATETIME,
				session_number INT IDENTITY(1,1) NOT NULL PRIMARY KEY
			);

			DECLARE buffer_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR 
				SELECT 
					session_id,
					MAX(start_time) AS start_time
				FROM #sessions
				WHERE
					recursion = 1
				GROUP BY
					session_id
				ORDER BY
					session_id
				OPTION (KEEPFIXED PLAN);

			OPEN buffer_cursor;

			FETCH NEXT FROM buffer_cursor
			INTO 
				@session_id,
				@start_time;

			WHILE @@FETCH_STATUS = 0
			BEGIN;
				BEGIN TRY;
					--In SQL Server 2008, DBCC INPUTBUFFER will throw 
					--an exception if the session no longer exists
					INSERT @buffer_results
					(
						EventType,
						Parameters,
						EventInfo
					)
					EXEC sp_executesql
						N'DBCC INPUTBUFFER(@session_id) WITH NO_INFOMSGS;',
						N'@session_id SMALLINT',
						@session_id;

					UPDATE br
					SET
						br.start_time = @start_time
					FROM @buffer_results AS br
					WHERE
						br.session_number = 
						(
							SELECT MAX(br2.session_number)
							FROM @buffer_results br2
						);
				END TRY
				BEGIN CATCH
				END CATCH;

				FETCH NEXT FROM buffer_cursor
				INTO 
					@session_id,
					@start_time;
			END;

			UPDATE s
			SET
				sql_command = 
				(
					SELECT 
						REPLACE
						(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								CONVERT
								(
									NVARCHAR(MAX),
									N'--' + NCHAR(13) + NCHAR(10) + br.EventInfo + NCHAR(13) + NCHAR(10) + N'--' COLLATE Latin1_General_Bin2
								),
								NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
								NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
								NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
							NCHAR(0),
							N''
						) AS [processing-instruction(query)]
					FROM @buffer_results AS br
					WHERE 
						br.session_number = s.session_number
						AND br.start_time = s.start_time
						AND 
						(
							(
								s.start_time = s.last_request_start_time
								AND EXISTS
								(
									SELECT *
									FROM sys.dm_exec_requests r2
									WHERE
										r2.session_id = s.session_id
										AND r2.request_id = s.request_id
										AND r2.start_time = s.start_time
								)
							)
							OR 
							(
								s.request_id = 0
								AND EXISTS
								(
									SELECT *
									FROM sys.dm_exec_sessions s2
									WHERE
										s2.session_id = s.session_id
										AND s2.last_request_start_time = s.last_request_start_time
								)
							)
						)
					FOR XML
						PATH(''),
						TYPE
				)
			FROM #sessions AS s
			WHERE
				recursion = 1
			OPTION (KEEPFIXED PLAN);

			CLOSE buffer_cursor;
			DEALLOCATE buffer_cursor;
		END;

		IF 
			@get_plans >= 1 
			AND @recursion = 1
			AND @output_column_list LIKE '%|[query_plan|]%' ESCAPE '|'
		BEGIN;
			DECLARE @live_plan BIT;
			SET @live_plan = ISNULL(CONVERT(BIT, SIGN(OBJECT_ID('sys.dm_exec_query_statistics_xml'))), 0)

			DECLARE plan_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR 
				SELECT
					session_id,
					request_id,
					plan_handle,
					statement_start_offset,
					statement_end_offset
				FROM #sessions
				WHERE
					recursion = 1
					AND plan_handle IS NOT NULL
			OPTION (KEEPFIXED PLAN);

			OPEN plan_cursor;

			FETCH NEXT FROM plan_cursor
			INTO 
				@session_id,
				@request_id,
				@plan_handle,
				@statement_start_offset,
				@statement_end_offset;

			--Wait up to 5 ms for a query plan, then give up
			SET LOCK_TIMEOUT 5;

			WHILE @@FETCH_STATUS = 0
			BEGIN;
				DECLARE @query_plan XML;
				SET @query_plan = NULL;

				IF @live_plan = 1
				BEGIN;
					BEGIN TRY;
						SELECT
							@query_plan = x.query_plan
						FROM sys.dm_exec_query_statistics_xml(@session_id) AS x;

						IF 
							@query_plan IS NOT NULL
							AND EXISTS
							(
								SELECT
									*
								FROM sys.dm_exec_requests AS r
								WHERE
									r.session_id = @session_id
									AND r.request_id = @request_id
									AND r.plan_handle = @plan_handle
									AND r.statement_start_offset = @statement_start_offset
									AND r.statement_end_offset = @statement_end_offset
							)
						BEGIN;
							UPDATE s
							SET
								s.query_plan = @query_plan
							FROM #sessions AS s
							WHERE 
								s.session_id = @session_id
								AND s.request_id = @request_id
								AND s.recursion = 1
							OPTION (KEEPFIXED PLAN);
						END;
					END TRY
					BEGIN CATCH;
						SET @query_plan = NULL;
					END CATCH;
				END;

				IF @query_plan IS NULL
				BEGIN;
					BEGIN TRY;
						UPDATE s
						SET
							s.query_plan =
							(
								SELECT
									CONVERT(xml, query_plan)
								FROM sys.dm_exec_text_query_plan
								(
									@plan_handle, 
									CASE @get_plans
										WHEN 1 THEN
											@statement_start_offset
										ELSE
											0
									END, 
									CASE @get_plans
										WHEN 1 THEN
											@statement_end_offset
										ELSE
											-1
									END
								)
							)
						FROM #sessions AS s
						WHERE 
							s.session_id = @session_id
							AND s.request_id = @request_id
							AND s.recursion = 1
						OPTION (KEEPFIXED PLAN);
					END TRY
					BEGIN CATCH;
						IF ERROR_NUMBER() = 6335
						BEGIN;
							UPDATE s
							SET
								s.query_plan =
								(
									SELECT
										N'--' + NCHAR(13) + NCHAR(10) + 
										N'-- Could not render showplan due to XML data type limitations. ' + NCHAR(13) + NCHAR(10) + 
										N'-- To see the graphical plan save the XML below as a .SQLPLAN file and re-open in SSMS.' + NCHAR(13) + NCHAR(10) +
										N'--' + NCHAR(13) + NCHAR(10) +
											REPLACE(qp.query_plan, N'<RelOp', NCHAR(13)+NCHAR(10)+N'<RelOp') + 
											NCHAR(13) + NCHAR(10) + N'--' COLLATE Latin1_General_Bin2 AS [processing-instruction(query_plan)]
									FROM sys.dm_exec_text_query_plan
									(
										@plan_handle, 
										CASE @get_plans
											WHEN 1 THEN
												@statement_start_offset
											ELSE
												0
										END, 
										CASE @get_plans
											WHEN 1 THEN
												@statement_end_offset
											ELSE
												-1
										END
									) AS qp
									FOR XML
										PATH(''),
										TYPE
								)
							FROM #sessions AS s
							WHERE 
								s.session_id = @session_id
								AND s.request_id = @request_id
								AND s.recursion = 1
							OPTION (KEEPFIXED PLAN);
						END;
						ELSE
						BEGIN;
							UPDATE s
							SET
								s.query_plan = 
									CASE ERROR_NUMBER() 
										WHEN 1222 THEN '<timeout_exceeded />'
										ELSE '<error message="' + ERROR_MESSAGE() + '" />'
									END
							FROM #sessions AS s
							WHERE 
								s.session_id = @session_id
								AND s.request_id = @request_id
								AND s.recursion = 1
							OPTION (KEEPFIXED PLAN);
						END;
					END CATCH;
				END;

				FETCH NEXT FROM plan_cursor
				INTO
					@session_id,
					@request_id,
					@plan_handle,
					@statement_start_offset,
					@statement_end_offset;
			END;

			--Return this to the default
			SET LOCK_TIMEOUT -1;

			CLOSE plan_cursor;
			DEALLOCATE plan_cursor;
		END;

		IF 
			@get_locks = 1 
			AND @recursion = 1
			AND @output_column_list LIKE '%|[locks|]%' ESCAPE '|'
		BEGIN;
			DECLARE locks_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR 
				SELECT DISTINCT
					database_name
				FROM #locks
				WHERE
					EXISTS
					(
						SELECT *
						FROM #sessions AS s
						WHERE
							s.session_id = #locks.session_id
							AND recursion = 1
					)
					AND database_name <> '(null)'
				OPTION (KEEPFIXED PLAN);

			OPEN locks_cursor;

			FETCH NEXT FROM locks_cursor
			INTO 
				@database_name;

			WHILE @@FETCH_STATUS = 0
			BEGIN;
				BEGIN TRY;
					SET @sql_n = CONVERT(NVARCHAR(MAX), '') +
						'UPDATE l ' +
						'SET ' +
							'object_name = ' +
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										'o.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								'), ' +
							'index_name = ' +
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										'i.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								'), ' +
							'schema_name = ' +
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										's.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								'), ' +
							'principal_name = ' + 
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										'dp.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								') ' +
						'FROM #locks AS l ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.allocation_units AS au ON ' +
							'au.allocation_unit_id = l.allocation_unit_id ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.partitions AS p ON ' +
							'p.hobt_id = ' +
								'COALESCE ' +
								'( ' +
									'l.hobt_id, ' +
									'CASE ' +
										'WHEN au.type IN (1, 3) THEN au.container_id ' +
										'ELSE NULL ' +
									'END ' +
								') ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.partitions AS p1 ON ' +
							'l.hobt_id IS NULL ' +
							'AND au.type = 2 ' +
							'AND p1.partition_id = au.container_id ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.objects AS o ON ' +
							'o.object_id = COALESCE(l.object_id, p.object_id, p1.object_id) ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.indexes AS i ON ' +
							'i.object_id = COALESCE(l.object_id, p.object_id, p1.object_id) ' +
							'AND i.index_id = COALESCE(l.index_id, p.index_id, p1.index_id) ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.schemas AS s ON ' +
							's.schema_id = COALESCE(l.schema_id, o.schema_id) ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.database_principals AS dp ON ' +
							'dp.principal_id = l.principal_id ' +
						'WHERE ' +
							'l.database_name = @database_name ' +
						'OPTION (KEEPFIXED PLAN); ';
					
					EXEC sp_executesql
						@sql_n,
						N'@database_name sysname',
						@database_name;
				END TRY
				BEGIN CATCH;
					UPDATE #locks
					SET
						query_error = 
							REPLACE
							(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									CONVERT
									(
										NVARCHAR(MAX), 
										ERROR_MESSAGE() COLLATE Latin1_General_Bin2
									),
									NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
									NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
									NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
								NCHAR(0),
								N''
							)
					WHERE 
						database_name = @database_name
					OPTION (KEEPFIXED PLAN);
				END CATCH;

				FETCH NEXT FROM locks_cursor
				INTO
					@database_name;
			END;

			CLOSE locks_cursor;
			DEALLOCATE locks_cursor;

			CREATE CLUSTERED INDEX IX_SRD ON #locks (session_id, request_id, database_name);

			UPDATE s
			SET 
				s.locks =
				(
					SELECT 
						REPLACE
						(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								CONVERT
								(
									NVARCHAR(MAX), 
									l1.database_name COLLATE Latin1_General_Bin2
								),
								NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
								NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
								NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
							NCHAR(0),
							N''
						) AS [Database/@name],
						MIN(l1.query_error) AS [Database/@query_error],
						(
							SELECT 
								l2.request_mode AS [Lock/@request_mode],
								l2.request_status AS [Lock/@request_status],
								COUNT(*) AS [Lock/@request_count]
							FROM #locks AS l2
							WHERE 
								l1.session_id = l2.session_id
								AND l1.request_id = l2.request_id
								AND l2.database_name = l1.database_name
								AND l2.resource_type = 'DATABASE'
							GROUP BY
								l2.request_mode,
								l2.request_status
							FOR XML
								PATH(''),
								TYPE
						) AS [Database/Locks],
						(
							SELECT
								COALESCE(l3.object_name, '(null)') AS [Object/@name],
								l3.schema_name AS [Object/@schema_name],
								(
									SELECT
										l4.resource_type AS [Lock/@resource_type],
										l4.page_type AS [Lock/@page_type],
										l4.index_name AS [Lock/@index_name],
										CASE 
											WHEN l4.object_name IS NULL THEN l4.schema_name
											ELSE NULL
										END AS [Lock/@schema_name],
										l4.principal_name AS [Lock/@principal_name],
										l4.resource_description AS [Lock/@resource_description],
										l4.request_mode AS [Lock/@request_mode],
										l4.request_status AS [Lock/@request_status],
										SUM(l4.request_count) AS [Lock/@request_count]
									FROM #locks AS l4
									WHERE 
										l4.session_id = l3.session_id
										AND l4.request_id = l3.request_id
										AND l3.database_name = l4.database_name
										AND COALESCE(l3.object_name, '(null)') = COALESCE(l4.object_name, '(null)')
										AND COALESCE(l3.schema_name, '') = COALESCE(l4.schema_name, '')
										AND l4.resource_type <> 'DATABASE'
									GROUP BY
										l4.resource_type,
										l4.page_type,
										l4.index_name,
										CASE 
											WHEN l4.object_name IS NULL THEN l4.schema_name
											ELSE NULL
										END,
										l4.principal_name,
										l4.resource_description,
										l4.request_mode,
										l4.request_status
									FOR XML
										PATH(''),
										TYPE
								) AS [Object/Locks]
							FROM #locks AS l3
							WHERE 
								l3.session_id = l1.session_id
								AND l3.request_id = l1.request_id
								AND l3.database_name = l1.database_name
								AND l3.resource_type <> 'DATABASE'
							GROUP BY 
								l3.session_id,
								l3.request_id,
								l3.database_name,
								COALESCE(l3.object_name, '(null)'),
								l3.schema_name
							FOR XML
								PATH(''),
								TYPE
						) AS [Database/Objects]
					FROM #locks AS l1
					WHERE
						l1.session_id = s.session_id
						AND l1.request_id = s.request_id
						AND l1.start_time IN (s.start_time, s.last_request_start_time)
						AND s.recursion = 1
					GROUP BY 
						l1.session_id,
						l1.request_id,
						l1.database_name
					FOR XML
						PATH(''),
						TYPE
				)
			FROM #sessions s
			OPTION (KEEPFIXED PLAN);
		END;

		IF 
			@find_block_leaders = 1
			AND @recursion = 1
			AND @output_column_list LIKE '%|[blocked_session_count|]%' ESCAPE '|'
		BEGIN;
			WITH
			blockers AS
			(
				SELECT
					session_id,
					session_id AS top_level_session_id,
					CONVERT(VARCHAR(8000), '.' + CONVERT(VARCHAR(8000), session_id) + '.') AS the_path
				FROM #sessions
				WHERE
					recursion = 1

				UNION ALL

				SELECT
					s.session_id,
					b.top_level_session_id,
					CONVERT(VARCHAR(8000), b.the_path + CONVERT(VARCHAR(8000), s.session_id) + '.') AS the_path
				FROM blockers AS b
				JOIN #sessions AS s ON
					s.blocking_session_id = b.session_id
					AND s.recursion = 1
					AND b.the_path NOT LIKE '%.' + CONVERT(VARCHAR(8000), s.session_id) + '.%' COLLATE Latin1_General_Bin2
			)
			UPDATE s
			SET
				s.blocked_session_count = x.blocked_session_count
			FROM #sessions AS s
			JOIN
			(
				SELECT
					b.top_level_session_id AS session_id,
					COUNT(*) - 1 AS blocked_session_count
				FROM blockers AS b
				GROUP BY
					b.top_level_session_id
			) x ON
				s.session_id = x.session_id
			WHERE
				s.recursion = 1;
		END;

		IF
			@get_task_info = 2
			AND @output_column_list LIKE '%|[additional_info|]%' ESCAPE '|'
			AND @recursion = 1
		BEGIN;
			CREATE TABLE #blocked_requests
			(
				session_id SMALLINT NOT NULL,
				request_id INT NOT NULL,
				database_name sysname NOT NULL,
				object_id INT,
				hobt_id BIGINT,
				schema_id INT,
				schema_name sysname NULL,
				object_name sysname NULL,
				query_error NVARCHAR(2048),
				PRIMARY KEY (database_name, session_id, request_id)
			);

			CREATE STATISTICS s_database_name ON #blocked_requests (database_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_schema_name ON #blocked_requests (schema_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_object_name ON #blocked_requests (object_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_query_error ON #blocked_requests (query_error)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
		
			INSERT #blocked_requests
			(
				session_id,
				request_id,
				database_name,
				object_id,
				hobt_id,
				schema_id
			)
			SELECT
				session_id,
				request_id,
				database_name,
				object_id,
				hobt_id,
				CONVERT(INT, SUBSTRING(schema_node, CHARINDEX(' = ', schema_node) + 3, LEN(schema_node))) AS schema_id
			FROM
			(
				SELECT
					session_id,
					request_id,
					agent_nodes.agent_node.value('(database_name/text())[1]', 'sysname') AS database_name,
					agent_nodes.agent_node.value('(object_id/text())[1]', 'int') AS object_id,
					agent_nodes.agent_node.value('(hobt_id/text())[1]', 'bigint') AS hobt_id,
					agent_nodes.agent_node.value('(metadata_resource/text()[.="SCHEMA"]/../../metadata_class_id/text())[1]', 'varchar(100)') AS schema_node
				FROM #sessions AS s
				CROSS APPLY s.additional_info.nodes('//block_info') AS agent_nodes (agent_node)
				WHERE
					s.recursion = 1
			) AS t
			WHERE
				t.database_name IS NOT NULL
				AND
				(
					t.object_id IS NOT NULL
					OR t.hobt_id IS NOT NULL
					OR t.schema_node IS NOT NULL
				);
			
			DECLARE blocks_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR
				SELECT DISTINCT
					database_name
				FROM #blocked_requests;
				
			OPEN blocks_cursor;
			
			FETCH NEXT FROM blocks_cursor
			INTO 
				@database_name;
			
			WHILE @@FETCH_STATUS = 0
			BEGIN;
				BEGIN TRY;
					SET @sql_n = 
						CONVERT(NVARCHAR(MAX), '') +
						'UPDATE b ' +
						'SET ' +
							'b.schema_name = ' +
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										's.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								'), ' +
							'b.object_name = ' +
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										'o.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								') ' +
						'FROM #blocked_requests AS b ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.partitions AS p ON ' +
							'p.hobt_id = b.hobt_id ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.objects AS o ON ' +
							'o.object_id = COALESCE(p.object_id, b.object_id) ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.schemas AS s ON ' +
							's.schema_id = COALESCE(o.schema_id, b.schema_id) ' +
						'WHERE ' +
							'b.database_name = @database_name; ';
					
					EXEC sp_executesql
						@sql_n,
						N'@database_name sysname',
						@database_name;
				END TRY
				BEGIN CATCH;
					UPDATE #blocked_requests
					SET
						query_error = 
							REPLACE
							(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									CONVERT
									(
										NVARCHAR(MAX), 
										ERROR_MESSAGE() COLLATE Latin1_General_Bin2
									),
									NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
									NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
									NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
								NCHAR(0),
								N''
							)
					WHERE
						database_name = @database_name;
				END CATCH;

				FETCH NEXT FROM blocks_cursor
				INTO
					@database_name;
			END;
			
			CLOSE blocks_cursor;
			DEALLOCATE blocks_cursor;
			
			UPDATE s
			SET
				additional_info.modify
				('
					insert <schema_name>{sql:column("b.schema_name")}</schema_name>
					as last
					into (/additional_info/block_info)[1]
				')
			FROM #sessions AS s
			INNER JOIN #blocked_requests AS b ON
				b.session_id = s.session_id
				AND b.request_id = s.request_id
				AND s.recursion = 1
			WHERE
				b.schema_name IS NOT NULL;

			UPDATE s
			SET
				additional_info.modify
				('
					insert <object_name>{sql:column("b.object_name")}</object_name>
					as last
					into (/additional_info/block_info)[1]
				')
			FROM #sessions AS s
			INNER JOIN #blocked_requests AS b ON
				b.session_id = s.session_id
				AND b.request_id = s.request_id
				AND s.recursion = 1
			WHERE
				b.object_name IS NOT NULL;

			UPDATE s
			SET
				additional_info.modify
				('
					insert <query_error>{sql:column("b.query_error")}</query_error>
					as last
					into (/additional_info/block_info)[1]
				')
			FROM #sessions AS s
			INNER JOIN #blocked_requests AS b ON
				b.session_id = s.session_id
				AND b.request_id = s.request_id
				AND s.recursion = 1
			WHERE
				b.query_error IS NOT NULL;
		END;

		IF
			@output_column_list LIKE '%|[program_name|]%' ESCAPE '|'
			AND @output_column_list LIKE '%|[additional_info|]%' ESCAPE '|'
			AND @recursion = 1
			AND DB_ID('msdb') IS NOT NULL
		BEGIN;
			SET @sql_n =
				N'BEGIN TRY;
					DECLARE @job_name sysname;
					SET @job_name = NULL;
					DECLARE @step_name sysname;
					SET @step_name = NULL;

					SELECT
						@job_name = 
							REPLACE
							(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									j.name,
									NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''),
									NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''),
									NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''),
								NCHAR(0),
								N''?''
							),
						@step_name = 
							REPLACE
							(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									s.step_name,
									NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''),
									NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''),
									NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''),
								NCHAR(0),
								N''?''
							)
					FROM msdb.dbo.sysjobs AS j
					INNER JOIN msdb.dbo.sysjobsteps AS s ON
						j.job_id = s.job_id
					WHERE
						j.job_id = @job_id
						AND s.step_id = @step_id;

					IF @job_name IS NOT NULL
					BEGIN;
						UPDATE s
						SET
							additional_info.modify
							(''
								insert text{sql:variable("@job_name")}
								into (/additional_info/agent_job_info/job_name)[1]
							'')
						FROM #sessions AS s
						WHERE 
							s.session_id = @session_id
							AND s.recursion = 1
						OPTION (KEEPFIXED PLAN);
						
						UPDATE s
						SET
							additional_info.modify
							(''
								insert text{sql:variable("@step_name")}
								into (/additional_info/agent_job_info/step_name)[1]
							'')
						FROM #sessions AS s
						WHERE 
							s.session_id = @session_id
							AND s.recursion = 1
						OPTION (KEEPFIXED PLAN);
					END;
				END TRY
				BEGIN CATCH;
					DECLARE @msdb_error_message NVARCHAR(256);
					SET @msdb_error_message = ERROR_MESSAGE();
				
					UPDATE s
					SET
						additional_info.modify
						(''
							insert <msdb_query_error>{sql:variable("@msdb_error_message")}</msdb_query_error>
							as last
							into (/additional_info/agent_job_info)[1]
						'')
					FROM #sessions AS s
					WHERE 
						s.session_id = @session_id
						AND s.recursion = 1
					OPTION (KEEPFIXED PLAN);
				END CATCH;'

			DECLARE @job_id UNIQUEIDENTIFIER;
			DECLARE @step_id INT;

			DECLARE agent_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR 
				SELECT
					s.session_id,
					agent_nodes.agent_node.value('(job_id/text())[1]', 'uniqueidentifier') AS job_id,
					agent_nodes.agent_node.value('(step_id/text())[1]', 'int') AS step_id
				FROM #sessions AS s
				CROSS APPLY s.additional_info.nodes('//agent_job_info') AS agent_nodes (agent_node)
				WHERE
					s.recursion = 1
			OPTION (KEEPFIXED PLAN);
			
			OPEN agent_cursor;

			FETCH NEXT FROM agent_cursor
			INTO 
				@session_id,
				@job_id,
				@step_id;

			WHILE @@FETCH_STATUS = 0
			BEGIN;
				EXEC sp_executesql
					@sql_n,
					N'@job_id UNIQUEIDENTIFIER, @step_id INT, @session_id SMALLINT',
					@job_id, @step_id, @session_id

				FETCH NEXT FROM agent_cursor
				INTO 
					@session_id,
					@job_id,
					@step_id;
			END;

			CLOSE agent_cursor;
			DEALLOCATE agent_cursor;
		END; 
		
		IF 
			@delta_interval > 0 
			AND @recursion <> 1
		BEGIN;
			SET @recursion = 1;

			DECLARE @delay_time CHAR(12);
			SET @delay_time = CONVERT(VARCHAR, DATEADD(second, @delta_interval, 0), 114);
			WAITFOR DELAY @delay_time;

			GOTO REDO;
		END;
	END;

	SET @sql = 
		--Outer column list
		CONVERT
		(
			VARCHAR(MAX),
			CASE
				WHEN 
					@destination_table <> '' 
					AND @return_schema = 0 
						THEN 'INSERT ' + @destination_table + ' '
				ELSE ''
			END +
			'SELECT ' +
				@output_column_list + ' ' +
			CASE @return_schema
				WHEN 1 THEN 'INTO #session_schema '
				ELSE ''
			END
		--End outer column list
		) + 
		--Inner column list
		CONVERT
		(
			VARCHAR(MAX),
			'FROM ' +
			'( ' +
				'SELECT ' +
					'session_id, ' +
					--[dd hh:mm:ss.mss]
					CASE
						WHEN @format_output IN (1, 2) THEN
							'CASE ' +
								'WHEN elapsed_time < 0 THEN ' +
									'RIGHT ' +
									'( ' +
										'REPLICATE(''0'', max_elapsed_length) + CONVERT(VARCHAR, (-1 * elapsed_time) / 86400), ' +
										'max_elapsed_length ' +
									') + ' +
										'RIGHT ' +
										'( ' +
											'CONVERT(VARCHAR, DATEADD(second, (-1 * elapsed_time), 0), 120), ' +
											'9 ' +
										') + ' +
										'''.000'' ' +
								'ELSE ' +
									'RIGHT ' +
									'( ' +
										'REPLICATE(''0'', max_elapsed_length) + CONVERT(VARCHAR, elapsed_time / 86400000), ' +
										'max_elapsed_length ' +
									') + ' +
										'RIGHT ' +
										'( ' +
											'CONVERT(VARCHAR, DATEADD(second, elapsed_time / 1000, 0), 120), ' +
											'9 ' +
										') + ' +
										'''.'' + ' + 
										'RIGHT(''000'' + CONVERT(VARCHAR, elapsed_time % 1000), 3) ' +
							'END AS [dd hh:mm:ss.mss], '
						ELSE
							''
					END +
					--[dd hh:mm:ss.mss (avg)] / avg_elapsed_time
					CASE 
						WHEN  @format_output IN (1, 2) THEN 
							'RIGHT ' +
							'( ' +
								'''00'' + CONVERT(VARCHAR, avg_elapsed_time / 86400000), ' +
								'2 ' +
							') + ' +
								'RIGHT ' +
								'( ' +
									'CONVERT(VARCHAR, DATEADD(second, avg_elapsed_time / 1000, 0), 120), ' +
									'9 ' +
								') + ' +
								'''.'' + ' +
								'RIGHT(''000'' + CONVERT(VARCHAR, avg_elapsed_time % 1000), 3) AS [dd hh:mm:ss.mss (avg)], '
						ELSE
							'avg_elapsed_time, '
					END +
					--physical_io
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, physical_io))) OVER() - LEN(CONVERT(VARCHAR, physical_io))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_io), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_io), 1), 19)) AS '
						ELSE ''
					END + 'physical_io, ' +
					--reads
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, reads))) OVER() - LEN(CONVERT(VARCHAR, reads))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, reads), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, reads), 1), 19)) AS '
						ELSE ''
					END + 'reads, ' +
					--physical_reads
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, physical_reads))) OVER() - LEN(CONVERT(VARCHAR, physical_reads))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_reads), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_reads), 1), 19)) AS '
						ELSE ''
					END + 'physical_reads, ' +
					--writes
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, writes))) OVER() - LEN(CONVERT(VARCHAR, writes))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, writes), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, writes), 1), 19)) AS '
						ELSE ''
					END + 'writes, ' +
					--tempdb_allocations
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, tempdb_allocations))) OVER() - LEN(CONVERT(VARCHAR, tempdb_allocations))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_allocations), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_allocations), 1), 19)) AS '
						ELSE ''
					END + 'tempdb_allocations, ' +
					--tempdb_current
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, tempdb_current))) OVER() - LEN(CONVERT(VARCHAR, tempdb_current))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_current), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_current), 1), 19)) AS '
						ELSE ''
					END + 'tempdb_current, ' +
					--CPU
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, CPU))) OVER() - LEN(CONVERT(VARCHAR, CPU))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, CPU), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, CPU), 1), 19)) AS '
						ELSE ''
					END + 'CPU, ' +
					--context_switches
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, context_switches))) OVER() - LEN(CONVERT(VARCHAR, context_switches))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, context_switches), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, context_switches), 1), 19)) AS '
						ELSE ''
					END + 'context_switches, ' +
					--used_memory
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, used_memory))) OVER() - LEN(CONVERT(VARCHAR, used_memory))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, used_memory), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, used_memory), 1), 19)) AS '
						ELSE ''
					END + 'used_memory, ' +
					CASE
						WHEN @output_column_list LIKE '%|_delta|]%' ESCAPE '|' THEN
							--physical_io_delta			
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND physical_io_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, physical_io_delta))) OVER() - LEN(CONVERT(VARCHAR, physical_io_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_io_delta), 1), 19)) ' 
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_io_delta), 1), 19)) '
											ELSE 'physical_io_delta '
										END +
								'ELSE NULL ' +
							'END AS physical_io_delta, ' +
							--reads_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND reads_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, reads_delta))) OVER() - LEN(CONVERT(VARCHAR, reads_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, reads_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, reads_delta), 1), 19)) '
											ELSE 'reads_delta '
										END +
								'ELSE NULL ' +
							'END AS reads_delta, ' +
							--physical_reads_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND physical_reads_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, physical_reads_delta))) OVER() - LEN(CONVERT(VARCHAR, physical_reads_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_reads_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_reads_delta), 1), 19)) '
											ELSE 'physical_reads_delta '
										END + 
								'ELSE NULL ' +
							'END AS physical_reads_delta, ' +
							--writes_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND writes_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, writes_delta))) OVER() - LEN(CONVERT(VARCHAR, writes_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, writes_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, writes_delta), 1), 19)) '
											ELSE 'writes_delta '
										END + 
								'ELSE NULL ' +
							'END AS writes_delta, ' +
							--tempdb_allocations_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND tempdb_allocations_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, tempdb_allocations_delta))) OVER() - LEN(CONVERT(VARCHAR, tempdb_allocations_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_allocations_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_allocations_delta), 1), 19)) '
											ELSE 'tempdb_allocations_delta '
										END + 
								'ELSE NULL ' +
							'END AS tempdb_allocations_delta, ' +
							--tempdb_current_delta
							--this is the only one that can (legitimately) go negative 
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, tempdb_current_delta))) OVER() - LEN(CONVERT(VARCHAR, tempdb_current_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_current_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_current_delta), 1), 19)) '
											ELSE 'tempdb_current_delta '
										END + 
								'ELSE NULL ' +
							'END AS tempdb_current_delta, ' +
							--CPU_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
										'THEN ' +
											'CASE ' +
												'WHEN ' +
													'thread_CPU_delta > CPU_delta ' +
													'AND thread_CPU_delta > 0 ' +
														'THEN ' +
															CASE @format_output
																WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, thread_CPU_delta + CPU_delta))) OVER() - LEN(CONVERT(VARCHAR, thread_CPU_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, thread_CPU_delta), 1), 19)) '
																WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, thread_CPU_delta), 1), 19)) '
																ELSE 'thread_CPU_delta '
															END + 
												'WHEN CPU_delta >= 0 THEN ' +
													CASE @format_output
														WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, thread_CPU_delta + CPU_delta))) OVER() - LEN(CONVERT(VARCHAR, CPU_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, CPU_delta), 1), 19)) '
														WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, CPU_delta), 1), 19)) '
														ELSE 'CPU_delta '
													END + 
												'ELSE NULL ' +
											'END ' +
								'ELSE ' +
									'NULL ' +
							'END AS CPU_delta, ' +
							--context_switches_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND context_switches_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, context_switches_delta))) OVER() - LEN(CONVERT(VARCHAR, context_switches_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, context_switches_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, context_switches_delta), 1), 19)) '
											ELSE 'context_switches_delta '
										END + 
								'ELSE NULL ' +
							'END AS context_switches_delta, ' +
							--used_memory_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND used_memory_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, used_memory_delta))) OVER() - LEN(CONVERT(VARCHAR, used_memory_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, used_memory_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, used_memory_delta), 1), 19)) '
											ELSE 'used_memory_delta '
										END + 
								'ELSE NULL ' +
							'END AS used_memory_delta, '
						ELSE ''
					END +
					--tasks
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, tasks))) OVER() - LEN(CONVERT(VARCHAR, tasks))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tasks), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tasks), 1), 19)) '
						ELSE ''
					END + 'tasks, ' +
					'status, ' +
					'wait_info, ' +
					'locks, ' +
					'tran_start_time, ' +
					'LEFT(tran_log_writes, LEN(tran_log_writes) - 1) AS tran_log_writes, ' +
					--open_tran_count
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, open_tran_count))) OVER() - LEN(CONVERT(VARCHAR, open_tran_count))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, open_tran_count), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, open_tran_count), 1), 19)) AS '
						ELSE ''
					END + 'open_tran_count, ' +
					--sql_command
					CASE @format_output 
						WHEN 0 THEN 'REPLACE(REPLACE(CONVERT(NVARCHAR(MAX), sql_command), ''<?query --''+CHAR(13)+CHAR(10), ''''), CHAR(13)+CHAR(10)+''--?>'', '''') AS '
						ELSE ''
					END + 'sql_command, ' +
					--sql_text
					CASE @format_output 
						WHEN 0 THEN 'REPLACE(REPLACE(CONVERT(NVARCHAR(MAX), sql_text), ''<?query --''+CHAR(13)+CHAR(10), ''''), CHAR(13)+CHAR(10)+''--?>'', '''') AS '
						ELSE ''
					END + 'sql_text, ' +
					'query_plan, ' +
					'blocking_session_id, ' +
					--blocked_session_count
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, blocked_session_count))) OVER() - LEN(CONVERT(VARCHAR, blocked_session_count))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, blocked_session_count), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, blocked_session_count), 1), 19)) AS '
						ELSE ''
					END + 'blocked_session_count, ' +
					--percent_complete
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, CONVERT(MONEY, percent_complete), 2))) OVER() - LEN(CONVERT(VARCHAR, CONVERT(MONEY, percent_complete), 2))) + CONVERT(CHAR(22), CONVERT(MONEY, percent_complete), 2)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, CONVERT(CHAR(22), CONVERT(MONEY, blocked_session_count), 1)) AS '
						ELSE ''
					END + 'percent_complete, ' +
					'host_name, ' +
					'login_name, ' +
					'database_name, ' +
					'program_name, ' +
					'additional_info, ' +
					'start_time, ' +
					'login_time, ' +
					'CASE ' +
						'WHEN status = N''sleeping'' THEN NULL ' +
						'ELSE request_id ' +
					'END AS request_id, ' +
					'GETDATE() AS collection_time '
		--End inner column list
		) +
		--Derived table and INSERT specification
		CONVERT
		(
			VARCHAR(MAX),
				'FROM ' +
				'( ' +
					'SELECT TOP(2147483647) ' +
						'*, ' +
						'CASE ' +
							'MAX ' +
							'( ' +
								'LEN ' +
								'( ' +
									'CONVERT ' +
									'( ' +
										'VARCHAR, ' +
										'CASE ' +
											'WHEN elapsed_time < 0 THEN ' +
												'(-1 * elapsed_time) / 86400 ' +
											'ELSE ' +
												'elapsed_time / 86400000 ' +
										'END ' +
									') ' +
								') ' +
							') OVER () ' +
								'WHEN 1 THEN 2 ' +
								'ELSE ' +
									'MAX ' +
									'( ' +
										'LEN ' +
										'( ' +
											'CONVERT ' +
											'( ' +
												'VARCHAR, ' +
												'CASE ' +
													'WHEN elapsed_time < 0 THEN ' +
														'(-1 * elapsed_time) / 86400 ' +
													'ELSE ' +
														'elapsed_time / 86400000 ' +
												'END ' +
											') ' +
										') ' +
									') OVER () ' +
						'END AS max_elapsed_length, ' +
						CASE
							WHEN @output_column_list LIKE '%|_delta|]%' ESCAPE '|' THEN
								'MAX(physical_io * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(physical_io * recursion) OVER (PARTITION BY session_id, request_id) AS physical_io_delta, ' +
								'MAX(reads * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(reads * recursion) OVER (PARTITION BY session_id, request_id) AS reads_delta, ' +
								'MAX(physical_reads * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(physical_reads * recursion) OVER (PARTITION BY session_id, request_id) AS physical_reads_delta, ' +
								'MAX(writes * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(writes * recursion) OVER (PARTITION BY session_id, request_id) AS writes_delta, ' +
								'MAX(tempdb_allocations * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(tempdb_allocations * recursion) OVER (PARTITION BY session_id, request_id) AS tempdb_allocations_delta, ' +
								'MAX(tempdb_current * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(tempdb_current * recursion) OVER (PARTITION BY session_id, request_id) AS tempdb_current_delta, ' +
								'MAX(CPU * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(CPU * recursion) OVER (PARTITION BY session_id, request_id) AS CPU_delta, ' +
								'MAX(thread_CPU_snapshot * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(thread_CPU_snapshot * recursion) OVER (PARTITION BY session_id, request_id) AS thread_CPU_delta, ' +
								'MAX(context_switches * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(context_switches * recursion) OVER (PARTITION BY session_id, request_id) AS context_switches_delta, ' +
								'MAX(used_memory * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(used_memory * recursion) OVER (PARTITION BY session_id, request_id) AS used_memory_delta, ' +
								'MIN(last_request_start_time) OVER (PARTITION BY session_id, request_id) AS first_request_start_time, '
							ELSE ''
						END +
						'COUNT(*) OVER (PARTITION BY session_id, request_id) AS num_events ' +
					'FROM #sessions AS s1 ' +
					CASE 
						WHEN @sort_order = '' THEN ''
						ELSE
							'ORDER BY ' +
								@sort_order
					END +
				') AS s ' +
				'WHERE ' +
					's.recursion = 1 ' +
			') x ' +
			'OPTION (KEEPFIXED PLAN); ' +
			'' +
			CASE @return_schema
				WHEN 1 THEN
					'SET @schema = ' +
						'''CREATE TABLE <table_name> ( '' + ' +
							'STUFF ' +
							'( ' +
								'( ' +
									'SELECT ' +
										''','' + ' +
										'QUOTENAME(COLUMN_NAME) + '' '' + ' +
										'DATA_TYPE + ' + 
										'CASE ' +
											'WHEN DATA_TYPE LIKE ''%char'' THEN ''('' + COALESCE(NULLIF(CONVERT(VARCHAR, CHARACTER_MAXIMUM_LENGTH), ''-1''), ''max'') + '') '' ' +
											'ELSE '' '' ' +
										'END + ' +
										'CASE IS_NULLABLE ' +
											'WHEN ''NO'' THEN ''NOT '' ' +
											'ELSE '''' ' +
										'END + ''NULL'' AS [text()] ' +
									'FROM tempdb.INFORMATION_SCHEMA.COLUMNS ' +
									'WHERE ' +
										'TABLE_NAME = (SELECT name FROM tempdb.sys.objects WHERE object_id = OBJECT_ID(''tempdb..#session_schema'')) ' +
										'ORDER BY ' +
											'ORDINAL_POSITION ' +
									'FOR XML ' +
										'PATH('''') ' +
								'), + ' +
								'1, ' +
								'1, ' +
								''''' ' +
							') + ' +
						''')''; ' 
				ELSE ''
			END
		--End derived table and INSERT specification
		);

	SET @sql_n = CONVERT(NVARCHAR(MAX), @sql);

	EXEC sp_executesql
		@sql_n,
		N'@schema VARCHAR(MAX) OUTPUT',
		@schema OUTPUT;
END;
GO
/****** Object:  StoredProcedure [dbo].[updateindexstats]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[updateindexstats]
AS 

EXECUTE dbo.IndexOptimize
@Databases = 'USER_DATABASES',
@FragmentationLow = NULL,
@FragmentationMedium = 'INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationHigh = 'INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationLevel1 = 5,
@FragmentationLevel2 = 30,
@UpdateStatistics = 'ALL',
@OnlyModifiedStatistics = 'Y',
@LogToTable = 'Y'
GO
/****** Object:  StoredProcedure [Deploy].[InitiateNFLDB]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [Deploy].[InitiateNFLDB]

AS 


--EXEC Deploy.InitiateNFLDB

--Truncate and Load mapping.team

	TRUNCATE TABLE Mapping.team;

	SET IDENTITY_INSERT Mapping.team ON

	INSERT INTO  Mapping.team  (TeamKey,TeamSuperKey,SOURCE,TeamID,City,Name,isPrimary,Conference,Division,isSourceDup )
	SELECT mt.TeamKey,
		   mt.TeamSuperKey,
		   mt.SOURCE,
		   mt.TeamID,
		   mt.City,
		   mt.Name,
		   mt.isPrimary,
		   mt.Conference,
		   mt.Division,
		   mt.isSourceDup 
	 FROM Deploy.Mapping_team AS mt

 
	SET IDENTITY_INSERT Mapping.team OFF;

--Truncate and load NFLDB_ScheduleDefinition
	TRUNCATE TABLE NFLDB.ScheduleDefinition;

	SET IDENTITY_INSERT NFLDB.ScheduleDefinition ON

	INSERT INTO  NFLDB.ScheduleDefinition  (ScheduleDefinitionKey, Week, SeasonType, DESCRIPTION )
	SELECT 
		nsd.ScheduleDefinitionKey, 
		nsd.Week, 
		nsd.SeasonType,
		nsd.DESCRIPTION
	 FROM Deploy.NFLDB_ScheduleDefinition AS nsd

 
	SET IDENTITY_INSERT NFLDB.ScheduleDefinition OFF;

--Truncate and load Refernce.Statistic
	TRUNCATE TABLE Reference.Statistic;

	SET IDENTITY_INSERT Reference.Statistic ON

	INSERT INTO  Reference.Statistic   ( [StatisticKey] , [StatID] , [Category] , [FieldsValue] , [FieldsYds] , [Description] , [LongDescription] , [Negative] )
	SELECT 
			rs.StatisticKey,
			rs.StatID,
			rs.Category,
			rs.FieldsValue,
			rs.FieldsYds,
			rs.Description,
			rs.LongDescription,
			rs.Negative
	 FROM Deploy.Reference_Statistic AS rs

 
	SET IDENTITY_INSERT Reference.Statistic OFF;



--Truncate and load LandRef.Franchise

	TRUNCATE TABLE LandRef.Franchise;

	INSERT INTO  LandRef.Franchise(Franchisetype, Parent, Team, [From], [To], W, L, T, [W-L%], AV, Passer, Rusher, Receiver, Coaching, Yrplyf, Chmp, SBwl, Conf, Div)		
	SELECT Franchisetype,
		Parent,
		Team,
		[From],
		[To],
		W,
		L,
		T,
		[W-L%],
		AV,
		Passer,
		Rusher,
		Receiver,
		Coaching,
		Yrplyf,
		Chmp,
		SBwl,
		Conf,
		Div
	FROM Deploy.LandRef_Franchise;

	EXEC NFLDB.BuildFranchise; 


GO
/****** Object:  StoredProcedure [LandNFL].[TruncateSchedule]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC  [LandNFL].[TruncateSchedule]

 AS 

TRUNCATE TABLE LandNFL.Schedule

GO
/****** Object:  StoredProcedure [LandNFL].[TruncateTables]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC  [LandNFL].[TruncateTables]

 AS 

TRUNCATE TABLE LandNFL.drive
TRUNCATE TABLE LandNFL.game
TRUNCATE TABLE LandNFL.play
TRUNCATE TABLE LandNFL.playplayer
GO
/****** Object:  StoredProcedure [MasterNFL].[CDCDrive]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [MasterNFL].[CDCDrive]

AS
--MERGE generated by 'sp_generate_merge' stored procedure, Version 0.93
--Originally by Vyas (http://vyaskn.tripod.com): sp_generate_inserts (build 22)
--Adapted for SQL Server 2008/2012 by Daniel Nolan (http://danere.com)

SET NOCOUNT ON

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));
DECLARE @datetime DATETIMEOFFSET = GETDATE(); 
EXEC dbo.LogProcedure @ProcID =  @@PROCID, @TableName = '[MasterNFL].[drive]', @starttime = @datetime, @isStart = true
;
MERGE INTO [MasterNFL].[drive] AS Target
USING  ( 
Select [eid],[drivenumber],[start-team],[start-qtr],[start-time],[start-yrdln],[end-team],[end-qtr],[end-time],[end-yrdln],[posteam],[postime],[qtr],[numplays],[result],[ydsgained],[fds],[penyds],[redzone]
 From[LandNFL].[drive_vw]
) AS Source ([eid],[drivenumber],[start-team],[start-qtr],[start-time],[start-yrdln],[end-team],[end-qtr],[end-time],[end-yrdln],[posteam],[postime],[qtr],[numplays],[result],[ydsgained],[fds],[penyds],[redzone])
ON (Target.[drivenumber] = Source.[drivenumber] AND Target.[eid] = Source.[eid])
WHEN MATCHED AND (
	NULLIF(Source.[start-team], Target.[start-team]) IS NOT NULL OR NULLIF(Target.[start-team], Source.[start-team]) IS NOT NULL OR 
	NULLIF(Source.[start-qtr], Target.[start-qtr]) IS NOT NULL OR NULLIF(Target.[start-qtr], Source.[start-qtr]) IS NOT NULL OR 
	NULLIF(Source.[start-time], Target.[start-time]) IS NOT NULL OR NULLIF(Target.[start-time], Source.[start-time]) IS NOT NULL OR 
	NULLIF(Source.[start-yrdln], Target.[start-yrdln]) IS NOT NULL OR NULLIF(Target.[start-yrdln], Source.[start-yrdln]) IS NOT NULL OR 
	NULLIF(Source.[end-team], Target.[end-team]) IS NOT NULL OR NULLIF(Target.[end-team], Source.[end-team]) IS NOT NULL OR 
	NULLIF(Source.[end-qtr], Target.[end-qtr]) IS NOT NULL OR NULLIF(Target.[end-qtr], Source.[end-qtr]) IS NOT NULL OR 
	NULLIF(Source.[end-time], Target.[end-time]) IS NOT NULL OR NULLIF(Target.[end-time], Source.[end-time]) IS NOT NULL OR 
	NULLIF(Source.[end-yrdln], Target.[end-yrdln]) IS NOT NULL OR NULLIF(Target.[end-yrdln], Source.[end-yrdln]) IS NOT NULL OR 
	NULLIF(Source.[posteam], Target.[posteam]) IS NOT NULL OR NULLIF(Target.[posteam], Source.[posteam]) IS NOT NULL OR 
	NULLIF(Source.[postime], Target.[postime]) IS NOT NULL OR NULLIF(Target.[postime], Source.[postime]) IS NOT NULL OR 
	NULLIF(Source.[qtr], Target.[qtr]) IS NOT NULL OR NULLIF(Target.[qtr], Source.[qtr]) IS NOT NULL OR 
	NULLIF(Source.[numplays], Target.[numplays]) IS NOT NULL OR NULLIF(Target.[numplays], Source.[numplays]) IS NOT NULL OR 
	NULLIF(Source.[result], Target.[result]) IS NOT NULL OR NULLIF(Target.[result], Source.[result]) IS NOT NULL OR 
	NULLIF(Source.[ydsgained], Target.[ydsgained]) IS NOT NULL OR NULLIF(Target.[ydsgained], Source.[ydsgained]) IS NOT NULL OR 
	NULLIF(Source.[fds], Target.[fds]) IS NOT NULL OR NULLIF(Target.[fds], Source.[fds]) IS NOT NULL OR 
	NULLIF(Source.[penyds], Target.[penyds]) IS NOT NULL OR NULLIF(Target.[penyds], Source.[penyds]) IS NOT NULL OR 
	NULLIF(Source.[redzone], Target.[redzone]) IS NOT NULL OR NULLIF(Target.[redzone], Source.[redzone]) IS NOT NULL OR 
  Target.deletets IS NOT NULL) THEN
 UPDATE SET
  [start-team] = Source.[start-team], 
  [start-qtr] = Source.[start-qtr], 
  [start-time] = Source.[start-time], 
  [start-yrdln] = Source.[start-yrdln], 
  [end-team] = Source.[end-team], 
  [end-qtr] = Source.[end-qtr], 
  [end-time] = Source.[end-time], 
  [end-yrdln] = Source.[end-yrdln], 
  [posteam] = Source.[posteam], 
  [postime] = Source.[postime], 
  [qtr] = Source.[qtr], 
  [numplays] = Source.[numplays], 
  [result] = Source.[result], 
  [ydsgained] = Source.[ydsgained], 
  [fds] = Source.[fds], 
  [penyds] = Source.[penyds], 
  [redzone] = Source.[redzone],
   [modifyts] = @datetime,
    deletets = NULL 
WHEN NOT MATCHED BY TARGET THEN
 INSERT([eid],[drivenumber],[start-team],[start-qtr],[start-time],[start-yrdln],[end-team],[end-qtr],[end-time],[end-yrdln],[posteam],[postime],[qtr],[numplays],[result],[ydsgained],[fds],[penyds],[redzone],[createts],[modifyts],[deletets])
 VALUES(Source.[eid],Source.[drivenumber],Source.[start-team],Source.[start-qtr],Source.[start-time],Source.[start-yrdln],Source.[end-team],Source.[end-qtr],Source.[end-time],Source.[end-yrdln],Source.[posteam],Source.[postime],Source.[qtr],Source.[numplays],Source.[result],Source.[ydsgained],Source.[fds],Source.[penyds],Source.[redzone],@datetime,@datetime,NULL)
WHEN NOT MATCHED BY SOURCE AND Target.deletets IS NULL AND Target.eid IN  (SELECT DISTINCT eid FROM [LandNFL].[drive_vw])  THEN  
  UPDATE SET	deletets = @datetime
OUTPUT $action INTO @SummaryOfChanges
;
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [MasterNFL].[drive]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[MasterNFL].[drive] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100));
 END
;


DECLARE @rowcount int = @mergeCount, 
		@insert INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'INSERT'), 
		@update INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'update'), 
		@delete INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'DELETE')  
 EXEC dbo.LogProcedure @ProcID = @@PROCID, @RowCount = @rowcount,@insert = @insert,@update = @update, @delete = @delete, @starttime = @datetime, @isStart = false
;

SET NOCOUNT OFF
;
GO
/****** Object:  StoredProcedure [MasterNFL].[CDCgame]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [MasterNFL].[CDCgame]
AS
--MERGE generated by 'sp_generate_merge' stored procedure, Version 0.93
--Originally by Vyas (http://vyaskn.tripod.com): sp_generate_inserts (build 22)
--Adapted for SQL Server 2008/2012 by Daniel Nolan (http://danere.com)

SET NOCOUNT ON

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));
DECLARE @datetime DATETIMEOFFSET = GETDATE(); 
EXEC dbo.LogProcedure @ProcID =  @@PROCID, @TableName = '[MasterNFL].[game]', @starttime = @datetime, @isStart = true
;
MERGE INTO [MasterNFL].[game] AS Target
USING  ( 
Select [eid],[home-abbr],[home-players],[away-to],[away-score-1],[away-score-2],[away-score-3],[away-score-4],[away-score-5],[away-score-T],[away-stats-team-totfd],[away-stats-team-pt],[away-stats-team-ptyds],[away-stats-team-trnovr],[away-stats-team-pyds],[away-stats-team-ryds],[away-stats-team-totyds],[away-stats-team-ptavg],[away-stats-team-pen],[away-stats-team-penyds],[away-stats-team-top],[away-abbr],[away-players],[home-to],[home-score-1],[home-score-2],[home-score-3],[home-score-4],[home-score-5],[home-score-T],[home-stats-team-totfd],[home-stats-team-pt],[home-stats-team-ptyds],[home-stats-team-trnovr],[home-stats-team-pyds],[home-stats-team-ryds],[home-stats-team-totyds],[home-stats-team-ptavg],[home-stats-team-pen],[home-stats-team-penyds],[home-stats-team-top],[current-quarter]
 From[LandNFL].[game_vw]
) AS Source ([eid],[home-abbr],[home-players],[away-to],[away-score-1],[away-score-2],[away-score-3],[away-score-4],[away-score-5],[away-score-T],[away-stats-team-totfd],[away-stats-team-pt],[away-stats-team-ptyds],[away-stats-team-trnovr],[away-stats-team-pyds],[away-stats-team-ryds],[away-stats-team-totyds],[away-stats-team-ptavg],[away-stats-team-pen],[away-stats-team-penyds],[away-stats-team-top],[away-abbr],[away-players],[home-to],[home-score-1],[home-score-2],[home-score-3],[home-score-4],[home-score-5],[home-score-T],[home-stats-team-totfd],[home-stats-team-pt],[home-stats-team-ptyds],[home-stats-team-trnovr],[home-stats-team-pyds],[home-stats-team-ryds],[home-stats-team-totyds],[home-stats-team-ptavg],[home-stats-team-pen],[home-stats-team-penyds],[home-stats-team-top],[current-quarter])
ON (Target.[eid] = Source.[eid])
WHEN MATCHED AND (
	NULLIF(Source.[home-abbr], Target.[home-abbr]) IS NOT NULL OR NULLIF(Target.[home-abbr], Source.[home-abbr]) IS NOT NULL OR 
	NULLIF(Source.[home-players], Target.[home-players]) IS NOT NULL OR NULLIF(Target.[home-players], Source.[home-players]) IS NOT NULL OR 
	NULLIF(Source.[away-to], Target.[away-to]) IS NOT NULL OR NULLIF(Target.[away-to], Source.[away-to]) IS NOT NULL OR 
	NULLIF(Source.[away-score-1], Target.[away-score-1]) IS NOT NULL OR NULLIF(Target.[away-score-1], Source.[away-score-1]) IS NOT NULL OR 
	NULLIF(Source.[away-score-2], Target.[away-score-2]) IS NOT NULL OR NULLIF(Target.[away-score-2], Source.[away-score-2]) IS NOT NULL OR 
	NULLIF(Source.[away-score-3], Target.[away-score-3]) IS NOT NULL OR NULLIF(Target.[away-score-3], Source.[away-score-3]) IS NOT NULL OR 
	NULLIF(Source.[away-score-4], Target.[away-score-4]) IS NOT NULL OR NULLIF(Target.[away-score-4], Source.[away-score-4]) IS NOT NULL OR 
	NULLIF(Source.[away-score-5], Target.[away-score-5]) IS NOT NULL OR NULLIF(Target.[away-score-5], Source.[away-score-5]) IS NOT NULL OR 
	NULLIF(Source.[away-score-T], Target.[away-score-T]) IS NOT NULL OR NULLIF(Target.[away-score-T], Source.[away-score-T]) IS NOT NULL OR 
	NULLIF(Source.[away-stats-team-totfd], Target.[away-stats-team-totfd]) IS NOT NULL OR NULLIF(Target.[away-stats-team-totfd], Source.[away-stats-team-totfd]) IS NOT NULL OR 
	NULLIF(Source.[away-stats-team-pt], Target.[away-stats-team-pt]) IS NOT NULL OR NULLIF(Target.[away-stats-team-pt], Source.[away-stats-team-pt]) IS NOT NULL OR 
	NULLIF(Source.[away-stats-team-ptyds], Target.[away-stats-team-ptyds]) IS NOT NULL OR NULLIF(Target.[away-stats-team-ptyds], Source.[away-stats-team-ptyds]) IS NOT NULL OR 
	NULLIF(Source.[away-stats-team-trnovr], Target.[away-stats-team-trnovr]) IS NOT NULL OR NULLIF(Target.[away-stats-team-trnovr], Source.[away-stats-team-trnovr]) IS NOT NULL OR 
	NULLIF(Source.[away-stats-team-pyds], Target.[away-stats-team-pyds]) IS NOT NULL OR NULLIF(Target.[away-stats-team-pyds], Source.[away-stats-team-pyds]) IS NOT NULL OR 
	NULLIF(Source.[away-stats-team-ryds], Target.[away-stats-team-ryds]) IS NOT NULL OR NULLIF(Target.[away-stats-team-ryds], Source.[away-stats-team-ryds]) IS NOT NULL OR 
	NULLIF(Source.[away-stats-team-totyds], Target.[away-stats-team-totyds]) IS NOT NULL OR NULLIF(Target.[away-stats-team-totyds], Source.[away-stats-team-totyds]) IS NOT NULL OR 
	NULLIF(Source.[away-stats-team-ptavg], Target.[away-stats-team-ptavg]) IS NOT NULL OR NULLIF(Target.[away-stats-team-ptavg], Source.[away-stats-team-ptavg]) IS NOT NULL OR 
	NULLIF(Source.[away-stats-team-pen], Target.[away-stats-team-pen]) IS NOT NULL OR NULLIF(Target.[away-stats-team-pen], Source.[away-stats-team-pen]) IS NOT NULL OR 
	NULLIF(Source.[away-stats-team-penyds], Target.[away-stats-team-penyds]) IS NOT NULL OR NULLIF(Target.[away-stats-team-penyds], Source.[away-stats-team-penyds]) IS NOT NULL OR 
	NULLIF(Source.[away-stats-team-top], Target.[away-stats-team-top]) IS NOT NULL OR NULLIF(Target.[away-stats-team-top], Source.[away-stats-team-top]) IS NOT NULL OR 
	NULLIF(Source.[away-abbr], Target.[away-abbr]) IS NOT NULL OR NULLIF(Target.[away-abbr], Source.[away-abbr]) IS NOT NULL OR 
	NULLIF(Source.[away-players], Target.[away-players]) IS NOT NULL OR NULLIF(Target.[away-players], Source.[away-players]) IS NOT NULL OR 
	NULLIF(Source.[home-to], Target.[home-to]) IS NOT NULL OR NULLIF(Target.[home-to], Source.[home-to]) IS NOT NULL OR 
	NULLIF(Source.[home-score-1], Target.[home-score-1]) IS NOT NULL OR NULLIF(Target.[home-score-1], Source.[home-score-1]) IS NOT NULL OR 
	NULLIF(Source.[home-score-2], Target.[home-score-2]) IS NOT NULL OR NULLIF(Target.[home-score-2], Source.[home-score-2]) IS NOT NULL OR 
	NULLIF(Source.[home-score-3], Target.[home-score-3]) IS NOT NULL OR NULLIF(Target.[home-score-3], Source.[home-score-3]) IS NOT NULL OR 
	NULLIF(Source.[home-score-4], Target.[home-score-4]) IS NOT NULL OR NULLIF(Target.[home-score-4], Source.[home-score-4]) IS NOT NULL OR 
	NULLIF(Source.[home-score-5], Target.[home-score-5]) IS NOT NULL OR NULLIF(Target.[home-score-5], Source.[home-score-5]) IS NOT NULL OR 
	NULLIF(Source.[home-score-T], Target.[home-score-T]) IS NOT NULL OR NULLIF(Target.[home-score-T], Source.[home-score-T]) IS NOT NULL OR 
	NULLIF(Source.[home-stats-team-totfd], Target.[home-stats-team-totfd]) IS NOT NULL OR NULLIF(Target.[home-stats-team-totfd], Source.[home-stats-team-totfd]) IS NOT NULL OR 
	NULLIF(Source.[home-stats-team-pt], Target.[home-stats-team-pt]) IS NOT NULL OR NULLIF(Target.[home-stats-team-pt], Source.[home-stats-team-pt]) IS NOT NULL OR 
	NULLIF(Source.[home-stats-team-ptyds], Target.[home-stats-team-ptyds]) IS NOT NULL OR NULLIF(Target.[home-stats-team-ptyds], Source.[home-stats-team-ptyds]) IS NOT NULL OR 
	NULLIF(Source.[home-stats-team-trnovr], Target.[home-stats-team-trnovr]) IS NOT NULL OR NULLIF(Target.[home-stats-team-trnovr], Source.[home-stats-team-trnovr]) IS NOT NULL OR 
	NULLIF(Source.[home-stats-team-pyds], Target.[home-stats-team-pyds]) IS NOT NULL OR NULLIF(Target.[home-stats-team-pyds], Source.[home-stats-team-pyds]) IS NOT NULL OR 
	NULLIF(Source.[home-stats-team-ryds], Target.[home-stats-team-ryds]) IS NOT NULL OR NULLIF(Target.[home-stats-team-ryds], Source.[home-stats-team-ryds]) IS NOT NULL OR 
	NULLIF(Source.[home-stats-team-totyds], Target.[home-stats-team-totyds]) IS NOT NULL OR NULLIF(Target.[home-stats-team-totyds], Source.[home-stats-team-totyds]) IS NOT NULL OR 
	NULLIF(Source.[home-stats-team-ptavg], Target.[home-stats-team-ptavg]) IS NOT NULL OR NULLIF(Target.[home-stats-team-ptavg], Source.[home-stats-team-ptavg]) IS NOT NULL OR 
	NULLIF(Source.[home-stats-team-pen], Target.[home-stats-team-pen]) IS NOT NULL OR NULLIF(Target.[home-stats-team-pen], Source.[home-stats-team-pen]) IS NOT NULL OR 
	NULLIF(Source.[home-stats-team-penyds], Target.[home-stats-team-penyds]) IS NOT NULL OR NULLIF(Target.[home-stats-team-penyds], Source.[home-stats-team-penyds]) IS NOT NULL OR 
	NULLIF(Source.[home-stats-team-top], Target.[home-stats-team-top]) IS NOT NULL OR NULLIF(Target.[home-stats-team-top], Source.[home-stats-team-top]) IS NOT NULL OR 
	NULLIF(Source.[current-quarter], Target.[current-quarter]) IS NOT NULL OR NULLIF(Target.[current-quarter], Source.[current-quarter]) IS NOT NULL OR 
  Target.deletets IS NOT NULL) THEN
 UPDATE SET
  [home-abbr] = Source.[home-abbr], 
  [home-players] = Source.[home-players], 
  [away-to] = Source.[away-to], 
  [away-score-1] = Source.[away-score-1], 
  [away-score-2] = Source.[away-score-2], 
  [away-score-3] = Source.[away-score-3], 
  [away-score-4] = Source.[away-score-4], 
  [away-score-5] = Source.[away-score-5], 
  [away-score-T] = Source.[away-score-T], 
  [away-stats-team-totfd] = Source.[away-stats-team-totfd], 
  [away-stats-team-pt] = Source.[away-stats-team-pt], 
  [away-stats-team-ptyds] = Source.[away-stats-team-ptyds], 
  [away-stats-team-trnovr] = Source.[away-stats-team-trnovr], 
  [away-stats-team-pyds] = Source.[away-stats-team-pyds], 
  [away-stats-team-ryds] = Source.[away-stats-team-ryds], 
  [away-stats-team-totyds] = Source.[away-stats-team-totyds], 
  [away-stats-team-ptavg] = Source.[away-stats-team-ptavg], 
  [away-stats-team-pen] = Source.[away-stats-team-pen], 
  [away-stats-team-penyds] = Source.[away-stats-team-penyds], 
  [away-stats-team-top] = Source.[away-stats-team-top], 
  [away-abbr] = Source.[away-abbr], 
  [away-players] = Source.[away-players], 
  [home-to] = Source.[home-to], 
  [home-score-1] = Source.[home-score-1], 
  [home-score-2] = Source.[home-score-2], 
  [home-score-3] = Source.[home-score-3], 
  [home-score-4] = Source.[home-score-4], 
  [home-score-5] = Source.[home-score-5], 
  [home-score-T] = Source.[home-score-T], 
  [home-stats-team-totfd] = Source.[home-stats-team-totfd], 
  [home-stats-team-pt] = Source.[home-stats-team-pt], 
  [home-stats-team-ptyds] = Source.[home-stats-team-ptyds], 
  [home-stats-team-trnovr] = Source.[home-stats-team-trnovr], 
  [home-stats-team-pyds] = Source.[home-stats-team-pyds], 
  [home-stats-team-ryds] = Source.[home-stats-team-ryds], 
  [home-stats-team-totyds] = Source.[home-stats-team-totyds], 
  [home-stats-team-ptavg] = Source.[home-stats-team-ptavg], 
  [home-stats-team-pen] = Source.[home-stats-team-pen], 
  [home-stats-team-penyds] = Source.[home-stats-team-penyds], 
  [home-stats-team-top] = Source.[home-stats-team-top], 
  [current-quarter] = Source.[current-quarter],
   [modifyts] = @datetime,
    deletets = NULL 
WHEN NOT MATCHED BY TARGET THEN
 INSERT([eid],[home-abbr],[home-players],[away-to],[away-score-1],[away-score-2],[away-score-3],[away-score-4],[away-score-5],[away-score-T],[away-stats-team-totfd],[away-stats-team-pt],[away-stats-team-ptyds],[away-stats-team-trnovr],[away-stats-team-pyds],[away-stats-team-ryds],[away-stats-team-totyds],[away-stats-team-ptavg],[away-stats-team-pen],[away-stats-team-penyds],[away-stats-team-top],[away-abbr],[away-players],[home-to],[home-score-1],[home-score-2],[home-score-3],[home-score-4],[home-score-5],[home-score-T],[home-stats-team-totfd],[home-stats-team-pt],[home-stats-team-ptyds],[home-stats-team-trnovr],[home-stats-team-pyds],[home-stats-team-ryds],[home-stats-team-totyds],[home-stats-team-ptavg],[home-stats-team-pen],[home-stats-team-penyds],[home-stats-team-top],[current-quarter],[createts],[modifyts],[deletets])
 VALUES(Source.[eid],Source.[home-abbr],Source.[home-players],Source.[away-to],Source.[away-score-1],Source.[away-score-2],Source.[away-score-3],Source.[away-score-4],Source.[away-score-5],Source.[away-score-T],Source.[away-stats-team-totfd],Source.[away-stats-team-pt],Source.[away-stats-team-ptyds],Source.[away-stats-team-trnovr],Source.[away-stats-team-pyds],Source.[away-stats-team-ryds],Source.[away-stats-team-totyds],Source.[away-stats-team-ptavg],Source.[away-stats-team-pen],Source.[away-stats-team-penyds],Source.[away-stats-team-top],Source.[away-abbr],Source.[away-players],Source.[home-to],Source.[home-score-1],Source.[home-score-2],Source.[home-score-3],Source.[home-score-4],Source.[home-score-5],Source.[home-score-T],Source.[home-stats-team-totfd],Source.[home-stats-team-pt],Source.[home-stats-team-ptyds],Source.[home-stats-team-trnovr],Source.[home-stats-team-pyds],Source.[home-stats-team-ryds],Source.[home-stats-team-totyds],Source.[home-stats-team-ptavg],Source.[home-stats-team-pen],Source.[home-stats-team-penyds],Source.[home-stats-team-top],Source.[current-quarter],@datetime,@datetime,NULL)
WHEN NOT MATCHED BY SOURCE AND Target.deletets IS NULL AND Target.eid IN  (SELECT DISTINCT eid FROM [LandNFL].[game_vw])  THEN  
  UPDATE SET	deletets = @datetime
OUTPUT $action INTO @SummaryOfChanges
;
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [MasterNFL].[game]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[MasterNFL].[game] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100));
 END
;


DECLARE @rowcount int = @mergeCount, 
		@insert INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'INSERT'), 
		@update INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'update'), 
		@delete INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'DELETE')  
 EXEC dbo.LogProcedure @ProcID = @@PROCID, @RowCount = @rowcount,@insert = @insert,@update = @update, @delete = @delete, @starttime = @datetime, @isStart = false
;

SET NOCOUNT OFF
;
GO
/****** Object:  StoredProcedure [MasterNFL].[CDCplay]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [MasterNFL].[CDCplay]
as

--MERGE generated by 'sp_generate_merge' stored procedure, Version 0.93
--Originally by Vyas (http://vyaskn.tripod.com): sp_generate_inserts (build 22)
--Adapted for SQL Server 2008/2012 by Daniel Nolan (http://danere.com)

SET NOCOUNT ON

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));
DECLARE @datetime DATETIMEOFFSET = GETDATE(); 
EXEC dbo.LogProcedure @ProcID =  @@PROCID, @TableName = '[MasterNFL].[play]', @starttime = @datetime, @isStart = true
;
MERGE INTO [MasterNFL].[play] AS Target
USING  ( 
Select [eid],[drivenumber],[playnumber],[posteam],[desc],[ydstogo],[note],[qtr],[yrdln],[sp],[down],[time],[ydsnet]
 From[LandNFL].[play_vw]
) AS Source ([eid],[drivenumber],[playnumber],[posteam],[desc],[ydstogo],[note],[qtr],[yrdln],[sp],[down],[time],[ydsnet])
ON (Target.[drivenumber] = Source.[drivenumber] AND Target.[eid] = Source.[eid] AND Target.[playnumber] = Source.[playnumber])
WHEN MATCHED AND (
	NULLIF(Source.[posteam], Target.[posteam]) IS NOT NULL OR NULLIF(Target.[posteam], Source.[posteam]) IS NOT NULL OR 
	NULLIF(Source.[desc], Target.[desc]) IS NOT NULL OR NULLIF(Target.[desc], Source.[desc]) IS NOT NULL OR 
	NULLIF(Source.[ydstogo], Target.[ydstogo]) IS NOT NULL OR NULLIF(Target.[ydstogo], Source.[ydstogo]) IS NOT NULL OR 
	NULLIF(Source.[note], Target.[note]) IS NOT NULL OR NULLIF(Target.[note], Source.[note]) IS NOT NULL OR 
	NULLIF(Source.[qtr], Target.[qtr]) IS NOT NULL OR NULLIF(Target.[qtr], Source.[qtr]) IS NOT NULL OR 
	NULLIF(Source.[yrdln], Target.[yrdln]) IS NOT NULL OR NULLIF(Target.[yrdln], Source.[yrdln]) IS NOT NULL OR 
	NULLIF(Source.[sp], Target.[sp]) IS NOT NULL OR NULLIF(Target.[sp], Source.[sp]) IS NOT NULL OR 
	NULLIF(Source.[down], Target.[down]) IS NOT NULL OR NULLIF(Target.[down], Source.[down]) IS NOT NULL OR 
	NULLIF(Source.[time], Target.[time]) IS NOT NULL OR NULLIF(Target.[time], Source.[time]) IS NOT NULL OR 
	NULLIF(Source.[ydsnet], Target.[ydsnet]) IS NOT NULL OR NULLIF(Target.[ydsnet], Source.[ydsnet]) IS NOT NULL OR 
  Target.deletets IS NOT NULL) THEN
 UPDATE SET
  [posteam] = Source.[posteam], 
  [desc] = Source.[desc], 
  [ydstogo] = Source.[ydstogo], 
  [note] = Source.[note], 
  [qtr] = Source.[qtr], 
  [yrdln] = Source.[yrdln], 
  [sp] = Source.[sp], 
  [down] = Source.[down], 
  [time] = Source.[time], 
  [ydsnet] = Source.[ydsnet],
   [modifyts] = @datetime,
    deletets = NULL 
WHEN NOT MATCHED BY TARGET THEN
 INSERT([eid],[drivenumber],[playnumber],[posteam],[desc],[ydstogo],[note],[qtr],[yrdln],[sp],[down],[time],[ydsnet],[createts],[modifyts],[deletets])
 VALUES(Source.[eid],Source.[drivenumber],Source.[playnumber],Source.[posteam],Source.[desc],Source.[ydstogo],Source.[note],Source.[qtr],Source.[yrdln],Source.[sp],Source.[down],Source.[time],Source.[ydsnet],@datetime,@datetime,NULL)
WHEN NOT MATCHED BY SOURCE AND Target.deletets IS NULL AND Target.eid IN  (SELECT DISTINCT eid FROM [LandNFL].[play_vw])  THEN  
  UPDATE SET	deletets = @datetime
OUTPUT $action INTO @SummaryOfChanges
;
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [MasterNFL].[play]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[MasterNFL].[play] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100));
 END
;


DECLARE @rowcount int = @mergeCount, 
		@insert INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'INSERT'), 
		@update INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'update'), 
		@delete INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'DELETE')  
 EXEC dbo.LogProcedure @ProcID = @@PROCID, @RowCount = @rowcount,@insert = @insert,@update = @update, @delete = @delete, @starttime = @datetime, @isStart = false
;

SET NOCOUNT OFF
;
GO
/****** Object:  StoredProcedure [MasterNFL].[CDCplayplayer]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [MasterNFL].[CDCplayplayer]
AS

--MERGE generated by 'sp_generate_merge' stored procedure, Version 0.93
--Originally by Vyas (http://vyaskn.tripod.com): sp_generate_inserts (build 22)
--Adapted for SQL Server 2008/2012 by Daniel Nolan (http://danere.com)

SET NOCOUNT ON

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));
DECLARE @datetime DATETIMEOFFSET = GETDATE(); 
EXEC dbo.LogProcedure @ProcID =  @@PROCID, @TableName = '[MasterNFL].[playplayer]', @starttime = @datetime, @isStart = true
;
MERGE INTO [MasterNFL].[playplayer] AS Target
USING  ( 
Select [eid],[drivenumber],[playnumber],[playerid],[statId],[sequence],[playerName],[clubcode],[yards]
 From[LandNFL].[playplayer_vw]
) AS Source ([eid],[drivenumber],[playnumber],[playerid],[statId],[sequence],[playerName],[clubcode],[yards])
ON (Target.[drivenumber] = Source.[drivenumber] AND Target.[eid] = Source.[eid] AND Target.[playerid] = Source.[playerid] AND Target.[playnumber] = Source.[playnumber])
WHEN MATCHED AND (
	NULLIF(Source.[statId], Target.[statId]) IS NOT NULL OR NULLIF(Target.[statId], Source.[statId]) IS NOT NULL OR 
	NULLIF(Source.[sequence], Target.[sequence]) IS NOT NULL OR NULLIF(Target.[sequence], Source.[sequence]) IS NOT NULL OR 
	NULLIF(Source.[playerName], Target.[playerName]) IS NOT NULL OR NULLIF(Target.[playerName], Source.[playerName]) IS NOT NULL OR 
	NULLIF(Source.[clubcode], Target.[clubcode]) IS NOT NULL OR NULLIF(Target.[clubcode], Source.[clubcode]) IS NOT NULL OR 
	NULLIF(Source.[yards], Target.[yards]) IS NOT NULL OR NULLIF(Target.[yards], Source.[yards]) IS NOT NULL OR 
  Target.deletets IS NOT NULL) THEN
 UPDATE SET
  [statId] = Source.[statId], 
  [sequence] = Source.[sequence], 
  [playerName] = Source.[playerName], 
  [clubcode] = Source.[clubcode], 
  [yards] = Source.[yards],
   [modifyts] = @datetime,
    deletets = NULL 
WHEN NOT MATCHED BY TARGET THEN
 INSERT([eid],[drivenumber],[playnumber],[playerid],[statId],[sequence],[playerName],[clubcode],[yards],[createts],[modifyts],[deletets])
 VALUES(Source.[eid],Source.[drivenumber],Source.[playnumber],Source.[playerid],Source.[statId],Source.[sequence],Source.[playerName],Source.[clubcode],Source.[yards],@datetime,@datetime,NULL)
WHEN NOT MATCHED BY SOURCE AND Target.deletets IS NULL AND Target.eid IN  (SELECT DISTINCT eid FROM [LandNFL].[playplayer_vw])  THEN  
  UPDATE SET	deletets = @datetime
OUTPUT $action INTO @SummaryOfChanges
;
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [MasterNFL].[playplayer]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[MasterNFL].[playplayer] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100));
 END
;


DECLARE @rowcount int = @mergeCount, 
		@insert INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'INSERT'), 
		@update INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'update'), 
		@delete INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'DELETE')  
 EXEC dbo.LogProcedure @ProcID = @@PROCID, @RowCount = @rowcount,@insert = @insert,@update = @update, @delete = @delete, @starttime = @datetime, @isStart = false
;

SET NOCOUNT OFF
;
GO
/****** Object:  StoredProcedure [MasterNFL].[CDCSchedule]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [MasterNFL].[CDCSchedule]
AS 

--MERGE generated by 'sp_generate_merge' stored procedure, Version 0.93
--Originally by Vyas (http://vyaskn.tripod.com): sp_generate_inserts (build 22)
--Adapted for SQL Server 2008/2012 by Daniel Nolan (http://danere.com)

SET NOCOUNT ON

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));
DECLARE @datetime DATETIMEOFFSET = GETDATE(); 
EXEC dbo.LogProcedure @ProcID =  @@PROCID, @TableName = '[MasterNFL].[schedule]', @starttime = @datetime, @isStart = true
;
MERGE INTO [MasterNFL].[schedule] AS Target
USING  ( 
Select [eid],[gsis],[SeasonYear],[SeasonType],[SeasonTypeDetail],[wkNumber],[DayName],[GameTime],[GameTimeUTC],[Qtr],[HomeTeam],[HomeTeamName],[AwayTeam],[AwayTeamName]
 From[LandNFL].[schedule_vw]
) AS Source ([eid],[gsis],[SeasonYear],[SeasonType],[SeasonTypeDetail],[wkNumber],[DayName],[GameTime],[GameTimeUTC],[Qtr],[HomeTeam],[HomeTeamName],[AwayTeam],[AwayTeamName])
ON (Target.[eid] = Source.[eid])
WHEN MATCHED AND (
	NULLIF(Source.[gsis], Target.[gsis]) IS NOT NULL OR NULLIF(Target.[gsis], Source.[gsis]) IS NOT NULL OR 
	NULLIF(Source.[SeasonYear], Target.[SeasonYear]) IS NOT NULL OR NULLIF(Target.[SeasonYear], Source.[SeasonYear]) IS NOT NULL OR 
	NULLIF(Source.[SeasonType], Target.[SeasonType]) IS NOT NULL OR NULLIF(Target.[SeasonType], Source.[SeasonType]) IS NOT NULL OR 
	NULLIF(Source.[SeasonTypeDetail], Target.[SeasonTypeDetail]) IS NOT NULL OR NULLIF(Target.[SeasonTypeDetail], Source.[SeasonTypeDetail]) IS NOT NULL OR 
	NULLIF(Source.[wkNumber], Target.[wkNumber]) IS NOT NULL OR NULLIF(Target.[wkNumber], Source.[wkNumber]) IS NOT NULL OR 
	NULLIF(Source.[DayName], Target.[DayName]) IS NOT NULL OR NULLIF(Target.[DayName], Source.[DayName]) IS NOT NULL OR 
	NULLIF(Source.[GameTime], Target.[GameTime]) IS NOT NULL OR NULLIF(Target.[GameTime], Source.[GameTime]) IS NOT NULL OR 
	NULLIF(Source.[GameTimeUTC], Target.[GameTimeUTC]) IS NOT NULL OR NULLIF(Target.[GameTimeUTC], Source.[GameTimeUTC]) IS NOT NULL OR 
	NULLIF(Source.[Qtr], Target.[Qtr]) IS NOT NULL OR NULLIF(Target.[Qtr], Source.[Qtr]) IS NOT NULL OR 
	NULLIF(Source.[HomeTeam], Target.[HomeTeam]) IS NOT NULL OR NULLIF(Target.[HomeTeam], Source.[HomeTeam]) IS NOT NULL OR 
	NULLIF(Source.[HomeTeamName], Target.[HomeTeamName]) IS NOT NULL OR NULLIF(Target.[HomeTeamName], Source.[HomeTeamName]) IS NOT NULL OR 
	NULLIF(Source.[AwayTeam], Target.[AwayTeam]) IS NOT NULL OR NULLIF(Target.[AwayTeam], Source.[AwayTeam]) IS NOT NULL OR 
	NULLIF(Source.[AwayTeamName], Target.[AwayTeamName]) IS NOT NULL OR NULLIF(Target.[AwayTeamName], Source.[AwayTeamName]) IS NOT NULL OR 
  Target.deletets IS NOT NULL) THEN
 UPDATE SET
  [gsis] = Source.[gsis], 
  [SeasonYear] = Source.[SeasonYear], 
  [SeasonType] = Source.[SeasonType], 
  [SeasonTypeDetail] = Source.[SeasonTypeDetail], 
  [wkNumber] = Source.[wkNumber], 
  [DayName] = Source.[DayName], 
  [GameTime] = Source.[GameTime], 
  [GameTimeUTC] = Source.[GameTimeUTC], 
  [Qtr] = Source.[Qtr], 
  [HomeTeam] = Source.[HomeTeam], 
  [HomeTeamName] = Source.[HomeTeamName], 
  [AwayTeam] = Source.[AwayTeam], 
  [AwayTeamName] = Source.[AwayTeamName],
   [modifyts] = @datetime,
    deletets = NULL 
WHEN NOT MATCHED BY TARGET THEN
 INSERT([eid],[gsis],[SeasonYear],[SeasonType],[SeasonTypeDetail],[wkNumber],[DayName],[GameTime],[GameTimeUTC],[Qtr],[HomeTeam],[HomeTeamName],[AwayTeam],[AwayTeamName],[createts],[modifyts],[deletets])
 VALUES(Source.[eid],Source.[gsis],Source.[SeasonYear],Source.[SeasonType],Source.[SeasonTypeDetail],Source.[wkNumber],Source.[DayName],Source.[GameTime],Source.[GameTimeUTC],Source.[Qtr],Source.[HomeTeam],Source.[HomeTeamName],Source.[AwayTeam],Source.[AwayTeamName],@datetime,@datetime,NULL)
WHEN NOT MATCHED BY SOURCE AND Target.deletets IS NULL AND Target.eid IN  (SELECT DISTINCT eid FROM [LandNFL].[Schedule_vw] )  THEN  
  UPDATE SET	deletets = @datetime
OUTPUT $action INTO @SummaryOfChanges
;
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [MasterNFL].[schedule]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[MasterNFL].[schedule] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100));
 END
;


DECLARE @rowcount int = @mergeCount, 
		@insert INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'INSERT'), 
		@update INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'update'), 
		@delete INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'DELETE')  
 EXEC dbo.LogProcedure @ProcID = @@PROCID, @RowCount = @rowcount,@insert = @insert,@update = @update, @delete = @delete, @starttime = @datetime, @isStart = false
;

SET NOCOUNT OFF
;
GO
/****** Object:  StoredProcedure [NFLDB].[BuildDrive]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [NFLDB].[BuildDrive]
AS

--MERGE generated by 'sp_generate_merge' stored procedure, Version 0.93
--Originally by Vyas (http://vyaskn.tripod.com): sp_generate_inserts (build 22)
--Adapted for SQL Server 2008/2012 by Daniel Nolan (http://danere.com)

SET NOCOUNT ON

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));
DECLARE @datetime DATETIMEOFFSET = GETDATE(); 
EXEC dbo.LogProcedure @ProcID =  @@PROCID, @TableName = '[nfldb].[Drive]', @starttime = @datetime, @isStart = true
;
MERGE INTO [nfldb].[Drive] AS Target
USING  ( 
Select [ScheduleKey],[DriveNumber],[StartTeam],[StartQtr],[StartTime],[StartTimeSec],[StartYardLine],[StartRelativeYardLine],[EndTeam],[EndQtr],[EndTime],[EndTimeSec],[EndYardLine],[EndRelativeYardLine],[PossessionTeam],[PossessionTime],[PossessionTimeSec],[Qtr],[PlayCount],[Result],[YardsGained],[FirstDowns],[PenaltyYards],[RedZone]
 From[nfldb].Drive_vw
) AS Source ([ScheduleKey],[DriveNumber],[StartTeam],[StartQtr],[StartTime],[StartTimeSec],[StartYardLine],[StartRelativeYardLine],[EndTeam],[EndQtr],[EndTime],[EndTimeSec],[EndYardLine],[EndRelativeYardLine],[PossessionTeam],[PossessionTime],[PossessionTimeSec],[Qtr],[PlayCount],[Result],[YardsGained],[FirstDowns],[PenaltyYards],[RedZone])
ON (Target.[ScheduleKey] = Source.[ScheduleKey] AND Target.[DriveNumber] = Source.[DriveNumber])
WHEN MATCHED AND (
	NULLIF(Source.[ScheduleKey], Target.[ScheduleKey]) IS NOT NULL OR NULLIF(Target.[ScheduleKey], Source.[ScheduleKey]) IS NOT NULL OR 
	NULLIF(Source.[DriveNumber], Target.[DriveNumber]) IS NOT NULL OR NULLIF(Target.[DriveNumber], Source.[DriveNumber]) IS NOT NULL OR 
	NULLIF(Source.[StartTeam], Target.[StartTeam]) IS NOT NULL OR NULLIF(Target.[StartTeam], Source.[StartTeam]) IS NOT NULL OR 
	NULLIF(Source.[StartQtr], Target.[StartQtr]) IS NOT NULL OR NULLIF(Target.[StartQtr], Source.[StartQtr]) IS NOT NULL OR 
	NULLIF(Source.[StartTime], Target.[StartTime]) IS NOT NULL OR NULLIF(Target.[StartTime], Source.[StartTime]) IS NOT NULL OR 
	NULLIF(Source.[StartTimeSec], Target.[StartTimeSec]) IS NOT NULL OR NULLIF(Target.[StartTimeSec], Source.[StartTimeSec]) IS NOT NULL OR 
	NULLIF(Source.[StartYardLine], Target.[StartYardLine]) IS NOT NULL OR NULLIF(Target.[StartYardLine], Source.[StartYardLine]) IS NOT NULL OR 
	NULLIF(Source.[StartRelativeYardLine], Target.[StartRelativeYardLine]) IS NOT NULL OR NULLIF(Target.[StartRelativeYardLine], Source.[StartRelativeYardLine]) IS NOT NULL OR 
	NULLIF(Source.[EndTeam], Target.[EndTeam]) IS NOT NULL OR NULLIF(Target.[EndTeam], Source.[EndTeam]) IS NOT NULL OR 
	NULLIF(Source.[EndQtr], Target.[EndQtr]) IS NOT NULL OR NULLIF(Target.[EndQtr], Source.[EndQtr]) IS NOT NULL OR 
	NULLIF(Source.[EndTime], Target.[EndTime]) IS NOT NULL OR NULLIF(Target.[EndTime], Source.[EndTime]) IS NOT NULL OR 
	NULLIF(Source.[EndTimeSec], Target.[EndTimeSec]) IS NOT NULL OR NULLIF(Target.[EndTimeSec], Source.[EndTimeSec]) IS NOT NULL OR 
	NULLIF(Source.[EndYardLine], Target.[EndYardLine]) IS NOT NULL OR NULLIF(Target.[EndYardLine], Source.[EndYardLine]) IS NOT NULL OR 
	NULLIF(Source.[EndRelativeYardLine], Target.[EndRelativeYardLine]) IS NOT NULL OR NULLIF(Target.[EndRelativeYardLine], Source.[EndRelativeYardLine]) IS NOT NULL OR 
	NULLIF(Source.[PossessionTeam], Target.[PossessionTeam]) IS NOT NULL OR NULLIF(Target.[PossessionTeam], Source.[PossessionTeam]) IS NOT NULL OR 
	NULLIF(Source.[PossessionTime], Target.[PossessionTime]) IS NOT NULL OR NULLIF(Target.[PossessionTime], Source.[PossessionTime]) IS NOT NULL OR 
	NULLIF(Source.[PossessionTimeSec], Target.[PossessionTimeSec]) IS NOT NULL OR NULLIF(Target.[PossessionTimeSec], Source.[PossessionTimeSec]) IS NOT NULL OR 
	NULLIF(Source.[Qtr], Target.[Qtr]) IS NOT NULL OR NULLIF(Target.[Qtr], Source.[Qtr]) IS NOT NULL OR 
	NULLIF(Source.[PlayCount], Target.[PlayCount]) IS NOT NULL OR NULLIF(Target.[PlayCount], Source.[PlayCount]) IS NOT NULL OR 
	NULLIF(Source.[Result], Target.[Result]) IS NOT NULL OR NULLIF(Target.[Result], Source.[Result]) IS NOT NULL OR 
	NULLIF(Source.[YardsGained], Target.[YardsGained]) IS NOT NULL OR NULLIF(Target.[YardsGained], Source.[YardsGained]) IS NOT NULL OR 
	NULLIF(Source.[FirstDowns], Target.[FirstDowns]) IS NOT NULL OR NULLIF(Target.[FirstDowns], Source.[FirstDowns]) IS NOT NULL OR 
	NULLIF(Source.[PenaltyYards], Target.[PenaltyYards]) IS NOT NULL OR NULLIF(Target.[PenaltyYards], Source.[PenaltyYards]) IS NOT NULL OR 
	NULLIF(Source.[RedZone], Target.[RedZone]) IS NOT NULL OR NULLIF(Target.[RedZone], Source.[RedZone]) IS NOT NULL) THEN 
 UPDATE SET
  [ScheduleKey] = Source.[ScheduleKey], 
  [DriveNumber] = Source.[DriveNumber], 
  [StartTeam] = Source.[StartTeam], 
  [StartQtr] = Source.[StartQtr], 
  [StartTime] = Source.[StartTime], 
  [StartTimeSec] = Source.[StartTimeSec], 
  [StartYardLine] = Source.[StartYardLine], 
  [StartRelativeYardLine] = Source.[StartRelativeYardLine], 
  [EndTeam] = Source.[EndTeam], 
  [EndQtr] = Source.[EndQtr], 
  [EndTime] = Source.[EndTime], 
  [EndTimeSec] = Source.[EndTimeSec], 
  [EndYardLine] = Source.[EndYardLine], 
  [EndRelativeYardLine] = Source.[EndRelativeYardLine], 
  [PossessionTeam] = Source.[PossessionTeam], 
  [PossessionTime] = Source.[PossessionTime], 
  [PossessionTimeSec] = Source.[PossessionTimeSec], 
  [Qtr] = Source.[Qtr], 
  [PlayCount] = Source.[PlayCount], 
  [Result] = Source.[Result], 
  [YardsGained] = Source.[YardsGained], 
  [FirstDowns] = Source.[FirstDowns], 
  [PenaltyYards] = Source.[PenaltyYards], 
  [RedZone] = Source.[RedZone]
WHEN NOT MATCHED BY TARGET THEN
 INSERT([ScheduleKey],[DriveNumber],[StartTeam],[StartQtr],[StartTime],[StartTimeSec],[StartYardLine],[StartRelativeYardLine],[EndTeam],[EndQtr],[EndTime],[EndTimeSec],[EndYardLine],[EndRelativeYardLine],[PossessionTeam],[PossessionTime],[PossessionTimeSec],[Qtr],[PlayCount],[Result],[YardsGained],[FirstDowns],[PenaltyYards],[RedZone] )
 VALUES(Source.[ScheduleKey],Source.[DriveNumber],Source.[StartTeam],Source.[StartQtr],Source.[StartTime],Source.[StartTimeSec],Source.[StartYardLine],Source.[StartRelativeYardLine],Source.[EndTeam],Source.[EndQtr],Source.[EndTime],Source.[EndTimeSec],Source.[EndYardLine],Source.[EndRelativeYardLine],Source.[PossessionTeam],Source.[PossessionTime],Source.[PossessionTimeSec],Source.[Qtr],Source.[PlayCount],Source.[Result],Source.[YardsGained],Source.[FirstDowns],Source.[PenaltyYards],Source.[RedZone])
WHEN NOT MATCHED BY SOURCE THEN 
 DELETE
 OUTPUT $action INTO @SummaryOfChanges 
;
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [nfldb].[Drive]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[nfldb].[Drive] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100));
 END
;


DECLARE @rowcount int = @mergeCount, 
		@insert INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'INSERT'), 
		@update INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'update'), 
		@delete INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'DELETE')  
 EXEC dbo.LogProcedure @ProcID = @@PROCID, @RowCount = @rowcount,@insert = @insert,@update = @update, @delete = @delete, @starttime = @datetime, @isStart = false
;

SET NOCOUNT OFF
;
GO
/****** Object:  StoredProcedure [NFLDB].[BuildFranchise]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [NFLDB].[BuildFranchise] 
AS

--MERGE generated by 'sp_generate_merge' stored procedure, Version 0.93
--Originally by Vyas (http://vyaskn.tripod.com): sp_generate_inserts (build 22)
--Adapted for SQL Server 2008/2012 by Daniel Nolan (http://danere.com)

SET NOCOUNT ON

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));
DECLARE @datetime DATETIMEOFFSET = GETDATE(); 
EXEC dbo.LogProcedure @ProcID =  @@PROCID, @TableName = '[nfldb].[Franchise]', @starttime = @datetime, @isStart = true
;
MERGE INTO [nfldb].[Franchise] AS Target
USING  ( 
Select [Team],[From],[To],[W],[L],[T],[W-L%],[AV],[Passer],[Rusher],[Receiver],[Coaching],[Yrplyf],[Chmp],[SBwl],[Conf],[Div]
 From[nfldb].[Franchise_vw]
) AS Source ([Team],[From],[To],[W],[L],[T],[W-L%],[AV],[Passer],[Rusher],[Receiver],[Coaching],[Yrplyf],[Chmp],[SBwl],[Conf],[Div])
ON (Target.[Team] = Source.[Team])
WHEN MATCHED AND (
	NULLIF(Source.[Team], Target.[Team]) IS NOT NULL OR NULLIF(Target.[Team], Source.[Team]) IS NOT NULL OR 
	NULLIF(Source.[From], Target.[From]) IS NOT NULL OR NULLIF(Target.[From], Source.[From]) IS NOT NULL OR 
	NULLIF(Source.[To], Target.[To]) IS NOT NULL OR NULLIF(Target.[To], Source.[To]) IS NOT NULL OR 
	NULLIF(Source.[W], Target.[W]) IS NOT NULL OR NULLIF(Target.[W], Source.[W]) IS NOT NULL OR 
	NULLIF(Source.[L], Target.[L]) IS NOT NULL OR NULLIF(Target.[L], Source.[L]) IS NOT NULL OR 
	NULLIF(Source.[T], Target.[T]) IS NOT NULL OR NULLIF(Target.[T], Source.[T]) IS NOT NULL OR 
	NULLIF(Source.[W-L%], Target.[W-L%]) IS NOT NULL OR NULLIF(Target.[W-L%], Source.[W-L%]) IS NOT NULL OR 
	NULLIF(Source.[AV], Target.[AV]) IS NOT NULL OR NULLIF(Target.[AV], Source.[AV]) IS NOT NULL OR 
	NULLIF(Source.[Passer], Target.[Passer]) IS NOT NULL OR NULLIF(Target.[Passer], Source.[Passer]) IS NOT NULL OR 
	NULLIF(Source.[Rusher], Target.[Rusher]) IS NOT NULL OR NULLIF(Target.[Rusher], Source.[Rusher]) IS NOT NULL OR 
	NULLIF(Source.[Receiver], Target.[Receiver]) IS NOT NULL OR NULLIF(Target.[Receiver], Source.[Receiver]) IS NOT NULL OR 
	NULLIF(Source.[Coaching], Target.[Coaching]) IS NOT NULL OR NULLIF(Target.[Coaching], Source.[Coaching]) IS NOT NULL OR 
	NULLIF(Source.[Yrplyf], Target.[Yrplyf]) IS NOT NULL OR NULLIF(Target.[Yrplyf], Source.[Yrplyf]) IS NOT NULL OR 
	NULLIF(Source.[Chmp], Target.[Chmp]) IS NOT NULL OR NULLIF(Target.[Chmp], Source.[Chmp]) IS NOT NULL OR 
	NULLIF(Source.[SBwl], Target.[SBwl]) IS NOT NULL OR NULLIF(Target.[SBwl], Source.[SBwl]) IS NOT NULL OR 
	NULLIF(Source.[Conf], Target.[Conf]) IS NOT NULL OR NULLIF(Target.[Conf], Source.[Conf]) IS NOT NULL OR 
	NULLIF(Source.[Div], Target.[Div]) IS NOT NULL OR NULLIF(Target.[Div], Source.[Div]) IS NOT NULL) THEN 
 UPDATE SET
  [Team] = Source.[Team], 
  [From] = Source.[From], 
  [To] = Source.[To], 
  [W] = Source.[W], 
  [L] = Source.[L], 
  [T] = Source.[T], 
  [W-L%] = Source.[W-L%], 
  [AV] = Source.[AV], 
  [Passer] = Source.[Passer], 
  [Rusher] = Source.[Rusher], 
  [Receiver] = Source.[Receiver], 
  [Coaching] = Source.[Coaching], 
  [Yrplyf] = Source.[Yrplyf], 
  [Chmp] = Source.[Chmp], 
  [SBwl] = Source.[SBwl], 
  [Conf] = Source.[Conf], 
  [Div] = Source.[Div]
WHEN NOT MATCHED BY TARGET THEN
 INSERT([Team],[From],[To],[W],[L],[T],[W-L%],[AV],[Passer],[Rusher],[Receiver],[Coaching],[Yrplyf],[Chmp],[SBwl],[Conf],[Div] )
 VALUES(Source.[Team],Source.[From],Source.[To],Source.[W],Source.[L],Source.[T],Source.[W-L%],Source.[AV],Source.[Passer],Source.[Rusher],Source.[Receiver],Source.[Coaching],Source.[Yrplyf],Source.[Chmp],Source.[SBwl],Source.[Conf],Source.[Div])
WHEN NOT MATCHED BY SOURCE THEN 
 DELETE
 OUTPUT $action INTO @SummaryOfChanges 
;
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [nfldb].[Franchise]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[nfldb].[Franchise] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100));
 END
;


DECLARE @rowcount int = @mergeCount, 
		@insert INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'INSERT'), 
		@update INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'update'), 
		@delete INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'DELETE')  
 EXEC dbo.LogProcedure @ProcID = @@PROCID, @RowCount = @rowcount,@insert = @insert,@update = @update, @delete = @delete, @starttime = @datetime, @isStart = false
;

SET NOCOUNT OFF
;


GO
/****** Object:  StoredProcedure [NFLDB].[BuildGame]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [NFLDB].[BuildGame] 
AS 
--MERGE generated by 'sp_generate_merge' stored procedure, Version 0.93
--Originally by Vyas (http://vyaskn.tripod.com): sp_generate_inserts (build 22)
--Adapted for SQL Server 2008/2012 by Daniel Nolan (http://danere.com)

SET NOCOUNT ON

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));
DECLARE @datetime DATETIMEOFFSET = GETDATE(); 
EXEC dbo.LogProcedure @ProcID =  @@PROCID, @TableName = '[nfldb].[game]', @starttime = @datetime, @isStart = true
;
MERGE INTO [nfldb].[game] AS Target
USING  ( 
Select [ScheduleKey],[GameID],[HomeAbbr],[HomeTurnOver],[HomeScoreQ1],[HomeScoreQ2],[HomeScoreQ3],[HomeScoreQ4],[HomeScoreQ5],[HomeScoreTotal],[AwayAbbr],[AwayTurnOver],[AwayScoreQ1],[AwayScoreQ2],[AwayScoreQ3],[AwayScoreQ4],[AwayScoreQ5],[AwayScoreTotal]
 From[nfldb].[game_vw]
) AS Source ([ScheduleKey],[GameID],[HomeAbbr],[HomeTurnOver],[HomeScoreQ1],[HomeScoreQ2],[HomeScoreQ3],[HomeScoreQ4],[HomeScoreQ5],[HomeScoreTotal],[AwayAbbr],[AwayTurnOver],[AwayScoreQ1],[AwayScoreQ2],[AwayScoreQ3],[AwayScoreQ4],[AwayScoreQ5],[AwayScoreTotal])
ON (Target.[GameID] = Source.[GameID])
WHEN MATCHED AND (
	NULLIF(Source.[ScheduleKey], Target.[ScheduleKey]) IS NOT NULL OR NULLIF(Target.[ScheduleKey], Source.[ScheduleKey]) IS NOT NULL OR 
	NULLIF(Source.[GameID], Target.[GameID]) IS NOT NULL OR NULLIF(Target.[GameID], Source.[GameID]) IS NOT NULL OR 
	NULLIF(Source.[HomeAbbr], Target.[HomeAbbr]) IS NOT NULL OR NULLIF(Target.[HomeAbbr], Source.[HomeAbbr]) IS NOT NULL OR 
	NULLIF(Source.[HomeTurnOver], Target.[HomeTurnOver]) IS NOT NULL OR NULLIF(Target.[HomeTurnOver], Source.[HomeTurnOver]) IS NOT NULL OR 
	NULLIF(Source.[HomeScoreQ1], Target.[HomeScoreQ1]) IS NOT NULL OR NULLIF(Target.[HomeScoreQ1], Source.[HomeScoreQ1]) IS NOT NULL OR 
	NULLIF(Source.[HomeScoreQ2], Target.[HomeScoreQ2]) IS NOT NULL OR NULLIF(Target.[HomeScoreQ2], Source.[HomeScoreQ2]) IS NOT NULL OR 
	NULLIF(Source.[HomeScoreQ3], Target.[HomeScoreQ3]) IS NOT NULL OR NULLIF(Target.[HomeScoreQ3], Source.[HomeScoreQ3]) IS NOT NULL OR 
	NULLIF(Source.[HomeScoreQ4], Target.[HomeScoreQ4]) IS NOT NULL OR NULLIF(Target.[HomeScoreQ4], Source.[HomeScoreQ4]) IS NOT NULL OR 
	NULLIF(Source.[HomeScoreQ5], Target.[HomeScoreQ5]) IS NOT NULL OR NULLIF(Target.[HomeScoreQ5], Source.[HomeScoreQ5]) IS NOT NULL OR 
	NULLIF(Source.[HomeScoreTotal], Target.[HomeScoreTotal]) IS NOT NULL OR NULLIF(Target.[HomeScoreTotal], Source.[HomeScoreTotal]) IS NOT NULL OR 
	NULLIF(Source.[AwayAbbr], Target.[AwayAbbr]) IS NOT NULL OR NULLIF(Target.[AwayAbbr], Source.[AwayAbbr]) IS NOT NULL OR 
	NULLIF(Source.[AwayTurnOver], Target.[AwayTurnOver]) IS NOT NULL OR NULLIF(Target.[AwayTurnOver], Source.[AwayTurnOver]) IS NOT NULL OR 
	NULLIF(Source.[AwayScoreQ1], Target.[AwayScoreQ1]) IS NOT NULL OR NULLIF(Target.[AwayScoreQ1], Source.[AwayScoreQ1]) IS NOT NULL OR 
	NULLIF(Source.[AwayScoreQ2], Target.[AwayScoreQ2]) IS NOT NULL OR NULLIF(Target.[AwayScoreQ2], Source.[AwayScoreQ2]) IS NOT NULL OR 
	NULLIF(Source.[AwayScoreQ3], Target.[AwayScoreQ3]) IS NOT NULL OR NULLIF(Target.[AwayScoreQ3], Source.[AwayScoreQ3]) IS NOT NULL OR 
	NULLIF(Source.[AwayScoreQ4], Target.[AwayScoreQ4]) IS NOT NULL OR NULLIF(Target.[AwayScoreQ4], Source.[AwayScoreQ4]) IS NOT NULL OR 
	NULLIF(Source.[AwayScoreQ5], Target.[AwayScoreQ5]) IS NOT NULL OR NULLIF(Target.[AwayScoreQ5], Source.[AwayScoreQ5]) IS NOT NULL OR 
	NULLIF(Source.[AwayScoreTotal], Target.[AwayScoreTotal]) IS NOT NULL OR NULLIF(Target.[AwayScoreTotal], Source.[AwayScoreTotal]) IS NOT NULL) THEN 
 UPDATE SET
  [ScheduleKey] = Source.[ScheduleKey], 
  [GameID] = Source.[GameID], 
  [HomeAbbr] = Source.[HomeAbbr], 
  [HomeTurnOver] = Source.[HomeTurnOver], 
  [HomeScoreQ1] = Source.[HomeScoreQ1], 
  [HomeScoreQ2] = Source.[HomeScoreQ2], 
  [HomeScoreQ3] = Source.[HomeScoreQ3], 
  [HomeScoreQ4] = Source.[HomeScoreQ4], 
  [HomeScoreQ5] = Source.[HomeScoreQ5], 
  [HomeScoreTotal] = Source.[HomeScoreTotal], 
  [AwayAbbr] = Source.[AwayAbbr], 
  [AwayTurnOver] = Source.[AwayTurnOver], 
  [AwayScoreQ1] = Source.[AwayScoreQ1], 
  [AwayScoreQ2] = Source.[AwayScoreQ2], 
  [AwayScoreQ3] = Source.[AwayScoreQ3], 
  [AwayScoreQ4] = Source.[AwayScoreQ4], 
  [AwayScoreQ5] = Source.[AwayScoreQ5], 
  [AwayScoreTotal] = Source.[AwayScoreTotal]
WHEN NOT MATCHED BY TARGET THEN
 INSERT([ScheduleKey],[GameID],[HomeAbbr],[HomeTurnOver],[HomeScoreQ1],[HomeScoreQ2],[HomeScoreQ3],[HomeScoreQ4],[HomeScoreQ5],[HomeScoreTotal],[AwayAbbr],[AwayTurnOver],[AwayScoreQ1],[AwayScoreQ2],[AwayScoreQ3],[AwayScoreQ4],[AwayScoreQ5],[AwayScoreTotal] )
 VALUES(Source.[ScheduleKey],Source.[GameID],Source.[HomeAbbr],Source.[HomeTurnOver],Source.[HomeScoreQ1],Source.[HomeScoreQ2],Source.[HomeScoreQ3],Source.[HomeScoreQ4],Source.[HomeScoreQ5],Source.[HomeScoreTotal],Source.[AwayAbbr],Source.[AwayTurnOver],Source.[AwayScoreQ1],Source.[AwayScoreQ2],Source.[AwayScoreQ3],Source.[AwayScoreQ4],Source.[AwayScoreQ5],Source.[AwayScoreTotal])
WHEN NOT MATCHED BY SOURCE THEN 
 DELETE
 OUTPUT $action INTO @SummaryOfChanges 
;
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [nfldb].[game]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[nfldb].[game] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100));
 END
;


DECLARE @rowcount int = @mergeCount, 
		@insert INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'INSERT'), 
		@update INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'update'), 
		@delete INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'DELETE')  
 EXEC dbo.LogProcedure @ProcID = @@PROCID, @RowCount = @rowcount,@insert = @insert,@update = @update, @delete = @delete, @starttime = @datetime, @isStart = false
;

SET NOCOUNT OFF
;

GO
/****** Object:  StoredProcedure [NFLDB].[BuildPlay]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [NFLDB].[BuildPlay]
AS

--MERGE generated by 'sp_generate_merge' stored procedure, Version 0.93
--Originally by Vyas (http://vyaskn.tripod.com): sp_generate_inserts (build 22)
--Adapted for SQL Server 2008/2012 by Daniel Nolan (http://danere.com)

SET NOCOUNT ON

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));
DECLARE @datetime DATETIMEOFFSET = GETDATE(); 
EXEC dbo.LogProcedure @ProcID =  @@PROCID, @TableName = '[nfldb].[Play]', @starttime = @datetime, @isStart = true
;
MERGE INTO [nfldb].[Play] AS Target
USING  ( 
Select [ScheduleKey],[DriveNumber],[PlayNumber],[Qtr],[PlayStartTime],[PlayStartTimeSeconds],[PossessionTeam],[RelativeYardLine],[YardsToGo],[YardsNet],[ScoredPoint],[Down],[Description],[Note]
 From[nfldb].[Play_vw]
) AS Source ([ScheduleKey],[DriveNumber],[PlayNumber],[Qtr],[PlayStartTime],[PlayStartTimeSeconds],[PossessionTeam],[RelativeYardLine],[YardsToGo],[YardsNet],[ScoredPoint],[Down],[Description],[Note])
ON (Target.[ScheduleKey] = Source.[ScheduleKey] AND Target.[DriveNumber] = Source.[DriveNumber] AND Target.[PlayNumber] = Source.[PlayNumber])
WHEN MATCHED AND (
	NULLIF(Source.[ScheduleKey], Target.[ScheduleKey]) IS NOT NULL OR NULLIF(Target.[ScheduleKey], Source.[ScheduleKey]) IS NOT NULL OR 
	NULLIF(Source.[DriveNumber], Target.[DriveNumber]) IS NOT NULL OR NULLIF(Target.[DriveNumber], Source.[DriveNumber]) IS NOT NULL OR 
	NULLIF(Source.[PlayNumber], Target.[PlayNumber]) IS NOT NULL OR NULLIF(Target.[PlayNumber], Source.[PlayNumber]) IS NOT NULL OR 
	NULLIF(Source.[Qtr], Target.[Qtr]) IS NOT NULL OR NULLIF(Target.[Qtr], Source.[Qtr]) IS NOT NULL OR 
	NULLIF(Source.[PlayStartTime], Target.[PlayStartTime]) IS NOT NULL OR NULLIF(Target.[PlayStartTime], Source.[PlayStartTime]) IS NOT NULL OR 
	NULLIF(Source.[PlayStartTimeSeconds], Target.[PlayStartTimeSeconds]) IS NOT NULL OR NULLIF(Target.[PlayStartTimeSeconds], Source.[PlayStartTimeSeconds]) IS NOT NULL OR 
	NULLIF(Source.[PossessionTeam], Target.[PossessionTeam]) IS NOT NULL OR NULLIF(Target.[PossessionTeam], Source.[PossessionTeam]) IS NOT NULL OR 
	NULLIF(Source.[RelativeYardLine], Target.[RelativeYardLine]) IS NOT NULL OR NULLIF(Target.[RelativeYardLine], Source.[RelativeYardLine]) IS NOT NULL OR 
	NULLIF(Source.[YardsToGo], Target.[YardsToGo]) IS NOT NULL OR NULLIF(Target.[YardsToGo], Source.[YardsToGo]) IS NOT NULL OR 
	NULLIF(Source.[YardsNet], Target.[YardsNet]) IS NOT NULL OR NULLIF(Target.[YardsNet], Source.[YardsNet]) IS NOT NULL OR 
	NULLIF(Source.[ScoredPoint], Target.[ScoredPoint]) IS NOT NULL OR NULLIF(Target.[ScoredPoint], Source.[ScoredPoint]) IS NOT NULL OR 
	NULLIF(Source.[Down], Target.[Down]) IS NOT NULL OR NULLIF(Target.[Down], Source.[Down]) IS NOT NULL OR 
	NULLIF(Source.[Description], Target.[Description]) IS NOT NULL OR NULLIF(Target.[Description], Source.[Description]) IS NOT NULL OR 
	NULLIF(Source.[Note], Target.[Note]) IS NOT NULL OR NULLIF(Target.[Note], Source.[Note]) IS NOT NULL) THEN 
 UPDATE SET
  [ScheduleKey] = Source.[ScheduleKey], 
  [DriveNumber] = Source.[DriveNumber], 
  [PlayNumber] = Source.[PlayNumber], 
  [Qtr] = Source.[Qtr], 
  [PlayStartTime] = Source.[PlayStartTime], 
  [PlayStartTimeSeconds] = Source.[PlayStartTimeSeconds], 
  [PossessionTeam] = Source.[PossessionTeam], 
  [RelativeYardLine] = Source.[RelativeYardLine], 
  [YardsToGo] = Source.[YardsToGo], 
  [YardsNet] = Source.[YardsNet], 
  [ScoredPoint] = Source.[ScoredPoint], 
  [Down] = Source.[Down], 
  [Description] = Source.[Description], 
  [Note] = Source.[Note]
WHEN NOT MATCHED BY TARGET THEN
 INSERT([ScheduleKey],[DriveNumber],[PlayNumber],[Qtr],[PlayStartTime],[PlayStartTimeSeconds],[PossessionTeam],[RelativeYardLine],[YardsToGo],[YardsNet],[ScoredPoint],[Down],[Description],[Note] )
 VALUES(Source.[ScheduleKey],Source.[DriveNumber],Source.[PlayNumber],Source.[Qtr],Source.[PlayStartTime],Source.[PlayStartTimeSeconds],Source.[PossessionTeam],Source.[RelativeYardLine],Source.[YardsToGo],Source.[YardsNet],Source.[ScoredPoint],Source.[Down],Source.[Description],Source.[Note])
WHEN NOT MATCHED BY SOURCE THEN 
 DELETE
 OUTPUT $action INTO @SummaryOfChanges 
;
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [nfldb].[Play]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[nfldb].[Play] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100));
 END
;


DECLARE @rowcount int = @mergeCount, 
		@insert INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'INSERT'), 
		@update INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'update'), 
		@delete INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'DELETE')  
 EXEC dbo.LogProcedure @ProcID = @@PROCID, @RowCount = @rowcount,@insert = @insert,@update = @update, @delete = @delete, @starttime = @datetime, @isStart = false
;

SET NOCOUNT OFF
;

GO
/****** Object:  StoredProcedure [NFLDB].[BuildSchedule]    Script Date: 9/8/2019 8:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [NFLDB].[BuildSchedule]
AS


--MERGE generated by 'sp_generate_merge' stored procedure, Version 0.93
--Originally by Vyas (http://vyaskn.tripod.com): sp_generate_inserts (build 22)
--Adapted for SQL Server 2008/2012 by Daniel Nolan (http://danere.com)

SET NOCOUNT ON

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));
DECLARE @datetime DATETIMEOFFSET = GETDATE(); 
EXEC dbo.LogProcedure @ProcID =  @@PROCID, @TableName = '[nfldb].[schedule]', @starttime = @datetime, @isStart = true
;
MERGE INTO [nfldb].[schedule] AS Target
USING  ( 
Select [GameID],[SeasonYear],[SeasonType],[SeasonTypeDetail],[WkNumber],[DayName],[GameDay],[GameTime],[GameTimeUTC],[Qtr],[HomeTeam],[HomeTeamName],[AwayTeam],[AwayTeamName]
 From[nfldb].[schedule_vw]
) AS Source ([GameID],[SeasonYear],[SeasonType],[SeasonTypeDetail],[WkNumber],[DayName],[GameDay],[GameTime],[GameTimeUTC],[Qtr],[HomeTeam],[HomeTeamName],[AwayTeam],[AwayTeamName])
ON (Target.[GameID] = Source.[GameID])
WHEN MATCHED AND (
	NULLIF(Source.[GameID], Target.[GameID]) IS NOT NULL OR NULLIF(Target.[GameID], Source.[GameID]) IS NOT NULL OR 
	NULLIF(Source.[SeasonYear], Target.[SeasonYear]) IS NOT NULL OR NULLIF(Target.[SeasonYear], Source.[SeasonYear]) IS NOT NULL OR 
	NULLIF(Source.[SeasonType], Target.[SeasonType]) IS NOT NULL OR NULLIF(Target.[SeasonType], Source.[SeasonType]) IS NOT NULL OR 
	NULLIF(Source.[SeasonTypeDetail], Target.[SeasonTypeDetail]) IS NOT NULL OR NULLIF(Target.[SeasonTypeDetail], Source.[SeasonTypeDetail]) IS NOT NULL OR 
	NULLIF(Source.[WkNumber], Target.[WkNumber]) IS NOT NULL OR NULLIF(Target.[WkNumber], Source.[WkNumber]) IS NOT NULL OR 
	NULLIF(Source.[DayName], Target.[DayName]) IS NOT NULL OR NULLIF(Target.[DayName], Source.[DayName]) IS NOT NULL OR 
	NULLIF(Source.[GameDay], Target.[GameDay]) IS NOT NULL OR NULLIF(Target.[GameDay], Source.[GameDay]) IS NOT NULL OR 
	NULLIF(Source.[GameTime], Target.[GameTime]) IS NOT NULL OR NULLIF(Target.[GameTime], Source.[GameTime]) IS NOT NULL OR 
	NULLIF(Source.[GameTimeUTC], Target.[GameTimeUTC]) IS NOT NULL OR NULLIF(Target.[GameTimeUTC], Source.[GameTimeUTC]) IS NOT NULL OR 
	NULLIF(Source.[Qtr], Target.[Qtr]) IS NOT NULL OR NULLIF(Target.[Qtr], Source.[Qtr]) IS NOT NULL OR 
	NULLIF(Source.[HomeTeam], Target.[HomeTeam]) IS NOT NULL OR NULLIF(Target.[HomeTeam], Source.[HomeTeam]) IS NOT NULL OR 
	NULLIF(Source.[HomeTeamName], Target.[HomeTeamName]) IS NOT NULL OR NULLIF(Target.[HomeTeamName], Source.[HomeTeamName]) IS NOT NULL OR 
	NULLIF(Source.[AwayTeam], Target.[AwayTeam]) IS NOT NULL OR NULLIF(Target.[AwayTeam], Source.[AwayTeam]) IS NOT NULL OR 
	NULLIF(Source.[AwayTeamName], Target.[AwayTeamName]) IS NOT NULL OR NULLIF(Target.[AwayTeamName], Source.[AwayTeamName]) IS NOT NULL) THEN 
 UPDATE SET
  [GameID] = Source.[GameID], 
  [SeasonYear] = Source.[SeasonYear], 
  [SeasonType] = Source.[SeasonType], 
  [SeasonTypeDetail] = Source.[SeasonTypeDetail], 
  [WkNumber] = Source.[WkNumber], 
  [DayName] = Source.[DayName], 
  [GameDay] = Source.[GameDay], 
  [GameTime] = Source.[GameTime], 
  [GameTimeUTC] = Source.[GameTimeUTC], 
  [Qtr] = Source.[Qtr], 
  [HomeTeam] = Source.[HomeTeam], 
  [HomeTeamName] = Source.[HomeTeamName], 
  [AwayTeam] = Source.[AwayTeam], 
  [AwayTeamName] = Source.[AwayTeamName]
WHEN NOT MATCHED BY TARGET THEN
 INSERT([GameID],[SeasonYear],[SeasonType],[SeasonTypeDetail],[WkNumber],[DayName],[GameDay],[GameTime],[GameTimeUTC],[Qtr],[HomeTeam],[HomeTeamName],[AwayTeam],[AwayTeamName] )
 VALUES(Source.[GameID],Source.[SeasonYear],Source.[SeasonType],Source.[SeasonTypeDetail],Source.[WkNumber],Source.[DayName],Source.[GameDay],Source.[GameTime],Source.[GameTimeUTC],Source.[Qtr],Source.[HomeTeam],Source.[HomeTeamName],Source.[AwayTeam],Source.[AwayTeamName])
WHEN NOT MATCHED BY SOURCE THEN 
 DELETE
 OUTPUT $action INTO @SummaryOfChanges 
;
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [nfldb].[schedule]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[nfldb].[schedule] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100));
 END
;


DECLARE @rowcount int = @mergeCount, 
		@insert INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'INSERT'), 
		@update INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'update'), 
		@delete INT = (SELECT COUNT(1) FROM @SummaryOfChanges WHERE Change = 'DELETE')  
 EXEC dbo.LogProcedure @ProcID = @@PROCID, @RowCount = @rowcount,@insert = @insert,@update = @update, @delete = @delete, @starttime = @datetime, @isStart = false
;

SET NOCOUNT OFF
;

GO
