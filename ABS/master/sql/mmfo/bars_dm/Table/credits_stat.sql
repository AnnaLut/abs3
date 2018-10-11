PROMPT *** Create  table CREDITS_STAT ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.CREDITS_STAT 
   (	ID NUMBER(15,0), 
	PER_ID NUMBER, 
	ND NUMBER(38,0), 
	RNK NUMBER(15,0), 
	KF VARCHAR2(12), 
	BRANCH VARCHAR2(30), 
	OKPO VARCHAR2(14), 
	CC_ID VARCHAR2(50), 
	SDATE DATE, 
	WDATE DATE, 
	WDATE_FACT DATE, 
	VIDD NUMBER(*,0), 
	PROD VARCHAR2(100), 
	PROD_CLAS VARCHAR2(100), 
	PAWN VARCHAR2(100), 
	SDOG NUMBER(24,2), 
	TERM NUMBER(*,0), 
	KV NUMBER(*,0), 
	POG_PLAN NUMBER(15,2), 
	POG_FACT NUMBER(15,2), 
	BORG_SY NUMBER(15,2), 
	BORGPROC_SY NUMBER(15,2), 
	BPK_NLS VARCHAR2(15), 
	INTRATE NUMBER, 
	PTN_NAME VARCHAR2(255), 
	PTN_OKPO VARCHAR2(14), 
	PTN_MOTHER_NAME VARCHAR2(255), 
	OPEN_DATE_BAL22 DATE, 
	ES000 VARCHAR2(24), 
	ES003 VARCHAR2(24), 
	VIDD_CUSTTYPE NUMBER(1,0),
	OB22 VARCHAR2(2),
	NMS  VARCHAR2(70)
   ) tablespace BRSDMIMP
PARTITION BY LIST (PER_ID) SUBPARTITION by list (KF)
SUBPARTITION TEMPLATE
         (SUBPARTITION KF_300465 VALUES (''300465''),
            SUBPARTITION KF_302076 VALUES (''302076''),
            SUBPARTITION KF_303398 VALUES (''303398''),
            SUBPARTITION KF_304665 VALUES (''304665''),
            SUBPARTITION KF_305482 VALUES (''305482''),
            SUBPARTITION KF_311647 VALUES (''311647''),
            SUBPARTITION KF_312356 VALUES (''312356''),
            SUBPARTITION KF_313957 VALUES (''313957''),
            SUBPARTITION KF_315784 VALUES (''315784''),
            SUBPARTITION KF_322669 VALUES (''322669''),
            SUBPARTITION KF_323475 VALUES (''323475''),
            SUBPARTITION KF_324805 VALUES (''324805''),
            SUBPARTITION KF_325796 VALUES (''325796''),
            SUBPARTITION KF_326461 VALUES (''326461''),
            SUBPARTITION KF_328845 VALUES (''328845''),
            SUBPARTITION KF_331467 VALUES (''331467''),
            SUBPARTITION KF_333368 VALUES (''333368''),
            SUBPARTITION KF_335106 VALUES (''335106''),
            SUBPARTITION KF_336503 VALUES (''336503''),
            SUBPARTITION KF_337568 VALUES (''337568''),
            SUBPARTITION KF_338545 VALUES (''338545''),
            SUBPARTITION KF_351823 VALUES (''351823''),
            SUBPARTITION KF_352457 VALUES (''352457''),
            SUBPARTITION KF_353553 VALUES (''353553''),
            SUBPARTITION KF_354507 VALUES (''354507''),
            SUBPARTITION KF_356334 VALUES (''356334'')
          )
(PARTITION INITIAL_PARTITION VALUES (0)) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

prompt add ob22, nms
begin
	execute immediate 'alter table bars_dm.credits_stat add ob22 varchar2(2)';
exception
	when others then
		if sqlcode = -1430 then null; else raise; end if;
end;
/
begin
	execute immediate 'alter table bars_dm.credits_stat add nms varchar2(70)';
exception
	when others then
		if sqlcode = -1430 then null; else raise; end if;
end;
/

prompt add column nls
begin
execute immediate 'alter table bars_dm.credits_stat add nls VARCHAR2(15)';
exception
  when others then
     if sqlcode = -1430 then null;
     else
       raise;
     end if;
end;
/

prompt drop error log
begin
	execute immediate 'drop table bars_dm.err$_credits_stat';
exception
	when others then
		if sqlcode = -942 then null; else raise; end if;
end;
/
prompt create errlog
begin
    dbms_errlog.create_error_log(dml_table_name => 'CREDITS_STAT');
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/

prompt nologging mode
alter table bars_dm.credits_stat nologging;

COMMENT ON TABLE BARS_DM.CREDITS_STAT IS 'Кредити, статичні дані';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PAWN IS 'Вид застави/Поручительства';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.SDOG IS 'Сума кредиту (загальна сума договору)';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.TERM IS 'Строк кредиту (в місяцях)';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.VIDD_CUSTTYPE IS 'Тип клиента по виду договора: 3 - физическое лицо, 2 - юридическое лицо, 1 - банк';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.KV IS 'Валюта кредиту';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.POG_PLAN IS 'Планова сума погашення за минулий місяць';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.POG_FACT IS 'Фактична сума погашення за минулий місяць';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.BORG_SY IS 'Сума залишку заборгованості на початок року, грн';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.BORGPROC_SY IS 'Сума залишку заборгованості за відсотками на початок року, грн.';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.BPK_NLS IS 'Рах.2625 для КД по БПК';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.INTRATE IS 'Розмір процентної ставки';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PTN_NAME IS 'найменування партнера';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.ID IS 'Ідентифікатор запису';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PER_ID IS 'Ідентифікатор періоду';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.ND IS 'Ідентифікатор КД';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.RNK IS 'РНК';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.KF IS 'МФО РУ';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.BRANCH IS 'Бранч';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.OKPO IS 'ІПН';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.CC_ID IS '№ договору';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.SDATE IS 'Дата укладання договору';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.WDATE IS 'Дата закінчення договору (фактична)';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.WDATE_FACT IS '';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.VIDD IS 'Тип договору';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PROD IS 'Вид кредитного продукту';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PROD_CLAS IS 'Класифікація кредитного продукту';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PTN_OKPO IS 'код ЄДРПОУ партнера';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PTN_MOTHER_NAME IS 'найменування материнської компанії';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.OPEN_DATE_BAL22 IS 'дата відкриття рахунку 2202/03 або 2232/33';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.ES000 IS '';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.ES003 IS '';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.NLS IS 'Номер рахунку';

PROMPT *** Create  grants  CREDITS_STAT ***
grant SELECT                                                                 on CREDITS_STAT    to BARS;
grant SELECT                                                                 on CREDITS_STAT    to BARSREADER_ROLE;
grant SELECT                                                                 on CREDITS_STAT    to BARSUPL;
