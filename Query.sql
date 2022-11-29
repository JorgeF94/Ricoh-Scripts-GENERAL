WITH cte AS ( 
    SELECT  
          [ClmReport].[ArchiveData].[RecordID] 
    FROM  [ClmReport].[ArchiveData] 
    WHERE 1=1 
    AND 
    ( 
        ( 
            @IsToFilterBy_ProjectIDs  = 0 AND  
            ( 
                (@HasWorkQueueAndAnalytics = 0 AND  [ClmReport].[ArchiveData].[SubscriptionAccessArchive] = 1)  
                OR 
                (@HasWorkQueueAndAnalytics = 1  
                    AND  
                    ( 
                        (@IsInboxTabSelected = 0  
                            AND (( [ClmReport].[ArchiveData].[SubscriptionAccessWorkQueue] = 1 and  [ClmReport].[ArchiveData].[ArchiveStatusCode] IN ( ))  
                                OR  [ClmReport].[ArchiveData].[SubscriptionAccessArchive] = 1) 
                        ) 
 
                        OR (@IsInboxTabSelected = 1  
                            AND ( [ClmReport].[ArchiveData].[SubscriptionAccessWorkQueue] = 1) 
                        ) 
                    ) 
                ) 
            ) 
        ) 
        OR 
        ( 
            @IsToFilterBy_ProjectIDs  = 1  
                AND  [ClmReport].[ArchiveData].[CompanyServiceListProjectID] IN () 
                AND ( 
                        (@HasWorkQueueAndAnalytics = 0  
                            AND  [ClmReport].[ArchiveData].[SubscriptionAccessArchive] = 1  
                        ) 
                         
                        OR 
                        (@HasWorkQueueAndAnalytics = 1 AND  
                            (@IsInboxTabSelected = 0  
                                AND (( [ClmReport].[ArchiveData].[SubscriptionAccessWorkQueue] = 1 and  [ClmReport].[ArchiveData].[ArchiveStatusCode] IN ())  
                                    OR  [ClmReport].[ArchiveData].[SubscriptionAccessArchive] = 1)  
                                  
                            ) 
                            OR  
                            (@IsInboxTabSelected = 1  
                                AND  [ClmReport].[ArchiveData].[SubscriptionAccessWorkQueue] = 1  
                            ) 
                        ) 
                    )    
        ) 
    ) 
     
    AND (@IsToFilterBy_RecordFamilyIds = 0  OR  [ClmReport].[ArchiveData].[RecordFamilyID] IN ()) 
    AND (@IsToFilterBy_DocumentTypeIds = 0  OR  [ClmReport].[ArchiveData].[RecordTypeID] IN ()) 
     
    AND ( [ClmReport].[ArchiveData].[ConfigurePlanMarkets] = 0 OR @IsToFilterBy_PlanMarkets     = 0  OR  [ClmReport].[ArchiveData].[PlanMarketId] IN ())  
    AND  [ClmReport].[ArchiveData].[ArchiveStatusCode] IN () 
     
    AND ( 
            (@DateFrom = @NullDate and @DateTo = @NullDate ) or 
            (@DateFrom <> @NullDate and @DateTo <> @NullDate and ( [ClmReport].[ArchiveData].[CreatedDate] >= @DateFrom and  [ClmReport].[ArchiveData].[CreatedDate] < @DateTo)) or 
            (@DateFrom <> @NullDate and @DateTo = @NullDate and  [ClmReport].[ArchiveData].[CreatedDate] >= @DateFrom ) or 
            (@DateFrom = @NullDate and @DateTo <> @NullDate and  [ClmReport].[ArchiveData].[CreatedDate] < @DateTo) 
    ) 
    AND  [ClmReport].[ArchiveData].[CompanyServiceListProjectID] IN ()  
    AND  [ClmReport].[ArchiveData].[RecordFamilyID] IN ()  
    AND  [ClmReport].[ArchiveData].[RecordTypeID] IN ()  
    AND ( [ClmReport].[ArchiveData].[ConfigurePlanMarkets] = 0 OR  [ClmReport].[ArchiveData].[ProjectPlanMarketId] IN ())  
    AND ( 
        @CanSeeDeleted = 1 
        OR 
        (@CanSeeDeleted = 0 AND  [ClmReport].[ArchiveData].[ArchiveStatusCode] <> @ClaimsStatus_Deleted) 
    ) 
     
     
    ORDER BY  
    OFFSET @StartIndex ROWS 
    FETCH NEXT @MaxRecords ROWS ONLY  
 
) 
 
SELECT  
 [ClmReport].[ArchiveData].[RecordID] as PID, 
0, 
0, 
0, 
CASE WHEN ( [ClmReport].[ArchiveData].[AllowClaimsException] = 1 AND  [ClmReport].[ArchiveData].[RecordTypeName] = 'Unassigned') THEN 1 ELSE 0 END, 
CASE WHEN ( [ClmReport].[ArchiveData].[AllowClaimsException] = 1 AND ISNULL( [ClmReport].[ArchiveData].[ClaimNumber], '')  = '') THEN 1 ELSE 0 END, 
, 
, 
, 
, 
, 
, 
, 
, 
, 
, 
, 
, 
, 
, 
, 
, 
, 
, 
, 
, 
 [ClmReport].[ArchiveData].[CompanyServiceListProjectID], 
 [ClmReport].[ArchiveData].[ProjectName] as PrjName, 
 [ClmReport].[ArchiveData].[ProjectColorCode] AS ProjectNameHex, 
 [ClmReport].[ArchiveData].[ThumbnailLocation] AS ThumbnailLocation, 
 [ClmReport].[ArchiveData].[ViewedStatus] AS ViewedStatus, 
 [ClmReport].[ArchiveData].[RicohViewedStatus] AS RicohViewedStatus, 
 [ClmReport].[ArchiveData].[DateReceived] AS DateReceived, 
 [ClmReport].[ArchiveData].[ArchiveStatusName] AS StatusName, 
 [ClmReport].[ArchiveData].[ArchiveStatusCode] AS StatusCode, 
 [ClmReport].[ArchiveData].[ArchiveStatusColorCode] AS StatusHex,  
0, 
 [ClmReport].[ArchiveData].[DateScanned] AS ScanDate, 
 [ClmReport].[ArchiveData].[CreatedDate] AS DeliveryDate, 
CONCAT( [ClmReport].[ArchiveData].[MemberName],' - ',  [ClmReport].[ArchiveData].[MemberID]) AS MemberInfo, 
CONCAT( [ClmReport].[ArchiveData].[ProviderName],' - ',   [ClmReport].[ArchiveData].[ProviderNumber]) AS ProviderInfo, 
 [ClmReport].[ArchiveData].[PlanMarketName] AS PlanMarket, 
 [ClmReport].[ArchiveData].[RecordTypeName] AS DocumentTypeName, 
 [ClmReport].[ArchiveData].[DateOfBirth] AS DateOfBirth, 
 [ClmReport].[ArchiveData].[DateOfIncident] AS DateOfIncident, 
 [ClmReport].[ArchiveData].[DateOfService] AS DateOfService, 
 [ClmReport].[ArchiveData].[PhysicalDeliveryRequestApprovalDate] AS DateRequested, 
 [ClmReport].[ArchiveData].[UniversalID], 
 [ClmReport].[ArchiveData].[RejectReasonCode], 
 [ClmReport].[ArchiveData].[ClaimNumber] AS ClNumber, 
0 IsToShowQuickView 
FROM  [ClmReport].[ArchiveData] 
INNER JOIN cte a ON a.RecordID =  [ClmReport].[ArchiveData].[RecordID] 
 
ORDER BY 