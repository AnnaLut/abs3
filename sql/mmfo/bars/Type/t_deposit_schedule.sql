PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/type/T_DEPOSIT_SCHEDULE.sql =========*** Run *** ========
PROMPT ===================================================================================== 

CREATE OR REPLACE TYPE BARS.T_DEPOSIT_SCHEDULE force as object
  (
     SCHEDULE_BEGIN_DT     DATE
     , SCHEDULE_END_DT     DATE
     , FREQ		   NUMBER
     , FREQ_MNTH	   NUMBER
     , PERIOD_BEGIN_DT	   DATE
     , PERIOD_END_DT       DATE
  );
/
show err;
  
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/type/T_DEPOSIT_SCHEDULE.sql =========*** End *** ========
PROMPT ===================================================================================== 
