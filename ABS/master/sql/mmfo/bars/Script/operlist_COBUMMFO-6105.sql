declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_RISK';
    l_name     operlist.name%type := '3.10. Протокол відхилення резерву (EXCEL)';
    l_funcname operlist.funcname%type := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||
                                         'sPar=REZ_NBU23_DELTA[PROC=>z23.P_DELTA(:A,:B)][PAR=>:A(SEM=Зв_дата_З_01-ММ-ГГГГ,TYPE=D),:B(SEM=Зв_дата_По_01-ДД-ГГГГ,TYPE=D)][EXEC=>BEFORE]';
begin 

    -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func (p_name  =>  l_name, p_funcname  =>  l_funcname, p_frontend  =>  1 ); 
 
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, l_codearm, 1 );     
    commit;

end;
/
