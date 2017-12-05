begin
   execute immediate 'alter table specparam_int drop constraint FK_ACCOUNTS_SPECPARAMINT_OB22';
exception when others then
  if sqlcode=-2443 then
  end if;
end;
/