begin
  sys.dbms_scheduler.create_job(job_name            => 'MSP.GET_CHECK_STATE',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'begin msp_utl.prepare_check_state; end;',
                                start_date          => to_date('15-01-2018 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Hourly;ByHour=09, 12, 15, 18, 21',
                                end_date            => to_date(null),
                                job_class           => 'DBMS_JOB$',
                                comments            => '');

  exception when others then
      if (sqlcode = -27477) then null;
        else raise; 
      end if;

end;
/
