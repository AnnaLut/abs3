

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMERW_UPDATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMERW_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMERW_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CUSTOMERW_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CUSTOMERW_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMERW_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMERW_UPDATE 
   (	RNK NUMBER, 
	TAG VARCHAR2(5), 
	VALUE VARCHAR2(500), 
	ISP NUMBER, 
	CHGDATE DATE, 
	CHGACTION NUMBER, 
	DONEBY VARCHAR2(64), 
	IDUPD NUMBER, 
	EFFECTDATE DATE, 
	KF VARCHAR2(6) DEFAULT NULL
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMERW_UPDATE ***
 exec bpa.alter_policies('CUSTOMERW_UPDATE');


COMMENT ON TABLE BARS.CUSTOMERW_UPDATE IS 'История изменения доп. реквизитов клиентов';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.RNK IS 'РНК клиента';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.TAG IS 'Доп. реквизит';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.VALUE IS 'Значение доп. реквизита';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.ISP IS '№ отдела';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.CHGDATE IS 'Дата изменения';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.CHGACTION IS 'Тип изменения';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.DONEBY IS 'Кто изменил';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.IDUPD IS 'Id';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.EFFECTDATE IS 'Банковская датат изменений';




PROMPT *** Create  constraint C_CUSTOMERWUPDATE_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE MODIFY (DONEBY CONSTRAINT C_CUSTOMERWUPDATE_DONEBY_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERWUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE ADD CONSTRAINT CC_CUSTOMERWUPDATE_KF_NN CHECK (KF IS NOT NULL) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUSTOMERWUPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE ADD CONSTRAINT PK_CUSTOMERWUPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERWUPDATE_CHGACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE ADD CONSTRAINT CC_CUSTOMERWUPDATE_CHGACTION CHECK (chgaction in (1,2,3)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_CUSTOMERWUPDATE_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE MODIFY (RNK CONSTRAINT C_CUSTOMERWUPDATE_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_CUSTOMERWUPDATE_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE MODIFY (TAG CONSTRAINT C_CUSTOMERWUPDATE_TAG_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_CUSTOMERWUPDATE_ISP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE MODIFY (ISP CONSTRAINT C_CUSTOMERWUPDATE_ISP_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_CUSTOMERWUPDATE_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE MODIFY (CHGDATE CONSTRAINT C_CUSTOMERWUPDATE_CHGDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_CUSTOMERWUPDATE_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE MODIFY (CHGACTION CONSTRAINT C_CUSTOMERWUPDATE_CHGACTION_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_CUSTOMERWUPDATE_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE MODIFY (IDUPD CONSTRAINT C_CUSTOMERWUPDATE_IDUPD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CUSTOMERWUPD_TAG_VALUE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CUSTOMERWUPD_TAG_VALUE ON BARS.CUSTOMERW_UPDATE (TAG, VALUE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CUSTOMERWUPD_EFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CUSTOMERWUPD_EFFDAT ON BARS.CUSTOMERW_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CUSTOMERWUPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_CUSTOMERWUPD ON BARS.CUSTOMERW_UPDATE (RNK, TAG, ISP, CHGDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERWUPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMERWUPDATE ON BARS.CUSTOMERW_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMERW_UPDATE ***
grant SELECT                                                                 on CUSTOMERW_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on CUSTOMERW_UPDATE to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMERW_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMERW_UPDATE to BARS_DM;
grant SELECT                                                                 on CUSTOMERW_UPDATE to CC_DOC;
grant INSERT,SELECT                                                          on CUSTOMERW_UPDATE to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMERW_UPDATE to CUSTOMERW;
grant SELECT                                                                 on CUSTOMERW_UPDATE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMERW_UPDATE to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CUSTOMERW_UPDATE to WR_REFREAD;



PROMPT *** Create SYNONYM  to CUSTOMERW_UPDATE ***

  CREATE OR REPLACE PUBLIC SYNONYM CUSTOMERW_UPDATE FOR BARS.CUSTOMERW_UPDATE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMERW_UPDATE.sql =========*** End 
PROMPT ===================================================================================== 
