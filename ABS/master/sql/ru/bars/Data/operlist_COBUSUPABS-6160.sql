prompt ��������� ������� "������� ���� ���'������ ���"
declare
l_id number;
begin
    l_id := abs_utils.add_func(p_rolename => 'BARS_ACCESS_DEFROLE', p_name => '������� ���� ���''������ ���', p_funcname => '/barsroot/LinkedGroupReference/LGroupsReference/Index', p_frontend => 1, p_runnable => 1);
end;
/
commit;
/