declare 
    l_codeoper number;
    l_new_name operlist.name%type;
    l_name     operlist.name%type := '����� ����';
    l_funcname operlist.funcname%type := '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_MBDK_ARCHIVE' || chr(38) || 
                                                                                                 'accessCode=1' || chr(38) || 'sPar=[NSIFUNCTION]';
begin 
    -- ������� �������
    umu.remove_function(l_funcname);
    commit;

    -- ������������� �������    
    l_name      := '����: �������� ����';
    l_new_name  := '����: �������� ���� (���������)';
    l_funcname  := '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_MBDK_PORTFOLIO' || chr(38) ||
                                                                             'accessCode=1' || chr(38) || 'sPar=[NSIFUNCTION][CONDITIONS=>VIDD IN (SELECT VIDD FROM V_MBDK_PRODUCT)]';
    operlist_adm.modify_func_by_path(l_funcname, null, l_new_name);

end;
/

