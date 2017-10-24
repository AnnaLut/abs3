begin
    dbms_scheduler.set_scheduler_attribute('SCHEDULER_DISABLED','TRUE');

    for i in (select job_name from dba_scheduler_running_jobs) loop
        dbms_scheduler.stop_job(i.job_name, force => true);
    end loop;
end;
/
