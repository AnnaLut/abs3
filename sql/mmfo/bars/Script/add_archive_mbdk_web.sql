	   set define off;
declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_MBDK';
begin   
     -- Cоздать/Обновить Арм
    umu.cor_arm( l_codearm, 'АРМ Портфель МБДК', 1);   
    -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'Архів угод МБДК',          -- Наименование функции
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?tableName=v_mbdk_archive&accessCode=1&sPar=[NSIFUNCTION]',      -- Строка вызова функции
                    p_frontend  =>      1 );                       -- 1 - web интерфейс, 0 - desctop
 
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - подтвержденный/неподтвержденный ресурс)
    commit;
end;
/
