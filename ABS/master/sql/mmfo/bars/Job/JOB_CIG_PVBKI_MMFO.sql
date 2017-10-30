prompt ====================================
prompt Create job CIG_PVBKI_MMFO
prompt ====================================

begin

 BEGIN 
   DBMS_SCHEDULER.DISABLE('J2248');
   DBMS_SCHEDULER.DISABLE('J2249');
   DBMS_SCHEDULER.DISABLE('J2250');
  END;

 BEGIN

 begin 
    sys.dbms_scheduler.create_job(  job_name        => 'BARS.CIG_PVBKI_MMFO',
                                    job_type        => 'PLSQL_BLOCK',
                                    job_action      => 'begin  cig_mgr.create_job_cig_mmfo; end;',
                                    start_date      => to_date('16-10-2017 12:23:35', 'dd-mm-yyyy hh24:mi:ss'),
                                    repeat_interval => 'Freq=daily;ByHour=18',
                                    end_date        => to_date(null),
                                    job_class       => 'DEFAULT_JOB_CLASS',
                                    enabled         => TRUE,
                                    auto_drop       => false,
                                    comments        => 'Создает джобы по ПВБКИ для новых филиалов перешедших на ММФО'); 
 end;   
     exception when others then
              if (sqlcode = -27477) then null;
              else raise; 
               end if;              
    end;
end;
/