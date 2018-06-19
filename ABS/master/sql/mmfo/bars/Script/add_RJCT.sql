--------------------------------------------
-- Добавить функцию в АРМ
--------------------------------------------
declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_@WF1'; -- АРМ SWIFT. Обробка повідомлень (повна)
begin   
    -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'SWIFT. Ручна відправка REJECT MT199',          -- Наименование функции
                    p_funcname  =>     '/barsroot/swift/swiftmt/index?isrejectview=true', 
                    p_frontend  =>      1 );                       -- 1 - web интерфейс, 0 - desctop
 
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - подтвержденный/неподтвержденный ресурс)
    commit;
end;
/


--------------------------------------------
-- Добавить функцию в АРМ
--------------------------------------------
declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_@WF1'; -- АРМ SWIFT. Обробка повідомлень (повна)
begin   
    -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'GPI. Формування МТ199(статут ACSC)',          -- Наименование функции
                    p_funcname  =>     '/barsroot/swift/swiftmt/index?isrejectview=false', 
                    p_frontend  =>      1 );                       -- 1 - web интерфейс, 0 - desctop
 
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - подтвержденный/неподтвержденный ресурс)
    commit;
end;
/