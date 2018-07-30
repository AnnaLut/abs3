PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/table/msp_acc_trans_2909.sql =========*** Run
PROMPT ===================================================================================== 

begin
    execute immediate 'create table MSP_ACC_TRANS_2909
(
  acc_num VARCHAR2(20),
  kf      VARCHAR2(10),
  edrpu   VARCHAR2(10)
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

comment on table msp.msp_acc_trans_2909 is 'Довідник транзитних рахунків 2909';
comment on column msp.msp_acc_trans_2909.acc_num is 'Транзитний рахунок (nls)';
comment on column msp.msp_acc_trans_2909.kf is 'Відділення банка (mfo)';
comment on column msp.msp_acc_trans_2909.edrpu is 'Код ЄДРПОУ банка';
-- Grant/Revoke object privileges 
grant select on MSP_ACC_TRANS_2909 to BARS;
grant select on MSP_ACC_TRANS_2909 to BARSREADER_ROLE;
grant select, insert, update, delete on MSP_ACC_TRANS_2909 to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/table/msp_acc_trans_2909.sql =========*** End
PROMPT ===================================================================================== 
