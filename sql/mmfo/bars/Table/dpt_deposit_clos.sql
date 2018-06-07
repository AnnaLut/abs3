PROMPT *** ALTER_POLICY_INFO to DPT_DEPOSIT_CLOS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_DEPOSIT_CLOS'', ''CENTER'' , ''E'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_DEPOSIT_CLOS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_DEPOSIT_CLOS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_DEPOSIT_CLOS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_DEPOSIT_CLOS 
   (	DEPOSIT_ID NUMBER(38,0), 
	VIDD NUMBER(38,0), 
	ACC NUMBER(38,0), 
	KV NUMBER(3,0), 
	RNK NUMBER(38,0), 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	COMMENTS VARCHAR2(128), 
	MFO_P VARCHAR2(12), 
	NLS_P VARCHAR2(15), 
	LIMIT NUMBER(24,0), 
	DEPOSIT_COD VARCHAR2(4), 
	NAME_P VARCHAR2(128), 
	ACTION_ID NUMBER(1,0), 
	ACTIION_AUTHOR NUMBER(38,0), 
	WHEN DATE, 
	OKPO_P VARCHAR2(15), 
	DATZ DATE, 
	FREQ NUMBER(3,0), 
	ND VARCHAR2(35), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	DPT_D NUMBER(38,0), 
	ACC_D NUMBER(38,0), 
	MFO_D VARCHAR2(12), 
	NLS_D VARCHAR2(15), 
	NMS_D VARCHAR2(38), 
	OKPO_D VARCHAR2(14), 
	IDUPD NUMBER(38,0), 
	BDATE DATE, 
	REF_DPS NUMBER(38,0), 
	DAT_END_ALT DATE, 
	STOP_ID NUMBER(38,0) DEFAULT 0, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	CNT_DUBL NUMBER(10,0), 
	CNT_EXT_INT NUMBER(10,0), 
	DAT_EXT_INT DATE, 
	USERID NUMBER(38,0), 
	ARCHDOC_ID NUMBER(38,0), 
	FORBID_EXTENSION NUMBER(1,0), 
	WB CHAR(1) DEFAULT ''N''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_DEPOSIT_CLOS ***
 exec bpa.alter_policies('DPT_DEPOSIT_CLOS');


COMMENT ON TABLE BARS.DPT_DEPOSIT_CLOS IS 'Архив депозитов ФЛ';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.WB IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.DEPOSIT_ID IS 'Идентификатор депозитного договора';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.VIDD IS 'Идентификатор вида деп. договора';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.ACC IS 'Идентификатор основного счета';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.RNK IS 'Идентификатор клиента';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.DAT_BEGIN IS 'Дата начала договора';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.DAT_END IS 'Дата завершения договора';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.COMMENTS IS 'Комментарий';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.MFO_P IS 'Код МФО банка получателя';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.NLS_P IS 'Номер счета получателя';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.LIMIT IS 'Лимит';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.DEPOSIT_COD IS 'Код вида договора';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.NAME_P IS 'Наименование получателя';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.ACTION_ID IS 'Код изменения';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.ACTIION_AUTHOR IS 'Код польз, совершившего изменения';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.WHEN IS 'Дата/время изменения';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.OKPO_P IS 'Код ОКПО получателя';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.DATZ IS 'Дата заключения договора';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.FREQ IS 'Периодичность выплаты %%';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.ND IS '№ депозитного договора (альтернативный)';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.DPT_D IS '№ техн.вклада';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.ACC_D IS 'Внутр.номер техн.счета';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.MFO_D IS 'МФО техн.счета';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.NLS_D IS 'Техн.счет';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.NMS_D IS 'Наименование техн.счета';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.OKPO_D IS 'Идент.код техн.счета';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.IDUPD IS 'Идентификатор записи';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.BDATE IS 'Банковская дата';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.REF_DPS IS 'Референс документа по взысканию штрафа';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.DAT_END_ALT IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.STOP_ID IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.KF IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.CNT_DUBL IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.CNT_EXT_INT IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.DAT_EXT_INT IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.USERID IS 'Пользователь-инициатор открытия вклада';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.ARCHDOC_ID IS 'Ідентифікатор депозитного договору в ЕАД';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.FORBID_EXTENSION IS '';




PROMPT *** Create  constraint PK_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT PK_DPTDEPOSITCLOS PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK2_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT UK2_DPTDEPOSITCLOS UNIQUE (KF, IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_DEPOSITID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (DEPOSIT_ID CONSTRAINT CC_DPTDEPOSITCLOS_DEPOSITID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (VIDD CONSTRAINT CC_DPTDEPOSITCLOS_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (ACC CONSTRAINT CC_DPTDEPOSITCLOS_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (KV CONSTRAINT CC_DPTDEPOSITCLOS_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (RNK CONSTRAINT CC_DPTDEPOSITCLOS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_DATBEGIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (DAT_BEGIN CONSTRAINT CC_DPTDEPOSITCLOS_DATBEGIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_ACTIONID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (ACTION_ID CONSTRAINT CC_DPTDEPOSITCLOS_ACTIONID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_ACTUSER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (ACTIION_AUTHOR CONSTRAINT CC_DPTDEPOSITCLOS_ACTUSER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_DATZ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (DATZ CONSTRAINT CC_DPTDEPOSITCLOS_DATZ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (BRANCH CONSTRAINT CC_DPTDEPOSITCLOS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (IDUPD CONSTRAINT CC_DPTDEPOSITCLOS_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_STOPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (STOP_ID CONSTRAINT CC_DPTDEPOSITCLOS_STOPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (KF CONSTRAINT CC_DPTDEPOSITCLOS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (USERID CONSTRAINT CC_DPTDEPOSITCLOS_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK3_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK3_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (REF_DPS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I6_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I6_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK2_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK2_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (KF, IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I5_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I5_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (DEPOSIT_ID, BDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I4_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I4_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (ACTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (BDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (DEPOSIT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (DECODE(ACTION_ID,0,DEPOSIT_ID,1,DEPOSIT_ID,2,DEPOSIT_ID,5,DEPOSIT_ID,NULL), DECODE(ACTION_ID,0,1,1,2,2,2,5,5,NULL)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

prompt CREATE UQ INDEX DPT_DEPOSIT_CLOS : I_KF_IDUPD_DPTID_DPTDEPCLOS (KF, IDUPD, DEPOSIT_ID)
begin
    execute immediate q'[
create unique index I_KF_IDUPD_DPTID_DPTDEPCLOS on dpt_deposit_clos (kf, idupd, deposit_id) 
GLOBAL PARTITION BY RANGE (KF)
( PARTITION DPTDEPCLOS_MIN values less than ('300465')
, PARTITION DPTDEPCLOS_300465 values less than ('302076')
, PARTITION DPTDEPCLOS_302076 values less than ('303398')
, PARTITION DPTDEPCLOS_303398 values less than ('304665')
, PARTITION DPTDEPCLOS_304665 values less than ('305482')
, PARTITION DPTDEPCLOS_305482 values less than ('311647')
, PARTITION DPTDEPCLOS_311647 values less than ('312356')
, PARTITION DPTDEPCLOS_312356 values less than ('313957')
, PARTITION DPTDEPCLOS_313957 values less than ('315784')
, PARTITION DPTDEPCLOS_315784 values less than ('322669')
, PARTITION DPTDEPCLOS_322669 values less than ('323475')
, PARTITION DPTDEPCLOS_323475 values less than ('324805')
, PARTITION DPTDEPCLOS_324805 values less than ('325796')
, PARTITION DPTDEPCLOS_325796 values less than ('326461')
, PARTITION DPTDEPCLOS_326461 values less than ('328845')
, PARTITION DPTDEPCLOS_328845 values less than ('331467')
, PARTITION DPTDEPCLOS_331467 values less than ('333368')
, PARTITION DPTDEPCLOS_333368 values less than ('335106')
, PARTITION DPTDEPCLOS_335106 values less than ('336503')
, PARTITION DPTDEPCLOS_336503 values less than ('337568')
, PARTITION DPTDEPCLOS_337568 values less than ('338545')
, PARTITION DPTDEPCLOS_338545 values less than ('351823')
, PARTITION DPTDEPCLOS_351823 values less than ('352457')
, PARTITION DPTDEPCLOS_352457 values less than ('353553')
, PARTITION DPTDEPCLOS_353553 values less than ('354507')
, PARTITION DPTDEPCLOS_354507 values less than ('356334')
, PARTITION DPTDEPCLOS_356334 values less than (maxvalue)
)
tablespace brsbigi compress 1
online]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/


PROMPT *** Create  grants  DPT_DEPOSIT_CLOS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_DEPOSIT_CLOS to ABS_ADMIN;
grant SELECT                                                                 on DPT_DEPOSIT_CLOS to BARSREADER_ROLE;
grant SELECT                                                                 on DPT_DEPOSIT_CLOS to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_DEPOSIT_CLOS to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on DPT_DEPOSIT_CLOS to BARS_DM;
grant SELECT                                                                 on DPT_DEPOSIT_CLOS to CHCK;
grant SELECT,UPDATE                                                          on DPT_DEPOSIT_CLOS to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_DEPOSIT_CLOS to DPT_ADMIN;
grant SELECT                                                                 on DPT_DEPOSIT_CLOS to RPBN001;
grant SELECT                                                                 on DPT_DEPOSIT_CLOS to START1;
grant SELECT                                                                 on DPT_DEPOSIT_CLOS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_DEPOSIT_CLOS to WR_ALL_RIGHTS;