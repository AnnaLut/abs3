prompt ZAY_SEGM_ACC


-- Create table
begin
    execute immediate 'create table ZAY_SEGM_ACC
(
  segm NUMBER(1) not null,
  acc  NUMBER,
  kf   VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'')
)
tablespace BRSDYND';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table ZAY_SEGM_ACC
  is 'Счета доходов за бирж.операции по сегментам клиента';
-- Add comments to the columns 
comment on column ZAY_SEGM_ACC.segm
  is 'Сегмент клиента';
comment on column ZAY_SEGM_ACC.acc
  is 'Счет 6114';
comment on column ZAY_SEGM_ACC.kf
  is 'Филиал';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table ZAY_SEGM_ACC
  add constraint PK_ZAYSEGMACC primary key (KF, SEGM)
  using index 
  tablespace BRSDYND';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ZAY_SEGM_ACC
  add constraint FK_ZAYSEGMACC_ACCOUNTS foreign key (KF, ACC)
  references ACCOUNTS (KF, ACC)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table ZAY_SEGM_ACC
  add constraint CC_ZAYSEGMACC_KF_NN
  check ("KF" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update, delete on ZAY_SEGM_ACC to BARS_ACCESS_DEFROLE;
