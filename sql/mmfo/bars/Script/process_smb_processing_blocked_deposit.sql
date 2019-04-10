declare
    l_process_type_id integer;
begin
    l_process_type_id := process_utl.corr_proc_type('SMBD'
                                                    ,'PROCESSING_BLOCKED_DEPOSIT'
                                                    ,'Обработка заблокированного депозита ММСБ  (блокировка/лимит по счету)'
                                                    ,p_is_active  => 'Y');
    commit;
end;
/
