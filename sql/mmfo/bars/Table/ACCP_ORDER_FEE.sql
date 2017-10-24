begin
  execute immediate 'begin bpa.alter_policy_info(''ACCP_ORDER_FEE'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

begin
  execute immediate 'begin bpa.alter_policy_info(''ACCP_ORDER_FEE'', ''FILIAL'', null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' create table ACCP_ORDER_FEE('||
    '     id   number(2),'||
    '     text varchar2(50) CONSTRAINT CC_ACCP_ORDERFEE_NN NOT NULL,'||
    '     constraint pk_accporderfee primary key(id) USING INDEX TABLESPACE BRSSMLI'||
    '     )'||
    ' tablespace brssmld';
exception when others then 
  if sqlcode=-955 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table ACCP_ORDER_FEE add ID NUMBER(2)';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table ACCP_ORDER_FEE add TEXT VARCHAR2(50) CONSTRAINT CC_ACCP_ORDERFEE_NN NOT NULL';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table ACCP_ORDER_FEE add constraint PK_ACCPORDERFEE primary key(ID) USING INDEX TABLESPACE BRSSMLI';
exception when others then 
  if sqlcode=-2260 or sqlcode=-2261 then null; else raise; end if;
end;
/

COMMENT ON TABLE ACCP_ORDER_FEE IS 'Порядок зняття комісійної винагороди';

COMMENT ON COLUMN ACCP_ORDER_FEE.ID IS 'ID';
COMMENT ON COLUMN ACCP_ORDER_FEE.TEXT IS 'Опис';

    
begin
  execute immediate 'begin bpa.alter_policies(''ACCP_ORDER_FEE''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

GRANT DELETE, INSERT, SELECT, UPDATE ON ACCP_ORDER_FEE TO BARS_ACCESS_DEFROLE;

