begin

     dbms_scheduler.create_job(job_name           => 'EDS_INTG_DELETE_OLD_DATA',
                               job_type           => 'PLSQL_BLOCK',
                               job_action         => 'BARS.EDS_INTG.DELETE_OLD_DATA;',
                               repeat_interval    => 'FREQ=MONTHLY;INTERVAL=1',
                               auto_drop          => false,
                               enabled            => true,
                               comments           =>  'Job for delete old data from eds_decl.');
  exception when others then 
 if sqlcode = -27477 then 
 null; 
 else 
 raise; 
 end if; 
 end;
 /