

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DAY_DOCS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DAY_DOCS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_DAY_DOCS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_DAY_DOCS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_DAY_DOCS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DAY_DOCS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_DAY_DOCS 
   (	DATEFROM DATE, 
	DATETO DATE, 
	OTD_ID NUMBER, 
	OTD_NAME VARCHAR2(70), 
	USERID NUMBER, 
	FIO VARCHAR2(70), 
	VAL_ISO NUMBER, 
	VAL_NAME VARCHAR2(30), 
	TT_ID VARCHAR2(3), 
	TT_NAME VARCHAR2(70), 
	CNT_PROV NUMBER, 
	CNT_DOCS NUMBER, 
	SUM_NOM NUMBER, 
	SUM_EQV NUMBER, 
	REF NUMBER, 
	ND VARCHAR2(10), 
	DK NUMBER, 
	FDAT DATE, 
	NLSA VARCHAR2(14), 
	NLSB VARCHAR2(14), 
	NAZN VARCHAR2(160)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DAY_DOCS ***
 exec bpa.alter_policies('TMP_DAY_DOCS');


COMMENT ON TABLE BARS.TMP_DAY_DOCS IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.DATEFROM IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.DATETO IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.OTD_ID IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.OTD_NAME IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.USERID IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.FIO IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.VAL_ISO IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.VAL_NAME IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.TT_ID IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.TT_NAME IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.CNT_PROV IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.CNT_DOCS IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.SUM_NOM IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.SUM_EQV IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.REF IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.ND IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.DK IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_DAY_DOCS.NAZN IS '';



PROMPT *** Create  grants  TMP_DAY_DOCS ***
grant SELECT                                                                 on TMP_DAY_DOCS    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_DAY_DOCS    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_DAY_DOCS    to START1;
grant SELECT                                                                 on TMP_DAY_DOCS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DAY_DOCS.sql =========*** End *** 
PROMPT ===================================================================================== 
