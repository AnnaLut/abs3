PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/table/msp_envelope_state.sql =========*** Run
PROMPT ===================================================================================== 

begin
    execute immediate 'create table MSP_ENVELOPE_STATE
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
comment on table MSP_ENVELOPE_STATE
  is 'Статуси конверта';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table MSP_ENVELOPE_STATE
  add constraint PK_MSP_ENVELOPE_STATE primary key (ID)
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
    execute immediate 'alter table MSP_ENVELOPE_STATE
  add constraint CC_MSP_ENV_STATE_ID_NN
  check ("ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/

comment on table msp.msp_envelope_state is 'Стани конвертів';
comment on column msp.msp_envelope_state.id is 'id стану конверта';
comment on column msp.msp_envelope_state.name is 'Назва стану конверта';
comment on column msp.msp_envelope_state.state is 'Ідентифікатор стану конверта';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/table/msp_envelope_state.sql =========*** End
PROMPT ===================================================================================== 
