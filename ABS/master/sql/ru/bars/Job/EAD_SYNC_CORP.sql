PROMPT *** Drop scheduled job EAD_SYNC_CORP ***
begin
    sys.dbms_scheduler.drop_job( job_name => 'EAD_SYNC_CORP' );
exception
    when OTHERS then null;
end;
/
PROMPT *** Create scheduled job EAD_SYNC_CORP ***
begin
  sys.dbms_scheduler.create_job(job_name            => 'BARS.EAD_SYNC_CORP',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'begin tuda (); ead_pack.cdc_client_u; ead_pack.cdc_agr_u; ead_pack.cdc_uacc; suda (); commit; tuda (); ead_pack.type_process(''UCLIENT'');ead_pack.type_process(''UAGR'');ead_pack.type_process(''UACC''); suda (); commit; end;',
                                start_date          => to_date('01-06-2016 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval   => 'Freq=MINUTELY;Interval=5',
                                end_date           => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => false,
                                auto_drop          => false,
                                comments         => 'Джоб для передачи сообщений в ЭА (Юр.особи)');
exception
  when others then
    if sqlcode = -27477 then
      null;
    else
      raise;
    end if;
end;
/
