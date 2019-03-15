
declare 
    l_codeoper number;
begin   
    -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'Перегляд протоколу вертушки СДО(CORP2)',          -- Наименование функции
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_NET_TOSS_LOG[CONDITIONS=>(V_NET_TOSS_LOG.phase=''CORP2'')]',      -- Строка вызова функции
                    p_frontend  =>      1 );                       -- 1 - web интерфейс, 0 - desctop
 
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, '$RM_BVBB', 1 );                 --(1/0 - подтвержденный/неподтвержденный ресурс)
	umu.add_func2arm(l_codeoper, '$RM_VIZA', 1 );                 --(1/0 - подтвержденный/неподтвержденный ресурс)
    commit;
	
	
	-- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'Перегляд протоколу вертушки СДО(CorpLight)',          -- Наименование функции
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_NET_TOSS_LOG[CONDITIONS=>(V_NET_TOSS_LOG.phase=''CL'')]',      -- Строка вызова функции
                    p_frontend  =>      1 );                       -- 1 - web интерфейс, 0 - desctop
 
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, '$RM_BVBB', 1 );                 --(1/0 - подтвержденный/неподтвержденный ресурс)
	umu.add_func2arm(l_codeoper, '$RM_VIZA', 1 );                 --(1/0 - подтвержденный/неподтвержденный ресурс)
    commit;
	
	
end;
/

