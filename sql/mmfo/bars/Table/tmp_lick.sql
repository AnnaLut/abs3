

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_LICK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_LICK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_LICK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_LICK 
   (	ID NUMBER(38,0), 
	SAB VARCHAR2(6), 
	NLS VARCHAR2(14), 
	NLSK VARCHAR2(14), 
	NAMS VARCHAR2(38), 
	NMK VARCHAR2(38), 
	MFO VARCHAR2(9), 
	ND VARCHAR2(10), 
	ISP NUMBER(38,0), 
	EL NUMBER, 
	NM NUMBER, 
	NP NUMBER, 
	VOB NUMBER(38,0), 
	DK NUMBER(38,0), 
	S NUMBER(17,0), 
	DAOPL DATE, 
	ISM NUMBER(24,0), 
	DAPP DATE, 
	NAZ VARCHAR2(160), 
	POND VARCHAR2(10), 
	FN_A VARCHAR2(12), 
	D_REC VARCHAR2(60), 
	RNK NUMBER(38,0), 
	KOKK VARCHAR2(14), 
	TD VARCHAR2(2), 
	ISPZ NUMBER, 
	REF NUMBER(38,0), 
	POLU VARCHAR2(92), 
	MINUSA3 NUMBER(38,0), 
	SOS NUMBER(18,0), 
	BLK_MSG VARCHAR2(200), 
	FDAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_LICK ***
 exec bpa.alter_policies('TMP_LICK');


COMMENT ON TABLE BARS.TMP_LICK IS '';
COMMENT ON COLUMN BARS.TMP_LICK.ID IS '';
COMMENT ON COLUMN BARS.TMP_LICK.SAB IS '';
COMMENT ON COLUMN BARS.TMP_LICK.NLS IS '';
COMMENT ON COLUMN BARS.TMP_LICK.NLSK IS '';
COMMENT ON COLUMN BARS.TMP_LICK.NAMS IS '';
COMMENT ON COLUMN BARS.TMP_LICK.NMK IS '';
COMMENT ON COLUMN BARS.TMP_LICK.MFO IS '';
COMMENT ON COLUMN BARS.TMP_LICK.ND IS '';
COMMENT ON COLUMN BARS.TMP_LICK.ISP IS '';
COMMENT ON COLUMN BARS.TMP_LICK.EL IS '';
COMMENT ON COLUMN BARS.TMP_LICK.NM IS '';
COMMENT ON COLUMN BARS.TMP_LICK.NP IS '';
COMMENT ON COLUMN BARS.TMP_LICK.VOB IS '';
COMMENT ON COLUMN BARS.TMP_LICK.DK IS '';
COMMENT ON COLUMN BARS.TMP_LICK.S IS '';
COMMENT ON COLUMN BARS.TMP_LICK.DAOPL IS '';
COMMENT ON COLUMN BARS.TMP_LICK.ISM IS '';
COMMENT ON COLUMN BARS.TMP_LICK.DAPP IS '';
COMMENT ON COLUMN BARS.TMP_LICK.NAZ IS '';
COMMENT ON COLUMN BARS.TMP_LICK.POND IS '';
COMMENT ON COLUMN BARS.TMP_LICK.FN_A IS '';
COMMENT ON COLUMN BARS.TMP_LICK.D_REC IS '';
COMMENT ON COLUMN BARS.TMP_LICK.RNK IS '';
COMMENT ON COLUMN BARS.TMP_LICK.KOKK IS '';
COMMENT ON COLUMN BARS.TMP_LICK.TD IS '';
COMMENT ON COLUMN BARS.TMP_LICK.ISPZ IS '';
COMMENT ON COLUMN BARS.TMP_LICK.REF IS '';
COMMENT ON COLUMN BARS.TMP_LICK.POLU IS '';
COMMENT ON COLUMN BARS.TMP_LICK.MINUSA3 IS '';
COMMENT ON COLUMN BARS.TMP_LICK.SOS IS '';
COMMENT ON COLUMN BARS.TMP_LICK.BLK_MSG IS '';
COMMENT ON COLUMN BARS.TMP_LICK.FDAT IS '';



PROMPT *** Create  grants  TMP_LICK ***
grant SELECT                                                                 on TMP_LICK        to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_LICK        to BARS_DM;
grant SELECT                                                                 on TMP_LICK        to KLB;
grant SELECT                                                                 on TMP_LICK        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_LICK        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_LICK.sql =========*** End *** ====
PROMPT ===================================================================================== 
