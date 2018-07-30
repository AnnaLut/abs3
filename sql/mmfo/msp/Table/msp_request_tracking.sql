PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/table/msp_request_tracking.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to msp_request_tracking ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table msp_request_tracking ***
begin
    execute immediate 'create table msp_request_tracking
(
  id          number(38) not null,
  response    clob,
  stack_trace clob,
  insert_dttm date default sysdate not null
)
tablespace BRSBIGD
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
comment on table msp_request_tracking is 'Історія відповідей на запити';
comment on column msp.msp_request_tracking.id is 'id запиту - msp_request.id';
comment on column msp.msp_request_tracking.response is 'Відповідь';
comment on column msp.msp_request_tracking.stack_trace is 'Текст помилки';
comment on column msp.msp_request_tracking.insert_dttm is 'Дата вставки зипису';
comment on column msp.msp_request_tracking.state is 'Стан відповіді (1 - помилковий, null - ОК!)';

PROMPT *** Create  constraint pk_msp_request_tracking ***
-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate '
    alter table msp_request_tracking
    add constraint pk_msp_request_tracking primary key (id)
    using index
      tablespace BRSBIGI
      pctfree 10
      initrans 2
      maxtrans 255
      storage
      (
        initial 64K
        next 1M
        minextents 1
        maxextents unlimited
      )  
  ';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** Create  constraint fk_msp_request_tracking ***
begin
    execute immediate 'alter table msp_request_tracking
  add constraint fk_msp_request_tracking foreign key (id)
  references msp_requests (id)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin 
  execute immediate 'alter table msp_request_tracking add state number(1)';
exception when others then 
  if sqlcode in (-904, -6512, -1430) then 
    null; 
  else 
    raise; 
  end if;
end;
/

comment on column msp_request_tracking.state is 'Стан відповіді (1 - помилковий, null - ОК!)';

begin
    execute immediate 'create index i_msp_request_tracking_state on msp_request_tracking (state)';
exception when others then 
  if sqlcode in (-955, -1408) then 
    null; 
  else 
    raise; 
  end if; 
end;
/ 

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/table/msp_request_tracking.sql =========*** End
PROMPT ===================================================================================== 
