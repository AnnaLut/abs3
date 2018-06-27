--------------------------------------------
-- Добавить функцию в АРМ
--------------------------------------------
declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_BVBB';
begin   
     -- Cоздать/Обновить Арм
    umu.cor_arm( l_codearm, 'АРМ Бек-офісу', 1);   
    
	-- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'Ф-605.Розрахунок простроч.заборгов. за КД, в тч за пенею та 3% річних',          -- Наименование функции
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_605[NSIFUNCTION]'||'[showDialogWindow=>false]',      -- Строка вызова функции
                    p_frontend  =>      1 );                       -- 1 - web интерфейс, 0 - desctop
 
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - подтвержденный/неподтвержденный ресурс)
    commit;
end;
/
