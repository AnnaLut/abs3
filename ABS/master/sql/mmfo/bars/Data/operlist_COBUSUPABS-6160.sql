prompt ��������� ������� "������� ���� ���'������ ���"
declare
l_id number;
begin
    l_id := operlist_adm.add_new_func(p_name => '������� ���� ���''������ ���', p_funcname => '/barsroot/LinkedGroupReference/LGroupsReference/Index', p_frontend => 1, p_runnable => 1);
end;
/
commit;
/