set define off
declare 
    l_funcid  operlist.codeoper%type;
    l_tabid   number;
    l_codearm  VARCHAR2(10) := 'PRVN';
begin
    l_tabid:= get_tabid('V_FRS9');
    l_funcid:= abs_utils.add_func( p_name     => 'Рекласифікація активів',
                                   p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid='||l_tabid||'&mode=ro&force=1',
                                   p_rolename => '',    
                                   p_frontend => 1);
	
	insert into operapp(codeapp,codeoper,hotkey,approve,adate1,adate2,rdate1,rdate2,reverse,revoked,grantor) values (l_codearm,l_funcid,null,1,null,null,null,null,null,null,1);
    
end;
/ 
commit;