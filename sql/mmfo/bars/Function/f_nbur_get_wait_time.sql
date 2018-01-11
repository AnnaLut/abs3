
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nbur_get_wait_time.sql =========*
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NBUR_GET_WAIT_TIME (p_type in number) return varchar2
is
   l_mes       varchar2(200);
   l_state     varchar2(200);
   l_interval  number;
   l_job_name  varchar2(200);
   l_kf        varchar2(20) := bc.current_mfo;
begin
   l_job_name := 'NBUR_CHECK_QUEUE_'||to_char(p_type)||'_'||l_kf;
   
   begin
      SELECT TO_CHAR (EXTRACT (MINUTE FROM (next_run_date - sysdate) DAY TO SECOND)),
           state,  to_number(substr(repeat_interval, instr(repeat_interval, 'INTERVAL')+9))
      INTO l_mes, l_state, l_interval
      FROM ALL_SCHEDULER_JOBS
      WHERE job_name = l_job_name;
      
      if l_state = 'RUNNING' then
         l_mes := to_char(to_number(l_mes)+l_interval);
      end if;
   exception
      when others then l_mes := '';
   end;    
   
   return l_mes;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nbur_get_wait_time.sql =========*
 PROMPT ===================================================================================== 
 