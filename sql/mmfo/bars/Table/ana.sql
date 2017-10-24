

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANA.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANA ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANA 
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




PROMPT *** ALTER_POLICIES to ANA ***
 exec bpa.alter_policies('ANA');


COMMENT ON TABLE BARS.ANA IS '';
COMMENT ON COLUMN BARS.ANA.REC IS '';
COMMENT ON COLUMN BARS.ANA.REF IS '';
COMMENT ON COLUMN BARS.ANA.MFOA IS '';
COMMENT ON COLUMN BARS.ANA.NLSA IS '';
COMMENT ON COLUMN BARS.ANA.MFOB IS '';
COMMENT ON COLUMN BARS.ANA.NLSB IS '';
COMMENT ON COLUMN BARS.ANA.DK IS '';
COMMENT ON COLUMN BARS.ANA.S IS '';
COMMENT ON COLUMN BARS.ANA.VOB IS '';
COMMENT ON COLUMN BARS.ANA.ND IS '';
COMMENT ON COLUMN BARS.ANA.KV IS '';
COMMENT ON COLUMN BARS.ANA.DATD IS '';
COMMENT ON COLUMN BARS.ANA.DATP IS '';
COMMENT ON COLUMN BARS.ANA.NAM_A IS '';
COMMENT ON COLUMN BARS.ANA.NAM_B IS '';
COMMENT ON COLUMN BARS.ANA.NAZN IS '';
COMMENT ON COLUMN BARS.ANA.NAZNK IS '';
COMMENT ON COLUMN BARS.ANA.NAZNS IS '';
COMMENT ON COLUMN BARS.ANA.ID_A IS '';
COMMENT ON COLUMN BARS.ANA.ID_B IS '';
COMMENT ON COLUMN BARS.ANA.ID_O IS '';
COMMENT ON COLUMN BARS.ANA.REF_A IS '';
COMMENT ON COLUMN BARS.ANA.BIS IS '';
COMMENT ON COLUMN BARS.ANA.SIGN IS '';
COMMENT ON COLUMN BARS.ANA.FN_A IS '';
COMMENT ON COLUMN BARS.ANA.DAT_A IS '';
COMMENT ON COLUMN BARS.ANA.REC_A IS '';
COMMENT ON COLUMN BARS.ANA.FN_B IS '';
COMMENT ON COLUMN BARS.ANA.DAT_B IS '';
COMMENT ON COLUMN BARS.ANA.REC_B IS '';
COMMENT ON COLUMN BARS.ANA.D_REC IS '';
COMMENT ON COLUMN BARS.ANA.BLK IS '';
COMMENT ON COLUMN BARS.ANA.SOS IS '';
COMMENT ON COLUMN BARS.ANA.PRTY IS '';
COMMENT ON COLUMN BARS.ANA.FA_NAME IS '';
COMMENT ON COLUMN BARS.ANA.FA_LN IS '';
COMMENT ON COLUMN BARS.ANA.FA_T_ARM3 IS '';
COMMENT ON COLUMN BARS.ANA.FA_T_ARM2 IS '';
COMMENT ON COLUMN BARS.ANA.FC_NAME IS '';
COMMENT ON COLUMN BARS.ANA.FC_LN IS '';
COMMENT ON COLUMN BARS.ANA.FC_T1_ARM2 IS '';
COMMENT ON COLUMN BARS.ANA.FC_T2_ARM2 IS '';
COMMENT ON COLUMN BARS.ANA.FB_NAME IS '';
COMMENT ON COLUMN BARS.ANA.FB_LN IS '';
COMMENT ON COLUMN BARS.ANA.FB_T_ARM2 IS '';
COMMENT ON COLUMN BARS.ANA.FB_T_ARM3 IS '';
COMMENT ON COLUMN BARS.ANA.FB_D_ARM3 IS '';
COMMENT ON COLUMN BARS.ANA.KF IS '';




PROMPT *** Create  constraint SYS_C005206 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANA MODIFY (REC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005207 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANA MODIFY (MFOA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005218 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANA MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005217 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANA MODIFY (SOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005216 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANA MODIFY (DAT_A NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005215 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANA MODIFY (DATP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005214 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANA MODIFY (DATD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005213 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANA MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005212 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANA MODIFY (VOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005211 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANA MODIFY (DK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005210 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANA MODIFY (NLSB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005209 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANA MODIFY (MFOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005208 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANA MODIFY (NLSA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ANA ***
grant SELECT                                                                 on ANA             to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ANA             to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANA.sql =========*** End *** =========
PROMPT ===================================================================================== 
