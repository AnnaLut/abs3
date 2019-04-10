declare
    l_process_type_id integer;
    l_activity_id integer;
begin
    -- все методы пустые сохраняем историю
    l_process_type_id := process_utl.corr_proc_type(
                                           p_module_code  => smb_deposit_utl.PROCESS_TRANCHE_MODULE
                                          ,p_process_code => smb_deposit_utl.PROCESS_TRANCHE_PROLONGATION 
                                          ,p_process_name => 'Пролонгація депозитного траншу ММСБ'
                                          ,p_is_active    => 'Y');

    delete process_workflow_dependency t
    where  t.primary_activity_id in (select a.id
                                     from   process_workflow a
                                     where  a.process_type_id = l_process_type_id) or
           t.following_activity_id in (select a.id
                                       from   process_workflow a
                                       where  a.process_type_id = l_process_type_id);

    l_activity_id := process_utl.corr_proc_flow(
                                                p_proc_type_id       => l_process_type_id
                                               ,p_activity_code      => smb_deposit_utl.ACT_TRANCHE_PROLONGATION
                                               ,p_activity_name      => 'Пролонгація'
                                               ,p_manual_run_flag    => 'N'
                                               ,p_manual_revert_flag => 'N'
                                               ,p_on_run             => null 
                                               ,p_is_active          => 'Y');
    commit;
end;
/