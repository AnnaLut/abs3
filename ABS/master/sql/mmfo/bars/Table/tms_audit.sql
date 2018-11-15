PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMS_AUDIT.sql =========*** Run *** =====
PROMPT ===================================================================================== 

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMS_AUDIT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMS_AUDIT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''TMS_AUDIT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

-- Create table
begin
    execute immediate 'create table tms_audit
(
  rec_id            NUMBER(38),
  rec_uid           NUMBER(38),
  rec_uname         VARCHAR2(30) default sys_context(''userenv'', ''session_user''),
  rec_uproxy        VARCHAR2(30) default sys_context(''userenv'', ''proxy_user''),
  rec_date          DATE default sysdate,
  rec_bdate         DATE,
  rec_type          VARCHAR2(10) default ''INFO'',
  rec_module        VARCHAR2(30),
  rec_message       VARCHAR2(4000),
  machine           VARCHAR2(255) default sys_context(''userenv'', ''terminal''),  
  rec_userid        NUMBER(38) default sys_context(''userenv'', ''session_userid''),
  branch            VARCHAR2(30) default sys_context(''bars_context'',''user_branch''),  
  client_identifier VARCHAR2(64) default sys_context(''userenv'',''client_identifier''),  
  kf       			VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''),
  task_run_id 		NUMBER(38)   default sys_context (''CLIENTCONTEXT'', ''task_runid'')
)
partition by range (REC_DATE)
interval(numtodsinterval(1, ''DAY''))
(
  partition SYS_P24299 values less than (TO_DATE('' 2018-09-27 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''))
    tablespace BRSBIGD
    pctfree 10
    initrans 1
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition SYS_P24346 values less than (TO_DATE('' 2018-09-28 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''))
    tablespace BRSBIGD
    pctfree 10
    initrans 1
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    )
)';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** ALTER_POLICIES to TMS_AUDIT ***
 exec bpa.alter_policies('TMS_AUDIT');
 
 
-- Add comments to the columns 
comment on column tms_audit.rec_id is 'Ідентифікатор запису';
comment on column tms_audit.rec_uid is 'Код користувача';
comment on column tms_audit.rec_uname is 'Ім''''я користувача';
comment on column tms_audit.rec_uproxy is 'Проксі користувача';
comment on column tms_audit.rec_date is 'Дата запису';
comment on column tms_audit.rec_bdate is 'Банківська дата';
comment on column tms_audit.rec_type is 'Тип запису';
comment on column tms_audit.rec_module is 'Модуль';
comment on column tms_audit.rec_message is 'Повідомлення';
comment on column tms_audit.machine is 'ПК';
comment on column tms_audit.rec_userid is 'Ідентифікатор користувача';
comment on column tms_audit.branch is 'Філіал';
comment on column tms_audit.client_identifier is 'Ідентифікатор клієнта';
comment on column tms_audit.task_run_id is 'Ідентифікатор запуску функції (TMS_TASK_RUN.ID)';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table tms_audit
  add constraint FK_TMSAUDIT_BRANCH foreign key (BRANCH)
  references BRANCH (BRANCH)
  deferrable
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table tms_audit
  add constraint FK_TMSAUDIT_SECRECTYPE foreign key (REC_TYPE)
  references SEC_RECTYPE (SEC_RECTYPE)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table TMS_AUDIT
  add constraint FK_TMS_TASK_RUN foreign key (task_run_id)
  references TMS_TASK_RUN (ID)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'alter table tms_audit
  add constraint FK_TMSAUDIT_STAFF foreign key (REC_UID)
  references STAFF$BASE (ID)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table tms_audit
  add constraint CC_TMSAUDIT_RECDATE_NN
  check ("REC_DATE" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table tms_audit
  add constraint CC_TMSAUDIT_RECID_NN
  check ("REC_ID" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update, delete on tms_audit to ABS_ADMIN;
grant select, insert, update, delete on tms_audit to BARS_ACCESS_DEFROLE;
grant select on tms_audit to BARSREADER_ROLE;
grant select on tms_audit to BARSUPL;
grant select on tms_audit to START1;
grant select, insert, update, delete, alter, debug on tms_audit to TEST2;
grant select on tms_audit to UPLD;
grant select, insert, update, delete on tms_audit to WR_ALL_RIGHTS;
/
