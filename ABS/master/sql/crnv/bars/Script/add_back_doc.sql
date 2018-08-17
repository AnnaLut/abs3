set define off
declare 
    l_funcid  operlist.codeoper%type;
    l_codearm  VARCHAR2(10) := 'WIME';
begin
    l_funcid:= abs_utils.add_func( p_name     => 'Виконання сторнування неоплачених документів',
                                   p_funcname => '/barsroot/docinput/back_doc.aspx',
                                   p_rolename => '',    
                                   p_frontend => 1);
   
  begin 
    insert into operapp(codeapp,codeoper,approve,grantor) values (l_codearm,l_funcid,1,1);
  exception when dup_val_on_index then
    null;
  end;   
end;
/ 
commit;