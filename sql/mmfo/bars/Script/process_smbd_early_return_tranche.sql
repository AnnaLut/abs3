declare
    l_process_type_id integer;
    l_back_office_confirm_act_id integer;
    l_create_smb_contract_act_id integer;
    l_transfer_funds_act_id integer;
begin
    l_process_type_id := process_utl.corr_proc_type('SMBD'
                                                    ,'EARLY_RETURN_TRANCHE'
                                                    ,'���������� ���������� ������ ����'
                                                    ,p_can_create => 'smb_deposit_proc.can_create_return_tranche' -- �������� ������� �� ���������� �����
                                                    ,p_can_run    => 'smb_deposit_proc.can_run_return_tranche'    -- �������� �� ����� ������������ �����-�����
                                                    ,p_on_create  => 'smb_deposit_proc.create_return_tranche'     -- ��������� ������ ��� ����������
                                                    ,p_on_remove  => 'smb_deposit_proc.remove_return_tranche'     -- ������������ ��'���� ������� DELETED, ���� ��'��� ��� ���������
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
                                                              ,'ϳ����������� ���� ���������� ������ ����������� ���-�����'
                                                              ,'Y'
                                                              ,'N'
                                                              ,p_can_run => 'smb_deposit_proc.can_run_bo_confirm_ret_tranche' -- �������� �� ��������� ����������� ���-�����
                                                              ,p_is_active => 'Y');

    l_transfer_funds_act_id := process_utl.corr_proc_flow(     l_process_type_id
                                                              ,'RETURN_TRANSFER_FUNDS'
                                                              ,'����������� ����� � ����������� �������'
                                                              ,'N'
                                                              ,'N'
                                                              ,p_can_run => 'smb_deposit_proc.can_run_return_transfer_funds' -- �������� �� ���������� ����� �� ������� ��� ��������
                                                              ,p_on_run => 'smb_deposit_proc.run_return_transfer_funds'      -- ��������� �������� 
                                                              ,p_is_active => 'Y');

    process_utl.add_proc_flow_dependence(l_back_office_confirm_act_id, l_transfer_funds_act_id);
    commit;
end;
/
