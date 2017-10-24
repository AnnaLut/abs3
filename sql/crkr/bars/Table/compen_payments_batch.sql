exec bpa.alter_policy_info('COMPEN_PAYMENTS_BATCH', 'filial', null, null, null, null);
exec bpa.alter_policy_info('COMPEN_PAYMENTS_BATCH', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table COMPEN_PAYMENTS_BATCH
(
  compen_payment_id NUMBER,
  batch_id          NUMBER
)
tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_PAYMENTS_BATCH
  is '"Пачка" відправлених виплат';
-- Add comments to the columns 
comment on column COMPEN_PAYMENTS_BATCH.compen_payment_id
  is 'id виплати';
comment on column COMPEN_PAYMENTS_BATCH.batch_id
  is 'пачка';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_PAYMENTS_BATCH
  add constraint FK_BATCH_ID foreign key (BATCH_ID)
  references COMPEN_BATCH (BATCH_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PAYMENTS_BATCH
  add constraint FK_COMPEN_REG_ID foreign key (COMPEN_PAYMENT_ID)
  references COMPEN_PAYMENTS_REGISTRY (REG_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_PAYMENTS_BATCH
  drop constraint FK_COMPEN_REG_ID';
 exception when others then 
    if sqlcode = -2443 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_PAYMENTS_BATCH
  add constraint FK_COMPEN_REG_ID foreign key (COMPEN_PAYMENT_ID)
  references COMPEN_PAYMENTS_REGISTRY (REG_ID) on delete cascade';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update, delete on COMPEN_PAYMENTS_BATCH to BARS_ACCESS_DEFROLE;
