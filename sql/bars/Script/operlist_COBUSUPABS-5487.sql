declare 
    l_codeoper number;
    id_        operlist.codeoper%type;
    l_codearm  varchar2(10) := 'PRVN';
    l_name     operlist.name%type := 'INV: Інформація щодо структури заборгованості клієнта';
    l_funcname operlist.funcname%type := 'FunNSIEditFFiltered("INV_CCK[PROC=>INV_P_CCK(:A)][PAR=>:A(SEM=Зв_дата_З_01-ММ-ГГГГ,TYPE=D)][EXEC=>BEFORE]", 0,"INV_CCK.fdat=NVL(TO_DATE(pul.Get_Mas_Ini_Val(''sFdat1''),''dd-mm-yyyy''),trunc(gl.BD,''MM''))")';

begin 
    delete from operapp  where codeoper in (select codeoper from operlist  where NAME =l_name);
    delete from operlist where name = l_name;
    begin
       select codeoper into id_ from operlist  where FUNCNAME LIKE l_funcname||'%';
       update operlist set funcname = l_funcname, name = l_name  where codeoper = id_;
    exception when no_data_found then 
       id_ := OPERLISTNEXTID ;
       Insert into OPERLIST (CODEOPER, NAME, DLGNAME, FUNCNAME, RUNABLE, ROLENAME, FRONTEND) Values (id_, l_name,'N/A', l_funcname ,1 ,'START1', 0);
    end ;

    begin
       Insert into OPERAPP (CODEAPP, CODEOPER, APPROVE) Values (l_codearm, id_, 1 );
    exception when dup_val_on_index then  null;
    end;
    commit;
end;
/


declare 
    l_codeoper number;
    id_        operlist.codeoper%type;
    l_codearm  varchar2(10) := 'PRVN';
    l_name     operlist.name%type := 'INV: Аналіз забезпечення';
    l_funcname operlist.funcname%type := 'FunNSIEditF("INV_V_ZAL[PROC=>PUL_DAT(:A,null)][PAR=>:A(SEM=Зв_дата_З_01-ММ-ГГГГ,TYPE=S)][EXEC=>BEFORE]",1)';

begin 
    delete from  operapp where codeoper in (select codeoper from operlist  where NAME =l_name);
    delete from operlist where name = l_name;
    begin
       select codeoper into id_ from operlist  where FUNCNAME LIKE l_funcname||'%';
       update operlist set funcname = l_funcname, name = l_name  where codeoper = id_;
    exception when no_data_found then 
       id_ := OPERLISTNEXTID ;
       Insert into OPERLIST (CODEOPER, NAME, DLGNAME, FUNCNAME, RUNABLE, ROLENAME, FRONTEND) Values (id_, l_name,'N/A', l_funcname ,1 ,'START1', 0);
    end ;

    begin
       Insert into OPERAPP (CODEAPP, CODEOPER, APPROVE) Values (l_codearm, id_, 1 );
    exception when dup_val_on_index then  null;
    end;
    commit;
end;
/
