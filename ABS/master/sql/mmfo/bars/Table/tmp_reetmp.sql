

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REETMP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REETMP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REETMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REETMP 
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




PROMPT *** ALTER_POLICIES to TMP_REETMP ***
 exec bpa.alter_policies('TMP_REETMP');


COMMENT ON TABLE BARS.TMP_REETMP IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.MFO IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.ID_A IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.RT IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.OT IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.ODAT IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.NLS IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.PRZ IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.KV IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.C_AG IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.NMK IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.NMKW IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.C_REG IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.C_DST IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.ID_O IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.SIGN IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.FN_I IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.DAT_I IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.REC_I IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.FN_O IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.DAT_O IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.REC_O IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.ERRK IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.REC IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.OTM IS '';
COMMENT ON COLUMN BARS.TMP_REETMP.KF IS '';




PROMPT *** Create  constraint SYS_C00138279 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REETMP MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REETMP ***
grant SELECT                                                                 on TMP_REETMP      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REETMP.sql =========*** End *** ==
PROMPT ===================================================================================== 
