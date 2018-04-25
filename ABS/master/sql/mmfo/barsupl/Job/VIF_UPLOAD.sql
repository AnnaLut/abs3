prompt Создаем джобы для 15 выгрузки
begin
    for rec in (select kf from bars.mv_kf)
    loop
        begin
          sys.dbms_scheduler.create_job(job_name            => 'BARSUPL.VIF_UPLOAD_'||rec.kf,
                                        job_type            => 'PLSQL_BLOCK',
                                        job_action          => 
        'begin
             bars.bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                                        p_userid    => 220301,
                                        p_hostname  => null,
                                        p_appname   => ''UPLD:VIF_UPLOAD_'||rec.kf||';group=15;null;'||rec.kf||''');
             bars.bc.go('''||rec.kf||''');
             barsupl.bars_upload_usr.routine_for_job( trunc(sysdate)-1 , 15,1,0,1,1,'''||rec.kf||''');
        end;',
                                        start_date          => to_date('10-02-2017 15:47:38', 'dd-mm-yyyy hh24:mi:ss'),
                                        repeat_interval     => 'Freq=DAILY;ByDay=MON,TUE,WED,THU,FRI;ByHour=13;ByMinute=00;BySecond=0',
                                        end_date            => to_date(null),
                                        job_class           => 'DEFAULT_JOB_CLASS',
                                        enabled             => true,
                                        auto_drop           => false,
                                        comments            => '15 group - daily VIF upload');
        exception
            when others then 
                if sqlcode = -27477 then null; else raise; end if;
        end;
    end loop;
end;
/
