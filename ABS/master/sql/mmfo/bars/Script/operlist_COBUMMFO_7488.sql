declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_RISK';
    l_name     operlist.name%type := '2.71. �볺���, �� ��������� ����� ������.�� ������.�������������';
    l_funcname operlist.funcname%type := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||
                                         'sPar=NBU23_CCK_DEB[PROC=>P_CCK_DEB(:A)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][EXEC=>BEFORE]';
begin 

    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func (p_name  =>  l_name, p_funcname  =>  l_funcname, p_frontend  =>  1 ); 
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );     
    commit;

    l_name      := '2.70. ���� ���������� �������';
    l_funcname  := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||
                   'sPar=REZ_LOG_18[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),NULL)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][EXEC=>BEFORE]';

    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func (p_name  =>  l_name, p_funcname  =>  l_funcname, p_frontend  =>  1 ); 
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );     
    commit;

end;
/




