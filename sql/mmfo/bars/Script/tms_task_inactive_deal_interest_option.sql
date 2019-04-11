declare 
    id_ number ;
begin 

    bc.go('/'); 

    id_ := TMS_UTL.create_or_replace_task (
             p_task_code               => 'SMB_INACTIVE_INTEREST_OPTION' -- ���������� ��� ��������� (������� TMS_TASK)
            ,p_task_group_id           => 2  -- �������� ��������� ���� ��� ��������� ���������: 1 - �����, 2 - �����, 3 - �� �������������� �������� ����
            ,p_sequence_number         => 312  -- ���������� ����� ��������� �������� (���� �����������)
            ,p_task_name               => '������������ ���������� ������ ��� ��������� ����'   -- ����� ��������
            ,p_task_description        => '���������� ������������ ���������� ������ ��� ��������� ����'  -- ���������� ��������� ���� ��������
            ,p_separate_by_branch_mode => 1  -- ����� ������������� ��: 1 - ���������� ��������� �� "/", 2 - ����� �� ������������ �� ����, 3 - �� �� ������������ ����������
            ,p_action_on_failure       => 1  -- ������� �� � ��� ���������� �������: 1 - ���������� ��������� ��������, 2 - �������� ��������� ��������� ��������
            ,p_task_statement          =>
                                         'begin
                                              smb_deposit_utl.set_inactive_deal_int_option(gl.bd);
                                              commit;
                                          end ;' -- PL/SQL-����, �� ���������� ��� ������ ��������
       ) ;
 
    commit;
end;
/
