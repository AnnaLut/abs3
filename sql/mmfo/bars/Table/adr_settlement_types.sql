-- ======================================================================================
-- Module : ADR
-- Author : BAA
-- Date   : 22.01.2016
-- ======================================================================================
-- create table ADR_SETTLEMENT_TYPES
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create Table ADR_SETTLEMENT_TYPES
prompt -- ======================================================

SET FEEDBACK     OFF

begin
  BPA.ALTER_POLICY_INFO( 'ADR_SETTLEMENT_TYPES', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'ADR_SETTLEMENT_TYPES', 'FILIAL', null, null, null, null );
end;
/
prompt ... 

  
prompt ... 


-- Create table
begin
    execute immediate 'create table ADR_SETTLEMENT_TYPES
(
  settlement_tp_id    NUMBER(3) not null,
  settlement_tp_nm    VARCHAR2(50) not null,
  settlement_tp_nm_ru VARCHAR2(50),
  settlement_tp_code  VARCHAR2(50)
)
tablespace BRSSMLD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table ADR_SETTLEMENT_TYPES
  is 'Довідник типів населених пунктів';
-- Add comments to the columns 
comment on column ADR_SETTLEMENT_TYPES.settlement_tp_id
  is 'Ідентифікатор типу населеного пункту';
comment on column ADR_SETTLEMENT_TYPES.settlement_tp_nm
  is 'Назва типу населеного пункту';
comment on column ADR_SETTLEMENT_TYPES.settlement_tp_nm_ru
  is 'Назва типу населеного пункту';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table ADR_SETTLEMENT_TYPES
  add constraint PK_SETTLEMENTTYPES primary key (SETTLEMENT_TP_ID)
  using index 
  tablespace BRSSMLI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on ADR_SETTLEMENT_TYPES to BARSUPL;
grant select on ADR_SETTLEMENT_TYPES to FINMON01;
grant select on ADR_SETTLEMENT_TYPES to START1;
grant select on ADR_SETTLEMENT_TYPES to UPLD;

