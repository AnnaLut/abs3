begin
  sys.dbms_scheduler.create_job(job_name            => 'BARS.EAD_SYNC_2625',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'declare
    nHour      pls_integer;
    cDayOfWeek character;
  begin
    execute immediate q''#alter session set nls_territory = ''UKRAINE''#'';
    select extract(hour from localtimestamp) into nHour from dual;
    cDayOfWeek := to_char(sysdate, ''D'');
  
    if cDayOfWeek in (6, 7) or (cDayOfWeek between 1 and 5) and (nHour < 7 or nHour > 20) then
      FOR cur IN (select *
                    from (SELECT sq.id, sq.crt_date, sq.type_id, sq.status_id, sq.err_count, sq.kf
                             FROM ead_sync_queue sq
                            WHERE sq.type_id = any(''AGR'', ''CLIENT'')
                              and sq.crt_date = date ''2000-01-01''
                              and sq.status_id in (''OUTDATED'', ''ERROR'') 
                              AND nvl(sq.err_count, 0) < 30
                            order by id asc)
                   where ROWNUM < 1000) LOOP
        ead_pack.msg_process(cur.id, cur.kf, ''F'');
        commit work;
      end loop;
    end if;
  end;',
                                start_date          => to_date(null),
                                repeat_interval     => 'Freq=Minutely;Interval=5',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'Звірка завантаження клієнтів та рахунків(2625) АБС БАРС та ЕА (Повторно)');
end;
/