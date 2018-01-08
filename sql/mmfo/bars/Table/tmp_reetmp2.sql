

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REETMP2.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REETMP2 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REETMP2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REETMP2 
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




PROMPT *** ALTER_POLICIES to TMP_REETMP2 ***
 exec bpa.alter_policies('TMP_REETMP2');


COMMENT ON TABLE BARS.TMP_REETMP2 IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.MFO IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.ID_A IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.RT IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.OT IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.ODAT IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.NLS IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.PRZ IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.KV IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.C_AG IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.NMK IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.NMKW IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.C_REG IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.C_DST IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.ID_O IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.SIGN IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.FN_I IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.DAT_I IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.REC_I IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.FN_O IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.DAT_O IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.REC_O IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.ERRK IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.REC IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.OTM IS '';
COMMENT ON COLUMN BARS.TMP_REETMP2.KF IS '';




PROMPT *** Create  constraint SYS_C00138280 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REETMP2 MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REETMP2 ***
grant SELECT                                                                 on TMP_REETMP2     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REETMP2.sql =========*** End *** =
PROMPT ===================================================================================== 
