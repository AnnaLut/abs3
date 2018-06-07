

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_UPDATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCOUNTS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCOUNTS_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACCOUNTS_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACCOUNTS_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCOUNTS_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCOUNTS_UPDATE 
   (	ACC NUMBER(38,0), 
	NLS VARCHAR2(15), 
	NLSALT VARCHAR2(15), 
	KV NUMBER(3,0), 
	NBS CHAR(4), 
	NBS2 CHAR(4), 
	DAOS DATE, 
	ISP NUMBER(38,0), 
	NMS VARCHAR2(70), 
	PAP NUMBER(1,0), 
	VID NUMBER(2,0), 
	DAZS DATE, 
	BLKD NUMBER(3,0), 
	BLKK NUMBER(3,0), 
	CHGDATE DATE, 
	CHGACTION NUMBER(1,0), 
	POS NUMBER(38,0), 
	TIP CHAR(3), 
	GRP NUMBER(38,0), 
	SECI NUMBER(38,0), 
	SECO NUMBER(38,0), 
	DONEBY VARCHAR2(64), 
	IDUPD NUMBER(38,0), 
	LIM NUMBER(24,0), 
	ACCC NUMBER(38,0), 
	TOBO VARCHAR2(30), 
	BRANCH VARCHAR2(30) DEFAULT NULL, 
	MDATE DATE, 
	OSTX NUMBER(24,0), 
	SEC RAW(64), 
	RNK NUMBER(22,0), 
	KF VARCHAR2(6) DEFAULT NULL, 
	EFFECTDATE DATE, 
	SEND_SMS VARCHAR2(1), 
	OB22 CHAR(2), 
	GLOBALBD DATE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255  NOLOGGING 
  TABLESPACE BRSBIGD 
  PARTITION BY RANGE (CHGDATE) INTERVAL (NUMTOYMINTERVAL(1,''MONTH'')) 
 (PARTITION SYS_P17644  VALUES LESS THAN (TO_DATE('' 2010-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCOUNTS_UPDATE ***
 exec bpa.alter_policies('ACCOUNTS_UPDATE');


COMMENT ON TABLE BARS.ACCOUNTS_UPDATE IS 'История изменений счетов банка';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.ACC IS 'Внутренний номер счета';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.NLS IS 'Номер лицевого счета (внешний)';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.NLSALT IS 'Альтернативный номер счета';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.NBS IS 'Номер балансового счета';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.NBS2 IS 'Номер альтернат. балансового счета';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.DAOS IS 'Дата открытия счета';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.ISP IS 'Код исполнителя';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.NMS IS 'Наименование счета';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.PAP IS 'Признак Атива-Пассива';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.VID IS 'Код вида счета';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.DAZS IS 'Дата закрытия счета';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.BLKD IS 'Код блокировки дебет';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.BLKK IS 'Код блокировки кредит';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.CHGDATE IS 'Дата/время изменения';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.CHGACTION IS 'Тип изменения';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.POS IS 'Признак главного счета';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.TIP IS 'Тип счета';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.GRP IS 'Код группы счета';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.SECI IS 'Код доступа исполнителя';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.SECO IS 'Код доступа остальных';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.DONEBY IS 'Имя пользователя, выполнившего изменения';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.IDUPD IS 'Идентификатор изменения';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.LIM IS 'Лимит';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.ACCC IS 'Внутренний номер счета';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.TOBO IS 'Код безбалансового отделения';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.MDATE IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.OSTX IS 'Максимальный остаток на счете';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.SEC IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.RNK IS 'РНК клиента-владельца счета';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.EFFECTDATE IS 'банковская дата изменения';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.SEND_SMS IS 'Признак відправки СМС по рахунку';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.OB22 IS 'Аналiтика рах. Розширення БР.';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.GLOBALBD IS 'Глобальна банківська дата';




PROMPT *** Create  constraint CC_ACCOUNTSUPD_CHGACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT CC_ACCOUNTSUPD_CHGACTION CHECK (chgaction in (0,1,2,3,4)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCOUNTSUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT PK_ACCOUNTSUPD PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (ACC CONSTRAINT CC_ACCOUNTSUPD_ACC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (NLS CONSTRAINT CC_ACCOUNTSUPD_NLS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (KV CONSTRAINT CC_ACCOUNTSUPD_KV_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_DAOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (DAOS CONSTRAINT CC_ACCOUNTSUPD_DAOS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_NMS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (NMS CONSTRAINT CC_ACCOUNTSUPD_NMS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (CHGDATE CONSTRAINT CC_ACCOUNTSUPD_CHGDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (CHGACTION CONSTRAINT CC_ACCOUNTSUPD_CHGACTION_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (DONEBY CONSTRAINT CC_ACCOUNTSUPD_DONEBY_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (IDUPD CONSTRAINT CC_ACCOUNTSUPD_IDUPD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (BRANCH CONSTRAINT CC_ACCOUNTSUPD_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (KF CONSTRAINT CC_ACCOUNTSUPD_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (GLOBALBD CONSTRAINT CC_ACCOUNTSUPD_GLOBALBD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCOUNTSUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCOUNTSUPD ON BARS.ACCOUNTS_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_ACCOUNTSUPD_KF_ACC_IDUPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_ACCOUNTSUPD_KF_ACC_IDUPD ON BARS.ACCOUNTS_UPDATE (KF, ACC, IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_ACCOUNTSUPD_GLD_EFFD ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_ACCOUNTSUPD_GLD_EFFD ON BARS.ACCOUNTS_UPDATE (GLOBALBD, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_ACCOUNTSUPD_EFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_ACCOUNTSUPD_EFFDAT ON BARS.ACCOUNTS_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_ACCOUNTSUPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_ACCOUNTSUPD ON BARS.ACCOUNTS_UPDATE (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_ACCOUNTS_UPDATE_DAOS ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAK_ACCOUNTS_UPDATE_DAOS ON BARS.ACCOUNTS_UPDATE (DAOS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION SYS_P17815 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_ACCOUNTSUPD_CHGDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_ACCOUNTSUPD_CHGDATE ON BARS.ACCOUNTS_UPDATE (CHGDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION SYS_P17758 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_ACCOUNTSUPD_UPLDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_ACCOUNTSUPD_UPLDATE ON BARS.ACCOUNTS_UPDATE (CHGDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION SYS_P17701 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

prompt CREATE UQ INDEX ACCOUNTS_UPDATE : I_KF_IDUPD_ACC_ACCSUPD (KF, IDUPD, ACC)
begin
    execute immediate q'[
create unique index I_KF_IDUPD_ACC_ACCSUPD on accounts_update (kf, idupd, acc) 
GLOBAL PARTITION BY RANGE (KF)
( PARTITION ACCUPD_MIN values less than ('300465')
, PARTITION ACCUPD_300465 values less than ('302076')
, PARTITION ACCUPD_302076 values less than ('303398')
, PARTITION ACCUPD_303398 values less than ('304665')
, PARTITION ACCUPD_304665 values less than ('305482')
, PARTITION ACCUPD_305482 values less than ('311647')
, PARTITION ACCUPD_311647 values less than ('312356')
, PARTITION ACCUPD_312356 values less than ('313957')
, PARTITION ACCUPD_313957 values less than ('315784')
, PARTITION ACCUPD_315784 values less than ('322669')
, PARTITION ACCUPD_322669 values less than ('323475')
, PARTITION ACCUPD_323475 values less than ('324805')
, PARTITION ACCUPD_324805 values less than ('325796')
, PARTITION ACCUPD_325796 values less than ('326461')
, PARTITION ACCUPD_326461 values less than ('328845')
, PARTITION ACCUPD_328845 values less than ('331467')
, PARTITION ACCUPD_331467 values less than ('333368')
, PARTITION ACCUPD_333368 values less than ('335106')
, PARTITION ACCUPD_335106 values less than ('336503')
, PARTITION ACCUPD_336503 values less than ('337568')
, PARTITION ACCUPD_337568 values less than ('338545')
, PARTITION ACCUPD_338545 values less than ('351823')
, PARTITION ACCUPD_351823 values less than ('352457')
, PARTITION ACCUPD_352457 values less than ('353553')
, PARTITION ACCUPD_353553 values less than ('354507')
, PARTITION ACCUPD_354507 values less than ('356334')
, PARTITION ACCUPD_356334 values less than (maxvalue)
)
tablespace brsbigi compress 1
online]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/


PROMPT *** Create  grants  ACCOUNTS_UPDATE ***
grant REFERENCES,SELECT                                                      on ACCOUNTS_UPDATE to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on ACCOUNTS_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on ACCOUNTS_UPDATE to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTS_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCOUNTS_UPDATE to BARS_DM;
grant DELETE,INSERT,UPDATE                                                   on ACCOUNTS_UPDATE to CUST001;
grant SELECT                                                                 on ACCOUNTS_UPDATE to KLBX;
grant SELECT                                                                 on ACCOUNTS_UPDATE to START1;
grant SELECT                                                                 on ACCOUNTS_UPDATE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACCOUNTS_UPDATE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_UPDATE.sql =========*** End *
PROMPT ===================================================================================== 
