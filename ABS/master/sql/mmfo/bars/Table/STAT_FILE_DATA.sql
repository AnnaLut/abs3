BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAT_FILE_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAT_FILE_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

prompt ... 


-- Create table
begin
    execute immediate 'create table STAT_FILE_DATA
(
  storage_id NUMBER(38) not null,
  file_id    NUMBER(38),
  file_data  BLOB
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


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table STAT_FILE_DATA
  add constraint P_STORAGE_ID primary key (STORAGE_ID)
  using index 
  tablespace BRSDYND
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
    execute immediate 'alter table STAT_FILE_DATA
  add constraint F_STORAGE_ID foreign key (STORAGE_ID)
  references STAT_FILE_STORAGE (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table STAT_FILE_DATA
  add constraint CC_EAFILEDATA_FILEID_NN
  check ("FILE_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

