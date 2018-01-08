

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_INT_ACCN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_INT_ACCN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_INT_ACCN ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_INT_ACCN 
   (	ACC NUMBER(38,0), 
	ID NUMBER, 
	METR NUMBER, 
	BASEM NUMBER(*,0), 
	BASEY NUMBER(*,0), 
	FREQ NUMBER(3,0), 
	STP_DAT DATE, 
	ACR_DAT DATE, 
	APL_DAT DATE, 
	TT CHAR(3), 
	ACRA NUMBER(38,0), 
	ACRB NUMBER(38,0), 
	S NUMBER, 
	TTB CHAR(3), 
	KVB NUMBER(3,0), 
	NLSB VARCHAR2(15), 
	MFOB VARCHAR2(12), 
	NAMB VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	IO NUMBER(1,0), 
	IDU NUMBER, 
	IDR NUMBER(*,0), 
	KF VARCHAR2(6), 
	OKPO VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_INT_ACCN ***
 exec bpa.alter_policies('TMP_INT_ACCN');


COMMENT ON TABLE BARS.TMP_INT_ACCN IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.ACC IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.ID IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.METR IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.BASEM IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.BASEY IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.FREQ IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.STP_DAT IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.ACR_DAT IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.APL_DAT IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.TT IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.ACRA IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.ACRB IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.S IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.TTB IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.KVB IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.NAMB IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.IO IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.IDU IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.IDR IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.KF IS '';
COMMENT ON COLUMN BARS.TMP_INT_ACCN.OKPO IS '';




PROMPT *** Create  constraint SYS_C00127924 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_ACCN MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00127925 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_ACCN MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00127926 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_ACCN MODIFY (METR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00127927 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_ACCN MODIFY (BASEY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00127928 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_ACCN MODIFY (FREQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00127929 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_ACCN MODIFY (ACR_DAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00127930 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_ACCN MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00127931 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_ACCN MODIFY (S NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00127932 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_ACCN MODIFY (IO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00127933 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_ACCN MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_INT_ACCN ***
grant SELECT                                                                 on TMP_INT_ACCN    to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_INT_ACCN    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_INT_ACCN.sql =========*** End *** 
PROMPT ===================================================================================== 
