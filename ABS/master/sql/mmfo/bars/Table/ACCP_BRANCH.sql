begin
  execute immediate 'begin bpa.alter_policy_info(''ACCP_BRANCH'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

begin
  execute immediate 'begin bpa.alter_policy_info(''ACCP_BRANCH'', ''FILIAL'', null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' create table ACCP_BRANCH'||
    ' ('||
    '     branch  varchar2(30) CONSTRAINT CC_ACCPBRANCH_BRANCH_NN NOT NULL,'||
    '     obl     number(2) CONSTRAINT CC_ACCPBRANCH_OBL_NN NOT NULL'||
    '     )'||
    ' tablespace brssmld';
exception when others then 
  if sqlcode=-955 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table ACCP_BRANCH add BRANCH VARCHAR2(30) CONSTRAINT CC_ACCPBRANCH_BRANCH_NN NOT NULL';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table ACCP_BRANCH add OBL NUMBER(2) CONSTRAINT CC_ACCPBRANCH_OBL_NN NOT NULL';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table ACCP_BRANCH add constraint pk_accpbranch primary key(branch) USING INDEX TABLESPACE BRSSMLI';
exception when others then 
  if sqlcode=-2260 or sqlcode=-2261 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table ACCP_BRANCH add constraint fk_accpbranch_obl FOREIGN KEY (obl) REFERENCES accp_scope (id)';
exception when others then 
  if sqlcode=-2275 then null; else raise; end if;
end;
/




COMMENT ON TABLE ACCP_BRANCH IS 'Довідник ТВБВ';

COMMENT ON COLUMN ACCP_BRANCH.branch IS 'ID';
COMMENT ON COLUMN ACCP_BRANCH.obl IS 'Приналежність ТВБВ, 1-Київ, 2-область';
    
begin
  execute immediate 'begin bpa.alter_policies(''ACCP_BRANCH''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

GRANT DELETE, INSERT, SELECT, UPDATE ON ACCP_BRANCH TO BARS_ACCESS_DEFROLE;
