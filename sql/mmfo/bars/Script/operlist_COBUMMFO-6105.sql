declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_RISK';
    l_name     operlist.name%type := '3.10. �������� ��������� ������� (EXCEL)';
    l_funcname operlist.funcname%type := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||
                                         'sPar=REZ_NBU23_DELTA[PROC=>z23.P_DELTA(:A,:B)][PAR=>:A(SEM=��_����_�_01-��-����,TYPE=D),:B(SEM=��_����_��_01-��-����,TYPE=D)][EXEC=>BEFORE]';
begin 

    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func (p_name  =>  l_name, p_funcname  =>  l_funcname, p_frontend  =>  1 ); 
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );     
    commit;

end;
/
