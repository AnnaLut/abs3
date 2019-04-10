declare
    l_process_type_id integer;
    l_back_office_confirm_act_id integer;
    l_transfer_funds_act_id integer;
begin
    l_process_type_id := process_utl.corr_proc_type('SMBD',
                                                    'CLOSE_ON_DEMAND',
                                                    'Закриття вкладу на вимогу ММСБ',
                                                    p_can_create => 'smb_deposit_proc.can_create_close_on_demand', -- перевірка повноти та коректності даних
                                                    p_can_run    => 'smb_deposit_proc.can_run_close_on_demand', -- перевірка на різних користувачів фронт-офісу
                                                    p_on_create  => 'smb_deposit_proc.create_close_on_demand', -- резервування рахунків та відправка їх до ЕА
                                                    p_on_remove  => 'smb_deposit_proc.remove_close_on_demand', -- встановлення об'єкту статусу DELETED, якщо об'єкт був створений
                                                    p_is_active  => 'Y');

    delete process_workflow_dependency t
    where  t.primary_activity_id in (select a.id
                                     from   process_workflow a
                                     where  a.process_type_id = l_process_type_id) or
           t.following_activity_id in (select a.id
                                       from   process_workflow a
                                       where  a.process_type_id = l_process_type_id);

    l_back_office_confirm_act_id := process_utl.corr_proc_flow(l_process_type_id,
                                                               'BACK_OFFICE_CONFIRMATION',
                                                               'Підтвердження закриття вкладу на вимогу контролером бек-офісу',
                                                               'Y',
                                                               'N',
                                                               p_can_run   => 'smb_deposit_proc.can_bo_confirm_close_on_demand', -- перевірка на співпадіння користувача бек-офісу
                                                               p_is_active => 'Y');

    l_transfer_funds_act_id := process_utl.corr_proc_flow(l_process_type_id,
                                                              'CLOSE_ON_DEMAND',
                                                              'Закриття вкладу на вимогу',
                                                              'N',
                                                              'N',
                                                              p_can_run => 'smb_deposit_proc.can_run_action_close_on_demand', -- перевірка на достатність коштів на рахунку для списання -- check_available
                                                              p_on_run => 'smb_deposit_proc.run_action_close_on_demand',      -- створення проводки 
                                                              p_is_active => 'Y');

    process_utl.add_proc_flow_dependence(l_back_office_confirm_act_id, l_transfer_funds_act_id);
    commit;
end;
/
