prompt == *** SMB_DEPOSIT_TRANSFER_FUNDS *** ===
declare 
    id_ number ;
begin 
    bc.go('/'); 

    id_ := TMS_UTL.create_or_replace_task (
             p_task_code               => 'SMB_DEPOSIT_TRANSFER_FUNDS' -- ��������� ��� ��������� (������� TMS_TASK)
            ,p_task_group_id           => 1  -- �������� ��������� ���� ��� �������� ���������: 1 - ����, 2 - �����, 3 - �� �������������� �������� ����
            ,p_sequence_number         => 301  -- ���������� ����� ��������� �������� (���� �����������)
            ,p_task_name               => 'smb ����������� ���� � ������� ��� �������� �� ����������. �������� ����'   -- ����� ��������
            ,p_task_description        => null  -- ���������� ��������� ���� ��������
            ,p_separate_by_branch_mode => 3  -- ����� ������������� ��: 1 - ���������� ��������� �� "/", 2 - ����� �� ������������ �� ����, 3 - �� �� ������������ ����������
            ,p_action_on_failure       => 1  -- ������� �� � ��� ���������� �������: 1 - ���������� ��������� ��������, 2 - �������� ��������� ��������� ��������
            ,p_task_statement          =>
                                         'begin
                                              smb_calculation_deposit.transfer_funds_failed_deposit();
                                              commit;
                                          end ;' -- PL/SQL-����, �� ���������� ��� ������ ��������
       ) ;
 
    commit;
end;
/

prompt == *** SMB_DEPOSIT_PROLONGATION *** ===
declare 
    id_ number ;
begin 
    bc.go('/'); 

    id_ := TMS_UTL.create_or_replace_task (
             p_task_code               => 'SMB_DEPOSIT_PROLONGATION' -- ��������� ��� ��������� (������� TMS_TASK)
            ,p_task_group_id           => 1  -- �������� ��������� ���� ��� �������� ���������: 1 - ����, 2 - �����, 3 - �� �������������� �������� ����
            ,p_sequence_number         => 302  -- ���������� ����� ��������� �������� (���� �����������)
            ,p_task_name               => 'smb ��������������� ���������� �������. �������� ����'   -- ����� ��������
            ,p_task_description        => null  -- ���������� ��������� ���� ��������
            ,p_separate_by_branch_mode => 1  -- ����� ������������� ��: 1 - ���������� ��������� �� "/", 2 - ����� �� ������������ �� ����, 3 - �� �� ������������ ����������
            ,p_action_on_failure       => 1  -- ������� �� � ��� ���������� �������: 1 - ���������� ��������� ��������, 2 - �������� ��������� ��������� ��������
            ,p_task_statement          =>
                                         'begin
                                              smb_calculation_deposit.auto_deposit_prolongation(p_date => null);
                                              commit;
                                          end ;' -- PL/SQL-����, �� ���������� ��� ������ ��������
       ) ;
 
    commit;
end;
/

prompt == *** SMB_ACCRUAL_INTEREST *** ===
declare 
    id_ number ;
begin 
    bc.go('/'); 

    id_ := TMS_UTL.create_or_replace_task (
             p_task_code               => 'SMB_ACCRUAL_INTEREST' -- ��������� ��� ��������� (������� TMS_TASK)
            ,p_task_group_id           => 1  -- �������� ��������� ���� ��� �������� ���������: 1 - ����, 2 - �����, 3 - �� �������������� �������� ����
            ,p_sequence_number         => 303  -- ���������� ����� ��������� �������� (���� �����������)
            ,p_task_name               => 'smb ����������� �������. �������� ����'   -- ����� ��������
            ,p_task_description        => null  -- ���������� ��������� ���� ��������
            ,p_separate_by_branch_mode => 3  -- ����� ������������� ��: 1 - ���������� ��������� �� "/", 2 - ����� �� ������������ �� ����, 3 - �� �� ������������ ����������
            ,p_action_on_failure       => 1  -- ������� �� � ��� ���������� �������: 1 - ���������� ��������� ��������, 2 - �������� ��������� ��������� ��������
            ,p_task_statement          =>
                                         'begin
                                              smb_calculation_deposit.auto_accrual_interest(p_date    => null
                                                                                           ,p_deposit_list => null);
                                              commit;
                                          end ;' -- PL/SQL-����, �� ���������� ��� ������ ��������
       ) ;
 
    commit;
