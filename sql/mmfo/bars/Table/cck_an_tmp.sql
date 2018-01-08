

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_AN_TMP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_AN_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_AN_TMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CCK_AN_TMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CCK_AN_TMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_AN_TMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.CCK_AN_TMP 
   (	DL CHAR(1), 
	NBS CHAR(4), 
	PR NUMBER, 
	PRS NUMBER, 
	SROK NUMBER, 
	KV NUMBER(*,0), 
	N1 NUMBER, 
	N2 NUMBER, 
	N3 NUMBER, 
	NAME VARCHAR2(70), 
	OE NUMBER(*,0), 
	INSIDER NUMBER(*,0), 
	TIP NUMBER(*,0), 
	POROG NUMBER(*,0), 
	N4 NUMBER, 
	N5 NUMBER, 
	REG NUMBER(*,0), 
	ACCL NUMBER(*,0), 
	ACC NUMBER(*,0), 
	ACRA NUMBER(*,0), 
	CC_ID VARCHAR2(20), 
	ZAL NUMBER, 
	ZALQ NUMBER, 
	REZ NUMBER, 
	REZQ NUMBER, 
	UV NUMBER, 
	NLS VARCHAR2(15), 
	AIM NUMBER(*,0), 
	USERID NUMBER, 
	BRANCH VARCHAR2(30), 
	ND NUMBER, 
	NAME1 VARCHAR2(35), 
	NLSALT VARCHAR2(15)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_AN_TMP ***
 exec bpa.alter_policies('CCK_AN_TMP');


COMMENT ON TABLE BARS.CCK_AN_TMP IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.USERID IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.BRANCH IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.ND IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.NAME1 IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.NLSALT IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.DL IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.NBS IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.PR IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.PRS IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.SROK IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.KV IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.N1 IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.N2 IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.N3 IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.NAME IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.OE IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.INSIDER IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.TIP IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.POROG IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.N4 IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.N5 IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.REG IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.ACCL IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.ACC IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.ACRA IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.CC_ID IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.ZAL IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.ZALQ IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.REZ IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.REZQ IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.UV IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.NLS IS '';
COMMENT ON COLUMN BARS.CCK_AN_TMP.AIM IS '';



PROMPT *** Create  grants  CCK_AN_TMP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_AN_TMP      to AN_KL;
grant SELECT                                                                 on CCK_AN_TMP      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_AN_TMP      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_AN_TMP      to BARS_DM;
grant DELETE,INSERT                                                          on CCK_AN_TMP      to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_AN_TMP      to RCC_DEAL;
grant SELECT                                                                 on CCK_AN_TMP      to SALGL;
grant SELECT                                                                 on CCK_AN_TMP      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_AN_TMP      to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to CCK_AN_TMP ***

  CREATE OR REPLACE SYNONYM BARS.V3800_3801 FOR BARS.CCK_AN_TMP;


PROMPT *** Create SYNONYM  to CCK_AN_TMP ***

  CREATE OR REPLACE PUBLIC SYNONYM CCK_AN_TMP FOR BARS.CCK_AN_TMP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_AN_TMP.sql =========*** End *** ==
PROMPT ===================================================================================== 
