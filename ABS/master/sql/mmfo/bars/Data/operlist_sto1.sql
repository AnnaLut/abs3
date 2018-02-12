--------------------------------------------
-- Добавить функцию в АРМ
--------------------------------------------
declare  
    l_codeoper number; 
    l_codearm  varchar2(10) := '$RM_STO1';
begin    
     -- Cоздать/Обновить Арм
    umu.cor_arm( l_codearm, 'АРМ Регулярні платежі', 1);    
    -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'Друк звітів',          -- Наименование функции
                    p_funcname  =>     '%/barsroot/cbirep/rep_list.aspx?codeapp=\S*%',      -- Строка вызова функции
                    p_frontend  =>      1 );                       -- 1 - web интерфейс, 0 - desctop

    -- добавить функциюв Арм 
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - подтвержденный/неподтвержденный ресурс)
    commit;
end;
/

               

