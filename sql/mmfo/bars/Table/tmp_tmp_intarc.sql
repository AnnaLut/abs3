

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_TMP_INTARC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_TMP_INTARC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_TMP_INTARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_TMP_INTARC 
   (	ID NUMBER(1,0), 
	ACC NUMBER(38,0), 
	NBS CHAR(4), 
	LCV CHAR(3), 
	NLS VARCHAR2(15), 
	FDAT DATE, 
	TDAT DATE, 
	IR NUMBER(20,4), 
	BR NUMBER, 
	OSTS NUMBER(24,0), 
	ACRD NUMBER(24,0), 
	NMS VARCHAR2(70), 
	OSTC NUMBER(24,0), 
	KV NUMBER(3,0), 
	USERID NUMBER(38,0), 
	BDAT DATE, 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_TMP_INTARC ***
 exec bpa.alter_policies('TMP_TMP_INTARC');


COMMENT ON TABLE BARS.TMP_TMP_INTARC IS '';
COMMENT ON COLUMN BARS.TMP_TMP_INTARC.ID IS '';
COMMENT ON COLUMN BARS.TMP_TMP_INTARC.ACC IS '';
COMMENT ON COLUMN BARS.TMP_TMP_INTARC.NBS IS '';
COMMENT ON COLUMN BARS.TMP_TMP_INTARC.LCV IS '';
COMMENT ON COLUMN BARS.TMP_TMP_INTARC.NLS IS '';
COMMENT ON COLUMN BARS.TMP_TMP_INTARC.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_TMP_INTARC.TDAT IS '';
COMMENT ON COLUMN BARS.TMP_TMP_INTARC.IR IS '';
COMMENT ON COLUMN BARS.TMP_TMP_INTARC.BR IS '';
COMMENT ON COLUMN BARS.TMP_TMP_INTARC.OSTS IS '';
COMMENT ON COLUMN BARS.TMP_TMP_INTARC.ACRD IS '';
COMMENT ON COLUMN BARS.TMP_TMP_INTARC.NMS IS '';
COMMENT ON COLUMN BARS.TMP_TMP_INTARC.OSTC IS '';
COMMENT ON COLUMN BARS.TMP_TMP_INTARC.KV IS '';
COMMENT ON COLUMN BARS.TMP_TMP_INTARC.USERID IS '';
COMMENT ON COLUMN BARS.TMP_TMP_INTARC.BDAT IS '';
COMMENT ON COLUMN BARS.TMP_TMP_INTARC.KF IS '';




PROMPT *** Create  constraint SYS_C00119316 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMP_INTARC MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119317 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMP_INTARC MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119318 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMP_INTARC MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_TMP_INTARC ***
grant SELECT                                                                 on TMP_TMP_INTARC  to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_TMP_INTARC  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_TMP_INTARC.sql =========*** End **
PROMPT ===================================================================================== 
