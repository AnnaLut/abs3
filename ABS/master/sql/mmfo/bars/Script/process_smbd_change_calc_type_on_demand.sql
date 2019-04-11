declare
    l_process_type_id            number;
    l_back_office_confirm_act_id number;
    l_activity_id                number;
begin
    l_process_type_id := process_utl.corr_proc_type(
                                               p_module_code  => smb_deposit_utl.PROCESS_TRANCHE_MODULE
                                              ,p_process_code => smb_deposit_utl.PROCESS_DOD_CHANGE_CALC_TYPE 
                                              ,p_process_name => 'Зміна методу нарахування відсотків для вкладу на вимогу ММСБ'
                                              ,p_can_run      => 'smb_deposit_proc.can_run_close_on_demand' -- перевірка на різних користувачів фронт-офісу
                                              ,p_on_create    => 'smb_deposit_proc.create_change_calc_type_dod'
                                              ,p_is_active    => 'Y');

    delete process_workflow_dependency t
    where  t.primary_activity_id in (select a.id
                                     from   process_workflow a
                                     where  a.process_type_id = l_process_type_id) or
           t.following_activity_id in (select a.id
                                       from   process_workflow a
                                       where  a.process_type_id = l_process_type_id);
                                       
    l_back_office_confirm_act_id := process_utl.corr_proc_flow(
                                                p_proc_type_id       => l_process_type_id
                                               ,p_activity_code      => 'BACK_OFFICE_CONFIRMATION'
                                               ,p_activity_name      => 'Підтвердження зміни методу нарахування відсотків контролером бек-офісу'
                                               ,p_manual_run_flag    => 'Y'
                                               ,p_manual_revert_flag => 'N'
                                               ,p_can_run            => 'smb_deposit_proc.can_confirm_change_calc_type'
                                               ,p_is_active          => 'Y');

    l_activity_id := process_utl.corr_proc_flow(
                                                p_proc_type_id       => l_process_type_id
                                               ,p_activity_code      => smb_deposit_utl.ACT_DOD_CHANGE_CALC_TYPE
                                               ,p_activity_name      => 'Зміна методу нарахування відсотків'
                                               ,p_manual_run_flag    => 'N'
                                               ,p_manual_revert_flag => 'N'
                                               ,p_on_run             => 'smb_deposit_proc.change_calc_type_dod_run' 
                                               ,p_is_active          => 'Y');
    process_utl.add_proc_flow_dependence(l_back_office_confirm_act_id, l_activity_id);                                               
    commit;
end;
/
