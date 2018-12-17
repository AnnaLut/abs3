declare 
    l_codeoper number; 
begin   
    --Создаем функцию пока без добавления в АРМ
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'Перегляд документів відділення(без ВіП)',          -- Наименование функции
                    p_funcname  =>     '/barsroot/DocView/Docs/DocumentDateFilter?type=3', 
                    p_frontend  =>      1 );                       -- 1 - web интерфейс, 0 - desctop

    -- По просьбе Демкович в АРМ в ее роли
	umu.add_func2arm(l_codeoper, '$RM_BUHG', 1);  -- АРМ Головний Бухгалтер
					
					
    commit;
end;
/