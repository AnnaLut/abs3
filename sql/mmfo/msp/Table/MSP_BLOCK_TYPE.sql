PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/table/msp_block_type.sql =========*** Run
PROMPT ===================================================================================== 

begin
    execute immediate 'create table MSP_BLOCK_TYPE
(
  id   NUMBER(2),
  name VARCHAR2(500)
)
tablespace BRSSMLD
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
comment on table MSP_BLOCK_TYPE
  is 'Типы блокировок пнесионеров';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table MSP_BLOCK_TYPE
  add constraint PK_MSP_BLOCK_TYPE primary key (ID)
  using index 
  tablespace BRSSMLI
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


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table MSP_BLOCK_TYPE
  add constraint MSP_BLOCK_TYPE_ID_NN
  check ("ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

comment on table msp.msp_block_type is 'Типи блокувань особи';
comment on column msp.msp_block_type.id is 'id типу блокування';
comment on column msp.msp_block_type.name is 'Назва типу блокування';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/table/msp_block_type.sql =========*** End
PROMPT ===================================================================================== 
