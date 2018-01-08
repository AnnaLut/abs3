

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DPT_RPT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DPT_RPT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_DPT_RPT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_DPT_RPT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_DPT_RPT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DPT_RPT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DPT_RPT 
   (	ID NUMBER, 
	KOD NUMBER, 
	DAT DATE, 
	DEPOSIT_ID NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	KV_NAME VARCHAR2(35), 
	VIDD NUMBER, 
	TYPE_NAME VARCHAR2(50), 
	TT CHAR(3), 
	REF NUMBER, 
	OST NUMBER, 
	S_K NUMBER, 
	S_D NUMBER, 
	VDAT DATE, 
	USERID NUMBER, 
	FIO VARCHAR2(60), 
	NAZN VARCHAR2(160)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DPT_RPT ***
 exec bpa.alter_policies('TMP_DPT_RPT');


COMMENT ON TABLE BARS.TMP_DPT_RPT IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.ID IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.KOD IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.DAT IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.DEPOSIT_ID IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.NLS IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.KV IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.KV_NAME IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.VIDD IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.TYPE_NAME IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.TT IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.REF IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.OST IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.S_K IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.S_D IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.VDAT IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.USERID IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.FIO IS '';
COMMENT ON COLUMN BARS.TMP_DPT_RPT.NAZN IS '';



PROMPT *** Create  grants  TMP_DPT_RPT ***
grant SELECT                                                                 on TMP_DPT_RPT     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_DPT_RPT     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_DPT_RPT     to START1;
grant SELECT                                                                 on TMP_DPT_RPT     to UPLD;



PROMPT *** Create SYNONYM  to TMP_DPT_RPT ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_DPT_RPT FOR BARS.TMP_DPT_RPT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DPT_RPT.sql =========*** End *** =
PROMPT ===================================================================================== 
