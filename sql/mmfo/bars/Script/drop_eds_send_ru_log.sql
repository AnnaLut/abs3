begin
execute immediate 'drop table eds_send_ru_log';
exception when others then
if sqlcode = -00942 then null; else raise; end if;
end;
/