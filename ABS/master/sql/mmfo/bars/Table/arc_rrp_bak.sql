

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ARC_RRP_BAK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ARC_RRP_BAK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ARC_RRP_BAK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ARC_RRP_BAK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ARC_RRP_BAK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ARC_RRP_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ARC_RRP_BAK 
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
	PRTY NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ARC_RRP_BAK ***
 exec bpa.alter_policies('ARC_RRP_BAK');


COMMENT ON TABLE BARS.ARC_RRP_BAK IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.REC IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.REF IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.MFOA IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.NLSA IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.MFOB IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.NLSB IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.DK IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.S IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.VOB IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.ND IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.KV IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.DATD IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.DATP IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.NAM_A IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.NAM_B IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.NAZN IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.NAZNK IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.NAZNS IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.ID_A IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.ID_B IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.ID_O IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.REF_A IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.BIS IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.SIGN IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.FN_A IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.DAT_A IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.REC_A IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.FN_B IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.DAT_B IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.REC_B IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.D_REC IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.BLK IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.SOS IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAK.PRTY IS '';




PROMPT *** Create  constraint SYS_C008043 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_RRP_BAK MODIFY (REC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ARC_RRP_BAK ***
grant SELECT                                                                 on ARC_RRP_BAK     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ARC_RRP_BAK     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ARC_RRP_BAK     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ARC_RRP_BAK     to START1;
grant SELECT                                                                 on ARC_RRP_BAK     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ARC_RRP_BAK.sql =========*** End *** =
PROMPT ===================================================================================== 
