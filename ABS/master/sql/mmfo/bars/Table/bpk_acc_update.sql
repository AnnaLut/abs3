

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_ACC_UPDATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_ACC_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_ACC_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BPK_ACC_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BPK_ACC_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_ACC_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_ACC_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ACC_PK NUMBER(38,0), 
	ACC_OVR NUMBER(38,0), 
	ACC_9129 NUMBER(38,0), 
	ACC_TOVR NUMBER(38,0), 
	KF VARCHAR2(6), 
	ACC_3570 NUMBER(38,0), 
	ACC_2208 NUMBER(38,0), 
	ND NUMBER(10,0), 
	PRODUCT_ID NUMBER(38,0), 
	ACC_2207 NUMBER(38,0), 
	ACC_3579 NUMBER(38,0), 
	ACC_2209 NUMBER(38,0), 
	ACC_W4 NUMBER(22,0), 
	FIN NUMBER(*,0), 
	FIN23 NUMBER(*,0), 
	OBS23 NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	K23 NUMBER, 
	DAT_END DATE, 
	KOL_SP NUMBER, 
	S250 VARCHAR2(1), 
	GRP NUMBER(*,0), 
	GLOBAL_BDATE DATE, 
	DAT_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_ACC_UPDATE ***
 exec bpa.alter_policies('BPK_ACC_UPDATE');


COMMENT ON TABLE BARS.BPK_ACC_UPDATE IS 'Історія змін: БПК. Таблица счетов';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.IDUPD IS 'Первичный ключ для таблицы обновления';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.CHGACTION IS 'Код обновления (I/U/D)';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.EFFECTDATE IS 'Банковская дата начала действия параметров';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.CHGDATE IS 'Системаная дата обновления';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.DONEBY IS 'Код пользователя. кто внес обновления';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_PK IS 'Карточный счет 2625-ФЛ/2605-ЮЛ';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_OVR IS 'Кред. БПК 2202(2203)-ФЛ/2062(2063)-ЮЛ';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_9129 IS 'Неиспольз. лимит 9129';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_TOVR IS 'Счет техн. овердрафта';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.KF IS 'Код филиала';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_3570 IS 'Счет комиссии';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_2208 IS 'Счет проц.доходов за пользование кредитом 2208-ФЛ/2268-ЮЛ';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ND IS 'Номер договору';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.PRODUCT_ID IS '';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_2207 IS '';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_3579 IS '';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_2209 IS '';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_W4 IS '';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.FIN IS '';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.FIN23 IS 'ФiнКлас по НБУ-23';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.OBS23 IS 'Обсл.долга по НБУ-23';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.KAT23 IS 'Категорiя якостi за кредитом по НБУ-23';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.K23 IS 'Коеф.Показник ризику по НБУ-23';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.DAT_END IS 'Дата закриття рах.2625 ACC_PK';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.KOL_SP IS 'К-во дней просрочки по договору';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.S250 IS 'Портфельный метод (8)';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.GRP IS 'Дата закриття договору';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.GLOBAL_BDATE IS 'Глобальная банковская дата изменений';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.DAT_CLOSE IS '';




PROMPT *** Create  constraint PK_BPKACC_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC_UPDATE ADD CONSTRAINT PK_BPKACC_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKACCUPD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC_UPDATE MODIFY (KF CONSTRAINT CC_BPKACCUPD_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004982 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC_UPDATE MODIFY (ACC_PK NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKACCUPD_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC_UPDATE MODIFY (GLOBAL_BDATE CONSTRAINT CC_BPKACCUPD_GLOBALBD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKACC_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKACC_UPDATE ON BARS.BPK_ACC_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_BPKACC_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_BPKACC_UPDATEEFFDAT ON BARS.BPK_ACC_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_BPKACC_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_BPKACC_UPDATEPK ON BARS.BPK_ACC_UPDATE (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_BPKACCUPD_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_BPKACCUPD_GLBDT_EFFDT ON BARS.BPK_ACC_UPDATE (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

prompt CREATE UQ INDEX BPK_ACC_UPDATE : I_KF_IDUPD_ACC_BPKACCSUPD (KF, IDUPD, ACC_PK)
begin
    execute immediate q'[
create unique index I_KF_IDUPD_ACC_BPKACCSUPD on bpk_acc_update (kf, idupd, acc_pk) 
GLOBAL PARTITION BY RANGE (KF)
( PARTITION BPKACCUPD_MIN values less than ('300465')
, PARTITION BPKACCUPD_300465 values less than ('302076')
, PARTITION BPKACCUPD_302076 values less than ('303398')
, PARTITION BPKACCUPD_303398 values less than ('304665')
, PARTITION BPKACCUPD_304665 values less than ('305482')
, PARTITION BPKACCUPD_305482 values less than ('311647')
, PARTITION BPKACCUPD_311647 values less than ('312356')
, PARTITION BPKACCUPD_312356 values less than ('313957')
, PARTITION BPKACCUPD_313957 values less than ('315784')
, PARTITION BPKACCUPD_315784 values less than ('322669')
, PARTITION BPKACCUPD_322669 values less than ('323475')
, PARTITION BPKACCUPD_323475 values less than ('324805')
, PARTITION BPKACCUPD_324805 values less than ('325796')
, PARTITION BPKACCUPD_325796 values less than ('326461')
, PARTITION BPKACCUPD_326461 values less than ('328845')
, PARTITION BPKACCUPD_328845 values less than ('331467')
, PARTITION BPKACCUPD_331467 values less than ('333368')
, PARTITION BPKACCUPD_333368 values less than ('335106')
, PARTITION BPKACCUPD_335106 values less than ('336503')
, PARTITION BPKACCUPD_336503 values less than ('337568')
, PARTITION BPKACCUPD_337568 values less than ('338545')
, PARTITION BPKACCUPD_338545 values less than ('351823')
, PARTITION BPKACCUPD_351823 values less than ('352457')
, PARTITION BPKACCUPD_352457 values less than ('353553')
, PARTITION BPKACCUPD_353553 values less than ('354507')
, PARTITION BPKACCUPD_354507 values less than ('356334')
, PARTITION BPKACCUPD_356334 values less than (maxvalue)
)
tablespace brsbigi compress 1
online]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/


PROMPT *** Create  grants  BPK_ACC_UPDATE ***
grant SELECT                                                                 on BPK_ACC_UPDATE  to BARSREADER_ROLE;
grant SELECT                                                                 on BPK_ACC_UPDATE  to BARSUPL;
grant SELECT                                                                 on BPK_ACC_UPDATE  to BARS_DM;
grant SELECT                                                                 on BPK_ACC_UPDATE  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_ACC_UPDATE.sql =========*** End **
PROMPT ===================================================================================== 
