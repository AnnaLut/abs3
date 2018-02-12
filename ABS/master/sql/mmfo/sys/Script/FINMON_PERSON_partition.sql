prompt Секционирование таблицы finmon.person

prompt create interim table
create table FINMON.TEST_PERSON
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
( PARTITION BRANCH_ID_1 VALUES ('1')
, PARTITION BRANCH_ID_2 VALUES ('2')
, PARTITION BRANCH_ID_3 VALUES ('3')
, PARTITION BRANCH_ID_4 VALUES ('4')
, PARTITION BRANCH_ID_5 VALUES ('5')
, PARTITION BRANCH_ID_6 VALUES ('6')
, PARTITION BRANCH_ID_7 VALUES ('7')
, PARTITION BRANCH_ID_8 VALUES ('8')
, PARTITION BRANCH_ID_9 VALUES ('9')
, PARTITION BRANCH_ID_10 VALUES ('10')
, PARTITION BRANCH_ID_11 VALUES ('11')
, PARTITION BRANCH_ID_12 VALUES ('12')
, PARTITION BRANCH_ID_13 VALUES ('13')
, PARTITION BRANCH_ID_14 VALUES ('14')
, PARTITION BRANCH_ID_15 VALUES ('15')
, PARTITION BRANCH_ID_16 VALUES ('16')
, PARTITION BRANCH_ID_17 VALUES ('17')
, PARTITION BRANCH_ID_18 VALUES ('18')
, PARTITION BRANCH_ID_19 VALUES ('19')
, PARTITION BRANCH_ID_20 VALUES ('20')
, PARTITION BRANCH_ID_21 VALUES ('21')
, PARTITION BRANCH_ID_22 VALUES ('22')
, PARTITION BRANCH_ID_23 VALUES ('23')
, PARTITION BRANCH_ID_24 VALUES ('24')
, PARTITION BRANCH_ID_25 VALUES ('25')
, PARTITION BRANCH_ID_26 VALUES ('26')
)
as select * from finmon.person
;

prompt redefinition
prompt drop fgac
BEGIN
  SYS.DBMS_RLS.DROP_POLICY (
    object_schema    => 'FINMON'
    ,object_name     => 'PERSON'
    ,policy_name     => 'GET_FM_POLICIES');
exception when others then
  if sqlcode = -28102 then null; else raise; end if;
END;
/

alter session force parallel dml parallel 4;
alter session force parallel query parallel 4;
prompt start redef
BEGIN
  DBMS_REDEFINITION.START_REDEF_TABLE('FINMON','PERSON','TEST_PERSON');
END;
/
prompt copy deps
DECLARE
  num_errors PLS_INTEGER;
BEGIN
  DBMS_REDEFINITION.COPY_TABLE_DEPENDENTS ('FINMON',  'PERSON', 'TEST_PERSON',
    DBMS_REDEFINITION.CONS_ORIG_PARAMS, TRUE, TRUE, TRUE, TRUE, num_errors);
END;
/

prompt sync
BEGIN
  DBMS_REDEFINITION.SYNC_INTERIM_TABLE ('FINMON', 'PERSON', 'TEST_PERSON');
END;
/
prompt finish redef
BEGIN
  DBMS_REDEFINITION.FINISH_REDEF_TABLE ('FINMON', 'PERSON', 'TEST_PERSON');
END;
/
prompt drop interim table
drop table FINMON.test_person cascade constraints purge;
prompt return fgac
BEGIN
  SYS.DBMS_RLS.ADD_POLICY     (
    object_schema          => 'FINMON'
    ,object_name           => 'PERSON'
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