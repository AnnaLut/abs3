declare 
    l_codeoper number;
    l_new_name operlist.name%type;
    l_name     operlist.name%type := 'Архів угод';
    l_funcname operlist.funcname%type := '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_MBDK_ARCHIVE' || chr(38) || 
                                                                                                 'accessCode=1' || chr(38) || 'sPar=[NSIFUNCTION]';
begin 
    -- Удалить функцию
    umu.remove_function(l_funcname);
    commit;

    -- Переименовать функцию    
    l_name      := 'МБДК: Портфель угод';
    l_new_name  := 'МБДК: Портфель угод (загальний)';
    l_funcname  := '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_MBDK_PORTFOLIO' || chr(38) ||
                                                                             'accessCode=1' || chr(38) || 'sPar=[NSIFUNCTION][CONDITIONS=>VIDD IN (SELECT VIDD FROM V_MBDK_PRODUCT)]';
    operlist_adm.modify_func_by_path(l_funcname, null, l_new_name);

end;
/

