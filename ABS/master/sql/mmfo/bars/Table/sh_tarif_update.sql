

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SH_TARIF_UPDATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SH_TARIF_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SH_TARIF_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SH_TARIF_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SH_TARIF_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SH_TARIF_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SH_TARIF_UPDATE 
   (	IDUPD NUMBER(38,0), 
	CHGACTION CHAR(1), 
	CHGDATE DATE, 
	GLOBAL_BDATE DATE, 
	EFFECTDATE DATE, 
	DONEBY NUMBER(38,0), 
	IDS NUMBER, 
	KOD NUMBER(22,0), 
	TAR NUMBER(22,0), 
	PR NUMBER(20,4), 
	SMIN NUMBER(22,0), 
	SMAX NUMBER(22,0), 
	KF VARCHAR2(6), 
	NBS_OB22 CHAR(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SH_TARIF_UPDATE ***
 exec bpa.alter_policies('SH_TARIF_UPDATE');


COMMENT ON TABLE BARS.SH_TARIF_UPDATE IS 'Історія змін пакетів тарифів';
COMMENT ON COLUMN BARS.SH_TARIF_UPDATE.IDUPD IS 'Ідентифікатор зміни';
COMMENT ON COLUMN BARS.SH_TARIF_UPDATE.CHGACTION IS 'Код типу зміни';
COMMENT ON COLUMN BARS.SH_TARIF_UPDATE.CHGDATE IS 'Календарна дата зміни';
COMMENT ON COLUMN BARS.SH_TARIF_UPDATE.GLOBAL_BDATE IS 'Глобальна банківська дата зміни';
COMMENT ON COLUMN BARS.SH_TARIF_UPDATE.EFFECTDATE IS 'Локальна банківська дата зміни';
COMMENT ON COLUMN BARS.SH_TARIF_UPDATE.DONEBY IS 'Ідентифікатор користувача, що виконав зміни';
COMMENT ON COLUMN BARS.SH_TARIF_UPDATE.IDS IS 'Код ПАКЕТА тарифов';
COMMENT ON COLUMN BARS.SH_TARIF_UPDATE.KOD IS 'Код тарифа';
COMMENT ON COLUMN BARS.SH_TARIF_UPDATE.TAR IS 'Тариф';
COMMENT ON COLUMN BARS.SH_TARIF_UPDATE.PR IS '% от суммы документа';
COMMENT ON COLUMN BARS.SH_TARIF_UPDATE.SMIN IS 'Минимальная сумма тарифа';
COMMENT ON COLUMN BARS.SH_TARIF_UPDATE.SMAX IS 'Максимальная сумма тарифа';
COMMENT ON COLUMN BARS.SH_TARIF_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.SH_TARIF_UPDATE.NBS_OB22 IS '';




PROMPT *** Create  constraint CC_SHTARIFUPD_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF_UPDATE MODIFY (GLOBAL_BDATE CONSTRAINT CC_SHTARIFUPD_GLOBALBD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIFUPD_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF_UPDATE MODIFY (CHGDATE CONSTRAINT CC_SHTARIFUPD_CHGDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIFUPD_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF_UPDATE MODIFY (CHGACTION CONSTRAINT CC_SHTARIFUPD_CHGACTION_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIFUPD_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF_UPDATE MODIFY (IDUPD CONSTRAINT CC_SHTARIFUPD_IDUPD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIFUPD_EFFECTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF_UPDATE MODIFY (EFFECTDATE CONSTRAINT CC_SHTARIFUPD_EFFECTDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SHTARIFUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF_UPDATE ADD CONSTRAINT PK_SHTARIFUPD PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIFUPD_IDS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF_UPDATE MODIFY (IDS CONSTRAINT CC_SHTARIFUPD_IDS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIFUPD_KOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF_UPDATE MODIFY (KOD CONSTRAINT CC_SHTARIFUPD_KOD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIFUPD_TAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF_UPDATE MODIFY (TAR CONSTRAINT CC_SHTARIFUPD_TAR_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIFUPD_PR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF_UPDATE MODIFY (PR CONSTRAINT CC_SHTARIFUPD_PR_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIFUPD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF_UPDATE MODIFY (KF CONSTRAINT CC_SHTARIFUPD_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIFUPD_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF_UPDATE MODIFY (DONEBY CONSTRAINT CC_SHTARIFUPD_DONEBY_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_SHTARIFUPD_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_SHTARIFUPD_GLBDT_EFFDT ON BARS.SH_TARIF_UPDATE (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_SHTARIFUPD__IDS_KOD ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_SHTARIFUPD__IDS_KOD ON BARS.SH_TARIF_UPDATE (KF, IDS, KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SHTARIFUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SHTARIFUPD ON BARS.SH_TARIF_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SH_TARIF_UPDATE ***
grant SELECT                                                                 on SH_TARIF_UPDATE to BARSUPL;
grant SELECT                                                                 on SH_TARIF_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SH_TARIF_UPDATE to START1;
grant SELECT                                                                 on SH_TARIF_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SH_TARIF_UPDATE.sql =========*** End *
PROMPT ===================================================================================== 
