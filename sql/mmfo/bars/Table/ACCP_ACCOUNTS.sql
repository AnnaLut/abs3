begin
  execute immediate 'begin bpa.alter_policy_info(''ACCP_ACCOUNTS'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

begin
  execute immediate 'begin bpa.alter_policy_info(''ACCP_ACCOUNTS'', ''FILIAL'', null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' CREATE TABLE ACCP_ACCOUNTS'||
    ' ('||
    '    okpo         VARCHAR2 (10) CONSTRAINT CC_ACCPACC_OKPO_NN NOT NULL,'||
    '    mfo          VARCHAR2(6) CONSTRAINT CC_ACCPACC_MFO_NN NOT NULL,'||
    '    nls          VARCHAR2(14) CONSTRAINT CC_ACCPACC_NLS_NN NOT NULL,   '||
    '    check_on     NUMBER(2) DEFAULT 1'||
    ' )'||
    ' TABLESPACE brssmld';
exception when others then 
  if sqlcode=-955 then null; else raise; end if;
end;
/


begin 
  execute immediate 
    ' alter table ACCP_ACCOUNTS add constraint PK_ACCPACCOUNTS primary key (mfo,nls) USING INDEX TABLESPACE BRSSMLI';
exception when others then 
  if sqlcode=-2260 or sqlcode=-2261 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table ACCP_ACCOUNTS add constraint FK_ACCPACCOUNTS_OKPO foreign key (okpo) references ACCP_ORGS (okpo)';
exception when others then 
  if sqlcode=-2275 then null; else raise; end if;
end;
/





begin 
  execute immediate 
    ' alter table  ACCP_ACCOUNTS add okpo VARCHAR2 (10) CONSTRAINT CC_ACCPACC_OKPO_NN NOT NULL';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table  ACCP_ACCOUNTS add mfo VARCHAR2(6) CONSTRAINT CC_ACCPACC_MFO_NN NOT NULL';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table  ACCP_ACCOUNTS add nls VARCHAR2(14) CONSTRAINT CC_ACCPACC_NLS_NN NOT NULL';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table  ACCP_ACCOUNTS add check_on NUMBER(2) DEFAULT 1';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/




COMMENT ON TABLE ACCP_ACCOUNTS IS 'довідник рахунків організацій';

COMMENT ON COLUMN ACCP_ACCOUNTS.okpo IS 'Код ЄДРПОУ організації';
COMMENT ON COLUMN ACCP_ACCOUNTS.mfo IS 'Код банку організації ';
COMMENT ON COLUMN ACCP_ACCOUNTS.nls IS 'Розрахунковий рахунок організації';
    
begin
  execute immediate 'begin bpa.alter_policies(''ACCP_ACCOUNTS''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

GRANT DELETE, INSERT, SELECT, UPDATE ON ACCP_ACCOUNTS TO BARS_ACCESS_DEFROLE;
