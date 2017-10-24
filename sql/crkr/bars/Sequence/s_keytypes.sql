prompt
prompt Creating sequence S_KEYTYPES
prompt ============================
prompt
begin
  execute immediate 'create sequence S_KEYTYPES
minvalue 1
maxvalue 9999999999999999999999999999
start with 4
increment by 1
cache 20';
exception
  when others then
    if sqlcode = -955 then
      null;
    else
      raise;
    end if;
end;
/
