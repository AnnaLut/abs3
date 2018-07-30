PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/table/msp_file_state.sql =========*** Run
PROMPT ===================================================================================== 

begin
    execute immediate 'create table MSP_FILE_STATE
(
  id    NUMBER(2),
  name  VARCHAR2(4000),
  state VARCHAR2(30 CHAR)
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
comment on table msp_file_state is 'Стани файла';
comment on column msp.msp_file_state.id is 'id стану файла';
comment on column msp.msp_file_state.name is 'Назва стану';
comment on column msp.msp_file_state.state is 'Ідентифікатор стану';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table MSP_FILE_STATE
  add constraint PK_MSP_FILE_STATE primary key (ID)
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


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table MSP_FILE_STATE
  add constraint CC_MSP_FILE_STATE_ID_NN
  check ("ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/table/msp_file_state.sql =========*** End
PROMPT ===================================================================================== 
