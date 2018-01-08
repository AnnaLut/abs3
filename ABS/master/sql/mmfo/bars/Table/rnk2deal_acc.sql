
prompt ... 
exec bpa.alter_policy_info('RNK2DEAL_ACC', 'WHOLE',  null,  null, null, null);
exec bpa.alter_policy_info('RNK2DEAL_ACC', 'FILIAL',  null,  null, null, null);


-- Create table
begin
    execute immediate 'create table RNK2DEAL_ACC
(
  rnkfrom   NUMBER,
  rnkto     NUMBER,
  sdate     DATE,
  deal_from NUMBER(10) not null,
  deal_to   NUMBER(10) not null,
  acc       NUMBER(38) not null,
  id        INTEGER,
  kf        VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'')
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 





