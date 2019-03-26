

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CP_REP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CP_REP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_CP_REP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_CP_REP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_CP_REP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CP_REP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CP_REP 
   (	ID NUMBER(*,0), 
	ISIN VARCHAR2(20), 
	NLS VARCHAR2(15), 
	NMS VARCHAR2(38), 
	REF NUMBER(*,0), 
	OST_V NUMBER, 
	NLS_S VARCHAR2(15), 
	S_D NUMBER, 
	S_C NUMBER, 
	NLS_P VARCHAR2(15), 
	S_DP NUMBER, 
	S_CP NUMBER, 
	OST_I NUMBER, 
	S_DK NUMBER, 
	S_CK NUMBER, 
	OST_P NUMBER, 
	NMS_P VARCHAR2(38), 
	REF2 NUMBER(*,0), 
	NLS_P1 VARCHAR2(15), 
	DAT_P DATE, 
	FL NUMBER(*,0), 
	USERID NUMBER(*,0), 
	S_DP_NEW NUMBER, 
	S_CP_NEW NUMBER, 
	KV NUMBER(*,0), 
	PAP NUMBER(*,0), 
	VID_R CHAR(2), 
	S_DK_NEW NUMBER, 
	S_CK_NEW NUMBER, 
	OST_PQ NUMBER, 
	OST_VQ NUMBER, 
	S_DQ NUMBER, 
	S_CQ NUMBER, 
	S_DKQ NUMBER, 
	S_CKQ NUMBER, 
	S_DPQ NUMBER, 
	S_CPQ NUMBER, 
	S_DPQ_NEW NUMBER, 
	S_CPQ_NEW NUMBER, 
	S_DKQ_NEW NUMBER, 
	S_CKQ_NEW NUMBER, 
	NBS_OLD NUMBER(4,0), 
	NBS_NEW NUMBER(4,0), 
	PF_OLD NUMBER(*,0), 
	PF_NEW NUMBER(*,0), 
	FRM VARCHAR2(5), 
	GR_Z VARCHAR2(2), 
	ORD_Z NUMBER(*,0), 
	ID_U NUMBER(*,0), 
	RNK NUMBER(*,0), 
	DN NUMBER(*,0), 
	EMI NUMBER(*,0), 
	NAME VARCHAR2(70), 
	PERIOD_KUP NUMBER, 
	DOK DATE, 
	DNK DATE, 
	S_DPOG NUMBER, 
	CENA NUMBER, 
	KOL NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CP_REP ***
 exec bpa.alter_policies('TMP_CP_REP');


COMMENT ON TABLE BARS.TMP_CP_REP IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.ID IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.ISIN IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.NLS IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.NMS IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.REF IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.OST_V IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.NLS_S IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_D IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_C IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.NLS_P IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_DP IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_CP IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.OST_I IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_DK IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_CK IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.OST_P IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.NMS_P IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.REF2 IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.NLS_P1 IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.DAT_P IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.FL IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.USERID IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_DP_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_CP_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.KV IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.PAP IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.VID_R IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_DK_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_CK_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.OST_PQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.OST_VQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_DQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_CQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_DKQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_CKQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_DPQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_CPQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_DPQ_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_CPQ_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_DKQ_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_CKQ_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.NBS_OLD IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.NBS_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.PF_OLD IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.PF_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.FRM IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.GR_Z IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.ORD_Z IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.ID_U IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.RNK IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.DN IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.EMI IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.NAME IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.PERIOD_KUP IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.DOK IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.DNK IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.S_DPOG IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.CENA IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP.KOL IS '';



PROMPT *** Create  grants  TMP_CP_REP ***
grant SELECT                                                                 on TMP_CP_REP      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_CP_REP      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_CP_REP      to START1;
grant SELECT                                                                 on TMP_CP_REP      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CP_REP.sql =========*** End *** ==
PROMPT ===================================================================================== 