exec bpa.alter_policy_info('pay_int_acrpay_log','FILIAL',null,null,null,null);
exec bpa.alter_policy_info('pay_int_acrpay_log','WHOLE',null,null,null,null);
commit;

-- Create table
begin
    execute immediate 'create table pay_int_acrpay_log
(
  batch_id    number,
  acc	      number,
  id	      number,
  nls	      varchar2(30),
  sumr	      number,
  tts	      varchar2(3),
  info        varchar2(4000)
)
tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table pay_int_acrpay_log
  is 'Лог по запуску виплат процентів по депозитах';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table PAY_INT_ACRPAY_LOG
  add constraint fk_pay_int_acrpay_batch_id foreign key (BATCH_ID)
  references pay_int_acrpay_batch (BATCH_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index I1_PAY_INT_ACRPAY_LOG on PAY_INT_ACRPAY_LOG (BATCH_ID)
  tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 
-- Grant/Revoke object privileges 
grant select on pay_int_acrpay_log to BARS_ACCESS_DEFROLE;
