prompt drop job j663
begin
  sys.dbms_scheduler.drop_job('BARS.J663');
exception
  when others then
    if sqlcode = -27475 then null; else raise; end if;
end;
/
prompt create job j_p_fm_getturn
begin
  sys.dbms_scheduler.create_job(job_name            => 'BARS.J_P_FM_GETTURN',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'begin for rec in (select * from mv_kf) loop bc.go(rec.kf); P_FM_GETTURN(sysdate,0); end loop; end;',
                                start_date          => to_date('09-04-2017 12:14:28', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Daily;Interval=1;ByHour=02;ByMinute=00;BySecond=00',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'Процедура по накоплению расчетных оборотов по клиентам для анкет ФМ');
exception
  when others then
    if sqlcode = -27477 then null; else raise; end if;
end;
/
