begin
  execute immediate 'begin bpa.alter_policy_info(''accp_fee_types'', ''whole'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

begin
  execute immediate 'begin bpa.alter_policy_info(''accp_fee_types'', ''filial'', null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' create table accp_fee_types'||
    ' ('||
    '    fee_type_id   number(1),'||
    '    fee_type_desc varchar2(500)'||
    ' ) tablespace brssmld';
exception when others then 
  if sqlcode=-955 then null; else raise; end if;
end;
/


begin
    execute immediate 'alter table accp_fee_types add (  constraint pk_accpfeetypes  primary key  (fee_type_id)  using index tablespace brssmli)';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

COMMENT ON TABLE accp_fee_types IS 'Справочник типов комиссии';
    

begin
  execute immediate 'begin bpa.alter_policies(''ACCP_FEE_TYPES''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

GRANT DELETE, INSERT, SELECT, UPDATE ON ACCP_FEE_TYPES TO BARS_ACCESS_DEFROLE;

grant select on accp_fee_types to bars_access_defrole;
