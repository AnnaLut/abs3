

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SNAP_JOB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SNAP_JOB ***

  CREATE OR REPLACE PROCEDURE BARS.SNAP_JOB (dat_ DATE) IS
BEGIN
   begin
     dbms_scheduler.drop_job(job_name => 'BARS_SNAPBAL');
   exception when others then
     if sqlcode = -27475 then null; else raise; end if;
   end;

   begin
     dbms_scheduler.create_job(
          job_name => 'BARS_SNAPBAL',
          job_type => 'PLSQL_BLOCK',
          job_action => 'begin tuda; draps(TO_DATE('''
          ||TO_CHAR(dat_,'DDMMYYYY')||''',''DDMMYYYY'')); end;',
--          repeat_interval => 'FREQ=DAYLY;INTERVAL=1;BYHOUR=21',
    enabled => true,
    comments => 'Формування знімків балансу');
   end;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SNAP_JOB.sql =========*** End *** 
PROMPT ===================================================================================== 
