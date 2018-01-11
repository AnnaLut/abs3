

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FX_NETTING.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FX_NETTING ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FX_NETTING ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_FX_NETTING 
   (	ROW_NUM NUMBER(*,0), 
	NLS VARCHAR2(17), 
	RNK NUMBER(*,0), 
	KV VARCHAR2(3), 
	NBS CHAR(4), 
	NAME VARCHAR2(100), 
	CC_ID VARCHAR2(20), 
	S NUMBER, 
	S_OSTC NUMBER, 
	VIDD VARCHAR2(50), 
	SDATE DATE, 
	WDATE DATE, 
	RATN NUMBER, 
	IN_DAT DATE, 
	OUT_DAT DATE, 
	COUNT_DAY NUMBER(*,0), 
	SUMG NUMBER, 
	SUM_RATN NUMBER, 
	POG_OSTC NUMBER, 
	SG_OSTC NUMBER, 
	SG_RATN NUMBER, 
	SGQ_RATN NUMBER, 
	OSTC_KL NUMBER, 
	DAT_POG NUMBER(*,0), 
	TOBO VARCHAR2(30), 
	USERID NUMBER DEFAULT sys_context(''bars_global'',''user_id'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FX_NETTING ***
 exec bpa.alter_policies('TMP_FX_NETTING');


COMMENT ON TABLE BARS.TMP_FX_NETTING IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.ROW_NUM IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.NLS IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.RNK IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.KV IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.NBS IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.NAME IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.CC_ID IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.S IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.S_OSTC IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.VIDD IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.SDATE IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.WDATE IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.RATN IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.IN_DAT IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.OUT_DAT IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.COUNT_DAY IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.SUMG IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.SUM_RATN IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.POG_OSTC IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.SG_OSTC IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.SG_RATN IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.SGQ_RATN IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.OSTC_KL IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.DAT_POG IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.TOBO IS '';
COMMENT ON COLUMN BARS.TMP_FX_NETTING.USERID IS '';



PROMPT *** Create  grants  TMP_FX_NETTING ***
grant SELECT                                                                 on TMP_FX_NETTING  to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_FX_NETTING  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FX_NETTING.sql =========*** End **
PROMPT ===================================================================================== 
