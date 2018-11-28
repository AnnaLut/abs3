begin
execute immediate'drop sequence S_TRANSP_RECEIVE_DATA';
exception when others then
if sqlcode = -02289 then null; else raise; end if;
end;
/
begin
execute immediate'drop sequence S_TRANSP_RECEIVE_LOG';
exception when others then
if sqlcode = -02289 then null; else raise; end if;
end;
/
begin
execute immediate'drop sequence S_TRANSP_RECEIVE_RESP';
exception when others then
if sqlcode = -02289 then null; else raise; end if;
end;
/
begin
execute immediate'drop sequence S_TRANSP_RECEIVE_TYPE';
exception when others then
if sqlcode = -02289 then null; else raise; end if;
end;
/
begin
execute immediate'drop sequence S_TRANSP_SEND_LOG';
exception when others then
if sqlcode = -02289 then null; else raise; end if;
end;
/
begin
execute immediate'drop sequence S_TRANSP_SEND_MAIN_REQ';
exception when others then
if sqlcode = -02289 then null; else raise; end if;
end;
/
begin
execute immediate'drop sequence S_TRANSP_SEND_REQ';
exception when others then
if sqlcode = -02289 then null; else raise; end if;
end;
/
begin
execute immediate'drop sequence S_TRANSP_SEND_TYPE';
exception when others then
if sqlcode = -02289 then null; else raise; end if;
end;
/
begin
execute immediate'drop sequence S_TRANSP_URI';
exception when others then
if sqlcode = -02289 then null; else raise; end if;
end;
/