exec bpa.alter_policy_info('COMPEN_REGISTRY_QUEUE', 'filial',  'M', 'M', 'M', 'M');
exec bpa.alter_policy_info('COMPEN_REGISTRY_QUEUE', 'whole',  null,  'E', 'E', 'E');

-- Create table
begin
    execute immediate 'create table COMPEN_REGISTRY_QUEUE
(
  ref_oper      NUMBER,
  reg_id        NUMBER,
  last_date_req DATE,
  msg           VARCHAR2(4000)
)
tablespace BRSMDLD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_REGISTRY_QUEUE
  is 'Черга для перевірки сформованих виплат';
-- Add comments to the columns 
comment on column COMPEN_REGISTRY_QUEUE.ref_oper
  is 'Внутрішній номер операціїї (АБС)';
comment on column COMPEN_REGISTRY_QUEUE.reg_id
  is 'Ідентифікатор виплати';
comment on column COMPEN_REGISTRY_QUEUE.last_date_req
  is 'Час останнього запиту';
comment on column COMPEN_REGISTRY_QUEUE.msg
  is 'Інформація';

-- Create/Rebegin
begin
  -- Drop indexes 
  execute immediate 'drop index I_COMPEN_QUEUE_REF_OPER';
 exception when others then 
    if sqlcode = -1418 then null; else raise; 
    end if;   
end;
/
  
begin
    execute immediate 'create unique index I_COMPEN_QUEUE_REG_ID on COMPEN_REGISTRY_QUEUE (REG_ID)
  tablespace BRSMDLI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_REGISTRY_QUEUE
  add constraint FK_COMPEN_REGISTRY_QUEUE_REG foreign key (REG_ID)
  references COMPEN_PAYMENTS_REGISTRY (REG_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 
