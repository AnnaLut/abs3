prompt ��������� �������� �-� "�������� �� �������� ������"
declare
l_codeoper number;
begin
    l_codeoper := abs_utils.add_func(p_funcname => '/barsroot/sto/contract/index?mode=user', 
                                     p_name     => '�������� �� �������� ������ (�����������)', 
                                     p_forceupd => 1, 
                                     p_rolename => 'START1');
    commit;
end;
/