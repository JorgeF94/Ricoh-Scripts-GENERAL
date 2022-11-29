
declare @HoursStatic varchar(500) ='HRS' ;
declare @DaysStatic varchar(500) ='DAY' ;
declare @MonthsStatic varchar(500) = 'MTH';
declare @YearsStatic varchar(500) = 'YRS';

/*
declare @HoursStatic varchar(500) ='Hours' ;
declare @DaysStatic varchar(500) ='Days' ;
declare @MonthsStatic varchar(500) = 'Months';
declare @YearsStatic varchar(500) = 'Years';
*/

declare @HoursToMinutes Int = 60;
declare @DaysToMinutes Int = 1440;
declare @MonthsToMinutes Int = 43200;
declare @YearsToMinutes Int = 525600;

select  
d.DeliverySLA *    
         IIF(c.DeliverySLATermTypeCode = @HoursStatic,  
                @HoursToMinutes,  
                IIF(c.DeliverySLATermTypeCode = @DaysStatic,  
                @DaysToMinutes,  
                IIF(c.DeliverySLATermTypeCode = @MonthsStatic,  
                @MonthsToMinutes,  
                IIF(c.DeliverySLATermTypeCode = @YearsStatic,@YearsToMinutes,0)))),
d.RejectedMailSLA *    
         IIF(e.RejectResponseTermTypeCode = @HoursStatic,  
                @HoursToMinutes,  
                IIF(e.RejectResponseTermTypeCode = @DaysStatic,  
                @DaysToMinutes,  
                IIF(e.RejectResponseTermTypeCode = @MonthsStatic,  
                @MonthsToMinutes,  
                IIF(e.RejectResponseTermTypeCode = @YearsStatic,@YearsToMinutes,0)))) ,
d.PhysicalDeliverySLA *    
         IIF(f.PhysicalDeliverySLATermTypeCode = @HoursStatic,  
                @HoursToMinutes,  
                IIF(f.PhysicalDeliverySLATermTypeCode = @DaysStatic,  
                @DaysToMinutes,  
                IIF(f.PhysicalDeliverySLATermTypeCode = @MonthsStatic,  
                @MonthsToMinutes,  
                IIF(f.PhysicalDeliverySLATermTypeCode = @YearsStatic, @YearsToMinutes,0)))) 
 from cmn.CompanyServiceListProject d 
 left JOIN cmn.DeliverySLATermType c ON c.DeliverySLATermTypeID = d.DeliverySLATermTypeID
 left JOIN cmn.RejectResponseSLATermType e ON e.RejectResponseSLATermTypeID = d.RejectResponseSLATermTypeID
 left join cmn.PhysicalDeliverySLATermType f ON f.PhysicalDeliverySLATermTypeID = d.PhysicalDeliverySLATermTypeID
 where CompanyServiceListProjectID = 125