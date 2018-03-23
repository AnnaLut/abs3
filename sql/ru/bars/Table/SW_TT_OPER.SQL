prompt ... 
begin 
  BPA.ALTER_POLICY_INFO( 'SW_TT_OPER', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'SW_TT_OPER', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table SW_TT_OPER
(
  id  NUMBER not null,
  tt  CHAR(3) not null
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
comment on table SW_TT_OPER
  is 'Таблица соответствия операции с БАРС операции с ЕО и ШК';
-- Add comments to the columns 
comment on column SW_TT_OPER.id
  is 'ссылка на операцию ЕО и ШК';
comment on column SW_TT_OPER.tt
  is 'операция БАРС';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table SW_TT_OPER
  add constraint PK_SWTTOPER primary key (ID, TT)
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


begin
    execute immediate 'alter table SW_TT_OPER
  add constraint FK_PK_SWTTOPER_ID foreign key (ID)
  references SW_OPERATION (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 



