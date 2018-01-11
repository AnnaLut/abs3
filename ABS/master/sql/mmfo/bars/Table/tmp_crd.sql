

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CRD.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CRD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CRD ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CRD 
   (	ND NUMBER(*,0), 
	CC_ID VARCHAR2(20), 
	RNK NUMBER(*,0), 
	NMK VARCHAR2(38), 
	KV_S NUMBER(*,0), 
	NLS VARCHAR2(15), 
	NMS VARCHAR2(38), 
	SDATE DATE, 
	WDATE DATE, 
	S NUMBER, 
	SQ NUMBER, 
	OTR VARCHAR2(15), 
	KV_D NUMBER(*,0), 
	OST NUMBER, 
	OSTQ NUMBER, 
	IR NUMBER, 
	IR_D NUMBER, 
	DAT1 DATE, 
	DAT2 DATE, 
	VID_Z NUMBER, 
	S_Z NUMBER, 
	S_ZQ NUMBER, 
	K_RISK NUMBER, 
	FIN VARCHAR2(20), 
	K_PRL NUMBER, 
	OBESP NUMBER, 
	R_REZ NUMBER, 
	F_REZ NUMBER, 
	SOUR NUMBER(*,0), 
	VIDD NUMBER(*,0), 
	NLSZ VARCHAR2(15), 
	US NUMBER(*,0), 
	DATE3 DATE, 
	DATE4 DATE, 
	DATE5 DATE, 
	ID NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CRD ***
 exec bpa.alter_policies('TMP_CRD');


COMMENT ON TABLE BARS.TMP_CRD IS '';
COMMENT ON COLUMN BARS.TMP_CRD.ND IS '';
COMMENT ON COLUMN BARS.TMP_CRD.CC_ID IS '';
COMMENT ON COLUMN BARS.TMP_CRD.RNK IS '';
COMMENT ON COLUMN BARS.TMP_CRD.NMK IS '';
COMMENT ON COLUMN BARS.TMP_CRD.KV_S IS '';
COMMENT ON COLUMN BARS.TMP_CRD.NLS IS '';
COMMENT ON COLUMN BARS.TMP_CRD.NMS IS '';
COMMENT ON COLUMN BARS.TMP_CRD.SDATE IS '';
COMMENT ON COLUMN BARS.TMP_CRD.WDATE IS '';
COMMENT ON COLUMN BARS.TMP_CRD.S IS '';
COMMENT ON COLUMN BARS.TMP_CRD.SQ IS '';
COMMENT ON COLUMN BARS.TMP_CRD.OTR IS '';
COMMENT ON COLUMN BARS.TMP_CRD.KV_D IS '';
COMMENT ON COLUMN BARS.TMP_CRD.OST IS '';
COMMENT ON COLUMN BARS.TMP_CRD.OSTQ IS '';
COMMENT ON COLUMN BARS.TMP_CRD.IR IS '';
COMMENT ON COLUMN BARS.TMP_CRD.IR_D IS '';
COMMENT ON COLUMN BARS.TMP_CRD.DAT1 IS '';
COMMENT ON COLUMN BARS.TMP_CRD.DAT2 IS '';
COMMENT ON COLUMN BARS.TMP_CRD.VID_Z IS '';
COMMENT ON COLUMN BARS.TMP_CRD.S_Z IS '';
COMMENT ON COLUMN BARS.TMP_CRD.S_ZQ IS '';
COMMENT ON COLUMN BARS.TMP_CRD.K_RISK IS '';
COMMENT ON COLUMN BARS.TMP_CRD.FIN IS '';
COMMENT ON COLUMN BARS.TMP_CRD.K_PRL IS '';
COMMENT ON COLUMN BARS.TMP_CRD.OBESP IS '';
COMMENT ON COLUMN BARS.TMP_CRD.R_REZ IS '';
COMMENT ON COLUMN BARS.TMP_CRD.F_REZ IS '';
COMMENT ON COLUMN BARS.TMP_CRD.SOUR IS '';
COMMENT ON COLUMN BARS.TMP_CRD.VIDD IS '';
COMMENT ON COLUMN BARS.TMP_CRD.NLSZ IS '';
COMMENT ON COLUMN BARS.TMP_CRD.US IS '';
COMMENT ON COLUMN BARS.TMP_CRD.DATE3 IS '';
COMMENT ON COLUMN BARS.TMP_CRD.DATE4 IS '';
COMMENT ON COLUMN BARS.TMP_CRD.DATE5 IS '';
COMMENT ON COLUMN BARS.TMP_CRD.ID IS '';



PROMPT *** Create  grants  TMP_CRD ***
grant SELECT                                                                 on TMP_CRD         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_CRD         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_CRD         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_CRD         to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_CRD         to RPBN001;
grant SELECT                                                                 on TMP_CRD         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_CRD         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CRD.sql =========*** End *** =====
PROMPT ===================================================================================== 
