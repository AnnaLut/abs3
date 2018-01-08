

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ND_TXT_UPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ND_TXT_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ND_TXT_UPDATE'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''ND_TXT_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ND_TXT_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ND_TXT_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ND_TXT_UPDATE 
   (	ND NUMBER, 
	TAG VARCHAR2(8), 
	TXT VARCHAR2(4000), 
	CHGDATE DATE, 
	CHGACTION NUMBER, 
	DONEBY VARCHAR2(64), 
	IDUPD NUMBER, 
	KF VARCHAR2(6) DEFAULT NULL, 
	EFFECTDATE DATE, 
	GLOBAL_BDATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ND_TXT_UPDATE ***
 exec bpa.alter_policies('ND_TXT_UPDATE');


COMMENT ON TABLE BARS.ND_TXT_UPDATE IS 'История изменения доп.реквизитов КД';
COMMENT ON COLUMN BARS.ND_TXT_UPDATE.ND IS 'Реф.договора';
COMMENT ON COLUMN BARS.ND_TXT_UPDATE.TAG IS 'Доп.реквизит';
COMMENT ON COLUMN BARS.ND_TXT_UPDATE.TXT IS 'Значение доп.реквизита';
COMMENT ON COLUMN BARS.ND_TXT_UPDATE.CHGDATE IS 'Дата изменения';
COMMENT ON COLUMN BARS.ND_TXT_UPDATE.CHGACTION IS 'Тип изменения';
COMMENT ON COLUMN BARS.ND_TXT_UPDATE.DONEBY IS 'Кто изменил';
COMMENT ON COLUMN BARS.ND_TXT_UPDATE.IDUPD IS 'ID';
COMMENT ON COLUMN BARS.ND_TXT_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.ND_TXT_UPDATE.EFFECTDATE IS 'Банковская дата изменения';
COMMENT ON COLUMN BARS.ND_TXT_UPDATE.GLOBAL_BDATE IS 'Глобальная банковская дата изменений';




PROMPT *** Create  constraint CC_ND_TXTUPDATE_CHGACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT_UPDATE ADD CONSTRAINT CC_ND_TXTUPDATE_CHGACTION CHECK (chgaction in (1,2,3)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NDTXTUPDATE_CHGACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT_UPDATE ADD CONSTRAINT CC_NDTXTUPDATE_CHGACTION CHECK (chgaction in (1,2,3)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NDTXTUPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT_UPDATE ADD CONSTRAINT PK_NDTXTUPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_ND_TXTUPDATE_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT_UPDATE MODIFY (ND CONSTRAINT C_ND_TXTUPDATE_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_ND_TXTUPDATE_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT_UPDATE MODIFY (TAG CONSTRAINT C_ND_TXTUPDATE_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_ND_TXTUPDATE_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT_UPDATE MODIFY (CHGDATE CONSTRAINT C_ND_TXTUPDATE_CHGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_ND_TXTUPDATE_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT_UPDATE MODIFY (CHGACTION CONSTRAINT C_ND_TXTUPDATE_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_ND_TXTUPDATE_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT_UPDATE MODIFY (DONEBY CONSTRAINT C_ND_TXTUPDATE_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_ND_TXTUPDATE_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT_UPDATE MODIFY (IDUPD CONSTRAINT C_ND_TXTUPDATE_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NDTXT_UPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT_UPDATE MODIFY (KF CONSTRAINT CC_NDTXT_UPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NDTXTUPDATE_EFFECTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT_UPDATE MODIFY (EFFECTDATE CONSTRAINT CC_NDTXTUPDATE_EFFECTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NDTXTUPD_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT_UPDATE MODIFY (GLOBAL_BDATE CONSTRAINT CC_NDTXTUPD_GLOBALBD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ND_TXTUPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ND_TXTUPDATE ON BARS.ND_TXT_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_NDTXTUPDATE_ND_TAG ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_NDTXTUPDATE_ND_TAG ON BARS.ND_TXT_UPDATE (ND, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_NDTXTUPD_EFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_NDTXTUPD_EFFDAT ON BARS.ND_TXT_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_NDTXTUPD_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_NDTXTUPD_GLBDT_EFFDT ON BARS.ND_TXT_UPDATE (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ND_TXT_UPDATE ***
grant SELECT                                                                 on ND_TXT_UPDATE   to BARSREADER_ROLE;
grant SELECT                                                                 on ND_TXT_UPDATE   to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ND_TXT_UPDATE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ND_TXT_UPDATE   to BARS_DM;
grant SELECT                                                                 on ND_TXT_UPDATE   to CC_DOC;
grant INSERT,SELECT                                                          on ND_TXT_UPDATE   to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on ND_TXT_UPDATE   to RCC_DEAL;
grant SELECT                                                                 on ND_TXT_UPDATE   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ND_TXT_UPDATE   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ND_TXT_UPDATE   to WR_REFREAD;



PROMPT *** Create SYNONYM  to ND_TXT_UPDATE ***

  CREATE OR REPLACE PUBLIC SYNONYM ND_TXT_UPDATE FOR BARS.ND_TXT_UPDATE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ND_TXT_UPDATE.sql =========*** End ***
PROMPT ===================================================================================== 
