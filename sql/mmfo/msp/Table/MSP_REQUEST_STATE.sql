PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/table/msp_request_state.sql =========*** Run
PROMPT ===================================================================================== 

begin
    execute immediate 'create table MSP_REQUEST_STATE
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
comment on table MSP_REQUEST_STATE
  is 'Статуси запитів';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table MSP_REQUEST_STATE
  add constraint PK_MSP_REQUEST_STATE primary key (ID)
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
    execute immediate 'alter table MSP_REQUEST_STATE
  add constraint CC_MSP_REQ_STATE_ID_NN
  check ("ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/

comment on table msp.msp_request_state is 'Стани запитів';
comment on column msp.msp_request_state.id is 'id стану запиту';
comment on column msp.msp_request_state.name is 'Назва стану запиту';
comment on column msp.msp_request_state.state is 'Ідентифікатор стану запиту';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/table/msp_request_state.sql =========*** End
PROMPT ===================================================================================== 
