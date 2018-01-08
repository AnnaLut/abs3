exec bpa.alter_policy_info('INS_W4_DEALS', 'WHOLE',  null,  null, null, null);
exec bpa.alter_policy_info('INS_W4_DEALS', 'FILIAL',  'M', 'M', 'M', 'M');
/*
begin
  execute immediate 'DROP TABLE BARS.INS_W4_DEALS CASCADE CONSTRAINTS';
exception
  when others then
    if sqlcode = -942 then
      null;
    else
      raise;
    end if;
end;
*/
begin
  execute immediate '
CREATE TABLE BARS.INS_W4_DEALS
(
  ND           NUMBER(22) PRIMARY KEY,
  STATE        VARCHAR2(100 BYTE),
  SET_DATE     DATE                             DEFAULT sysdate,
  ERR_MSG      VARCHAR2(4000 BYTE),
  REQUEST      CLOB,
  RESPONSE     CLOB,
  INS_EXT_ID   NUMBER,
  INS_EXT_TMP  NUMBER,
  DEAL_ID      VARCHAR2(100 BYTE),
  DATE_FROM    DATE,
  DATE_TO      DATE
)';
exception
  when others then
    if sqlcode = -00955 then
      null;
    else
      raise;
    end if;
end;
/

begin
  execute immediate 'alter table ins_w4_deals add requestxml clob';
exception
  when others then
    if sqlcode = -1430 then
      null;
    else 
      raise;
    end if;
end;
/
begin
    execute immediate 'alter table ins_w4_deals add kf varchar2(6)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'alter table ins_w4_deals modify kf varchar2(6) default sys_context(''bars_context'',''user_mfo'')';
 exception when others then 
    if sqlcode = -904 then null; else raise; 
    end if; 
end;
/ 
GRANT SELECT ON BARS.INS_W4_DEALS TO BARS_ACCESS_USER;
/