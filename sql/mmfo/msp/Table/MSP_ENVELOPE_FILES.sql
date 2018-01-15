begin
    execute immediate 'create table MSP_ENVELOPE_FILES
(
  id       NUMBER(38),
  filedata CLOB
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  )
nologging';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table MSP_ENVELOPE_FILES
  is '������� ����� ����� � �������';
-- Add comments to the columns 
comment on column MSP_ENVELOPE_FILES.id
  is 'id �����';
comment on column MSP_ENVELOPE_FILES.filedata
  is '��������� ����';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table MSP_ENVELOPE_FILES
  add constraint PK_MSP_ENVELOPE_FILES primary key (ID)
  using index';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table MSP_ENVELOPE_FILES
  add constraint CC_MSP_ENV_FILE_ID_NN
  check ("ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on MSP_ENVELOPE_FILES to BARS_ACCESS_DEFROLE;
