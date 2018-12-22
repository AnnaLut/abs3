declare 
    l_codeoper number; 
begin   
    --Создаем функцию пока без добавления в АРМ
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'Стан транзитного Рахунку T00 на дату',
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_T00_STATS[NSIFUNCTION][PROC=>PUL.PUT(''ZDAT'', to_char ( :D , ''dd.mm.yyyy'' ) )][PAR=>:D(SEM=Звітна_дата,TYPE=D)][EXEC=>BEFORE]',
                    p_frontend  =>      1 );                       -- 1 - web интерфейс, 0 - desctop
	umu.add_func2arm(l_codeoper, '$RM_BVBB', 1);  -- АРМ Бек-офісу
        umu.add_func2arm(l_codeoper, '$RM_@VPS', 1);  -- АРМ МВПС. Управление платежами
    commit;
end;
/