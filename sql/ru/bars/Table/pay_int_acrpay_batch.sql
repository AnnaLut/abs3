exec bpa.alter_policy_info('pay_int_acrpay_batch','FILIAL',null,null,null,null);
exec bpa.alter_policy_info('pay_int_acrpay_batch','WHOLE',null,null,null,null);
commit;

-- Create table
begin
    execute immediate 'create table pay_int_acrpay_batch
(
  batch_id    number,
  user_login  varchar2(30),
  create_date date default sysdate,
  info        varchar2(4000),
  filter      varchar2(4000)
)
tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table pay_int_acrpay_batch
  is 'Запуск виплати процентів по депозитах';

begin
    execute immediate 'alter table pay_int_acrpay_batch
  add constraint pk_pay_int_acrpay_batch primary key (BATCH_ID)';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on pay_int_acrpay_batch to BARS_ACCESS_DEFROLE;
