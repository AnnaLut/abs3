

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_SOB_UPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_SOB_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_SOB_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_SOB_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_SOB_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_SOB_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_SOB_UPDATE 
   (	ND NUMBER(38,0), 
	FDAT DATE, 
	ID NUMBER(38,0), 
	ISP NUMBER(38,0), 
	TXT VARCHAR2(4000), 
	OTM NUMBER(38,0), 
	FREQ NUMBER(38,0), 
	PSYS NUMBER(38,0), 
	CHGDATE DATE, 
	CHGACTION NUMBER, 
	DONEBY VARCHAR2(64), 
	IDUPD NUMBER, 
	KF VARCHAR2(6) DEFAULT NULL, 
	FACT_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_SOB_UPDATE ***
 exec bpa.alter_policies('CC_SOB_UPDATE');


COMMENT ON TABLE BARS.CC_SOB_UPDATE IS '';
COMMENT ON COLUMN BARS.CC_SOB_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.CC_SOB_UPDATE.FDAT IS '';
COMMENT ON COLUMN BARS.CC_SOB_UPDATE.ID IS '';
COMMENT ON COLUMN BARS.CC_SOB_UPDATE.ISP IS '';
COMMENT ON COLUMN BARS.CC_SOB_UPDATE.TXT IS '';
COMMENT ON COLUMN BARS.CC_SOB_UPDATE.OTM IS '';
COMMENT ON COLUMN BARS.CC_SOB_UPDATE.FREQ IS '';
COMMENT ON COLUMN BARS.CC_SOB_UPDATE.PSYS IS '';
COMMENT ON COLUMN BARS.CC_SOB_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.CC_SOB_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.CC_SOB_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.CC_SOB_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.CC_SOB_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CC_SOB_UPDATE.FACT_DATE IS 'ƒата фактического исполнени€ событи€';




PROMPT *** Create  constraint C_CC_SOBUPDATE_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB_UPDATE MODIFY (IDUPD CONSTRAINT C_CC_SOBUPDATE_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_CC_SOBUPDATE_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB_UPDATE MODIFY (DONEBY CONSTRAINT C_CC_SOBUPDATE_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CC_SOBUPDATE_CHGACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB_UPDATE ADD CONSTRAINT CC_CC_SOBUPDATE_CHGACTION CHECK (chgaction in (1,2,3)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOBUPDTXT_UPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB_UPDATE MODIFY (KF CONSTRAINT CC_SOBUPDTXT_UPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_CC_SOBUPDATE_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB_UPDATE MODIFY (CHGACTION CONSTRAINT C_CC_SOBUPDATE_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_SOB_UPDATE_FDAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB_UPDATE MODIFY (FDAT CONSTRAINT NK_CC_SOB_UPDATE_FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_SOB_UPDATE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB_UPDATE MODIFY (ID CONSTRAINT NK_CC_SOB_UPDATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_SOB_UPDATE_ISP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB_UPDATE MODIFY (ISP CONSTRAINT NK_CC_SOB_UPDATE_ISP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_CC_SOBUPDATE_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB_UPDATE MODIFY (CHGDATE CONSTRAINT C_CC_SOBUPDATE_CHGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_SOB_UPDATE_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB_UPDATE MODIFY (ND CONSTRAINT NK_CC_SOB_UPDATE_ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CC_SOBUPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CC_SOBUPDATE ON BARS.CC_SOB_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_CC_SOB_UPDATE_ND ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_CC_SOB_UPDATE_ND ON BARS.CC_SOB_UPDATE (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_SOB_UPDATE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_SOB_UPDATE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_SOB_UPDATE   to BARS_DM;
grant SELECT                                                                 on CC_SOB_UPDATE   to CC_DOC;
grant INSERT,SELECT                                                          on CC_SOB_UPDATE   to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_SOB_UPDATE   to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_SOB_UPDATE   to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to CC_SOB_UPDATE ***

  CREATE OR REPLACE PUBLIC SYNONYM CC_SOB_UPDATE FOR BARS.CC_SOB_UPDATE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_SOB_UPDATE.sql =========*** End ***
PROMPT ===================================================================================== 
