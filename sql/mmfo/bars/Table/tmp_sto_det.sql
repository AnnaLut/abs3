

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_STO_DET.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_STO_DET ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_STO_DET ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_STO_DET 
   (	IDS NUMBER(*,0), 
	VOB NUMBER(*,0), 
	DK NUMBER(*,0), 
	TT CHAR(3), 
	NLSA VARCHAR2(15), 
	KVA NUMBER(*,0), 
	NLSB VARCHAR2(15), 
	KVB NUMBER(*,0), 
	MFOB VARCHAR2(12), 
	POLU VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	FSUM VARCHAR2(100), 
	OKPO VARCHAR2(10), 
	DAT1 DATE, 
	DAT2 DATE, 
	FREQ NUMBER, 
	DAT0 DATE, 
	WEND NUMBER(*,0), 
	STMP DATE, 
	IDD NUMBER(*,0), 
	ORD NUMBER(38,0), 
	KF VARCHAR2(6), 
	DR VARCHAR2(9), 
	BRANCH VARCHAR2(30), 
	USERID_MADE NUMBER, 
	BRANCH_MADE VARCHAR2(30), 
	DATETIMESTAMP TIMESTAMP (6), 
	BRANCH_CARD VARCHAR2(30), 
	USERID NUMBER, 
	STATUS_ID NUMBER(*,0), 
	DISCLAIM_ID NUMBER(*,0), 
	STATUS_DATE DATE, 
	STATUS_UID NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_STO_DET ***
 exec bpa.alter_policies('TMP_STO_DET');


COMMENT ON TABLE BARS.TMP_STO_DET IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.IDS IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.VOB IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.DK IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.TT IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.KVA IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.KVB IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.POLU IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.FSUM IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.DAT1 IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.DAT2 IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.FREQ IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.DAT0 IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.WEND IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.STMP IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.IDD IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.ORD IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.KF IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.DR IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.USERID_MADE IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.BRANCH_MADE IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.DATETIMESTAMP IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.BRANCH_CARD IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.USERID IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.STATUS_ID IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.DISCLAIM_ID IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.STATUS_DATE IS '';
COMMENT ON COLUMN BARS.TMP_STO_DET.STATUS_UID IS '';




PROMPT *** Create  constraint SYS_C00132230 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (IDS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132231 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (VOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132232 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (DK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132233 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132234 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (NLSA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132235 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (KVA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132236 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (NLSB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132237 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (KVB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132238 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (MFOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132239 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (POLU NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132240 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (NAZN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132241 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (OKPO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132242 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (DAT1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132243 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (DAT2 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132244 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (FREQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132245 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (WEND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132246 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (IDD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132247 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (ORD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132248 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STO_DET MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_STO_DET ***
grant SELECT                                                                 on TMP_STO_DET     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_STO_DET.sql =========*** End *** =
PROMPT ===================================================================================== 
