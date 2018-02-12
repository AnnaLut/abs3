prompt CTAS Interim finmon.TEST_OPER

create table FINMON.TEST_OPER
tablespace FMNTBS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )
PARTITION BY LIST (BRANCH_ID)
( PARTITION SP_1 VALUES ('1')
, PARTITION SP_2 VALUES ('2')
, PARTITION SP_3 VALUES ('3')
, PARTITION SP_4 VALUES ('4')
, PARTITION SP_5 VALUES ('5')
, PARTITION SP_6 VALUES ('6')
, PARTITION SP_7 VALUES ('7')
, PARTITION SP_8 VALUES ('8')
, PARTITION SP_9 VALUES ('9')
, PARTITION SP_10 VALUES ('10')
, PARTITION SP_11 VALUES ('11')
, PARTITION SP_12 VALUES ('12')
, PARTITION SP_13 VALUES ('13')
, PARTITION SP_14 VALUES ('14')
, PARTITION SP_15 VALUES ('15')
, PARTITION SP_16 VALUES ('16')
, PARTITION SP_17 VALUES ('17')
, PARTITION SP_18 VALUES ('18')
, PARTITION SP_19 VALUES ('19')
, PARTITION SP_20 VALUES ('20')
, PARTITION SP_21 VALUES ('21')
, PARTITION SP_22 VALUES ('22')
, PARTITION SP_23 VALUES ('23')
, PARTITION SP_24 VALUES ('24')
, PARTITION SP_25 VALUES ('25')
, PARTITION SP_26 VALUES ('26')
)
as select * from finmon.oper
;

prompt REDEFINITION FINMON.OPER
prompt drop FGAC
BEGIN
  SYS.DBMS_RLS.DROP_POLICY (
    object_schema    => 'FINMON'
    ,object_name     => 'OPER'
    ,policy_name     => 'GET_FM_POLICIES');
exception when others then
  if sqlcode = -28102 then null; else raise; end if;
END;
/

alter session force parallel dml parallel 4;
alter session force parallel query parallel 4;
prompt start redefinition
BEGIN
  DBMS_REDEFINITION.START_REDEF_TABLE('FINMON','OPER','TEST_OPER');
END;
/
prompt copy deps
DECLARE
  num_errors PLS_INTEGER;
BEGIN
  DBMS_REDEFINITION.COPY_TABLE_DEPENDENTS ('FINMON',  'OPER', 'TEST_OPER',
    DBMS_REDEFINITION.CONS_ORIG_PARAMS, TRUE, TRUE, TRUE, TRUE, num_errors);
END;
/

prompt Sync...
BEGIN
  DBMS_REDEFINITION.SYNC_INTERIM_TABLE ('FINMON', 'OPER', 'TEST_OPER');
END;
/
prompt Finish redefinition
BEGIN
  DBMS_REDEFINITION.FINISH_REDEF_TABLE ('FINMON', 'OPER', 'TEST_OPER');
END;
/
prompt drop interim table
drop table FINMON.test_oper cascade constraints purge;

BEGIN
  SYS.DBMS_RLS.ADD_POLICY     (
    object_schema          => 'FINMON'
    ,object_name           => 'OPER'
    ,policy_name           => 'GET_FM_POLICIES'
    ,function_schema       => 'FINMON'
    ,policy_function       => 'FM_POLICIES.GET_FM_POLICIES'
    ,statement_types       => 'SELECT'
    ,policy_type           => dbms_rls.dynamic
    ,long_predicate        => FALSE
    ,update_check          => FALSE
    ,static_policy         => FALSE
    ,enable                => TRUE );
exception when others then
  if sqlcode = -28101 then null; else raise; end if;
END;
/

prompt create index finmon.I_OPER_FILE_ID
begin
    execute immediate '
    create index FINMON.I_OPER_FILE_ID on finmon.oper (branch_id, file_id)
    tablespace BRSBIGI
    compute statistics';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt set default values
alter table finmon.oper modify KL_DATE default null;
alter table finmon.oper modify OPR_VID2 default '0000';
alter table finmon.oper modify DROPPED default 0;
alter table finmon.oper modify KL_DATE_BRANCH_ID default trunc(sysdate);