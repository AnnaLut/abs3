exec bpa.alter_policy_info( 'OVR_ACC_ADD', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'OVR_ACC_ADD', 'FILIAL', null, null, null, null );

prompt ... 


-- Create table
begin
    execute immediate 'create table OVR_ACC_ADD
(
  acc     NUMBER not null,
  acc_add NUMBER not null
)
tablespace BRSDYND
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
comment on table OVR_ACC_ADD
  is 'Дополнительные счета для расчета ЧКО';
-- Add comments to the columns 
comment on column OVR_ACC_ADD.acc
  is 'счет 2600-участник';
comment on column OVR_ACC_ADD.acc_add
  is 'дополнительный счет';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table OVR_ACC_ADD
  add constraint PK_OVRACCADD primary key (ACC, ACC_ADD)
  using index 
  tablespace BRSDYND
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

-- Grant/Revoke object privileges 
grant select on OVR_ACC_ADD to BARS_ACCESS_DEFROLE;
grant select on OVR_ACC_ADD to START1;
