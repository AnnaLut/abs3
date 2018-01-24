declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_PRVN';
    l_name     operlist.name%type := 'INV: Інформація щодо структури заборгованості клієнта';
    l_funcname operlist.funcname%type := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||
                                         'sPar=INV_CCK[PROC=>INV_P_CCK(:A)][PAR=>:A(SEM=Зв_дата_З_01-ММ-ГГГГ,TYPE=D)][EXEC=>BEFORE]'||
                                         '[CONDITIONS=>INV_CCK.fdat=NVL(TO_DATE(pul.Get_Mas_Ini_Val(''sFdat1''),''dd-mm-yyyy''),trunc(gl.BD,''MM''))]';

begin 

    -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func (p_name  =>  l_name, p_funcname  =>  l_funcname, p_frontend  =>  1 ); 
 
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, l_codearm, 1 );     
    commit;

end;
/

declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_PRVN';
    l_name     operlist.name%type := 'INV: Аналіз забезпечення';
    l_funcname operlist.funcname%type := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||
                                         'sPar=INV_V_ZAL[PROC=>PUL_DAT(to_char( :A,''dd/mm/yyyy''),null)][PAR=>:A(SEM=Зв_дата_З_01-ММ-ГГГГ,TYPE=D)]'||
                                         '[EXEC=>BEFORE]';
begin 

    -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func (p_name  =>  l_name, p_funcname  =>  l_funcname, p_frontend  =>  1 ); 
 
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, l_codearm, 1 );     
    commit;

end;
/
