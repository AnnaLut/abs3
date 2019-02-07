BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAT_FILE_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAT_FILE_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

prompt ... 


-- Create table
begin
    execute immediate 'create table STAT_FILE_TYPES
(
  id     NUMBER(5) not null,
  name   VARCHAR2(400),
  wf_id  NUMBER(5),
  ext_id VARCHAR2(5) not null,
  code   VARCHAR2(3) not null
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


-- Add/modify columns 
begin
    execute immediate 'alter table STAT_FILE_TYPES modify name VARCHAR2(400)';
 exception when others then 
   null;
end;
/ 

-- Add comments to the table 
comment on table STAT_FILE_TYPES
  is ' Типи файлів ';
-- Add comments to the columns 
comment on column STAT_FILE_TYPES.id
  is ' ID типу ';
comment on column STAT_FILE_TYPES.name
  is ' Найменування типу ';
comment on column STAT_FILE_TYPES.wf_id
  is ' ID workflow ';
comment on column STAT_FILE_TYPES.ext_id
  is ' ID розширення файла для preview ';
comment on column STAT_FILE_TYPES.code
  is 'Код файлу';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table STAT_FILE_TYPES
  add constraint PK_FK_FILETYPES primary key (ID)
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
    execute immediate 'alter table STAT_FILE_TYPES
  add constraint UK_FK_FILETYPES unique (CODE)
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
    if sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILE_TYPES
  add constraint FK_STATFILETYPES_FILEEXTS foreign key (EXT_ID)
  references STAT_FILE_EXTENSIONS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILE_TYPES
  add constraint FK_STATFILETYPES_WORKFLOW foreign key (WF_ID)
  references STAT_WORKFLOWS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table STAT_FILE_TYPES
  add constraint CC_STATFILETYPES_TYPENAME_NN
  check ("NAME" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILE_TYPES
  add constraint CC_STATFILETYPES_WFID_NN
  check ("WF_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

