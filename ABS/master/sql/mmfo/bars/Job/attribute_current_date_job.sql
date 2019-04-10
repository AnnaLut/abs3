declare
    l_exists_job number;
begin
    select count(1)
      into l_exists_job
      from dba_scheduler_jobs
     where job_name = 'ATTRIBUTE_CURRENT_DATE_JOB'
       and owner = 'BARS';
    if l_exists_job = 0 then
          sys.dbms_scheduler.create_job(job_name            => 'BARS.ATTRIBUTE_CURRENT_DATE_JOB',
                                        job_type            => 'STORED_PROCEDURE',
                                        job_action          => 'attribute_utl.set_current_values',
                                        start_date          => to_date('01-01-2000 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                        repeat_interval     => 'Freq=Daily;Interval=1',
                                        end_date            => to_date(null),
                                        job_class           => 'DEFAULT_JOB_CLASS',
                                        enabled             => true,
                                        auto_drop           => false,
                                        comments            => '');
     end if;
end;
/
