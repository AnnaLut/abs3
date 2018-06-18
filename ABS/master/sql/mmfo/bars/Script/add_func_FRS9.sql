set define off
declare 
    l_funcid  operlist.codeoper%type;
    l_tabid   number;
    l_codearm  VARCHAR2(10) := '$RM_WDOC';
begin
    l_tabid:= get_tabid('V_FRS9');
    l_funcid:= abs_utils.add_func( p_name     => 'Рекласифікація активів',
                                   p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid='||l_tabid||'&mode=ro&force=1',
                                   p_rolename => '',    
                                   p_frontend => 1);
    umu.add_func2arm(l_funcid, l_codearm, 1); 
end;
/ 
commit;