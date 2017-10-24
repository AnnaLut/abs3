

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_V_UNIQUE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_V_UNIQUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_V_UNIQUE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_V_UNIQUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_V_UNIQUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_V_UNIQUE ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_V_UNIQUE 
   (	MFOA VARCHAR2(12), 
	NLSA VARCHAR2(15), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(15), 
	DK NUMBER, 
	S NUMBER(24,0), 
	VOB NUMBER, 
	ND CHAR(10), 
	KV NUMBER, 
	DATP DATE, 
	REF_A VARCHAR2(9), 
	FN_A VARCHAR2(12), 
	REC_A NUMBER, 
	FN_B VARCHAR2(12), 
	REC_B NUMBER, 
	OTM CHAR(1)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_V_UNIQUE ***
 exec bpa.alter_policies('TMP_V_UNIQUE');


COMMENT ON TABLE BARS.TMP_V_UNIQUE IS '';
COMMENT ON COLUMN BARS.TMP_V_UNIQUE.FN_A IS '';
COMMENT ON COLUMN BARS.TMP_V_UNIQUE.REC_A IS '';
COMMENT ON COLUMN BARS.TMP_V_UNIQUE.FN_B IS '';
COMMENT ON COLUMN BARS.TMP_V_UNIQUE.REC_B IS '';
COMMENT ON COLUMN BARS.TMP_V_UNIQUE.OTM IS '';
COMMENT ON COLUMN BARS.TMP_V_UNIQUE.MFOA IS '';
COMMENT ON COLUMN BARS.TMP_V_UNIQUE.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_V_UNIQUE.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_V_UNIQUE.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_V_UNIQUE.DK IS '';
COMMENT ON COLUMN BARS.TMP_V_UNIQUE.S IS '';
COMMENT ON COLUMN BARS.TMP_V_UNIQUE.VOB IS '';
COMMENT ON COLUMN BARS.TMP_V_UNIQUE.ND IS '';
COMMENT ON COLUMN BARS.TMP_V_UNIQUE.KV IS '';
COMMENT ON COLUMN BARS.TMP_V_UNIQUE.DATP IS '';
COMMENT ON COLUMN BARS.TMP_V_UNIQUE.REF_A IS '';



PROMPT *** Create  grants  TMP_V_UNIQUE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_V_UNIQUE    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_V_UNIQUE    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_V_UNIQUE.sql =========*** End *** 
PROMPT ===================================================================================== 
