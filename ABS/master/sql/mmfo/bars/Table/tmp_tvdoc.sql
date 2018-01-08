

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_TVDOC.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_TVDOC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_TVDOC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_TVDOC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_TVDOC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_TVDOC ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_TVDOC 
   (	ID NUMBER(8,0), 
	FDAT DATE, 
	DATD DATE, 
	ND VARCHAR2(10), 
	VOB NUMBER(2,0), 
	DK CHAR(1), 
	NLSA_R NUMBER(14,0), 
	KVA_R NUMBER(3,0), 
	NLSB_R NUMBER(14,0), 
	KVB_R NUMBER(3,0), 
	MFOA NUMBER(9,0), 
	NLSA NUMBER(14,0), 
	KVA NUMBER(3,0), 
	NAMA VARCHAR2(38), 
	OKPOA VARCHAR2(14), 
	MFOB NUMBER(9,0), 
	NLSB NUMBER(14,0), 
	KVB NUMBER(3,0), 
	NAMB VARCHAR2(38), 
	S NUMBER(16,0), 
	KV NUMBER(3,0), 
	SQ NUMBER(16,0), 
	NAZN VARCHAR2(160), 
	DATP DATE, 
	FA_T_ARM3 VARCHAR2(4), 
	FA_T_ARM2 VARCHAR2(4), 
	FB_T_ARM2 VARCHAR2(4), 
	FB_T_ARM3 VARCHAR2(4), 
	FB_D_ARM3 DATE, 
	OKPOB VARCHAR2(14), 
	REF NUMBER(9,0), 
	REZERV VARCHAR2(77), 
	ID_KLI CHAR(2)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_TVDOC ***
 exec bpa.alter_policies('TMP_TVDOC');


COMMENT ON TABLE BARS.TMP_TVDOC IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.KVA IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.NAMA IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.OKPOA IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.KVB IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.NAMB IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.S IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.KV IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.SQ IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.DATP IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.FA_T_ARM3 IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.FA_T_ARM2 IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.FB_T_ARM2 IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.FB_T_ARM3 IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.FB_D_ARM3 IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.OKPOB IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.REF IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.REZERV IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.ID_KLI IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.ID IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.DATD IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.ND IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.VOB IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.DK IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.NLSA_R IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.KVA_R IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.NLSB_R IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.KVB_R IS '';
COMMENT ON COLUMN BARS.TMP_TVDOC.MFOA IS '';



PROMPT *** Create  grants  TMP_TVDOC ***
grant SELECT                                                                 on TMP_TVDOC       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_TVDOC       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_TVDOC       to START1;
grant SELECT                                                                 on TMP_TVDOC       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_TVDOC.sql =========*** End *** ===
PROMPT ===================================================================================== 
