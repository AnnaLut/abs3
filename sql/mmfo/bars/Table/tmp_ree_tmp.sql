

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REE_TMP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REE_TMP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REE_TMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REE_TMP 
   (	MFO VARCHAR2(12), 
	ID_A VARCHAR2(14), 
	RT CHAR(1), 
	OT CHAR(1), 
	ODAT DATE, 
	NLS VARCHAR2(15), 
	PRZ CHAR(1), 
	KV NUMBER(38,0), 
	C_AG CHAR(1), 
	NMK VARCHAR2(38), 
	NMKW VARCHAR2(38), 
	C_REG NUMBER(38,0), 
	C_DST NUMBER(38,0), 
	ID_O VARCHAR2(6), 
	SIGN RAW(128), 
	FN_I VARCHAR2(12), 
	DAT_I DATE, 
	REC_I NUMBER(38,0), 
	FN_O VARCHAR2(30), 
	DAT_O DATE, 
	REC_O NUMBER(38,0), 
	ERRK NUMBER(38,0), 
	REC NUMBER(38,0), 
	OTM NUMBER(38,0), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REE_TMP ***
 exec bpa.alter_policies('TMP_REE_TMP');


COMMENT ON TABLE BARS.TMP_REE_TMP IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.REC_I IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.FN_O IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.DAT_O IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.REC_O IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.ERRK IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.REC IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.OTM IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.KF IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.MFO IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.ID_A IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.RT IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.OT IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.ODAT IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.NLS IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.PRZ IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.KV IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.C_AG IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.NMK IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.NMKW IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.C_REG IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.C_DST IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.ID_O IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.SIGN IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.FN_I IS '';
COMMENT ON COLUMN BARS.TMP_REE_TMP.DAT_I IS '';




PROMPT *** Create  constraint SYS_C00132693 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REE_TMP MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REE_TMP ***
grant SELECT                                                                 on TMP_REE_TMP     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REE_TMP.sql =========*** End *** =
PROMPT ===================================================================================== 
