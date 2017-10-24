prompt
prompt Creating sequence S_OW_KEYS
prompt ===========================
prompt
begin
  execute immediate 'create sequence s_ow_keys
minvalue 1
maxvalue 999999999999999999
start with 1
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