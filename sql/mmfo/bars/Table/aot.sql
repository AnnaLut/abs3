

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AOT.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AOT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AOT ***
begin 
  execute immediate '
  CREATE TABLE BARS.AOT 
   (	REC NUMBER(38,0), 
	REF NUMBER(38,0), 
	MFOA VARCHAR2(12), 
	NLSA VARCHAR2(15), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(15), 
	DK NUMBER(1,0), 
	S NUMBER(24,0), 
	VOB NUMBER(3,0), 
	ND CHAR(10), 
	KV NUMBER(3,0), 
	DATD DATE, 
	DATP DATE, 
	NAM_A VARCHAR2(38), 
	NAM_B VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	NAZNK CHAR(3), 
	NAZNS CHAR(2), 
	ID_A VARCHAR2(14), 
	ID_B VARCHAR2(14), 
	ID_O VARCHAR2(6), 
	REF_A VARCHAR2(9), 
	BIS NUMBER(10,0), 
	SIGN RAW(128), 
	FN_A CHAR(12), 
	DAT_A DATE, 
	REC_A NUMBER(10,0), 
	FN_B CHAR(12), 
	DAT_B DATE, 
	REC_B NUMBER(10,0), 
	D_REC VARCHAR2(80), 
	BLK NUMBER(4,0), 
	SOS NUMBER(1,0), 
	PRTY NUMBER(1,0), 
	FA_NAME VARCHAR2(12), 
	FA_LN NUMBER(10,0), 
	FA_T_ARM3 VARCHAR2(4), 
	FA_T_ARM2 VARCHAR2(4), 
	FC_NAME VARCHAR2(12), 
	FC_LN NUMBER(10,0), 
	FC_T1_ARM2 VARCHAR2(4), 
	FC_T2_ARM2 VARCHAR2(4), 
	FB_NAME VARCHAR2(12), 
	FB_LN NUMBER(10,0), 
	FB_T_ARM2 VARCHAR2(4), 
	FB_T_ARM3 VARCHAR2(4), 
	FB_D_ARM3 DATE, 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AOT ***
 exec bpa.alter_policies('AOT');


COMMENT ON TABLE BARS.AOT IS '';
COMMENT ON COLUMN BARS.AOT.REC IS '';
COMMENT ON COLUMN BARS.AOT.REF IS '';
COMMENT ON COLUMN BARS.AOT.MFOA IS '';
COMMENT ON COLUMN BARS.AOT.NLSA IS '';
COMMENT ON COLUMN BARS.AOT.MFOB IS '';
COMMENT ON COLUMN BARS.AOT.NLSB IS '';
COMMENT ON COLUMN BARS.AOT.DK IS '';
COMMENT ON COLUMN BARS.AOT.S IS '';
COMMENT ON COLUMN BARS.AOT.VOB IS '';
COMMENT ON COLUMN BARS.AOT.ND IS '';
COMMENT ON COLUMN BARS.AOT.KV IS '';
COMMENT ON COLUMN BARS.AOT.DATD IS '';
COMMENT ON COLUMN BARS.AOT.DATP IS '';
COMMENT ON COLUMN BARS.AOT.NAM_A IS '';
COMMENT ON COLUMN BARS.AOT.NAM_B IS '';
COMMENT ON COLUMN BARS.AOT.NAZN IS '';
COMMENT ON COLUMN BARS.AOT.NAZNK IS '';
COMMENT ON COLUMN BARS.AOT.NAZNS IS '';
COMMENT ON COLUMN BARS.AOT.ID_A IS '';
COMMENT ON COLUMN BARS.AOT.ID_B IS '';
COMMENT ON COLUMN BARS.AOT.ID_O IS '';
COMMENT ON COLUMN BARS.AOT.REF_A IS '';
COMMENT ON COLUMN BARS.AOT.BIS IS '';
COMMENT ON COLUMN BARS.AOT.SIGN IS '';
COMMENT ON COLUMN BARS.AOT.FN_A IS '';
COMMENT ON COLUMN BARS.AOT.DAT_A IS '';
COMMENT ON COLUMN BARS.AOT.REC_A IS '';
COMMENT ON COLUMN BARS.AOT.FN_B IS '';
COMMENT ON COLUMN BARS.AOT.DAT_B IS '';
COMMENT ON COLUMN BARS.AOT.REC_B IS '';
COMMENT ON COLUMN BARS.AOT.D_REC IS '';
COMMENT ON COLUMN BARS.AOT.BLK IS '';
COMMENT ON COLUMN BARS.AOT.SOS IS '';
COMMENT ON COLUMN BARS.AOT.PRTY IS '';
COMMENT ON COLUMN BARS.AOT.FA_NAME IS '';
COMMENT ON COLUMN BARS.AOT.FA_LN IS '';
COMMENT ON COLUMN BARS.AOT.FA_T_ARM3 IS '';
COMMENT ON COLUMN BARS.AOT.FA_T_ARM2 IS '';
COMMENT ON COLUMN BARS.AOT.FC_NAME IS '';
COMMENT ON COLUMN BARS.AOT.FC_LN IS '';
COMMENT ON COLUMN BARS.AOT.FC_T1_ARM2 IS '';
COMMENT ON COLUMN BARS.AOT.FC_T2_ARM2 IS '';
COMMENT ON COLUMN BARS.AOT.FB_NAME IS '';
COMMENT ON COLUMN BARS.AOT.FB_LN IS '';
COMMENT ON COLUMN BARS.AOT.FB_T_ARM2 IS '';
COMMENT ON COLUMN BARS.AOT.FB_T_ARM3 IS '';
COMMENT ON COLUMN BARS.AOT.FB_D_ARM3 IS '';
COMMENT ON COLUMN BARS.AOT.KF IS '';




PROMPT *** Create  constraint SYS_C006404 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AOT MODIFY (REC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006405 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AOT MODIFY (MFOA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006406 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AOT MODIFY (NLSA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006407 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AOT MODIFY (MFOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006408 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AOT MODIFY (NLSB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006409 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AOT MODIFY (DK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006410 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AOT MODIFY (VOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006411 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AOT MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006412 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AOT MODIFY (DATD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006413 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AOT MODIFY (DATP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006414 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AOT MODIFY (DAT_A NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006415 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AOT MODIFY (SOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006416 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AOT MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AOT ***
grant SELECT                                                                 on AOT             to BARSREADER_ROLE;
grant SELECT                                                                 on AOT             to BARS_DM;
grant SELECT                                                                 on AOT             to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on AOT             to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AOT.sql =========*** End *** =========
PROMPT ===================================================================================== 
