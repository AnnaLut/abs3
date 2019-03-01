declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_F601';
begin   
     -- Cоздать/Обновить Арм
    umu.cor_arm( l_codearm, 'АРМ "ФОРМА 601"', 1);   
    -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'Перевірка повноти передачі кредитів до 601 форми',          -- Наименование функции
                    p_funcname  =>     '/barsroot/Compare_351_601/Compare_351_601/index',      -- Строка вызова функции
                    p_frontend  =>      1 );                       -- 1 - web интерфейс, 0 - desctop
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, l_codearm, 1 );      --(1/0 - подтвержденный/неподтвержденный ресурс)
    commit;
end;
/