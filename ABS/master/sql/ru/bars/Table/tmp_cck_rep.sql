

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CCK_REP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CCK_REP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CCK_REP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_CCK_REP 
   (	BRANCH VARCHAR2(30), 
	TT CHAR(3), 
	VOB NUMBER(*,0), 
	VDAT DATE, 
	KV NUMBER(3,0), 
	DK NUMBER(1,0), 
	S NUMBER(22,2), 
	SQ NUMBER(22,2), 
	NAM_A VARCHAR2(38), 
	NLSA VARCHAR2(15), 
	MFOA VARCHAR2(12), 
	NAM_B VARCHAR2(38), 
	NLSB VARCHAR2(15), 
	MFOB VARCHAR2(12), 
	NAZN VARCHAR2(160), 
	S2 NUMBER(22,2), 
	KV2 NUMBER(3,0), 
	SQ2 NUMBER(22,2), 
	ND VARCHAR2(10), 
	CC_ID VARCHAR2(40), 
	SDATE DATE, 
	NMK VARCHAR2(70)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CCK_REP ***
 exec bpa.alter_policies('TMP_CCK_REP');


COMMENT ON TABLE BARS.TMP_CCK_REP IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.TT IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.VOB IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.VDAT IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.KV IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.DK IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.S IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.SQ IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.NAM_A IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.MFOA IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.NAM_B IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.S2 IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.KV2 IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.SQ2 IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.ND IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.CC_ID IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.SDATE IS '';
COMMENT ON COLUMN BARS.TMP_CCK_REP.NMK IS '';



PROMPT *** Create  grants  TMP_CCK_REP ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_CCK_REP     to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_CCK_REP     to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CCK_REP.sql =========*** End *** =
PROMPT ===================================================================================== 
