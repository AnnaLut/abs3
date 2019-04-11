declare
    l_process_type_id integer;
    l_back_office_confirm_act_id integer;
    l_create_smb_contract_act_id integer;
    l_transfer_funds_act_id integer;
begin
    l_process_type_id := process_utl.corr_proc_type('SMBD',
                                                    'NEW_ON_DEMAND',
                                                    '��������� ������ �� ������ ����',
                                                    p_can_create => 'smb_deposit_proc.can_create_new_on_demand', -- �������� ������� �� ���������� �����
                                                    p_can_run    => 'smb_deposit_proc.can_run_new_on_demand', -- �������� �� ����� ������������ �����-�����
                                                    p_on_create  => 'smb_deposit_proc.create_new_on_demand', -- ������������ ������� �� �������� �� �� ��
                                                    p_on_remove  => 'smb_deposit_proc.remove_new_on_demand', -- ������������ ��'���� ������� DELETED, ���� ��'��� ��� ���������
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
                                                               'ϳ����������� ���� ������ �� ������ ����������� ���-�����',
                                                               'Y',
                                                               'N',
                                                               p_can_run   => 'smb_deposit_proc.can_run_bo_confirm_on_demand', -- �������� �� ��������� ����������� ���-�����
                                                               p_is_active => 'Y');

    l_create_smb_contract_act_id := process_utl.corr_proc_flow(l_process_type_id,
                                                               'CREATE_ON_DEMAND_CONTRACT',
                                                               '��������� �������� ������ �� ������',
                                                               'N',
                                                               'N',
                                                               p_on_run => 'smb_deposit_proc.run_new_on_demand_contract', -- ����������� ����� ��'���� � ACTIVE, �������� �������
                                                               p_on_revert => 'smb_deposit_proc.revert_new_on_demand_contract', -- ���������� ��'���� � ���� CREATED
                                                               p_is_active => 'Y');

    process_utl.add_proc_flow_dependence(l_back_office_confirm_act_id, l_create_smb_contract_act_id);

    l_transfer_funds_act_id := process_utl.corr_proc_flow(l_process_type_id,
                                                          'TRANSFER_FUNDS',
                                                          '����������� ����� �� ���������� ������� �� ������ �� ������',
                                                          'N',
                                                          'N',
                                                          p_can_run => 'smb_deposit_proc.can_run_transfer_on_demand', -- �������� �� ���������� ����� �� ������� ��� �������� -- check_available
                                                          p_on_run => 'smb_deposit_proc.run_transfer_on_demand',      -- ��������� �������� 
                                                          p_on_revert => 'smb_deposit_proc.revert_transfer_on_demand',
                                                          p_is_active => 'Y');

    process_utl.add_proc_flow_dependence(l_create_smb_contract_act_id, l_transfer_funds_act_id);
    commit;
end;
/
