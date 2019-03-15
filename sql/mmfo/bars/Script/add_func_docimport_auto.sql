set define off
declare 
    l_funcid  operlist.codeoper%type;
    l_tabid   number;
    l_codearm  VARCHAR2(10) := '$RM_BVBB';   --'АРМ Бек-офісу'
begin
    l_funcid:= abs_utils.add_func( p_name     => 'Документи CORP2 для автопроведення',
                                   p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2'||chr(38)||'sPar=DOC_IMPORT_AUTO[NSIFUNCTION][EDIT_MODE=>MULTI_EDIT]',
                                   p_rolename => '',    
                                   p_frontend => 1);
    umu.add_func2arm(l_funcid, l_codearm, 1); 
end;
/ 
commit;

