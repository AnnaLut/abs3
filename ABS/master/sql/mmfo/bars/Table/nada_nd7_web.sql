

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NADA_ND7_WEB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NADA_ND7_WEB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NADA_ND7_WEB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NADA_ND7_WEB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NADA_ND7_WEB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NADA_ND7_WEB ***
begin 
  execute immediate '
  CREATE TABLE BARS.NADA_ND7_WEB 
   (	ROW_NUM NUMBER(38,0), 
	NLS VARCHAR2(17), 
	RNK NUMBER(38,0), 
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
	COUNT_DAY NUMBER(38,0), 
	SUMG NUMBER, 
	SUM_RATN NUMBER, 
	POG_OSTC NUMBER, 
	SG_OSTC NUMBER, 
	SG_RATN NUMBER, 
	SGQ_RATN NUMBER, 
	OSTC_KL NUMBER, 
	DAT_POG NUMBER(38,0), 
	TOBO VARCHAR2(30), 
	USERID NUMBER(10,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NADA_ND7_WEB ***
 exec bpa.alter_policies('NADA_ND7_WEB');


COMMENT ON TABLE BARS.NADA_ND7_WEB IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.ROW_NUM IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.NLS IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.RNK IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.KV IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.NBS IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.NAME IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.CC_ID IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.S IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.S_OSTC IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.VIDD IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.SDATE IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.WDATE IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.RATN IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.IN_DAT IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.OUT_DAT IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.COUNT_DAY IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.SUMG IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.SUM_RATN IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.POG_OSTC IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.SG_OSTC IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.SG_RATN IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.SGQ_RATN IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.OSTC_KL IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.DAT_POG IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.TOBO IS '';
COMMENT ON COLUMN BARS.NADA_ND7_WEB.USERID IS '';



PROMPT *** Create  grants  NADA_ND7_WEB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NADA_ND7_WEB    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NADA_ND7_WEB.sql =========*** End *** 
PROMPT ===================================================================================== 
