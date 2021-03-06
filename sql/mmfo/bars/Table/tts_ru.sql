

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TTS_RU.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TTS_RU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TTS_RU ***
begin 
  execute immediate '
  CREATE TABLE BARS.TTS_RU 
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
	NAZN VARCHAR2(160)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TTS_RU ***
 exec bpa.alter_policies('TTS_RU');


COMMENT ON TABLE BARS.TTS_RU IS '';
COMMENT ON COLUMN BARS.TTS_RU.TT IS '';
COMMENT ON COLUMN BARS.TTS_RU.NAME IS '';
COMMENT ON COLUMN BARS.TTS_RU.DK IS '';
COMMENT ON COLUMN BARS.TTS_RU.NLSM IS '';
COMMENT ON COLUMN BARS.TTS_RU.KV IS '';
COMMENT ON COLUMN BARS.TTS_RU.NLSK IS '';
COMMENT ON COLUMN BARS.TTS_RU.KVK IS '';
COMMENT ON COLUMN BARS.TTS_RU.NLSS IS '';
COMMENT ON COLUMN BARS.TTS_RU.NLSA IS '';
COMMENT ON COLUMN BARS.TTS_RU.NLSB IS '';
COMMENT ON COLUMN BARS.TTS_RU.MFOB IS '';
COMMENT ON COLUMN BARS.TTS_RU.FLC IS '';
COMMENT ON COLUMN BARS.TTS_RU.FLI IS '';
COMMENT ON COLUMN BARS.TTS_RU.FLV IS '';
COMMENT ON COLUMN BARS.TTS_RU.FLR IS '';
COMMENT ON COLUMN BARS.TTS_RU.S IS '';
COMMENT ON COLUMN BARS.TTS_RU.S2 IS '';
COMMENT ON COLUMN BARS.TTS_RU.SK IS '';
COMMENT ON COLUMN BARS.TTS_RU.PROC IS '';
COMMENT ON COLUMN BARS.TTS_RU.S3800 IS '';
COMMENT ON COLUMN BARS.TTS_RU.S6201 IS '';
COMMENT ON COLUMN BARS.TTS_RU.S7201 IS '';
COMMENT ON COLUMN BARS.TTS_RU.RANG IS '';
COMMENT ON COLUMN BARS.TTS_RU.FLAGS IS '';
COMMENT ON COLUMN BARS.TTS_RU.NAZN IS '';




PROMPT *** Create  constraint SYS_C008910 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_RU MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008911 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_RU MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008912 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_RU MODIFY (FLC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008913 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_RU MODIFY (FLI NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008914 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_RU MODIFY (FLV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008915 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_RU MODIFY (FLR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008916 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_RU MODIFY (FLAGS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TTS_RU ***
grant SELECT                                                                 on TTS_RU          to BARSREADER_ROLE;
grant SELECT                                                                 on TTS_RU          to BARS_DM;
grant SELECT                                                                 on TTS_RU          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TTS_RU.sql =========*** End *** ======
PROMPT ===================================================================================== 
