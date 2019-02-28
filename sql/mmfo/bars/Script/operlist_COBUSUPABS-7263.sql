declare 
    l_codeoper number;
    id_        operlist.codeoper%type;
    l_codearm  varchar2(10) := '$RM_MBDK';
    l_name     operlist.name%type := 'Перегляд/заповнення параметрiв угод КП Банки для резерву 351';
    l_funcname operlist.funcname%type := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2'||chr(38)||
                                         'sPar=NBU23_CCK_BN[NSIFUNCTION][PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),NULL)][PAR=>:A(SEM=Звiтна_дата 01.MM.ГГГГ>,TYPE=D)][EXEC=>BEFORE]';

begin 
   -- Обновление
   operlist_adm.modify_func_by_name
                   (p_name         =>  l_name,
                    p_new_funcpath =>  l_funcname,
		    p_new_name     =>  l_name );

end;
/

