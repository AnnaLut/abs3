declare
    l_process_type_id integer;
    l_back_office_confirm_act_id integer;
    l_create_smb_contract_act_id integer;
    l_transfer_funds_act_id integer;
begin
    l_process_type_id := process_utl.corr_proc_type('SMBD'
                                                    ,'REPLENISH_TRANCHE'
                                                    ,'Поповнення депозитного траншу ММСБ'
                                                    ,p_can_create => 'smb_deposit_proc.can_create_replenish_tranche' -- перевірка повноти та коректності даних
                                                    ,p_can_run    => 'smb_deposit_proc.can_run_replenish_tranche'    -- перевірка на різних користувачів фронт-офісу
                                                    ,p_on_create  => 'smb_deposit_proc.create_replenish_tranche'     -- створення запису про поповнення
                                                    ,p_on_remove  => 'smb_deposit_proc.remove_replenish_tranche'     -- встановлення об'єкту статусу DELETED, якщо об'єкт був створений
                                                    ,p_is_active  => 'Y');

    delete process_workflow_dependency t
    where  t.primary_activity_id in (select a.id
                                     from   process_workflow a
                                     where  a.process_type_id = l_process_type_id) or
           t.following_activity_id in (select a.id
                                       from   process_workflow a
                                       where  a.process_type_id = l_process_type_id);

    l_back_office_confirm_act_id := process_utl.corr_proc_flow(l_process_type_id
                                                              ,'BACK_OFFICE_CONFIRMATION'
                                                              ,'Підтвердження умов поповнення траншу контролером бек-офісу'
                                                              ,'Y'
                                                              ,'N'
                                                              ,p_can_run => 'smb_deposit_proc.bo_confirm_replenish_tranche' -- перевірка на співпадіння користувача бек-офісу
                                                              ,p_is_active => 'Y');

    l_transfer_funds_act_id := process_utl.corr_proc_flow(     l_process_type_id
                                                              ,'REPLENISH_TRANSFER_FUNDS'
                                                              ,'Зарахування коштів на депозитний рахунок (попвнення траншу)'
                                                              ,'N'
                                                              ,'N'
                                                              ,p_can_run => 'smb_deposit_proc.can_run_transfer_replenishment' -- перевірка на достатність коштів на рахунку для списання
                                                              ,p_on_run => 'smb_deposit_proc.run_transfer_replenishment'      -- створення проводки
                                                              ,p_on_revert => 'smb_deposit_proc.revert_transfer_replenishment'
                                                              ,p_is_active => 'Y');

    process_utl.add_proc_flow_dependence(l_back_office_confirm_act_id, l_transfer_funds_act_id);
    commit;
end;
/
