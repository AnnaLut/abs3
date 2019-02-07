BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAT_FILE_OPERATIONS_HIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAT_FILE_OPERATIONS_HIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

prompt ... 


-- Create table
begin
    execute immediate 'create table STAT_FILE_OPERATIONS_HIST
(
  id           NUMBER(38) not null,
  file_id      NUMBER(38),
  user_id      NUMBER(38),
  oper_id      NUMBER(5),
  oper_date    DATE,
  sign_id      NUMBER(38),
  user_comment VARCHAR2(4000),
  tr_id        VARCHAR2(100),
  way          NUMBER(1)
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
comment on table STAT_FILE_OPERATIONS_HIST
  is ' Операції користувачa з файлом ';
-- Add comments to the columns 
comment on column STAT_FILE_OPERATIONS_HIST.file_id
  is ' ID файла ';
comment on column STAT_FILE_OPERATIONS_HIST.user_id
  is ' ID користувача';
comment on column STAT_FILE_OPERATIONS_HIST.oper_id
  is ' ID операції ';
comment on column STAT_FILE_OPERATIONS_HIST.oper_date
  is 'Дата операції';
comment on column STAT_FILE_OPERATIONS_HIST.sign_id
  is ' ID підпису  ';
comment on column STAT_FILE_OPERATIONS_HIST.user_comment
  is 'Комментарий пользователя';
comment on column STAT_FILE_OPERATIONS_HIST.tr_id
  is 'Код транзакции';
comment on column STAT_FILE_OPERATIONS_HIST.way
  is 'when 1 then пряма when 2 then відміна when 3 then пряма(відмінена)';

-- Create/Rebegin
begin
    execute immediate '
create index I_STATFILEOPERATIONS_FILE_ID on STAT_FILE_OPERATIONS_HIST (FILE_ID)
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
    execute immediate 'alter table STAT_FILE_OPERATIONS_HIST
  add constraint PK_STATFILEOPERATIONS primary key (ID)
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
    execute immediate 'alter table STAT_FILE_OPERATIONS_HIST
  add constraint FK_STATUSEROPER_OPERATIONS foreign key (OPER_ID)
  references STAT_OPERATIONS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table STAT_FILE_OPERATIONS_HIST
  add constraint CC_STATFILEOPER_FILEID_NN
  check ("FILE_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILE_OPERATIONS_HIST
  add constraint CC_STATFILEOPER_OPERDATE_NN
  check ("OPER_DATE" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILE_OPERATIONS_HIST
  add constraint CC_STATFILEOPER_OPERID_NN
  check ("OPER_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILE_OPERATIONS_HIST
  add constraint CC_STATFILEOPER_USERID_NN
  check ("USER_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

