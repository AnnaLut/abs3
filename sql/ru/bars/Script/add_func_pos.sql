set define off
declare
   l_funcid  operlist.codeoper%type;
   am_ char(1) := chr(38);
begin
     begin
        l_funcid := abs_utils.add_func(
        p_name     => 'Імпорт документів із POS-термінала в АБС ',
        p_funcname =>  '/barsroot/pos/pos', 
        p_rolename => NULL,   
        p_frontend => 1
        );
     end;
/*  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('WDOC', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;
*/
end;
/

commit;