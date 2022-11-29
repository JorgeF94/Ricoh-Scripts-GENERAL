-- =============================================
-- Author: Jorge Falcão
-- Create date: 10/10/2021
-- Description: Script with some usefull queries
-- Env: ALL
-- =============================================


WITH TOTALS AS (
    SELECT b.RecordTypeID,
            b.TypeName,
            c.RecordFamilyID,
			g.FamilyName,
            d.CompanyServiceListProjectId,
            d.ProjectName,
            b.IsActive,
            e.ServiceCode,
            d.SubscriptionAccessArchive,
			d.SubscriptionAccessWorkQueue,
			d.AllowClaimsException,
			ISNULL(customFieldsCount.CoustomFields_Count,0) AS CoustomFields_Count,
			'--' as Tab,
			ReportDataCount.ReportDataCount
    FROM CMN.RecordFamilyType a
    INNER JOIN CMN.RecordType b ON a.RecordTypeID = b.RecordTypeID
    INNER JOIN CMN.ProjectRecordFamilyRecordType c ON c.RecordFamilyID = a.RecordFamilyID
    INNER JOIN CMN.CompanyServiceListProject d ON c.CompanyServiceListProjectID = d.CompanyServiceListProjectId AND d.IsActive = 1
    INNER JOIN CMN.ServiceList e ON e.ServiceListId = d.ServiceListId
    LEFT JOIN CMN.ProjectRecordFamilyRecordType f ON f.RecordTypeID = a.RecordTypeID
	inner join cmn.RecordFamily g ON g.RecordFamilyID = c.RecordFamilyID
	left join (select RecordTypeID, COUNT(1) as CoustomFields_Count from cmn.RecordTypeField group by RecordTypeID) customFieldsCount ON customFieldsCount.RecordTypeID = b.RecordTypeID 
		--LEFT JOIN () SummaryDataCount
	left join (select a.CompanyServiceListProjectID,a.RecordTypeID, count(1) AS ReportDataCount 
				from clmreport.archiveData a 
				group by a.CompanyServiceListProjectID,a.RecordTypeID) ReportDataCount ON ReportDataCount.CompanyServiceListProjectID = c.CompanyServiceListProjectId AND ReportDataCount.RecordTypeID = a.RecordTypeID
    WHERE 1=1
    AND f.RecordTypeID is null

    union

    SELECT a.RecordTypeID,
            a.TypeName,
            b.RecordFamilyID,
			e.FamilyName,
            c.CompanyServiceListProjectId,
            c.ProjectName,
            a.IsActive,
            d.ServiceCode,
            c.SubscriptionAccessArchive,
			c.SubscriptionAccessWorkQueue,
			c.AllowClaimsException,
			ISNULL(customFieldsCount.CoustomFields_Count,0) AS CoustomFields_Count,
			'--' as Tab,
			ReportDataCount.ReportDataCount
    FROM CMN.RecordType a
    Inner JOIN CMN.ProjectRecordFamilyRecordType b ON b.RecordTypeID = a.RecordTypeID
    Inner JOIN CMN.CompanyServiceListProject c ON b.CompanyServiceListProjectID = c.CompanyServiceListProjectId
    inner join CMN.ServiceList d ON d.ServiceListId = c.ServiceListId
	inner join cmn.RecordFamily e ON e.RecordFamilyID = b.RecordFamilyID
	left join (select RecordTypeID, COUNT(1) as CoustomFields_Count from cmn.RecordTypeField group by RecordTypeID) customFieldsCount ON customFieldsCount.RecordTypeID = a.RecordTypeID
	--LEFT JOIN () SummaryDataCount
	left join (select a.CompanyServiceListProjectID,a.RecordTypeID, count(1) AS ReportDataCount 
				from clmreport.archiveData a 
				group by a.CompanyServiceListProjectID,a.RecordTypeID) ReportDataCount ON ReportDataCount.CompanyServiceListProjectID = c.CompanyServiceListProjectId AND ReportDataCount.RecordTypeID = a.RecordTypeID
    WHERE 1=1
)
SELECT  a.CompanyServiceListProjectId,a.ProjectName,a.RecordFamilyID,a.FamilyName,a.RecordTypeID,a.TypeName,a.SubscriptionAccessArchive,a.SubscriptionAccessWorkQueue,a.AllowClaimsException,a.CoustomFields_Count,'--' as tab,ISNULL(a.ReportDataCount,0) AS ReportDataCount
FROM TOTALS a
WHERE 1=1
--AND a.CompanyServiceListProjectId = @SelectedProject
--AND a.SubscriptionAccessArchive = 1
and a.ServiceCode = 'CLMN'--'CLMN'--CPCN
AND a.IsActive = 1

ORDER BY a.CompanyServiceListProjectId desc,RecordFamilyID,RecordTypeID ASC





/*Was data created?*/
--select CreatedDate,ProjectName,CompanyServiceListProjectID,count(1) recordsCreated from cncReport.ArchiveData where CompanyServiceListProjectID in( 388,390,391,387) /*and CreatedDate = '2022-09-12 10:23:48.490'*/ group by CreatedDate,ProjectName,CompanyServiceListProjectID order by CreatedDate desc
--select CreatedDate,ProjectName,CompanyServiceListProjectID,count(1) recordsCreated from ClmReport.ArchiveData where CompanyServiceListProjectID in( 394,393,392,389) group by CreatedDate,ProjectName,CompanyServiceListProjectID order by CreatedDate desc