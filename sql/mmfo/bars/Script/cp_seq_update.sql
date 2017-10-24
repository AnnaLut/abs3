declare
  l_max number;
begin
  select max(to_number(substr(u_id,1,length(to_char(u_id))-2))) + 1 into l_max from CP_MANY_UPD;

begin
  execute immediate 'drop sequence S_CPMANYupd';
exception when others then
  if sqlcode = -2289 then null; else raise; end if;
end;

begin
  execute immediate 'create sequence S_CPMANYupd minvalue 1 maxvalue 999999999999999999999999999 start with '||l_max||' increment by 1 cache 20';
exception when others then
  if sqlcode = -00955 then null; else raise; end if;
end;

end;
/