--------------------------------------------
-- Добавить функцию в АРМ
--------------------------------------------
declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_VALB'; -- АРМ Валютний Бухгалтер 
    l_codearm_1  varchar2(10) := '$RM_@WF1'; -- АРМ SWIFT. Обробка повідомлень (повна) 
begin   
    -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     '3720 NLI ->розбір нез’ясованих SWIFT по Юр. особам',          -- Наименование функции
                    p_funcname  =>     '/barsroot/gl/nl/index?tip=nli'||chr(38)||'ttList=99', 
                    p_frontend  =>      1 );                       -- 1 - web интерфейс, 0 - desctop
 
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - подтвержденный/неподтвержденный ресурс)
    umu.add_func2arm(l_codeoper, l_codearm_1, 1 );                 --(1/0 - подтвержденный/неподтвержденный ресурс)
    commit;
end;
/

declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_VALB'; -- АРМ Валютний Бухгалтер
    l_codearm_1  varchar2(10) := '$RM_@WF1'; -- АРМ SWIFT. Обробка повідомлень (повна)
begin   
    -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     '3720 NLJ ->розбір нез’ясованих SWIFT по Фіз. Особам',          -- Наименование функции
                    p_funcname  =>     '/barsroot/gl/nl/index?tip=nlj'||chr(38)||'ttList=99', 
                    p_frontend  =>      1 );                       -- 1 - web интерфейс, 0 - desctop
 
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - подтвержденный/неподтвержденный ресурс)
    umu.add_func2arm(l_codeoper, l_codearm_1, 1 );                 --(1/0 - подтвержденный/неподтвержденный ресурс)
    commit;
end;
/