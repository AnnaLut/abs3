PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/table/msp_requests.sql =========*** Run
PROMPT ===================================================================================== 

PROMPT *** Create  table msp_requests ***

begin
    execute immediate 'create table MSP_REQUESTS
(
  id          NUMBER not null,
  req_xml     CLOB,
  state       NUMBER,
  act_type    NUMBER,
  comm        VARCHAR2(1000),
  create_date TIMESTAMP(6) default sysdate
)
tablespace USERS
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


PROMPT *** add constraint PK_MSP_REQUESTS ***

begin
    execute immediate 'alter table MSP_REQUESTS
  add constraint PK_MSP_REQUESTS primary key (ID)
  using index 
  tablespace USERS
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

PROMPT *** add comments on table/columns msp_requests ***

comment on table msp.msp_requests is 'Таблиця запитів від ІВЦ';
comment on column msp.msp_requests.id is 'id запиту';
comment on column msp.msp_requests.req_xml is 'XML запиту';
comment on column msp.msp_requests.state is 'Стан запиту (msp_request_state)';
comment on column msp.msp_requests.act_type is '1 - msp_const.req_PAYMENT_DATA - ІВЦ прислав файл (конверт), 2 - не використовується, 3 - msp_const.req_DATA_STATE - запит на стан прийнятого файлу, 4 - msp_const.req_VALIDATION_STATE - запит на результат валідації реєстру (квитанція 1), 5 - msp_const.req_PAYMENT_STATE - запит на квитанцію 2 (факт оплати реєстрів в конверті)';
comment on column msp.msp_requests.comm is 'Коментар обробки конвертів (TOSS)';
comment on column msp.msp_requests.create_date is 'Дата створення запиту';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/table/msp_requests.sql =========*** End
PROMPT ===================================================================================== 
