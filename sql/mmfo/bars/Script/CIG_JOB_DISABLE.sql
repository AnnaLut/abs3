BEGIN
  for rec in (select j.job_name
                from DBA_SCHEDULER_JOBS j, mv_kf m
               where j.job_name like 'CIG_PVBKI_MMFO_%' || m.kf) loop  
    DBMS_SCHEDULER.DISABLE(rec.job_name);
  end loop;
  commit;
END;
/
