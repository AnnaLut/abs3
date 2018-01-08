

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OB23_K11.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OB23_K11 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OB23_K11 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OB23_K11 
   (	DAT DATE, 
	USERID NUMBER, 
	ACCS NUMBER, 
	ACCZ NUMBER, 
	PAWN NUMBER, 
	S NUMBER, 
	PROC NUMBER, 
	SALL NUMBER, 
	ND NUMBER, 
	DAY_IMP NUMBER(*,0), 
	KV NUMBER(3,0), 
	GRP NUMBER, 
	ZPR NUMBER, 
	ZPRQ NUMBER, 
	S031 VARCHAR2(2), 
	PVZ NUMBER, 
	PVZQ NUMBER, 
	SQ NUMBER, 
	SALLQ NUMBER, 
	DAT_P DATE, 
	IRR0 NUMBER, 
	S_L NUMBER, 
	SQ_L NUMBER, 
	SUM_IMP NUMBER, 
	SUMQ_IMP NUMBER, 
	PV NUMBER, 
	K NUMBER, 
	PR_IMP NUMBER, 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OB23_K11 ***
 exec bpa.alter_policies('TMP_OB23_K11');


COMMENT ON TABLE BARS.TMP_OB23_K11 IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.DAT IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.USERID IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.ACCS IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.ACCZ IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.PAWN IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.S IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.PROC IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.SALL IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.ND IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.DAY_IMP IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.KV IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.GRP IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.ZPR IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.ZPRQ IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.S031 IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.PVZ IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.PVZQ IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.SQ IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.SALLQ IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.DAT_P IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.IRR0 IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.S_L IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.SQ_L IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.SUM_IMP IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.SUMQ_IMP IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.PV IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.K IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.PR_IMP IS '';
COMMENT ON COLUMN BARS.TMP_OB23_K11.KF IS '';




PROMPT *** Create  constraint SYS_C0031763 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OB23_K11 MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OB23_K11.sql =========*** End *** 
PROMPT ===================================================================================== 
