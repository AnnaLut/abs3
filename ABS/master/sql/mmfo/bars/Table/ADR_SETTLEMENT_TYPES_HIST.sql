begin
  BPA.ALTER_POLICY_INFO( 'ADR_SETTLEMENT_TYPES_HIST', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'ADR_SETTLEMENT_TYPES_HIST', 'FILIAL', null, null, null, null );
end;
/


prompt ... 


-- Create table
begin
    execute immediate 'create table ADR_SETTLEMENT_TYPES_HIST
(
  id                  NUMBER(10),
  ddate               DATE,
  settlement_tp_id    NUMBER(3) not null,
  settlement_tp_nm    VARCHAR2(50) not null,
  settlement_tp_nm_ru VARCHAR2(50),
  settlement_tp_code  VARCHAR2(50),
  settlement_tp_nm_eng VARCHAR2(50 BYTE)
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

begin
    execute immediate 'alter table ADR_SETTLEMENT_TYPES_HIST
add SETTLEMENT_TP_NM_ENG  VARCHAR2(50 BYTE)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 