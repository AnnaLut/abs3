PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/table/msp_acc_rest.sql =========*** Run
PROMPT ===================================================================================== 

begin
    execute immediate 'create table MSP_ACC_REST
(
  acc      VARCHAR2(20),
  rest     NUMBER(38,2),
  restdate DATE,
  fileid   NUMBER(10)
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

comment on table msp.msp_acc_rest is 'Залишок на рахунку 2560 в РУ';
comment on column msp.msp_acc_rest.acc is 'Рахунок 2560';
comment on column msp.msp_acc_rest.rest is 'Остаток';
comment on column msp.msp_acc_rest.restdate is 'Дата остатка';
comment on column msp.msp_acc_rest.fileid is 'Связь с реестром';
-- Grant/Revoke object privileges 
grant select on MSP_ACC_REST to BARSREADER_ROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/table/msp_acc_rest.sql =========*** End
PROMPT ===================================================================================== 
