declare
    l_process_type_id integer;
    l_back_office_confirm_act_id integer;
begin
    l_process_type_id := process_utl.corr_proc_type('SMBD'
                                                    ,'TRANCHE_UNBLOCKING'
                                                    ,'Розблокування депозитного траншу ММСБ'
                                                    ,p_can_create => 'smb_deposit_proc.can_create_tranche_unblocking'  -- перевірка можливості розблокування траншу
                                                    ,p_on_create  => 'smb_deposit_proc.create_tranche_unblocking'      -- створення процесу для розблокування траншу
                                                    ,p_is_active  => 'Y');

    delete process_workflow_dependency t
    where  t.primary_activity_id in (select a.id
                                     from   process_workflow a
                                     where  a.process_type_id = l_process_type_id) or
           t.following_activity_id in (select a.id
                                       from   process_workflow a
                                       where  a.process_type_id = l_process_type_id);

    l_back_office_confirm_act_id := process_utl.corr_proc_flow(l_process_type_id
                                                              ,'TRANCHE_UNBLOCKING'
                                                              ,'Розблокування депозитного траншу ММСБ'
                                                              ,'N'
                                                              ,'N'
                                                              ,p_on_run   => 'smb_deposit_proc.run_tranche_unblocking' 
                                                              ,p_is_active => 'Y');

    commit;
end;
/
