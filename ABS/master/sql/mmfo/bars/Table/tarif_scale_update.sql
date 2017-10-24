

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TARIF_SCALE_UPDATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TARIF_SCALE_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TARIF_SCALE_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TARIF_SCALE_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''TARIF_SCALE_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TARIF_SCALE_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TARIF_SCALE_UPDATE 
   (	IDUPD NUMBER(38,0), 
	CHGACTION CHAR(1), 
	CHGDATE DATE, 
	GLOBAL_BDATE DATE, 
	EFFECTDATE DATE, 
	DONEBY NUMBER(38,0), 
	KOD NUMBER(38,0), 
	SUM_LIMIT NUMBER(24,0), 
	SUM_TARIF NUMBER(24,0), 
	PR NUMBER(20,4), 
	KF VARCHAR2(6), 
	SMIN NUMBER(24,0), 
	SMAX NUMBER(24,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TARIF_SCALE_UPDATE ***
 exec bpa.alter_policies('TARIF_SCALE_UPDATE');


COMMENT ON TABLE BARS.TARIF_SCALE_UPDATE IS 'Історія змін Шкали тарифів и комісій';
COMMENT ON COLUMN BARS.TARIF_SCALE_UPDATE.IDUPD IS 'Ідентифікатор зміни';
COMMENT ON COLUMN BARS.TARIF_SCALE_UPDATE.CHGACTION IS 'Код типу зміни';
COMMENT ON COLUMN BARS.TARIF_SCALE_UPDATE.CHGDATE IS 'Календарна дата зміни';
COMMENT ON COLUMN BARS.TARIF_SCALE_UPDATE.GLOBAL_BDATE IS 'Глобальна банківська дата зміни';
COMMENT ON COLUMN BARS.TARIF_SCALE_UPDATE.EFFECTDATE IS 'Локальна банківська дата зміни';
COMMENT ON COLUMN BARS.TARIF_SCALE_UPDATE.DONEBY IS 'Ідентифікатор користувача, що виконав зміни';
COMMENT ON COLUMN BARS.TARIF_SCALE_UPDATE.KOD IS 'Код тарифа (из справочника TARIF)';
COMMENT ON COLUMN BARS.TARIF_SCALE_UPDATE.SUM_LIMIT IS 'Верхняя граница диапазона суммы для расчета комиссии';
COMMENT ON COLUMN BARS.TARIF_SCALE_UPDATE.SUM_TARIF IS 'Сумма за 1 документ';
COMMENT ON COLUMN BARS.TARIF_SCALE_UPDATE.PR IS '% от суммы документа';
COMMENT ON COLUMN BARS.TARIF_SCALE_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.TARIF_SCALE_UPDATE.SMIN IS 'минимальная сумма тарифа';
COMMENT ON COLUMN BARS.TARIF_SCALE_UPDATE.SMAX IS 'максимальная сумма тарифа';




PROMPT *** Create  constraint CC_TFSCALEUPD_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCALE_UPDATE MODIFY (CHGDATE CONSTRAINT CC_TFSCALEUPD_CHGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TFSCALEUPD_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCALE_UPDATE MODIFY (CHGACTION CONSTRAINT CC_TFSCALEUPD_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TFSCALEUPD_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCALE_UPDATE MODIFY (IDUPD CONSTRAINT CC_TFSCALEUPD_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TFSCALEUPD_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCALE_UPDATE MODIFY (GLOBAL_BDATE CONSTRAINT CC_TFSCALEUPD_GLOBALBD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TFSCALEUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCALE_UPDATE ADD CONSTRAINT PK_TFSCALEUPD PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TFSCALEUPD_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCALE_UPDATE MODIFY (DONEBY CONSTRAINT CC_TFSCALEUPD_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TFSCALEUPD_KOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCALE_UPDATE MODIFY (KOD CONSTRAINT CC_TFSCALEUPD_KOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TFSCALEUPD_SUMLIMIT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCALE_UPDATE MODIFY (SUM_LIMIT CONSTRAINT CC_TFSCALEUPD_SUMLIMIT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TFSCALEUPD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCALE_UPDATE MODIFY (KF CONSTRAINT CC_TFSCALEUPD_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TFSCALEUPD_EFFECTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCALE_UPDATE MODIFY (EFFECTDATE CONSTRAINT CC_TFSCALEUPD_EFFECTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TFSCALEUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TFSCALEUPD ON BARS.TARIF_SCALE_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_TFSCALEUPD_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_TFSCALEUPD_GLBDT_EFFDT ON BARS.TARIF_SCALE_UPDATE (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_TFSCALEUPD_KOD_SUM ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_TFSCALEUPD_KOD_SUM ON BARS.TARIF_SCALE_UPDATE (KF, KOD, SUM_LIMIT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TARIF_SCALE_UPDATE ***
grant SELECT                                                                 on TARIF_SCALE_UPDATE to BARSUPL;
grant SELECT                                                                 on TARIF_SCALE_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TARIF_SCALE_UPDATE to START1;
grant SELECT                                                                 on TARIF_SCALE_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TARIF_SCALE_UPDATE.sql =========*** En
PROMPT ===================================================================================== 
