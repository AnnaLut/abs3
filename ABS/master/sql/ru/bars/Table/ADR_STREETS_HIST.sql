begin
  BPA.ALTER_POLICY_INFO( 'ADR_STREETS_HIST', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'ADR_STREETS_HIST', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table ADR_STREETS_HIST
(
  id             NUMBER(10),
  ddate          DATE,
  street_id      NUMBER(10) not null,
  street_name    VARCHAR2(50) not null,
  street_name_ru VARCHAR2(50),
  street_type    NUMBER(3) not null,
  settlement_id  NUMBER(10) not null,
  eff_dt         DATE not null,
  end_dt         DATE
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
    pctincrease 0
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

