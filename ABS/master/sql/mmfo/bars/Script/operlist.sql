declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_MBDK';
    l_name     operlist.name%type := '����: �������� � ���� ����������� �����';
    l_name2    operlist.name%type := '����: �������� ����';
    l_funcname operlist.funcname%type := '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_MBDK_PORTFOLIO'||chr(38)||
                                         'accessCode=1'||chr(38)||
                                         'sPar=[NSIFUNCTION][CONDITIONS=>VIDD IN (SELECT VIDD FROM V_MBDK_PRODUCT WHERE TIPP = 2)]';
begin 

    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>   l_name,
                    p_funcname  =>   '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_MBDK_PORTFOLIO'||chr(38)||
                                     'accessCode=2'||chr(38)||
                                     'sPar=[NSIFUNCTION][CONDITIONS=>VIDD IN (SELECT VIDD FROM V_MBDK_PRODUCT WHERE TIPP = 1)]', 
                    p_frontend  =>   1 ); 
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );     
    commit;

    -- �������� �������
    update operlist set funcname = l_funcname where name = l_name2;
    commit;

end;
/

