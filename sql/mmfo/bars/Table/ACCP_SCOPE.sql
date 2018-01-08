/*
begin
  execute immediate 'DROP TABLE ACCP_SCOPE CASCADE CONSTRAINTS';
exception when others then
  if sqlcode = -00942 then null; else raise; end if;
end;
/
*/

begin
  execute immediate 'begin bpa.alter_policy_info(''ACCP_SCOPE'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

begin
  execute immediate 'begin bpa.alter_policy_info(''ACCP_SCOPE'', ''FILIAL'', null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    'create table ACCP_SCOPE'||
    '(	id   number(2),'||
    '	text varchar2(50) CONSTRAINT CC_ACCP_SCOPE_NN NOT NULL,'||
    '	constraint pk_accpscope primary key(id) USING INDEX TABLESPACE BRSSMLI'||
    ')'||
	'tablespace brssmld';
exception when others then 
  if sqlcode=-955 then null; else raise; end if;
end;
/

COMMENT ON TABLE ACCP_SCOPE IS 'Область дії договору';

COMMENT ON COLUMN ACCP_SCOPE.ID IS 'ID';
COMMENT ON COLUMN ACCP_SCOPE.TEXT IS 'Опис';

    
begin
  execute immediate 'begin bpa.alter_policies(''ACCP_SCOPE''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

GRANT DELETE, INSERT, SELECT, UPDATE ON ACCP_SCOPE TO BARS_ACCESS_DEFROLE;

