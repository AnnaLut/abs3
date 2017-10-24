declare
   l_funcid  operlist.codeoper%type;
  begin
     begin
        l_funcid := abs_utils.add_func(
        p_name     => 'Way4. «в≥рка баланс≥в(new)',
        p_funcname => 'FunNSIEditF(''V_W4_BALANCE_TXT'', 1 | 0x0010)', 
        p_rolename => 'OW',   
        p_frontend => 0
        );
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve)
 values
   ('OWAY', l_funcid, 1);
 exception when dup_val_on_index then null;
end;

end;
/

commit;
/