begin
  BPA.ALTER_POLICY_INFO( 'ADR_PHONE_CODES_HIST', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'ADR_PHONE_CODES_HIST', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table ADR_PHONE_CODES_HIST
(
  id            NUMBER(10),
  ddate         DATE,
  phone_code_id NUMBER(10) not null,
  phone_code    VARCHAR2(10) not null,
  phone_add_num VARCHAR2(10)
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

