

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_LINES_R.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_LINES_R ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_LINES_R ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_LINES_R 
   (	FN VARCHAR2(30), 
	DAT DATE, 
	N NUMBER, 
	MFO VARCHAR2(6), 
	BANK_OKPO VARCHAR2(8), 
	OKPO VARCHAR2(14), 
	RTYPE NUMBER(1,0), 
	NMKK VARCHAR2(38), 
	ODATE DATE, 
	NLS VARCHAR2(14), 
	KV NUMBER(3,0), 
	RESID NUMBER(1,0), 
	DAT_IN_DPA DATE, 
	DAT_ACC_DPA DATE, 
	ID_PR NUMBER(2,0), 
	ID_DPA NUMBER(2,0), 
	ID_DPS NUMBER(2,0), 
	ID_REC VARCHAR2(24), 
	FN_F VARCHAR2(30), 
	N_F NUMBER(6,0), 
	ERR VARCHAR2(4), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_LINES_R ***
 exec bpa.alter_policies('TMP_LINES_R');


COMMENT ON TABLE BARS.TMP_LINES_R IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.FN IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.DAT IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.N IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.MFO IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.BANK_OKPO IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.RTYPE IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.NMKK IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.ODATE IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.NLS IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.KV IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.RESID IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.DAT_IN_DPA IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.DAT_ACC_DPA IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.ID_PR IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.ID_DPA IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.ID_DPS IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.ID_REC IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.FN_F IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.N_F IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.ERR IS '';
COMMENT ON COLUMN BARS.TMP_LINES_R.KF IS '';




PROMPT *** Create  constraint SYS_C00132416 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_LINES_R MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_LINES_R ***
grant SELECT                                                                 on TMP_LINES_R     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_LINES_R.sql =========*** End *** =
PROMPT ===================================================================================== 
