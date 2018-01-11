

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_AG1.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_AG1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_AG1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_AG1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_AG1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_AG1 
   (	KV8 NUMBER, 
	CC_ID VARCHAR2(20), 
	SOUR NUMBER, 
	RNK NUMBER, 
	NMK VARCHAR2(38), 
	ND NUMBER, 
	SK8 NUMBER, 
	KV_S NUMBER, 
	NLS VARCHAR2(15), 
	VIDD NUMBER, 
	SZQ8 NUMBER, 
	NLSZ VARCHAR2(15), 
	SZ8 NUMBER, 
	SPQ8 NUMBER, 
	SPPQ8 NUMBER, 
	SSQ8 NUMBER, 
	SDATE DATE, 
	WDATE DATE, 
	IR NUMBER, 
	US NUMBER, 
	DATE3 DATE, 
	DATE4 DATE, 
	DATE5 DATE, 
	ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_AG1 ***
 exec bpa.alter_policies('TMP_AG1');


COMMENT ON TABLE BARS.TMP_AG1 IS '';
COMMENT ON COLUMN BARS.TMP_AG1.KV8 IS '';
COMMENT ON COLUMN BARS.TMP_AG1.CC_ID IS '';
COMMENT ON COLUMN BARS.TMP_AG1.SOUR IS '';
COMMENT ON COLUMN BARS.TMP_AG1.RNK IS '';
COMMENT ON COLUMN BARS.TMP_AG1.NMK IS '';
COMMENT ON COLUMN BARS.TMP_AG1.ND IS '';
COMMENT ON COLUMN BARS.TMP_AG1.SK8 IS '';
COMMENT ON COLUMN BARS.TMP_AG1.KV_S IS '';
COMMENT ON COLUMN BARS.TMP_AG1.NLS IS '';
COMMENT ON COLUMN BARS.TMP_AG1.VIDD IS '';
COMMENT ON COLUMN BARS.TMP_AG1.SZQ8 IS '';
COMMENT ON COLUMN BARS.TMP_AG1.NLSZ IS '';
COMMENT ON COLUMN BARS.TMP_AG1.SZ8 IS '';
COMMENT ON COLUMN BARS.TMP_AG1.SPQ8 IS '';
COMMENT ON COLUMN BARS.TMP_AG1.SPPQ8 IS '';
COMMENT ON COLUMN BARS.TMP_AG1.SSQ8 IS '';
COMMENT ON COLUMN BARS.TMP_AG1.SDATE IS '';
COMMENT ON COLUMN BARS.TMP_AG1.WDATE IS '';
COMMENT ON COLUMN BARS.TMP_AG1.IR IS '';
COMMENT ON COLUMN BARS.TMP_AG1.US IS '';
COMMENT ON COLUMN BARS.TMP_AG1.DATE3 IS '';
COMMENT ON COLUMN BARS.TMP_AG1.DATE4 IS '';
COMMENT ON COLUMN BARS.TMP_AG1.DATE5 IS '';
COMMENT ON COLUMN BARS.TMP_AG1.ID IS '';



PROMPT *** Create  grants  TMP_AG1 ***
grant SELECT                                                                 on TMP_AG1         to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_AG1         to BARS_DM;
grant SELECT                                                                 on TMP_AG1         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_AG1         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_AG1.sql =========*** End *** =====
PROMPT ===================================================================================== 
