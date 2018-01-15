PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/job/job_parse_files.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** drop job msp.parse_files ***

begin
  dbms_scheduler.drop_job(job_name  => 'msp.parse_files');
exception when others then
  if (sqlcode = -27475) then null;
  else raise; end if;
end;
/
 
PROMPT *** create job msp.parse_files ***

begin
  sys.dbms_scheduler.create_job(job_name            => 'msp.parse_files',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'begin msp_utl.process_files; end;',
                                start_date          => to_date('15-12-2017 13:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=MINUTELY;Interval=20',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => true,
                                comments            => 'Запуск процесу парсингу файлів');
exception when others then
      if (sqlcode = -27477) then null;
        else raise; 
      end if;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/job/job_parse_files.sql =========*** End *** =
PROMPT ===================================================================================== 
