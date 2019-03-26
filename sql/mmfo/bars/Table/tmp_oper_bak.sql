

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OPER_BAK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OPER_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OPER_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OPER_BAK 
   (	REF NUMBER(38,0), 
	DEAL_TAG NUMBER(38,0), 
	TT CHAR(3), 
	VOB NUMBER(38,0), 
	ND VARCHAR2(10), 
	PDAT DATE, 
	VDAT DATE, 
	KV NUMBER(*,0), 
	DK NUMBER(1,0), 
	S NUMBER(24,0), 
	SQ NUMBER(24,0), 
	SK NUMBER(2,0), 
	DATD DATE, 
	DATP DATE, 
	NAM_A VARCHAR2(38), 
	NLSA VARCHAR2(15), 
	MFOA VARCHAR2(12), 
	NAM_B VARCHAR2(38), 
	NLSB VARCHAR2(15), 
	MFOB VARCHAR2(12), 
	NAZN VARCHAR2(160), 
	D_REC VARCHAR2(60), 
	ID_A VARCHAR2(14), 
	ID_B VARCHAR2(14), 
	ID_O VARCHAR2(8), 
	SIGN RAW(2000), 
	SOS NUMBER(2,0), 
	VP NUMBER(1,0), 
	CHK CHAR(70), 
	S2 NUMBER(24,0), 
	KV2 NUMBER(38,0), 
	KVQ NUMBER(38,0), 
	REFL NUMBER(38,0), 
	PRTY NUMBER(1,0), 
	SQ2 NUMBER(24,0), 
	CURRVISAGRP VARCHAR2(4), 
	NEXTVISAGRP VARCHAR2(4), 
	REF_A VARCHAR2(9), 
	TOBO VARCHAR2(30), 
	OTM NUMBER(1,0), 
	SIGNED CHAR(1), 
	BRANCH VARCHAR2(30), 
	USERID NUMBER(38,0), 
	RESPID NUMBER, 
	KF VARCHAR2(6), 
	BIS NUMBER(38,0), 
	SOS_TRACKER NUMBER(38,0), 
	NEXT_VISA_BRANCHES VARCHAR2(128), 
	SOS_CHANGE_TIME DATE, 
	ODAT DATE, 
	BDAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OPER_BAK ***
 exec bpa.alter_policies('TMP_OPER_BAK');


COMMENT ON TABLE BARS.TMP_OPER_BAK IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.REF IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.DEAL_TAG IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.TT IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.VOB IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.ND IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.PDAT IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.VDAT IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.KV IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.DK IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.S IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.SQ IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.SK IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.DATD IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.DATP IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.NAM_A IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.MFOA IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.NAM_B IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.D_REC IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.ID_A IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.ID_B IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.ID_O IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.SIGN IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.SOS IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.VP IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.CHK IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.S2 IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.KV2 IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.KVQ IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.REFL IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.PRTY IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.SQ2 IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.CURRVISAGRP IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.NEXTVISAGRP IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.REF_A IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.TOBO IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.OTM IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.SIGNED IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.USERID IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.RESPID IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.KF IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.BIS IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.SOS_TRACKER IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.NEXT_VISA_BRANCHES IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.SOS_CHANGE_TIME IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.ODAT IS '';
COMMENT ON COLUMN BARS.TMP_OPER_BAK.BDAT IS '';



PROMPT *** Create  grants  TMP_OPER_BAK ***
grant SELECT                                                                 on TMP_OPER_BAK    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OPER_BAK.sql =========*** End *** 
PROMPT ===================================================================================== 