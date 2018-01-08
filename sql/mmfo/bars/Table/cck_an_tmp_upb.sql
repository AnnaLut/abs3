

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_AN_TMP_UPB.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_AN_TMP_UPB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_AN_TMP_UPB ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.CCK_AN_TMP_UPB 
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
	TOBO VARCHAR2(30)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_AN_TMP_UPB ***
 exec bpa.alter_policies('CCK_AN_TMP_UPB');


COMMENT ON TABLE BARS.CCK_AN_TMP_UPB IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.ROW_NUM IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.NLS IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.RNK IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.KV IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.NBS IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.NAME IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.CC_ID IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.S IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.S_OSTC IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.VIDD IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.SDATE IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.WDATE IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.RATN IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.IN_DAT IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.OUT_DAT IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.COUNT_DAY IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.SUMG IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.SUM_RATN IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.POG_OSTC IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.SG_OSTC IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.SG_RATN IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.SGQ_RATN IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.OSTC_KL IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.DAT_POG IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP_UPB.TOBO IS '';



PROMPT *** Create  grants  CCK_AN_TMP_UPB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_AN_TMP_UPB  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_AN_TMP_UPB  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_AN_TMP_UPB  to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_AN_TMP_UPB  to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_AN_TMP_UPB  to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to CCK_AN_TMP_UPB ***

  CREATE OR REPLACE SYNONYM BARS.S_ARJK_DATF FOR BARS.CCK_AN_TMP_UPB;


PROMPT *** Create SYNONYM  to CCK_AN_TMP_UPB ***

  CREATE OR REPLACE PUBLIC SYNONYM CCK_AN_TMP_UPB FOR BARS.CCK_AN_TMP_UPB;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_AN_TMP_UPB.sql =========*** End **
PROMPT ===================================================================================== 
