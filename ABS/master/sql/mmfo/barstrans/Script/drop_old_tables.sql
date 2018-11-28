begin
execute immediate'drop table TRANSP_RECEIVE_DATA';
exception when others then
if sqlcode = -00942 then null; else raise; end if;
end;
/
begin
execute immediate'drop table TRANSP_RECEIVE_LOG';
exception when others then
if sqlcode = -00942 then null; else raise; end if;
end;
/
begin
execute immediate'drop table TRANSP_RECEIVE_RESP';
exception when others then
if sqlcode = -00942 then null; else raise; end if;
end;
/
begin
execute immediate'drop table TRANSP_RECEIVE_RESP_PARAMS';
exception when others then
if sqlcode = -00942 then null; else raise; end if;
end;
/
begin
execute immediate'drop table TRANSP_RECEIVE_TYPE';
exception when others then
if sqlcode = -00942 then null; else raise; end if;
end;
/
begin
execute immediate'drop table TRANSP_RECEIVE_URI_PARAMS';
exception when others then
if sqlcode = -00942 then null; else raise; end if;
end;
/
begin
execute immediate'drop table TRANSP_SEND_LOG';
exception when others then
if sqlcode = -00942 then null; else raise; end if;
end;
/
begin
execute immediate'drop table TRANSP_SEND_MAIN_REQ';
exception when others then
if sqlcode = -00942 then null; else raise; end if;
end;
/
begin
execute immediate'drop table TRANSP_SEND_REQ';
exception when others then
if sqlcode = -00942 then null; else raise; end if;
end;
/
begin
execute immediate'drop table TRANSP_SEND_REQ_PARAMS';
exception when others then
if sqlcode = -00942 then null; else raise; end if;
end;
/
begin
execute immediate'drop table TRANSP_SEND_RESP_PARAMS';
exception when others then
if sqlcode = -00942 then null; else raise; end if;
end;
/
begin
execute immediate'drop table TRANSP_SEND_TYPE';
exception when others then
if sqlcode = -00942 then null; else raise; end if;
end;
/
begin
execute immediate'drop table TRANSP_STATUS_DICT';
exception when others then
if sqlcode = -00942 then null; else raise; end if;
end;
/
begin
execute immediate'drop table TRANSP_URI';
exception when others then
if sqlcode = -00942 then null; else raise; end if;
end;
/