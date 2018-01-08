create or replace view v_staff_managers as
select  id, fio, LOGNAME,TYPE,TABN,DISABLE,EXPIRED,CAN_SELECT_BRANCH,CLSID  
 from bars.staff$base t WHERE branch LIKE bars.bars_context.get_parent_branch(SYS_CONTEXT ('bars_context', 'user_branch'))||'%'
                   and length(branch) >= length('/______/______/');
                   
comment on table v_staff_managers is '������ ������������� ������� �������� �����. �������� ����� ���� 3-�� ��� 2-�� ������.';   

