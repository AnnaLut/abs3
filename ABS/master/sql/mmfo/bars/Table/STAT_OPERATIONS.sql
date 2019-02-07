BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAT_OPERATIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAT_OPERATIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

prompt ... 


-- Create table
begin
    execute immediate 'create table STAT_OPERATIONS
(
  id           NUMBER(5) not null,
  name         VARCHAR2(64),
  begin_status NUMBER,
  end_status   NUMBER,
  need_sign    VARCHAR2(1) default ''N''
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
comment on table STAT_OPERATIONS
  is ' Перелік операцій над файлами ';
-- Add comments to the columns 
comment on column STAT_OPERATIONS.id
  is ' ID операції ';
comment on column STAT_OPERATIONS.name
  is ' Найменування операції ';
comment on column STAT_OPERATIONS.begin_status
  is ' Статус файлу для початку операції ';
comment on column STAT_OPERATIONS.end_status
  is ' Статус файлу після закінченого операції ';
comment on column STAT_OPERATIONS.need_sign
  is 'Ознака необхідності ЕЦП (Y/N/H)? H-підпис не на файл, а на хеш';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table STAT_OPERATIONS
  add constraint PK_STATOPERATIONS primary key (ID)
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
    execute immediate 'alter table STAT_OPERATIONS
  add constraint FK_STATOPER_BEGINSTATUS foreign key (BEGIN_STATUS)
  references STAT_FILE_STATUSES (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_OPERATIONS
  add constraint FK_STATOPER_ENDSTATUS foreign key (END_STATUS)
  references STAT_FILE_STATUSES (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table STAT_OPERATIONS
  add constraint CC_STATOPER_NEEDSIGN_YN
  check (need_sign in (''Y'',''N'',''H''))';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_OPERATIONS
  add constraint CC_STATOPER_OPERNAME_NN
  check ("NAME" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

