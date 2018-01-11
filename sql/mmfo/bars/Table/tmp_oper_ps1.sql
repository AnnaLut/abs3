

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OPER_PS1.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OPER_PS1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OPER_PS1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OPER_PS1 
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




PROMPT *** ALTER_POLICIES to TMP_OPER_PS1 ***
 exec bpa.alter_policies('TMP_OPER_PS1');


COMMENT ON TABLE BARS.TMP_OPER_PS1 IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.REF IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.DEAL_TAG IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.TT IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.VOB IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.ND IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.PDAT IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.VDAT IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.KV IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.DK IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.S IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.SQ IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.SK IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.DATD IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.DATP IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.NAM_A IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.MFOA IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.NAM_B IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.D_REC IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.ID_A IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.ID_B IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.ID_O IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.SIGN IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.SOS IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.VP IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.CHK IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.S2 IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.KV2 IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.KVQ IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.REFL IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.PRTY IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.SQ2 IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.CURRVISAGRP IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.NEXTVISAGRP IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.REF_A IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.TOBO IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.OTM IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.SIGNED IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.USERID IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.RESPID IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.KF IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.BIS IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.SOS_TRACKER IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.NEXT_VISA_BRANCHES IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.SOS_CHANGE_TIME IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.ODAT IS '';
COMMENT ON COLUMN BARS.TMP_OPER_PS1.BDAT IS '';



PROMPT *** Create  grants  TMP_OPER_PS1 ***
grant SELECT                                                                 on TMP_OPER_PS1    to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_OPER_PS1    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OPER_PS1.sql =========*** End *** 
PROMPT ===================================================================================== 
