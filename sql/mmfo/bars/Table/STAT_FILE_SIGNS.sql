BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAT_FILE_SIGNS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAT_FILE_SIGNS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

prompt ... 


-- Create table
begin
    execute immediate 'create table STAT_FILE_SIGNS
(
  sign_id   NUMBER(38) not null,
  file_id   NUMBER(38),
  sign_date DATE,
  user_id   NUMBER(38),
  sign      CLOB,
  oper_hist NUMBER(38),
  end_oper  NUMBER(1)
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
comment on table STAT_FILE_SIGNS
  is ' Підписи на файлі ';
-- Add comments to the columns 
comment on column STAT_FILE_SIGNS.sign_id
  is ' ID підпису ';
comment on column STAT_FILE_SIGNS.file_id
  is ' ID файлу';
comment on column STAT_FILE_SIGNS.sign_date
  is ' Дата підпису ';
comment on column STAT_FILE_SIGNS.user_id
  is ' ID користувача , який підписав ';
comment on column STAT_FILE_SIGNS.sign
  is ' Підпис ';
comment on column STAT_FILE_SIGNS.oper_hist
  is 'ID історіії операцій';
comment on column STAT_FILE_SIGNS.end_oper
  is 'останній підпис';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table STAT_FILE_SIGNS
  add constraint PK_STATFILESIGNS primary key (SIGN_ID)
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
    execute immediate 'alter table STAT_FILE_SIGNS
  add constraint CC_STATFILESIGNS_FILEID_NN
  check ("FILE_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILE_SIGNS
  add constraint CC_STATFILESIGNS_SIGNDATE_NN
  check ("SIGN_DATE" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_FILE_SIGNS
  add constraint CC_STATFILESIGNS_USERID_NN
  check ("USER_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

