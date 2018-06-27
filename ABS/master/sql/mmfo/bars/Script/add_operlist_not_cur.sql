--------------------------------------------
-- Добавить функцию в АРМ
--------------------------------------------
declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_CHIF';
begin   
    -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'Перелік відділень по яким не встановлено курс на дату',          -- Наименование функции
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_NOT_EXISTS_BRANCH_CUR'||chr(38)||'accessCode=1'||chr(38)||'sPar=[PROC=>PUL_DAT(to_char(:Par0,''dd/mm/yyyy''),null)][PAR=>:Par0(SEM=На дату,TYPE=D)][EXEC=>BEFORE]', 
                    p_frontend  =>      1 );                       -- 1 - web интерфейс, 0 - desctop
 
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - подтвержденный/неподтвержденный ресурс)
    commit;
end;
/