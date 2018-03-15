prompt ... createing table ow_query_log

exec bpa.alter_policy_info('OW_QUERY_LOG', 'WHOLE',  null, null, null, null);
exec bpa.alter_policy_info('OW_QUERY_LOG', 'FILIAL', 'M', 'M', 'M', 'M');
begin
    execute immediate 'create table OW_QUERY_LOG
(
  reqid       NUMBER(38) not null,
  rnk         NUMBER(38) not null,
  nd          NUMBER(22) not null,
  requestdate DATE default sysdate not null,
  respcode    NUMBER(5),
  resptext    VARCHAR2(4000),
  reqbody     CLOB,
  err_text    VARCHAR2(4000),
  respbody    CLOB,
  kf          varchar2(6) default sys_context(''bars_context'',''user_mfo'') 
)';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 
prompt ... 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table OW_QUERY_LOG
  add constraint PK_OW_QUERY_LOG primary key (REQID)';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


-- Create/Rebegin
begin
    execute immediate 'create index I_OW_QUERY_LOG_ND on OW_QUERY_LOG (nd)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create index I_OW_QUERY_LOG_RNK on OW_QUERY_LOG (rnk)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Add/modify columns 
begin
    execute immediate 'alter table OW_QUERY_LOG add respbody clob';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table OW_QUERY_LOG add kf varchar2(6) default sys_context(''bars_context'',''user_mfo'')';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/


begin
    execute immediate 'create index I_OW_QUERY_LOG_ND on OW_QUERY_LOG (nd)
  tablespace BRSDYNI';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 



-- Add comments to the columns 
comment on column OW_QUERY_LOG.respbody
  is 'Тіло відповіді';
comment on table OW_QUERY_LOG
  is 'Журнал отправки запросов на Way4';
comment on column OW_QUERY_LOG.nd
  is 'Номер договору';
comment on column OW_QUERY_LOG.requestdate
  is 'Дата запиту';
comment on column OW_QUERY_LOG.respcode
  is 'Код відповіді';
comment on column OW_QUERY_LOG.resptext
  is 'Тест відповіді';
comment on column OW_QUERY_LOG.reqbody
  is 'Тіло запиту';
