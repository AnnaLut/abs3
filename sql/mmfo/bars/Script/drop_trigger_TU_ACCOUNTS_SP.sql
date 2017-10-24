begin 
   execute immediate ' drop trigger TU_ACCOUNTS_SP';
exception when others then
  if sqlcode = -04080 then null; end if;
end;
/ 