/****** Object:  Table [Person].[PersonDemographics]    Script Date: 8/6/2025 12:11:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Person].[PersonDemographics](
	[BusinessEntityID] [int] NULL,
	[BirthDate] [date] NULL,
	[MaritalStatus] [nchar](1) NULL,
	[Gender] [nvarchar](1) NULL,
	[YearlyIncome] [nvarchar](100) NULL,
	[Education] [nvarchar](40) NULL,
	[Occupation] [nvarchar](100) NULL,
	[HomeOwnerFlag] [nchar](1) NULL,
	[TotalChildren] [tinyint] NULL,
	[NumberChildrenAtHome] [tinyint] NULL,
	[NumberCarsOwned] [tinyint] NULL,
	[DateFirstPurchase] [date] NULL,
	[CommuteDistance] [nvarchar](15) NULL
) ON [PRIMARY]
GO

INSERT INTO [Person].[PersonDemographics]
(
	[BusinessEntityID],
	[BirthDate],
	[MaritalStatus],
	[Gender],
	[YearlyIncome],
	[Education],
	[Occupation],
	[HomeOwnerFlag],
	[TotalChildren],
	[NumberChildrenAtHome],
	[NumberCarsOwned],
	[DateFirstPurchase],
	[CommuteDistance]
)
SELECT
	
    p.[BusinessEntityID],
    CONVERT(datetime, REPLACE([IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        BirthDate[1]', 'nvarchar(20)') ,'Z', ''), 101),
	[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        MaritalStatus[1]', 'nvarchar(1)'),
	[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        Gender[1]', 'nvarchar(1)'),
	[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        YearlyIncome[1]', 'nvarchar(100)'),
	[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        Education[1]', 'nvarchar(40)'),
	[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        Occupation[1]', 'nvarchar(100)'), 
	[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        HomeOwnerFlag[1]', 'bit'),
	[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        TotalChildren[1]', 'integer'),
	[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        NumberChildrenAtHome[1]', 'integer'),
	[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        NumberCarsOwned[1]', 'integer'),
	CONVERT(datetime, REPLACE([IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        DateFirstPurchase[1]', 'nvarchar(20)') ,'Z', ''), 101),
	[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        CommuteDistance[1]', 'nvarchar(30)')
FROM 
	[Person].[Person] p 
	CROSS APPLY p.[Demographics].nodes(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
    /IndividualSurvey') AS [IndividualSurvey](ref) 
WHERE 
	[Demographics] IS NOT NULL
GO