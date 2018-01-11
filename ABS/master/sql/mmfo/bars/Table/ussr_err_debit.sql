

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/USSR_ERR_DEBIT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to USSR_ERR_DEBIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''USSR_ERR_DEBIT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''USSR_ERR_DEBIT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''USSR_ERR_DEBIT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table USSR_ERR_DEBIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.USSR_ERR_DEBIT 
   (	REF NUMBER(38,0), 
	DEAL_TAG NUMBER, 
	TT CHAR(3), 
	VOB NUMBER(38,0), 
	ND VARCHAR2(10), 
	PDAT DATE, 
	VDAT DATE, 
	KV NUMBER(38,0), 
	DK NUMBER(38,0), 
	S NUMBER(24,0), 
	SQ NUMBER(24,0), 
	SK NUMBER(38,0), 
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
	USERID NUMBER, 
	ID_A VARCHAR2(14), 
	ID_B VARCHAR2(14), 
	ID_O VARCHAR2(6), 
	SIGN RAW(128), 
	SOS NUMBER(38,0), 
	VP NUMBER(38,0), 
	CHK CHAR(70), 
	S2 NUMBER(24,0), 
	KV2 NUMBER(38,0), 
	KVQ NUMBER(38,0), 
	REFL NUMBER(38,0), 
	PRTY NUMBER(38,0), 
	CURRVISAGRP VARCHAR2(4), 
	NEXTVISAGRP VARCHAR2(4), 
	REF_A VARCHAR2(9), 
	TOBO VARCHAR2(12), 
	SIGNED CHAR(1), 
	RESPID NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to USSR_ERR_DEBIT ***
 exec bpa.alter_policies('USSR_ERR_DEBIT');


COMMENT ON TABLE BARS.USSR_ERR_DEBIT IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.REF IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.DEAL_TAG IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.TT IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.VOB IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.ND IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.PDAT IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.VDAT IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.KV IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.DK IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.S IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.SQ IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.SK IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.DATD IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.DATP IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.NAM_A IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.NLSA IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.MFOA IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.NAM_B IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.NLSB IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.MFOB IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.NAZN IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.D_REC IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.USERID IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.ID_A IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.ID_B IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.ID_O IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.SIGN IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.SOS IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.VP IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.CHK IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.S2 IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.KV2 IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.KVQ IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.REFL IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.PRTY IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.CURRVISAGRP IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.NEXTVISAGRP IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.REF_A IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.TOBO IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.SIGNED IS '';
COMMENT ON COLUMN BARS.USSR_ERR_DEBIT.RESPID IS '';




PROMPT *** Create  constraint SYS_C005962 ***
begin   
 execute immediate '
  ALTER TABLE BARS.USSR_ERR_DEBIT MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SERGERRDEBIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.USSR_ERR_DEBIT ADD CONSTRAINT PK_SERGERRDEBIT PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SERGERRDEBIT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SERGERRDEBIT ON BARS.USSR_ERR_DEBIT (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  USSR_ERR_DEBIT ***
grant SELECT                                                                 on USSR_ERR_DEBIT  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on USSR_ERR_DEBIT  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on USSR_ERR_DEBIT  to START1;
grant SELECT                                                                 on USSR_ERR_DEBIT  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/USSR_ERR_DEBIT.sql =========*** End **
PROMPT ===================================================================================== 
