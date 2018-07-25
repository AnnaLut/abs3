begin
  BPA.ALTER_POLICY_INFO( 'ADR_STREET_TYPES_HIST', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'ADR_STREET_TYPES_HIST', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table ADR_STREET_TYPES_HIST
(
  id           NUMBER(10),
  ddate        DATE,
  str_tp_id    NUMBER(3) not null,
  str_tp_nm    VARCHAR2(12) not null,
  str_tp_nm_ru VARCHAR2(12),
  str_tp_nm_eng varchar2(50),
  str_tp_code_eng varchar2(50)
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

begin
    execute immediate 'alter table ADR_STREET_TYPES_HIST
 add STR_TP_NM_ENG varchar2(50)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_STREET_TYPES_HIST
 add STR_TP_CODE_ENG varchar2(50)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

