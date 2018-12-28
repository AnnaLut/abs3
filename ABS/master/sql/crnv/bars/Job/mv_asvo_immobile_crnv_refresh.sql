BEGIN
  BEGIN
    dbms_scheduler.drop_job(job_name => 'BARS.MV_ASVO_IMMOBILE_CRNV_REFRESH');
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -27475 THEN
        NULL;
      ELSE
        RAISE;
      END IF;
  END;

  sys.dbms_scheduler.create_job(job_name            => 'BARS.MV_ASVO_IMMOBILE_CRNV_REFRESH',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'declare
   e_full_refresh exception;
   pragma exception_init(e_full_refresh,-12034);
  begin
     dbms_mview.refresh(list => ''MV_ASVO_IMMOBILE_CRNV'',method => ''FAST'',atomic_refresh => false);
  exception
     when e_full_refresh then 
      dbms_mview.refresh(list => ''MV_ASVO_IMMOBILE_CRNV'',method => ''COMPLETE'',atomic_refresh => false);

  end;',
                                schedule_name       => 'BARS.INTERVAL_2_MINUTES',
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'gettintg ASVO_IMMOBILE data from CRNV');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -27477 THEN
      NULL;
    ELSE
      RAISE;
    END IF;
END;
/
