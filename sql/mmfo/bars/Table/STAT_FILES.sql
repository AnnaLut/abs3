BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAT_FILES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAT_FILES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

prompt ... 


-- Create table
begin
    execute immediate 'create table STAT_FILES
(
  id           NUMBER(38) not null,
  name         VARCHAR2(256),
  file_type_id NUMBER(5),
  load_user_id NUMBER(38),
  load_date    DATE,
  exec_user_id NUMBER(38),
  status       NUMBER(9),
  status_date  DATE,
  last_version NUMBER(5),
  signer_id    NUMBER(38),
  sign_date    DATE,
  kf           NUMBER(38),
  zdate        VARCHAR2(5),
  end_oper     NUMBER(1)
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


begin 
   execute immediate('alter table STAT_FILES add end_oper NUMBER(1) ');
exception when others then 
   null; 
end;
/

-- Add comments to the table 
comment on table STAT_FILES
  is ' Заголовки файлів ';
-- Add comments to the columns 
comment on column STAT_FILES.id
  is ' ID файлу';
comment on column STAT_FILES.name
  is ' Назва файлу ';
comment on column STAT_FILES.file_type_id
  is 'Тип файлу';
comment on column STAT_FILES.load_user_id
  is ' ID користувача завантажив файлу';
comment on column STAT_FILES.load_date
  is ' Дата завантаження';
comment on column STAT_FILES.exec_user_id
  is ' ID виконавця ';
comment on column STAT_FILES.status
  is ' Статус файлу';
comment on column STAT_FILES.status_date
  is 'Дата статусу';
comment on column STAT_FILES.last_version
  is ' Номер останньої версії файлу ';
comment on column STAT_FILES.signer_id
  is 'ID користувача, який наклав підпис';
comment on column STAT_FILES.sign_date
  is 'Дата накладання підпису';
comment on column STAT_FILES.kf
  is 'Код установи (МФО)';
comment on column STAT_FILES.zdate
  is 'Звітний період';
comment on column STAT_FILES.end_oper
  is 'Признак завершенности технологической линии';

-- Create/Rebegin
begin
    execute immediate 'create index I_STATFILES_FILETYPEID on STAT_FILES (FILE_TYPE_ID)
  tablespace BRSDYNI
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
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table STAT_FILES
  add constraint PK_STATFILES primary key (ID)
  using index 
  tablespace BRSDYNI
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
    execute immediate 'alter table STAT_FILES
  add constraint FK_STATFILES_FILETYPES_ID foreign key (FILE_TYPE_ID)
  references STAT_FILE_TYPES (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table STAT_FILES
  add constraint CC_STATFILES_FILENAME_NN
  check ("NAME" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILES
  add constraint CC_STATFILES_FILESTATUS_NN
  check ("STATUS" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILES
  add constraint CC_STATFILES_FILETYPE_NN
  check ("FILE_TYPE_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILES
  add constraint CC_STATFILES_LASTVER_NN
  check ("LAST_VERSION" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILES
  add constraint CC_STATFILES_LOADED_NN
  check ("LOAD_DATE" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILES
  add constraint CC_STATFILES_LOADUSERID_NN
  check ("LOAD_USER_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILES
  add constraint CC_STATFILES_STATUSDATE_NN
  check ("STATUS_DATE" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


