declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_PRVN';
    l_name     operlist.name%type := '���������� ������ �� ������������ FTPL/Other';
    l_funcname operlist.funcname%type := '/barsroot/PRVN/SrrCost/index';

begin 
    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func (p_name  =>  l_name, p_funcname  =>  l_funcname, p_frontend  =>  1 ); 
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );     
    commit;

end;
/

