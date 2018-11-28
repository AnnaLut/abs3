--program with event parametr  
begin  
  dbms_scheduler.create_program(program_name => 'BARSTRANS.PRG_READ_EVENT',program_type => 'STORED_PROCEDURE',program_action=>'BARSTRANS.TRANSP_UTL.JOB_STOPER',number_of_arguments => 1);
exception when others then
if sqlcode = -27477 then null; else raise; end if;
end;
/
begin    
  dbms_scheduler.define_metadata_argument(program_name => 'BARSTRANS.PRG_READ_EVENT',metadata_attribute => 'EVENT_MESSAGE',argument_position => 1);
end;
/
begin  
  dbms_scheduler.enable(name => 'BARSTRANS.PRG_READ_EVENT');  
end;  
/ 
 
--adding substriber for scheduler queue  
BEGIN  
dbms_scheduler.add_event_queue_subscriber(subscriber_name => 'BARSTRANS_QUEUE_AGENT');
exception when others then
if sqlcode = -24034 then null; else raise; end if; 
END;  
/  

--create job to catch raised events  
BEGIN  
dbms_scheduler.create_job(job_name            => 'BARSTRANS.JOB_STOPER',  
                          program_name        => 'BARSTRANS.PRG_READ_EVENT',  
                          event_condition     => 'tab.user_data.event_type=''JOB_OVER_MAX_DUR'' 
											      and tab.user_data.object_owner = ''BARSTRANS''',  
                          queue_spec          => 'SYS.SCHEDULER$_EVENT_QUEUE, BARSTRANS_QUEUE_AGENT',  
                          enabled             => TRUE,  
                          auto_drop           => FALSE); 
exception when others then
if sqlcode = -27477 then null; else raise; end if; 
END;  
/ 

BEGIN
  DBMS_SCHEDULER.SET_ATTRIBUTE('BARSTRANS.JOB_STOPER','PARALLEL_INSTANCES',TRUE);
END;
/

