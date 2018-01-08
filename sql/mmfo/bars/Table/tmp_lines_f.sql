

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_LINES_F.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_LINES_F ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_LINES_F ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_LINES_F 
   (	FN VARCHAR2(30), 
	DAT DATE, 
	N NUMBER, 
	MFO VARCHAR2(9), 
	OKPO VARCHAR2(14), 
	RTYPE NUMBER(1,0), 
	OTYPE NUMBER(1,0), 
	ODATE DATE, 
	NLS VARCHAR2(14), 
	NLSM NUMBER(1,0), 
	KV NUMBER(3,0), 
	RESID NUMBER(1,0), 
	NMKK VARCHAR2(38), 
	C_REG NUMBER(2,0), 
	NTAX NUMBER(2,0), 
	ID_O VARCHAR2(6), 
	SIGN RAW(64), 
	ERR VARCHAR2(4), 
	DAT_IN_DPA DATE, 
	DAT_ACC_DPA DATE, 
	ID_PR NUMBER(2,0), 
	ID_DPA NUMBER(2,0), 
	ID_DPS NUMBER(2,0), 
	ID_REC VARCHAR2(24), 
	FN_R VARCHAR2(30), 
	DATE_R DATE, 
	N_R NUMBER(6,0), 
	KF VARCHAR2(6), 
	ADR VARCHAR2(80)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_LINES_F ***
 exec bpa.alter_policies('TMP_LINES_F');


COMMENT ON TABLE BARS.TMP_LINES_F IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.FN IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.DAT IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.N IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.MFO IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.RTYPE IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.OTYPE IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.ODATE IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.NLS IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.NLSM IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.KV IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.RESID IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.NMKK IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.C_REG IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.NTAX IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.ID_O IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.SIGN IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.ERR IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.DAT_IN_DPA IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.DAT_ACC_DPA IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.ID_PR IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.ID_DPA IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.ID_DPS IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.ID_REC IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.FN_R IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.DATE_R IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.N_R IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.KF IS '';
COMMENT ON COLUMN BARS.TMP_LINES_F.ADR IS '';




PROMPT *** Create  constraint SYS_C00132413 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_LINES_F MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_LINES_F ***
grant SELECT                                                                 on TMP_LINES_F     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_LINES_F.sql =========*** End *** =
PROMPT ===================================================================================== 
