--------------------------------------------
-- Добавить функцию в АРМ
--------------------------------------------
declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_UCCK';
begin   
    -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'Фініш первинного КД ОСББ і Старт вторинного КД ОСББ за вимогою по КД',          -- Наименование функции
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=[PROC=>CCK_OSBB(2,:ND)][PAR=>:ND(SEM=Референс КД)][QST=>Виконати фініш первинного і старт вторинного КД ОСББ?][MSG=>Виконано!]', 
                    p_frontend  =>      1 );                       -- 1 - web интерфейс, 0 - desctop
 
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - подтвержденный/неподтвержденный ресурс)
    commit;
end;
/

grant execute on CCK_OSBB to bars_access_defrole;