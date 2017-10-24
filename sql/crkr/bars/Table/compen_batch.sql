exec bpa.alter_policy_info('COMPEN_BATCH', 'filial', null, null, null, null);
exec bpa.alter_policy_info('COMPEN_BATCH', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table COMPEN_BATCH
(
  batch_id    NUMBER not null,
  create_date TIMESTAMP(6) default localtimestamp not null,
  state       VARCHAR2(32),
  msg         VARCHAR2(1024 CHAR)
)
tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_BATCH
  is 'Пачки';
-- Add comments to the columns 
comment on column COMPEN_BATCH.batch_id
  is 'id пачки';
comment on column COMPEN_BATCH.create_date
  is 'час створення';
comment on column COMPEN_BATCH.state
  is 'ERROR або SUCCEEDED';
comment on column COMPEN_BATCH.msg
  is 'Повідомлення в разі ERROR';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_BATCH
  add constraint PK_BATCH_ID primary key (BATCH_ID)
  using index 
  tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/
 
-- Add/modify columns 
begin
    execute immediate 'alter table COMPEN_BATCH add user_id number default sys_context(''bars_global'', ''user_id'')';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_BATCH.user_id
  is 'Користувач створивший пачку';

begin
    execute immediate 'create index IDX_COMPEN_BATCH_STATE on COMPEN_BATCH (STATE)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Grant/Revoke object privileges 
grant select, insert, update on COMPEN_BATCH to BARS_ACCESS_DEFROLE;
