

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_ACC_UPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_ACC_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_ACC_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''W4_ACC_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''W4_ACC_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_ACC_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_ACC_UPDATE 
   (	IDUPD NUMBER(38,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ND NUMBER(22,0), 
	ACC_PK NUMBER(22,0), 
	ACC_OVR NUMBER(22,0), 
	ACC_9129 NUMBER(22,0), 
	ACC_3570 NUMBER(22,0), 
	ACC_2208 NUMBER(22,0), 
	ACC_2627 NUMBER(22,0), 
	ACC_2207 NUMBER(22,0), 
	ACC_3579 NUMBER(22,0), 
	ACC_2209 NUMBER(22,0), 
	CARD_CODE VARCHAR2(32), 
	ACC_2625X NUMBER(22,0), 
	ACC_2627X NUMBER(22,0), 
	ACC_2625D NUMBER(22,0), 
	ACC_2628 NUMBER(22,0), 
	ACC_2203 NUMBER(22,0), 
	FIN NUMBER(*,0), 
	FIN23 NUMBER(*,0), 
	OBS23 NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	K23 NUMBER, 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	DAT_CLOSE DATE, 
	PASS_DATE DATE, 
	PASS_STATE NUMBER(10,0), 
	KOL_SP NUMBER, 
	S250 VARCHAR2(1), 
	GRP NUMBER(*,0), 
	GLOBAL_BDATE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''),
	ACC_9129I NUMBER(22)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** Add  columns for Instolment ***
begin 
execute immediate'
alter table BARS.W4_ACC_UPDATE add (
  ACC_9129I      NUMBER(22))';
exception
 when others 
 then 
 if sqlcode = -1430 then null; 
 else raise;
 end if;
end;
/


PROMPT *** ALTER_POLICIES to W4_ACC_UPDATE ***
 exec bpa.alter_policies('W4_ACC_UPDATE');


COMMENT ON TABLE BARS.W4_ACC_UPDATE IS 'Історія змін: OW. Портфель карткових угод для ЦРВ';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.FIN23 IS '';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.OBS23 IS '';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.KAT23 IS '';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.K23 IS '';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.DAT_BEGIN IS 'Дата початку дії кредитного договору';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.DAT_END IS 'Дата закінчення дії кредитного договору';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.DAT_CLOSE IS 'Дата закриття договору W4_ACC';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.PASS_DATE IS 'Дата передачі справи';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.PASS_STATE IS 'Стан передачі справ до Бек-офісу: 1-передано, 2-перевірено, 3-повернуто на доопрацювання';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.KOL_SP IS 'К-во дней просрочки по договору';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.S250 IS 'Портфельный метод (8)';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.GRP IS 'група активу портфельного методу';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.GLOBAL_BDATE IS 'Глобальная банковская дата изменений';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.IDUPD IS 'Первичный ключ для таблицы обновления';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.CHGACTION IS 'Код обновления (I/U/D)';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.EFFECTDATE IS 'Банковская дата начала действия параметров';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.CHGDATE IS 'Системаная дата обновления';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.DONEBY IS 'Код пользователя. кто внес обновления(если в течении дня было несколько обновлений - остается только последнее)';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ND IS 'Номер договору';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_PK IS 'Поточний картковий рахунок';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_OVR IS 'Кред. БПК';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_9129 IS 'Невикористаний ліміт';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_3570 IS 'Нараховані доходи (комісії)';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2208 IS 'Счет проц.доходов за пользование кредитом';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2627 IS 'Нараховані доходи за кредитами овердрафт';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2207 IS 'Прострочена заборгованість за кредитами ';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_3579 IS 'Прострочені нараховані доходи (комісії)';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2209 IS 'Прострочені нараховані доходи за кредитами ';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.CARD_CODE IS 'Тип карты';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2625X IS '';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2627X IS 'Нараховані доходи за несанкціонований овердрафт';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2625D IS 'Вклад на вимогу Мобільний';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2628 IS 'Нараховані витрати за коштами на вимогу ';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2203 IS '';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.FIN IS '';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_9129I IS 'Невикористаний ліміт, що надано клієнтам(Інстолмент)';



PROMPT *** Create  constraint PK_W4ACC_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_UPDATE ADD CONSTRAINT PK_W4ACC_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4ACCUPD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_UPDATE MODIFY (KF CONSTRAINT CC_W4ACCUPD_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007567 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_UPDATE MODIFY (ND NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007568 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_UPDATE MODIFY (ACC_PK NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007569 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_UPDATE MODIFY (CARD_CODE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4ACCUPD_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_UPDATE MODIFY (GLOBAL_BDATE CONSTRAINT CC_W4ACCUPD_GLOBALBD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_W4ACC_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_W4ACC_UPDATEPK ON BARS.W4_ACC_UPDATE (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_W4ACC_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_W4ACC_UPDATEEFFDAT ON BARS.W4_ACC_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_W4ACC_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_W4ACC_UPDATE ON BARS.W4_ACC_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_W4ACCUPD_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_W4ACCUPD_GLBDT_EFFDT ON BARS.W4_ACC_UPDATE (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

prompt CREATE UQ INDEX W4_ACC_UPDATE : I_KF_IDUPD_ACC_W4ACCSUPD (KF, IDUPD, ACC_PK)
begin
    execute immediate q'[
create unique index I_KF_IDUPD_ACC_W4ACCSUPD on w4_acc_update (kf, idupd, acc_pk) 
GLOBAL PARTITION BY RANGE (KF)
( PARTITION W4ACCUPD_MIN values less than ('300465')
, PARTITION W4ACCUPD_300465 values less than ('302076')
, PARTITION W4ACCUPD_302076 values less than ('303398')
, PARTITION W4ACCUPD_303398 values less than ('304665')
, PARTITION W4ACCUPD_304665 values less than ('305482')
, PARTITION W4ACCUPD_305482 values less than ('311647')
, PARTITION W4ACCUPD_311647 values less than ('312356')
, PARTITION W4ACCUPD_312356 values less than ('313957')
, PARTITION W4ACCUPD_313957 values less than ('315784')
, PARTITION W4ACCUPD_315784 values less than ('322669')
, PARTITION W4ACCUPD_322669 values less than ('323475')
, PARTITION W4ACCUPD_323475 values less than ('324805')
, PARTITION W4ACCUPD_324805 values less than ('325796')
, PARTITION W4ACCUPD_325796 values less than ('326461')
, PARTITION W4ACCUPD_326461 values less than ('328845')
, PARTITION W4ACCUPD_328845 values less than ('331467')
, PARTITION W4ACCUPD_331467 values less than ('333368')
, PARTITION W4ACCUPD_333368 values less than ('335106')
, PARTITION W4ACCUPD_335106 values less than ('336503')
, PARTITION W4ACCUPD_336503 values less than ('337568')
, PARTITION W4ACCUPD_337568 values less than ('338545')
, PARTITION W4ACCUPD_338545 values less than ('351823')
, PARTITION W4ACCUPD_351823 values less than ('352457')
, PARTITION W4ACCUPD_352457 values less than ('353553')
, PARTITION W4ACCUPD_353553 values less than ('354507')
, PARTITION W4ACCUPD_354507 values less than ('356334')
, PARTITION W4ACCUPD_356334 values less than (maxvalue)
)
tablespace brsbigi compress 1
online]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/


PROMPT *** Create  grants  W4_ACC_UPDATE ***
grant SELECT                                                                 on W4_ACC_UPDATE   to BARSREADER_ROLE;
grant SELECT                                                                 on W4_ACC_UPDATE   to BARSUPL;
grant SELECT                                                                 on W4_ACC_UPDATE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_ACC_UPDATE   to BARS_DM;
grant SELECT                                                                 on W4_ACC_UPDATE   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_ACC_UPDATE.sql =========*** End ***
PROMPT ===================================================================================== 
