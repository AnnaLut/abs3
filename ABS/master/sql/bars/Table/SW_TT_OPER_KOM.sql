prompt ... 
begin 
  BPA.ALTER_POLICY_INFO( 'SW_TT_OPER_KOM', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'SW_TT_OPER_KOM', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table SW_TT_OPER_KOM
(
  kod_nbu VARCHAR2(5) not null,
  tt      CHAR(3) not null,
  ttk     CHAR(3),
  ttkm    CHAR(3)
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table SW_TT_OPER_KOM
  is 'Таблица определения комиссии по операции+системма';
-- Add comments to the columns 
comment on column SW_TT_OPER_KOM.kod_nbu
  is 'Код НБУ';
comment on column SW_TT_OPER_KOM.tt
  is 'операция БАРС';
comment on column SW_TT_OPER_KOM.ttk
  is 'операция комиссии';
comment on column SW_TT_OPER_KOM.ttkm
  is 'операция комиссии (минусуется)';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table SW_TT_OPER_KOM
  add constraint PK_SWTTOPERKOM primary key (KOD_NBU, TT)
  using index 
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

