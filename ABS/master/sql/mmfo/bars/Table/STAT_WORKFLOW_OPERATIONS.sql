BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAT_WORKFLOW_OPERATIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAT_WORKFLOW_OPERATIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

prompt ... 


-- Create table
begin
    execute immediate 'create table STAT_WORKFLOW_OPERATIONS
(
  id       NUMBER(5) not null,
  wf_id    NUMBER(5) not null,
  oper_id  NUMBER(38) not null,
  end_oper NUMBER(1)
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
comment on table STAT_WORKFLOW_OPERATIONS
  is 'Связь операций с техпроцессом';
-- Add comments to the columns 
comment on column STAT_WORKFLOW_OPERATIONS.wf_id
  is 'ID workflow';
comment on column STAT_WORKFLOW_OPERATIONS.oper_id
  is 'ID операции';
comment on column STAT_WORKFLOW_OPERATIONS.end_oper
  is 'признак последней операции';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table STAT_WORKFLOW_OPERATIONS
  add constraint PK_WFOPERATIONS primary key (ID)
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
    execute immediate 'alter table STAT_WORKFLOW_OPERATIONS
  add constraint FK_WFOPER_OPER foreign key (OPER_ID)
  references STAT_OPERATIONS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STAT_WORKFLOW_OPERATIONS
  add constraint FK_WFOPER_WF foreign key (WF_ID)
  references STAT_WORKFLOWS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

