begin
    execute immediate 'create table MSP_FILE_CONTENT
(
  id          NUMBER(38),
  type_id     NUMBER(2),
  file_id     NUMBER(2),
  bvalue      BLOB,
  insert_dttm DATE default sysdate
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
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table MSP_FILE_CONTENT
  is 'Сформовані дані по файлу';
-- Add comments to the columns 
comment on column MSP_FILE_CONTENT.type_id
  is 'Тип вмісту сформованих даних по файлу';
comment on column MSP_FILE_CONTENT.insert_dttm
  is 'Дата формування';

begin
-- Create/Rebegin
    execute immediate 'create index I_MSP_FILE_CONTENT_FILE_ID on MSP_FILE_CONTENT (FILE_ID)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create index I_MSP_FILE_CONTENT_TYPE_ID on MSP_FILE_CONTENT (TYPE_ID)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create unique index UK_MSP_FILE_CONTENT_TYPE_FILE on MSP_FILE_CONTENT (TYPE_ID, FILE_ID)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table MSP_FILE_CONTENT
  add constraint PK_MSP_FILE_CONTENT primary key (ID)
  using index';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table MSP_FILE_CONTENT
  add constraint FK_MSP_FILE_CONTENT_FILE_ID foreign key (FILE_ID)
  references MSP_FILES (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table MSP_FILE_CONTENT
  add constraint FK_MSP_FILE_CONTENT_TYPE_ID foreign key (TYPE_ID)
  references MSP_FILE_CONTENT_TYPE (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table MSP_FILE_CONTENT
  add constraint CC_MSP_FILE_CONTENT_FILE_ID_NN
  check ("FILE_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table MSP_FILE_CONTENT
  add constraint CC_MSP_FILE_CONTENT_ID_NN
  check ("ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table MSP_FILE_CONTENT
  add constraint CC_MSP_FILE_CONTENT_TYPEID_NN
  check ("TYPE_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on MSP_FILE_CONTENT to BARS_ACCESS_DEFROLE;
