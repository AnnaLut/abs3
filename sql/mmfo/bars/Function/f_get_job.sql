CREATE OR REPLACE FUNCTION BARS.F_Get_Job ( p_Name varchar2, p_mode int) return varchar2
is
   l_Ret varchar2 (2000);
   l_log_ID int;
begin 
   If p_mode = 0 then  
      select max(Log_Id) into l_Log_Id from ALL_SCHEDULER_JOB_RUN_DETAILS where job_name = p_Name ;
      if l_Log_Id  is not null then
         select Substr (STATUS || ' '|| to_char(Log_date, 'dd.mm.yy HH24:mi:ss') || ' '|| ADDITIONAL_INFO ,1,2000)
         into l_Ret 
         from ALL_SCHEDULER_JOB_RUN_DETAILS 
         where job_name = p_Name and Log_id = l_Log_Id ;
      end if ;
   else

      Begin select 'Yes' into l_Ret  from dba_scheduler_running_jobs where job_name = p_Name ;
      EXCEPTION WHEN NO_DATA_FOUND THEN  l_Ret := 'No'; 
      end ;
   
   end if ;
   RETURN l_Ret ;
End f_Get_Job ;
/
 show err;
 
PROMPT *** Create  grants  F_GET_JOB ***
grant EXECUTE                                                                on F_GET_JOB      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_JOB      to START1;

