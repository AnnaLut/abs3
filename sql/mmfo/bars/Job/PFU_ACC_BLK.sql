BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BARS.PFU_ACC_BLK');
EXCEPTION
   WHEN OTHERS THEN IF SQLCODE = -27475 THEN NULL; ELSE RAISE; END IF;  
END;
/

begin
  sys.dbms_scheduler.create_job(job_name            => 'BARS.PFU_ACC_BLK',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'begin pfu_ru_epp_utl.pfu_files_blk_processing; end;',
                                start_date          => to_date('02-03-2018 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Minutely;Interval=10',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => '');
end;
/