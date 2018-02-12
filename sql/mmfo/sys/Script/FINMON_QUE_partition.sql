prompt Скрипт для секционирования таблицы bars.finmon_que

begin
    execute immediate 'drop table bars.test_finmon_que';
exception
    when others then
        if sqlcode = -942 then null; else raise; end if;
end;
/

prompt Промежуточная таблица

create table BARS.TEST_FINMON_QUE
tablespace BRSBIGD
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
PARTITION BY LIST (KF)
( PARTITION FMQ_300465 VALUES ('300465')
, PARTITION FMQ_302076 VALUES ('302076')
, PARTITION FMQ_303398 VALUES ('303398')
, PARTITION FMQ_304665 VALUES ('304665')
, PARTITION FMQ_305482 VALUES ('305482')
, PARTITION FMQ_311647 VALUES ('311647')
, PARTITION FMQ_312356 VALUES ('312356')
, PARTITION FMQ_313957 VALUES ('313957')
, PARTITION FMQ_315784 VALUES ('315784')
, PARTITION FMQ_322669 VALUES ('322669')
, PARTITION FMQ_323475 VALUES ('323475')
, PARTITION FMQ_324805 VALUES ('324805')
, PARTITION FMQ_325796 VALUES ('325796')
, PARTITION FMQ_326461 VALUES ('326461')
, PARTITION FMQ_328845 VALUES ('328845')
, PARTITION FMQ_331467 VALUES ('331467')
, PARTITION FMQ_333368 VALUES ('333368')
, PARTITION FMQ_335106 VALUES ('335106')
, PARTITION FMQ_336503 VALUES ('336503')
, PARTITION FMQ_337568 VALUES ('337568')
, PARTITION FMQ_338545 VALUES ('338545')
, PARTITION FMQ_351823 VALUES ('351823')
, PARTITION FMQ_352457 VALUES ('352457')
, PARTITION FMQ_353553 VALUES ('353553')
, PARTITION FMQ_354507 VALUES ('354507')
, PARTITION FMQ_356334 VALUES ('356334')
)
as select * from bars.finmon_que
;

prompt REDEFINITION


BEGIN
	bars.bars_login.login_user(sys_guid, 1, null, null);
	bars.bpa.remove_policies(p_table_name => 'FINMON_QUE');
END;
/

alter session force parallel dml parallel 4;
alter session force parallel query parallel 4;

prompt отключаем триггер

alter trigger BARS.tddl_crtab disable;

prompt начало redefinition

BEGIN
  DBMS_REDEFINITION.START_REDEF_TABLE('BARS','FINMON_QUE','TEST_FINMON_QUE');
END;
/

prompt копируем связи

DECLARE
  num_errors PLS_INTEGER;
BEGIN
	DBMS_REDEFINITION.COPY_TABLE_DEPENDENTS ('BARS',  'FINMON_QUE', 'TEST_FINMON_QUE',
    DBMS_REDEFINITION.CONS_ORIG_PARAMS, TRUE, TRUE, TRUE, TRUE, num_errors);
END;
/

prompt Синхронизация

BEGIN
  DBMS_REDEFINITION.SYNC_INTERIM_TABLE ('BARS', 'FINMON_QUE', 'TEST_FINMON_QUE');
END;
/

prompt конец redefinition

BEGIN
  DBMS_REDEFINITION.FINISH_REDEF_TABLE ('BARS', 'FINMON_QUE', 'TEST_FINMON_QUE');
END;
/

prompt удаляем промежуточную таблицу

drop table BARS.TEST_FINMON_QUE cascade constraints purge;

alter trigger BARS.tddl_crtab enable;

BEGIN
    execute immediate  
      'begin  
           bars.bpa.alter_policy_info(''FINMON_QUE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
           bars.bpa.alter_policy_info(''FINMON_QUE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
           bars.bpa.alter_policy_info(''FINMON_QUE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
           null;
       end; 
      '; 
exception when others then
  if sqlcode = -28101 then null; else raise; end if;
END;
/
begin
    bars.bpa.alter_policies(p_table_name => 'FINMON_QUE');
end;
/

prompt FINMON_QUE_MODIFICATION перемещаем в BRSBIGD

alter table bars.finmon_que_modification move tablespace BRSBIGD;

alter index bars.XPK_FINMON_QUE_MODIFICATION rebuild tablespace BRSBIGI;

prompt Статистика по двум таблицам

begin
    dbms_stats.gather_table_stats('BARS', 'FINMON_QUE', estimate_percent => 100, cascade => true);
    dbms_stats.gather_table_stats('BARS', 'FINMON_QUE_MODIFICATION', estimate_percent => 100, cascade => true);
end;
/
prompt set default values
alter table bars.finmon_que modify OPR_VID1 default '999999999999999';
alter table bars.finmon_que modify OPR_VID2 default '0000';
alter table bars.finmon_que modify OPR_VID3 default '000';
alter table bars.finmon_que modify MONITOR_MODE default 0;
alter table bars.finmon_que modify KF default sys_context('bars_context','user_mfo');