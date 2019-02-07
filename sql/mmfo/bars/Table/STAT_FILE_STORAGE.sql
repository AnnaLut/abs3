BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAT_FILE_STORAGE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAT_FILE_STORAGE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

prompt ... 


-- Create table
begin
    execute immediate 'create table STAT_FILE_STORAGE
(
  id          NUMBER(38) not null,
  file_id     NUMBER(38),
  file_size   NUMBER,
  file_hash   VARCHAR2(128),
  file_ver    NUMBER(5) default 1,
  upd_date    DATE,
  upd_user_id NUMBER(38)
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
comment on table STAT_FILE_STORAGE
  is ' Сховище реквізитів файлів ';
-- Add comments to the columns 
comment on column STAT_FILE_STORAGE.id
  is ' ID файлу в сховище ';
comment on column STAT_FILE_STORAGE.file_id
  is ' ID заголовка файлу';
comment on column STAT_FILE_STORAGE.file_size
  is 'Розмір файлу';
comment on column STAT_FILE_STORAGE.file_hash
  is ' Хеш файлу';
comment on column STAT_FILE_STORAGE.file_ver
  is ' Версія файлу ';
comment on column STAT_FILE_STORAGE.upd_date
  is ' Дата останньої зміни файлу';
comment on column STAT_FILE_STORAGE.upd_user_id
  is ' ID користувача , який змінив файл';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table STAT_FILE_STORAGE
  add constraint PK_STATFILESTORAGE primary key (ID)
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


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table STAT_FILE_STORAGE
  add constraint CC_STATFILESTORAGE_FILEID_NN
  check ("FILE_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILE_STORAGE
  add constraint CC_STATFILESTORAGE_FILESIZE_NN
  check ("FILE_SIZE" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILE_STORAGE
  add constraint CC_STATFILESTORAGE_HASH_NN
  check ("FILE_HASH" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILE_STORAGE
  add constraint CC_STATFILESTORAGE_UPDDATE_NN
  check ("UPD_DATE" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILE_STORAGE
  add constraint CC_STATFILESTORAGE_VER_NN
  check ("FILE_VER" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILE_STORAGE
  add constraint CC_STATFILESTOR_UPDUSERID_NN
  check ("UPD_USER_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

