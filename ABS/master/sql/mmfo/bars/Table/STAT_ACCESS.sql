BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAT_ACCESS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAT_ACCESS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

prompt ... 


-- Create table
begin
    execute immediate 'create table STAT_ACCESS
(
  id         NUMBER(5) not null,
  wf_oper_id NUMBER(5) not null,
  role       NUMBER(38) not null
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
comment on table STAT_ACCESS
  is 'ƒоступ пользовател€ к операции';
-- Add comments to the columns 
comment on column STAT_ACCESS.wf_oper_id
  is 'ID workflow-операци€';
comment on column STAT_ACCESS.role
  is 'роль';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table STAT_ACCESS
  add constraint PK_STATACCESS primary key (ID)
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
    execute immediate 'alter table STAT_ACCESS
  add constraint FK_STAT_ACCESS_WFOPERID foreign key (WF_OPER_ID)
  references STAT_WORKFLOW_OPERATIONS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

