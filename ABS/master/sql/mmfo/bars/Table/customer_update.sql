

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_UPDATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CUSTOMER_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CUSTOMER_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_UPDATE 
   (	RNK NUMBER(38,0), 
	CUSTTYPE NUMBER(1,0), 
	COUNTRY NUMBER(3,0), 
	NMK VARCHAR2(70), 
	NMKV VARCHAR2(70), 
	NMKK VARCHAR2(38), 
	CODCAGENT NUMBER(1,0), 
	PRINSIDER NUMBER(38,0), 
	OKPO VARCHAR2(14), 
	ADR VARCHAR2(70), 
	SAB VARCHAR2(6), 
	C_REG NUMBER(2,0), 
	C_DST NUMBER(2,0), 
	RGTAX VARCHAR2(30), 
	DATET DATE, 
	ADM VARCHAR2(70), 
	DATEA DATE, 
	STMT NUMBER(5,0), 
	DATE_ON DATE, 
	DATE_OFF DATE, 
	NOTES VARCHAR2(140), 
	NOTESEC VARCHAR2(256), 
	CRISK NUMBER(38,0), 
	PINCODE VARCHAR2(10), 
	CHGDATE DATE, 
	CHGACTION NUMBER(1,0), 
	TGR NUMBER(1,0), 
	IDUPD NUMBER(38,0), 
	DONEBY VARCHAR2(30), 
	BRANCH VARCHAR2(30) DEFAULT NULL, 
	ND VARCHAR2(10), 
	RNKP NUMBER(38,0), 
	ISE CHAR(5), 
	FS CHAR(2), 
	OE CHAR(5), 
	VED CHAR(5), 
	SED CHAR(4), 
	LIM NUMBER(24,0), 
	MB CHAR(1), 
	RGADM VARCHAR2(30), 
	BC NUMBER(1,0), 
	TOBO VARCHAR2(30) DEFAULT NULL, 
	ISP NUMBER(38,0), 
	TAXF VARCHAR2(12), 
	NOMPDV VARCHAR2(9), 
	K050 CHAR(3), 
	EFFECTDATE DATE, 
	GLOBAL_BDATE DATE, 
	NREZID_CODE VARCHAR2(20), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_UPDATE ***
 exec bpa.alter_policies('CUSTOMER_UPDATE');


COMMENT ON TABLE BARS.CUSTOMER_UPDATE IS 'История обновлений реквизитов клиентов';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.RNK IS 'Регистрационный номер';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.CUSTTYPE IS 'Тип
 (1=БН,2=ЮЛ,3=ФЛ)';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.COUNTRY IS 'Код страны';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.NMK IS 'Полное Наименование контрагента';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.NMKV IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.NMKK IS 'Краткое Наименование контрагента';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.CODCAGENT IS 'Хар-ка';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.PRINSIDER IS 'Код инсайдера';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.OKPO IS 'Код ОКПО';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.ADR IS 'Адрес';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.SAB IS 'Эл.код';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.C_REG IS 'Код обл.НИ';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.C_DST IS 'Код район.НИ';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.RGTAX IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.DATET IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.ADM IS 'Админ.орган';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.DATEA IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.STMT IS 'Формат выписки';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.DATE_ON IS 'Дата открытия';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.DATE_OFF IS 'Дата закрытия';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.NOTES IS 'Комментарий';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.NOTESEC IS 'Комментарий службы безопастности';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.CRISK IS 'Категория риска';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.PINCODE IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.CHGDATE IS 'Дата изменения';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.CHGACTION IS 'Действие изменения (что изменено)';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.TGR IS 'ТГР
(1=ЄДР.,2=ДРФ.,3=тимчас)';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.ND IS '№ дог';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.RNKP IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.ISE IS 'Код сектора экономики';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.FS IS 'Форма собственности';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.OE IS 'Отрасль экономики';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.VED IS 'Вид экономической деятельности';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.SED IS 'Код отрасли экономики';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.LIM IS 'Лимит';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.MB IS 'Принадлежность к малому бизнесу';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.RGADM IS 'Рег.номер в Администрации';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.BC IS 'Признак НЕклиента банка (1)';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.TOBO IS 'Код ТОБО';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.ISP IS 'Менеджер клиента (ответ. исполнитель)';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.TAXF IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.NOMPDV IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.K050 IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.EFFECTDATE IS 'банковская дата изменения';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.GLOBAL_BDATE IS 'Глобальна банківська дата зміни';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.NREZID_CODE IS 'Код в країні реєстрації (для нерезидентів)';




PROMPT *** Create  constraint PK_CUSTOMERUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT PK_CUSTOMERUPD PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPD_DATEOFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT CC_CUSTOMERUPD_DATEOFF CHECK (date_off = trunc(date_off)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPD_BC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT CC_CUSTOMERUPD_BC CHECK (bc in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPD_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE MODIFY (CHGDATE CONSTRAINT CC_CUSTOMERUPD_CHGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE MODIFY (KF CONSTRAINT CC_CUSTOMERUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPD_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE MODIFY (RNK CONSTRAINT CC_CUSTOMERUPD_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPD_DATEON_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE MODIFY (DATE_ON CONSTRAINT CC_CUSTOMERUPD_DATEON_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPD_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE MODIFY (CHGACTION CONSTRAINT CC_CUSTOMERUPD_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPD_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE MODIFY (IDUPD CONSTRAINT CC_CUSTOMERUPD_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPD_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE MODIFY (DONEBY CONSTRAINT CC_CUSTOMERUPD_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMER_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE MODIFY (GLOBAL_BDATE CONSTRAINT CC_CUSTOMER_GLOBALBD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CUSTOMERUPD_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CUSTOMERUPD_GLBDT_EFFDT ON BARS.CUSTOMER_UPDATE (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI 
  PARALLEL ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CUSTUPD_EFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CUSTUPD_EFFDAT ON BARS.CUSTOMER_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_CUSTOMERUPD_CHGDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_CUSTOMERUPD_CHGDATE ON BARS.CUSTOMER_UPDATE (CHGDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMERUPD ON BARS.CUSTOMER_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_CUSTOMERUPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_CUSTOMERUPD ON BARS.CUSTOMER_UPDATE (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CUSTOMERUPD_KF_RNK_IDUPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CUSTOMERUPD_KF_RNK_IDUPD ON BARS.CUSTOMER_UPDATE (KF, RNK, IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

prompt CREATE UQ INDEX CUSTOMER_UPDATE : I_KF_IDUPD_RNK_CUSTSUPD (KF, IDUPD, RNK)
begin
    execute immediate q'[
create unique index I_KF_IDUPD_RNK_CUSTSUPD on customer_update (kf, idupd, rnk) 
GLOBAL PARTITION BY RANGE (KF)
( PARTITION CUSTUPD_MIN values less than ('300465')
, PARTITION CUSTUPD_300465 values less than ('302076')
, PARTITION CUSTUPD_302076 values less than ('303398')
, PARTITION CUSTUPD_303398 values less than ('304665')
, PARTITION CUSTUPD_304665 values less than ('305482')
, PARTITION CUSTUPD_305482 values less than ('311647')
, PARTITION CUSTUPD_311647 values less than ('312356')
, PARTITION CUSTUPD_312356 values less than ('313957')
, PARTITION CUSTUPD_313957 values less than ('315784')
, PARTITION CUSTUPD_315784 values less than ('322669')
, PARTITION CUSTUPD_322669 values less than ('323475')
, PARTITION CUSTUPD_323475 values less than ('324805')
, PARTITION CUSTUPD_324805 values less than ('325796')
, PARTITION CUSTUPD_325796 values less than ('326461')
, PARTITION CUSTUPD_326461 values less than ('328845')
, PARTITION CUSTUPD_328845 values less than ('331467')
, PARTITION CUSTUPD_331467 values less than ('333368')
, PARTITION CUSTUPD_333368 values less than ('335106')
, PARTITION CUSTUPD_335106 values less than ('336503')
, PARTITION CUSTUPD_336503 values less than ('337568')
, PARTITION CUSTUPD_337568 values less than ('338545')
, PARTITION CUSTUPD_338545 values less than ('351823')
, PARTITION CUSTUPD_351823 values less than ('352457')
, PARTITION CUSTUPD_352457 values less than ('353553')
, PARTITION CUSTUPD_353553 values less than ('354507')
, PARTITION CUSTUPD_354507 values less than ('356334')
, PARTITION CUSTUPD_356334 values less than (maxvalue)
)
tablespace brsbigi compress 1
online]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/


PROMPT *** Create  grants  CUSTOMER_UPDATE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_UPDATE to ABS_ADMIN;
grant SELECT                                                                 on CUSTOMER_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on CUSTOMER_UPDATE to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_UPDATE to BARS_DM;
grant INSERT                                                                 on CUSTOMER_UPDATE to CUST001;
grant SELECT                                                                 on CUSTOMER_UPDATE to KLBX;
grant SELECT                                                                 on CUSTOMER_UPDATE to START1;
grant SELECT                                                                 on CUSTOMER_UPDATE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMER_UPDATE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_UPDATE.sql =========*** End *
PROMPT ===================================================================================== 
