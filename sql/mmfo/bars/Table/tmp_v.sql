

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_V.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_V ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_V ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_V 
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
	OTM CHAR(1), 
	O NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_V ***
 exec bpa.alter_policies('TMP_V');


COMMENT ON TABLE BARS.TMP_V IS '';
COMMENT ON COLUMN BARS.TMP_V.MFOA IS '';
COMMENT ON COLUMN BARS.TMP_V.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_V.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_V.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_V.DK IS '';
COMMENT ON COLUMN BARS.TMP_V.S IS '';
COMMENT ON COLUMN BARS.TMP_V.VOB IS '';
COMMENT ON COLUMN BARS.TMP_V.ND IS '';
COMMENT ON COLUMN BARS.TMP_V.KV IS '';
COMMENT ON COLUMN BARS.TMP_V.DATP IS '';
COMMENT ON COLUMN BARS.TMP_V.REF_A IS '';
COMMENT ON COLUMN BARS.TMP_V.FN_A IS '';
COMMENT ON COLUMN BARS.TMP_V.REC_A IS '';
COMMENT ON COLUMN BARS.TMP_V.FN_B IS '';
COMMENT ON COLUMN BARS.TMP_V.REC_B IS '';
COMMENT ON COLUMN BARS.TMP_V.OTM IS '';
COMMENT ON COLUMN BARS.TMP_V.O IS '';



PROMPT *** Create  grants  TMP_V ***
grant SELECT                                                                 on TMP_V           to BARSREADER_ROLE;
grant INSERT                                                                 on TMP_V           to BARS_ACCESS_DEFROLE;
grant INSERT                                                                 on TMP_V           to TOSS;
grant SELECT                                                                 on TMP_V           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_V           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_V.sql =========*** End *** =======
PROMPT ===================================================================================== 
