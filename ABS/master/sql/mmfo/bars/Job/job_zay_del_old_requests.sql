begin
    sys.dbms_scheduler.drop_job( job_name => 'JOB_ZAY_DEL_OLD_REQUESTS' );
  exception
    when OTHERS then null;
end;
/

begin
  sys.dbms_scheduler.create_job(job_name            => 'BARS.JOB_ZAY_DEL_OLD_REQUESTS',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'begin
    for k in (select * from mv_kf)
    loop
        bars.bc.go(k.kf);     
        for c in (select * from bars.zayavka z where sos=0 and viza=0 and fdat<trunc(sysdate)-30)
        loop
            bars.bars_zay.del_request(p_id => c.id, p_flag => 0);
        end loop;
        bars.bc.home;
    end loop;
end;',
                                start_date          => to_date('01-06-2016 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Daily;ByHour=04;ByMinute=00;BySecond=00',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'ZAY. Видалення не оброблених заявок старше 30 днів.');
exception
  when others then
    if sqlcode = -27477 then
      null;
    else
      raise;
    end if;
end;
/
