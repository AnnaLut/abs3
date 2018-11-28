--------------------------------------------
-- Добавить функцию в АРМ
--------------------------------------------
declare 
    l_codeoper number;
    l_arm  varchar2(10):= '$RM_WDOC';
    begin 
 
l_codeoper:=operlist_adm.add_new_func
                   (p_name      =>     'Формування та перегляд Є-декларацій',          
                    p_funcname  =>     '/barsroot/edeclarations/edeclarations/index',     
                    p_frontend  =>      1 );

umu.add_func2arm(l_codeoper, l_arm, 1 );
commit;
end;
/