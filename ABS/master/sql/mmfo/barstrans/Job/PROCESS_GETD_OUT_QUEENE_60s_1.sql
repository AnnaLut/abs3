begin

     dbms_scheduler.create_job(job_name           => 'PROCESS_GETD_OUT_QUEENE_60s_1',
                               job_type           => 'PLSQL_BLOCK',
                               job_action         => 'BARSTRANS.TRANSP_UTL.PROCESS_GET_D_OUT_QUEUE;',
                               repeat_interval    => 'FREQ=SECONDLY;INTERVAL=60',
                               auto_drop          => false,
                               enabled            => true,
                               comments           =>  'Job for send sub requests.');
  exception when others then 
 if sqlcode = -27477 then 
 null; 
 else 
 raise; 
 end if; 
 end;
 /