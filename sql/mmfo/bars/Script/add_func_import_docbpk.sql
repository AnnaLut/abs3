set define off
set define off
declare 
    l_funcid  operlist.codeoper%type;
    l_tabid   number;
    l_codearm  VARCHAR2(10) := '$RM_W_W4'; -- ��� "��� � Way4"
begin
    l_funcid:= abs_utils.add_func( p_name     => 'I����� 7.0: ������ ����� ���������� ��������',
                                   p_funcname => '/barsroot/sberutls/importex.aspx?imptype=cw&config=imp_7_0',
                                   p_rolename => '',    
                                   p_frontend => 1);
    umu.add_func2arm(l_funcid, l_codearm, 1); 
end;
/ 
commit;                                                                            

