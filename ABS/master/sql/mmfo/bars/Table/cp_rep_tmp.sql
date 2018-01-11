

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_REP_TMP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_REP_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_REP_TMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_REP_TMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_REP_TMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_REP_TMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_REP_TMP 
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
	PF_NEW NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_REP_TMP ***
 exec bpa.alter_policies('CP_REP_TMP');


COMMENT ON TABLE BARS.CP_REP_TMP IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.ID IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.ISIN IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.NLS IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.NMS IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.REF IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.OST_V IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.NLS_S IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_D IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_C IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.NLS_P IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_DP IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_CP IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.OST_I IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_DK IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_CK IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.OST_P IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.NMS_P IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.REF2 IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.NLS_P1 IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.DAT_P IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.FL IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.USERID IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_DP_NEW IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_CP_NEW IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.KV IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.PAP IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.VID_R IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_DK_NEW IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_CK_NEW IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.OST_PQ IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.OST_VQ IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_DQ IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_CQ IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_DKQ IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_CKQ IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_DPQ IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_CPQ IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_DPQ_NEW IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_CPQ_NEW IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_DKQ_NEW IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.S_CKQ_NEW IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.NBS_OLD IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.NBS_NEW IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.PF_OLD IS '';
COMMENT ON COLUMN BARS.CP_REP_TMP.PF_NEW IS '';



PROMPT *** Create  grants  CP_REP_TMP ***
grant SELECT                                                                 on CP_REP_TMP      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_REP_TMP      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_REP_TMP      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_REP_TMP      to START1;
grant SELECT                                                                 on CP_REP_TMP      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_REP_TMP.sql =========*** End *** ==
PROMPT ===================================================================================== 
