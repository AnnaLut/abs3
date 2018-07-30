begin
    execute immediate 'create table MSP_ENVELOPE_FILES_INFO
(
  id       NUMBER(38) not null,
  id_msp   NUMBER(38),
  filename VARCHAR2(50),
  filedate TIMESTAMP(6),
  state    NUMBER(2),
  comm     VARCHAR2(1000),
  filepath VARCHAR2(50),
  id_file  NUMBER(38) not null
)
tablespace BRSBIGD
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
comment on table MSP_ENVELOPE_FILES_INFO
  is 'Содержимое пакета';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table MSP_ENVELOPE_FILES_INFO
  add constraint PK_MSP_ENVELOPE_FILES_INFO primary key (ID, ID_FILE)
  using index 
  tablespace USERS
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


begin
    execute immediate 'alter table MSP_ENVELOPE_FILES_INFO
  add constraint UK_MSP_ENVELOPE_FILES_INFO unique (ID_MSP)
  using index 
  tablespace USERS
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
    if sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table MSP_ENVELOPE_FILES_INFO
  add constraint FK_MSP_ENVELOPE_FILES_INFO foreign key (ID)
  references MSP_REQUESTS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table MSP_ENVELOPE_FILES_INFO
  add constraint FK_MSP_ENV_FILE_INFO_STATE foreign key (STATE)
  references MSP_FILE_STATE (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index I_MSP_ENV_FILE_INFO_ID on MSP_ENVELOPE_FILES_INFO (ID)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/

begin 
  execute immediate 'alter table msp_envelope_files_info modify filename varchar2(256)';
exception when others then 
  if sqlcode in (-904, -6512, -1430) then 
    null; 
  else 
    raise; 
  end if;
end;
/

begin 
  execute immediate 'alter table msp_envelope_files_info add payment_type varchar2(2)';
exception when others then 
  if sqlcode in (-904, -6512, -1430) then 
    null; 
  else 
    raise; 
  end if;
end;
/

begin 
  execute immediate 'alter table msp_envelope_files_info drop column payment_type';
exception when others then 
  if sqlcode in (-904, -6512, -1430) then 
    null; 
  else 
    raise; 
  end if;
end;
/
  
PROMPT *** Create comment on table msp_envelope_files_info ***
comment on table msp_envelope_files_info is 'Інформаційні записи до файлів конвертів';
comment on column msp_envelope_files_info.id is 'id конверту';
comment on column msp_envelope_files_info.id_msp is 'id_msp';
comment on column msp_envelope_files_info.filename is 'Назва файлу конверта ІОЦ';
comment on column msp_envelope_files_info.filedate is 'Дата файлу ІОЦ';
comment on column msp_envelope_files_info.state is 'Стан файлу';
comment on column msp_envelope_files_info.comm is 'Коментар';
comment on column msp_envelope_files_info.filepath is 'Назва файлу в архіві';
comment on column msp_envelope_files_info.id_file is 'id файлу реєстра';


-- Grant/Revoke object privileges 
grant select on MSP_ENVELOPE_FILES_INFO to BARS_ACCESS_DEFROLE;