end;
/

prompt == *** SMB_DEPOSIT_CLOSING *** ===
declare 
    id_ number ;
begin 
    bc.go('/'); 

    id_ := TMS_UTL.create_or_replace_task (
             p_task_code               => 'SMB_DEPOSIT_CLOSING' -- ��������� ��� ��������� (������� TMS_TASK)
            ,p_task_group_id           => 1  -- �������� ��������� ���� ��� �������� ���������: 1 - ����, 2 - �����, 3 - �� �������������� �������� ����
            ,p_sequence_number         => 304  -- ���������� ����� ��������� �������� (���� �����������)
            ,p_task_name               => 'smb ����������� �������� ���������� �������. �������� ����'   -- ����� ��������
            ,p_task_description        => null  -- ���������� ��������� ���� ��������
            ,p_separate_by_branch_mode => 3  -- ����� ������������� ��: 1 - ���������� ��������� �� "/", 2 - ����� �� ������������ �� ����, 3 - �� �� ������������ ����������
            ,p_action_on_failure       => 1  -- ������� �� � ��� ���������� �������: 1 - ���������� ��������� ��������, 2 - �������� ��������� ��������� ��������
            ,p_task_statement          =>
                                         'begin
                                              smb_calculation_deposit.auto_deposit_closing(p_date => null);
                                              commit;
                                          end ;' -- PL/SQL-����, �� ���������� ��� ������ ��������
       ) ;
 
    commit;
end;
/

prompt == *** SMB_PAYMENT_ACCRUED_INTEREST *** ===
declare 
    id_ number ;
begin 
    bc.go('/'); 

    id_ := TMS_UTL.create_or_replace_task (
             p_task_code               => 'SMB_PAYMENT_ACCRUED_INTEREST' -- ��������� ��� ��������� (������� TMS_TASK)
            ,p_task_group_id           => 2  -- �������� ��������� ���� ��� �������� ���������: 1 - ����, 2 - �����, 3 - �� �������������� �������� ����
            ,p_sequence_number         => 305  -- ���������� ����� ��������� �������� (���� �����������)
            ,p_task_name               => 'smb ������� ����������� �������. �������� ����'   -- ����� ��������
            ,p_task_description        => null  -- ���������� ��������� ���� ��������
            ,p_separate_by_branch_mode => 3  -- ����� ������������� ��: 1 - ���������� ��������� �� "/", 2 - ����� �� ������������ �� ����, 3 - �� �� ������������ ����������
            ,p_action_on_failure       => 1  -- ������� �� � ��� ���������� �������: 1 - ���������� ��������� ��������, 2 - �������� ��������� ��������� ��������
            ,p_task_statement          =>
                                         'begin
                                              smb_calculation_deposit.auto_payment_accrued_interest(p_date    => null);
                                              commit;
                                          end ;' -- PL/SQL-����, �� ���������� ��� ������ ��������
       ) ;
 
    commit;
end;
/

prompt == *** SMB_ACCOUNT_DEPOSIT_CLOSING *** ===
declare 
    id_ number ;
begin 
    bc.go('/'); 

    id_ := TMS_UTL.create_or_replace_task (
             p_task_code               => 'SMB_ACCOUNT_DEPOSIT_CLOSING' -- ��������� ��� ��������� (������� TMS_TASK)
            ,p_task_group_id           => 2  -- �������� ��������� ���� ��� �������� ���������: 1 - ����, 2 - �����, 3 - �� �������������� �������� ����
            ,p_sequence_number         => 306  -- ���������� ����� ��������� �������� (���� �����������)
            ,p_task_name               => 'smb ����������� �������� �������. �������� ����'   -- ����� ��������
            ,p_task_description        => null  -- ���������� ��������� ���� ��������
            ,p_separate_by_branch_mode => 3  -- ����� ������������� ��: 1 - ���������� ��������� �� "/", 2 - ����� �� ������������ �� ����, 3 - �� �� ������������ ����������
            ,p_action_on_failure       => 1  -- ������� �� � ��� ���������� �������: 1 - ���������� ��������� ��������, 2 - �������� ��������� ��������� ��������
            ,p_task_statement          =>
                                         'begin
                                              smb_calculation_deposit.auto_account_deposit_closing(p_date    => null);
                                              commit;
                                          end ;' -- PL/SQL-����, �� ���������� ��� ������ ��������
       ) ;
 
    commit;
end;
/
