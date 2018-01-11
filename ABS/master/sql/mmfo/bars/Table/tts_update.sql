

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TTS_UPDATE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TTS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TTS_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TTS_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TTS_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TTS_UPDATE 
   (	TT CHAR(3), 
	NAME VARCHAR2(70), 
	DK NUMBER(1,0), 
	NLSM VARCHAR2(90), 
	KV NUMBER(3,0), 
	NLSK VARCHAR2(128), 
	KVK NUMBER(3,0), 
	NLSS VARCHAR2(15), 
	NLSA VARCHAR2(55), 
	NLSB VARCHAR2(55), 
	MFOB VARCHAR2(12), 
	FLC NUMBER(1,0), 
	FLI NUMBER(1,0), 
	FLV NUMBER(1,0), 
	FLR NUMBER(1,0), 
	S VARCHAR2(254), 
	S2 VARCHAR2(254), 
	SK NUMBER(24,0), 
	PROC NUMBER(7,2), 
	S3800 VARCHAR2(55), 
	S6201 NUMBER(38,0), 
	S7201 NUMBER(38,0), 
	RANG NUMBER(10,0), 
	FLAGS CHAR(64), 
	NAZN VARCHAR2(160), 
	ID NUMBER(38,0), 
	CHGDATE DATE, 
	CHGACTION VARCHAR2(38), 
	DONEBY VARCHAR2(64), 
	IDUPD NUMBER, 
	EFFECTDATE DATE, 
	MACHINE VARCHAR2(250), 
	IP VARCHAR2(64), 
	OSUSERS VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TTS_UPDATE ***
 exec bpa.alter_policies('TTS_UPDATE');


COMMENT ON TABLE BARS.TTS_UPDATE IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.MACHINE IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.IP IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.OSUSERS IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.TT IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.NAME IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.DK IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.NLSM IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.KV IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.NLSK IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.KVK IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.NLSS IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.NLSA IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.NLSB IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.MFOB IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.FLC IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.FLI IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.FLV IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.FLR IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.S IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.S2 IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.SK IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.PROC IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.S3800 IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.S6201 IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.S7201 IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.RANG IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.FLAGS IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.NAZN IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.ID IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.TTS_UPDATE.EFFECTDATE IS '';




PROMPT *** Create  constraint PK_TTS_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_UPDATE ADD CONSTRAINT PK_TTS_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TTS_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TTS_UPDATE ON BARS.TTS_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_TTS_UPDATE_CHGDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_TTS_UPDATE_CHGDATE ON BARS.TTS_UPDATE (CHGDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TTS_UPDATE ***
grant SELECT                                                                 on TTS_UPDATE      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TTS_UPDATE.sql =========*** End *** ==
PROMPT ===================================================================================== 
