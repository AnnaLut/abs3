
prompt Add AutoOfficialNote func to Way4BPK ARM

declare 
    l_funcid  operlist.codeoper%type;
    l_codearm  VARCHAR2(10) := '$RM_W_W4';
begin
    l_funcid:= abs_utils.add_func( p_name     => 'Way4. Заява на видалення тікету',
                                   p_funcname => '/barsroot/bpkw4/AutoOfficialNote/index',
                                   p_rolename => '',    
                                   p_frontend => 1);
    umu.add_func2arm(l_funcid, l_codearm, 1); 
end;
/
