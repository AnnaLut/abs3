

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ARC_RRP_GOODSIGN.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ARC_RRP_GOODSIGN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ARC_RRP_GOODSIGN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ARC_RRP_GOODSIGN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ARC_RRP_GOODSIGN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ARC_RRP_GOODSIGN ***
begin 
  execute immediate '
  CREATE TABLE BARS.ARC_RRP_GOODSIGN 
   (	REC NUMBER, 
	REF NUMBER, 
	MFOA VARCHAR2(12), 
	NLSA VARCHAR2(15), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(15), 
	DK NUMBER(38,0), 
	S NUMBER(24,0), 
	VOB NUMBER(38,0), 
	ND CHAR(10), 
	KV NUMBER(38,0), 
	DATD DATE, 
	DATP DATE, 
	NAM_A VARCHAR2(38), 
	NAM_B VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	NAZNK CHAR(3), 
	NAZNS CHAR(2), 
	ID_A VARCHAR2(14), 
	ID_B VARCHAR2(14), 
	ID_O VARCHAR2(6), 
	REF_A VARCHAR2(9), 
	BIS NUMBER(38,0), 
	SIGN RAW(128), 
	FN_A CHAR(12), 
	DAT_A DATE, 
	REC_A NUMBER(38,0), 
	FN_B CHAR(12), 
	DAT_B DATE, 
	REC_B NUMBER(38,0), 
	D_REC VARCHAR2(80), 
	BLK NUMBER(38,0), 
	SOS NUMBER(38,0), 
	PRTY NUMBER(38,0), 
	FA_NAME VARCHAR2(12), 
	FA_LN NUMBER, 
	FA_T_ARM3 VARCHAR2(4), 
	FA_T_ARM2 VARCHAR2(4), 
	FC_NAME VARCHAR2(12), 
	FC_LN NUMBER, 
	FC_T1_ARM2 VARCHAR2(4), 
	FC_T2_ARM2 VARCHAR2(4), 
	FB_NAME VARCHAR2(12), 
	FB_LN NUMBER, 
	FB_T_ARM2 VARCHAR2(4), 
	FB_T_ARM3 VARCHAR2(4), 
	FB_D_ARM3 DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ARC_RRP_GOODSIGN ***
 exec bpa.alter_policies('ARC_RRP_GOODSIGN');


COMMENT ON TABLE BARS.ARC_RRP_GOODSIGN IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.REC IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.REF IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.MFOA IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.NLSA IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.MFOB IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.NLSB IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.DK IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.S IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.VOB IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.ND IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.KV IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.DATD IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.DATP IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.NAM_A IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.NAM_B IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.NAZN IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.NAZNK IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.NAZNS IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.ID_A IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.ID_B IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.ID_O IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.REF_A IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.BIS IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.SIGN IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.FN_A IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.DAT_A IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.REC_A IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.FN_B IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.DAT_B IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.REC_B IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.D_REC IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.BLK IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.SOS IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.PRTY IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.FA_NAME IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.FA_LN IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.FA_T_ARM3 IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.FA_T_ARM2 IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.FC_NAME IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.FC_LN IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.FC_T1_ARM2 IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.FC_T2_ARM2 IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.FB_NAME IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.FB_LN IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.FB_T_ARM2 IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.FB_T_ARM3 IS '';
COMMENT ON COLUMN BARS.ARC_RRP_GOODSIGN.FB_D_ARM3 IS '';




PROMPT *** Create  constraint SYS_C005070 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_RRP_GOODSIGN MODIFY (REC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005071 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_RRP_GOODSIGN MODIFY (DAT_A NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ARC_RRP_GOODSIGN ***
grant SELECT                                                                 on ARC_RRP_GOODSIGN to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ARC_RRP_GOODSIGN to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ARC_RRP_GOODSIGN to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ARC_RRP_GOODSIGN to START1;
grant SELECT                                                                 on ARC_RRP_GOODSIGN to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ARC_RRP_GOODSIGN.sql =========*** End 
PROMPT ===================================================================================== 
