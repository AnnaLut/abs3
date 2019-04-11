declare
    l_process_type_id integer;
    l_back_office_confirm_act_id integer;
    l_transfer_funds_act_id integer;
begin
    l_process_type_id := process_utl.corr_proc_type('SMBD',
                                                    'CLOSE_ON_DEMAND',
                                                    '�������� ������ �� ������ ����',
                                                    p_can_create => 'smb_deposit_proc.can_create_close_on_demand', -- �������� ������� �� ���������� �����
                                                    p_can_run    => 'smb_deposit_proc.can_run_close_on_demand', -- �������� �� ����� ������������ �����-�����
                                                    p_on_create  => 'smb_deposit_proc.create_close_on_demand', -- ������������ ������� �� �������� �� �� ��
                                                    p_on_remove  => 'smb_deposit_proc.remove_close_on_demand', -- ������������ ��'���� ������� DELETED, ���� ��'��� ��� ���������
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
                                                               'ϳ����������� �������� ������ �� ������ ����������� ���-�����',
                                                               'Y',
                                                               'N',
                                                               p_can_run   => 'smb_deposit_proc.can_bo_confirm_close_on_demand', -- �������� �� ��������� ����������� ���-�����
                                                               p_is_active => 'Y');

    l_transfer_funds_act_id := process_utl.corr_proc_flow(l_process_type_id,
                                                              'CLOSE_ON_DEMAND',
                                                              '�������� ������ �� ������',
                                                              'N',
                                                              'N',
                                                              p_can_run => 'smb_deposit_proc.can_run_action_close_on_demand', -- �������� �� ���������� ����� �� ������� ��� �������� -- check_available
                                                              p_on_run => 'smb_deposit_proc.run_action_close_on_demand',      -- ��������� �������� 
                                                              p_is_active => 'Y');

    process_utl.add_proc_flow_dependence(l_back_office_confirm_act_id, l_transfer_funds_act_id);
    commit;
end;
/
