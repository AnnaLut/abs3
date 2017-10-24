

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_TASK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_TASK ***

  CREATE OR REPLACE PROCEDURE BARS.P_TASK ( P_MOD INT, P_cod varchar2, p_grp int, P_ORD INT, P_Nam varchar2, p_dsc varchar2, P_MFO int, p_ERR INT, p_SQL varchar2 )  IS
 ID_ INT ;
BEGIN
 iF P_MOD = 1 THEN -- ������� -- ����� �������
    id_ := TMS_UTL.create_or_replace_task (
        p_task_code               => p_cod,  -- ��������� ��� ��������� (������� TMS_TASK)
        p_task_group_id           => p_grp,  -- �������� ��������� ���� ��� �������� ���������: 1 - ����, 2 - �����, 3 - �� �������������� �������� ����
        p_sequence_number         => p_ord,  -- ���������� ����� ��������� �������� (���� �����������)
        p_task_name               => p_nam,  -- ����� ��������
        p_task_description        => p_dsc,  -- ���������� ��������� ���� ��������
        p_separate_by_branch_mode => p_Mfo,  -- ����� ������������� ��: 1 - ���������� ��������� �� "/", 2 - ����� �� ������������ �� ����, 3 - �� �� ������������ ����������
        p_action_on_failure       => p_err,  -- ������� �� � ��� ���������� �������: 1 - ���������� ��������� ��������, 2 - �������� ��������� ��������� ��������
        p_task_statement          => p_sql   -- PL/SQL-����, �� ���������� ��� ������ ��������
                                          ) ;
 end if;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_TASK.sql =========*** End *** ==
PROMPT ===================================================================================== 
