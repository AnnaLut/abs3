set define off

declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_NBUR';
    l_name     operlist.name%type := 'Перегляд списку сформованих файлів (всі версії)';
    l_funcname operlist.funcname%type := '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_NBUR_FORM_ALL_USER&accessCode=1';
begin 
    bc.home;
    
    -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>   l_name,
                    p_funcname  =>   l_funcname, 
                    p_frontend  =>   1 ); 
 
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, l_codearm, 1 );         
    commit;
end;
/

