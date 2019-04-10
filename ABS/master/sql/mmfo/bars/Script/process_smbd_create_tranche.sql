declare
    l_process_type_id integer;
    l_back_office_confirm_act_id integer;
    l_create_smb_contract_act_id integer;
    l_transfer_funds_act_id integer;
begin
    l_process_type_id := process_utl.corr_proc_type('SMBD',
                                                    'NEW_TRANCHE',
                                                    'Реєстрація депозитного траншу ММСБ',
                                                    p_can_create => 'smb_deposit_proc.can_create_new_tranche', -- перевірка повноти та коректності даних
                                                    p_can_run => 'smb_deposit_proc.can_run_new_tranche', -- перевірка на різних користувачів фронт-офісу
                                                    p_on_create => 'smb_deposit_proc.create_new_tranche', -- резервування рахунків та відправка їх до ЕА
                                                    p_on_remove => 'smb_deposit_proc.remove_new_tranche', -- встановлення об'єкту статусу DELETED, якщо об'єкт був створений
                                                    p_is_active => 'Y');

    delete process_workflow_dependency t
    where  t.primary_activity_id in (select a.id
                                     from   process_workflow a
                                     where  a.process_type_id = l_process_type_id) or
           t.following_activity_id in (select a.id
                                       from   process_workflow a
                                       where  a.process_type_id = l_process_type_id);

    l_back_office_confirm_act_id := process_utl.corr_proc_flow(l_process_type_id,
                                                               'BACK_OFFICE_CONFIRMATION',
                                                               'Підтвердження умов траншу контролером бек-офісу',
                                                               'Y',
                                                               'N',
                                                               p_can_run => 'smb_deposit_proc.can_run_back_office_confirm', -- перевірка на співпадіння користувача бек-офісу
                                                               p_is_active => 'Y');

    l_create_smb_contract_act_id := process_utl.corr_proc_flow(l_process_type_id,
                                                               'CREATE_TRANCHE_CONTRACT',
                                                               'Реєстрація договору строкового траншу',
                                                               'N',
                                                               'N',
                                                               p_on_run => 'smb_deposit_proc.run_new_tranche_contract', -- переведення стану об'єкту в ACTIVE, відкриття рахунків
                                                               p_on_revert => 'smb_deposit_proc.revert_new_tranche_contract', -- повернення об'єкту в стан CREATED
                                                               p_is_active => 'Y');

    process_utl.add_proc_flow_dependence(l_back_office_confirm_act_id, l_create_smb_contract_act_id);

    l_transfer_funds_act_id := process_utl.corr_proc_flow(l_process_type_id,
                                                          'TRANSFER_FUNDS',
                                                          'Зарахування коштів на депозитний рахунок',
                                                          'N',
                                                          'N',
                                                          p_can_run => 'smb_deposit_proc.can_run_transfer_tranche_funds', -- перевірка на достатність коштів на рахунку для списання
                                                          p_on_run => 'smb_deposit_proc.run_transfer_tranche_funds',      -- створення проводки 
                                                          p_on_revert => 'smb_deposit_proc.revert_transfer_tranche_funds',
                                                          p_is_active => 'Y');

    process_utl.add_proc_flow_dependence(l_create_smb_contract_act_id, l_transfer_funds_act_id);
end;
/
