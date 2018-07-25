BEGIN
execute immediate 'create sequence S_OB_CORP_SESS_TRACK nocache';
exception when others then
  if sqlcode = -00955 then null; else raise; end if;
end;
/