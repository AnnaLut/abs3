BEGIN
  BEGIN
    dbms_scheduler.drop_job(job_name => 'BARS.MV_ASVO_IMMOBILE_MMFO_REFRESH');
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -27475 THEN
        NULL;
      ELSE
        RAISE;
      END IF;
  END;

  sys.dbms_scheduler.create_job(job_name            => 'BARS.MV_ASVO_IMMOBILE_MMFO_REFRESH',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'declare
   e_full_refresh exception;
   pragma exception_init(e_full_refresh,-12034);
  begin
        mmfo_login.login_user(sys_guid,1,''CRNV'',null);
        mmfo_bc.go(''/'');
      begin
        dbms_mview.refresh(list => ''MV_ASVO_IMMOBILE_MMFO'',method => ''FAST'',atomic_refresh => false);
       exception
         when e_full_refresh then 
           dbms_mview.refresh(list => ''MV_ASVO_IMMOBILE_MMFO'',method => ''COMPLETE'',atomic_refresh => false);
      end;
  end;',
                                schedule_name       => 'BARS.INTERVAL_2_MINUTES',
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'gettintg ASVO_IMMOBILE data from MMFO');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -27477 THEN
      NULL;
    ELSE
      RAISE;
    END IF;
END;
/
