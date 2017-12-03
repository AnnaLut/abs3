declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_MBDK';
    l_name     operlist.name%type := 'МБДК: Портфель – інші запозичення банку';
    l_name2    operlist.name%type := 'МБДК: Портфель угод';
    l_funcname operlist.funcname%type := '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_MBDK_PORTFOLIO'||chr(38)||
                                         'accessCode=1'||chr(38)||
                                         'sPar=[NSIFUNCTION][CONDITIONS=>VIDD IN (SELECT VIDD FROM V_MBDK_PRODUCT WHERE TIPP = 2)]';
begin 

    -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>   l_name,
                    p_funcname  =>   '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_MBDK_PORTFOLIO'||chr(38)||
                                     'accessCode=2'||chr(38)||
                                     'sPar=[NSIFUNCTION][CONDITIONS=>VIDD IN (SELECT VIDD FROM V_MBDK_PRODUCT WHERE TIPP = 1)]', 
                    p_frontend  =>   1 ); 
 
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, l_codearm, 1 );     
    commit;

    -- обновить функцию
    update operlist set funcname = l_funcname where name = l_name2;
    commit;

end;
/

