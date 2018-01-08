

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BACKUP2_TTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BACKUP2_TTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BACKUP2_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BACKUP2_TTS 
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
	ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BACKUP2_TTS ***
 exec bpa.alter_policies('TMP_BACKUP2_TTS');


COMMENT ON TABLE BARS.TMP_BACKUP2_TTS IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.TT IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.NAME IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.DK IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.NLSM IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.KV IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.NLSK IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.KVK IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.NLSS IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.FLC IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.FLI IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.FLV IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.FLR IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.S IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.S2 IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.SK IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.PROC IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.S3800 IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.S6201 IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.S7201 IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.RANG IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.FLAGS IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_TTS.ID IS '';




PROMPT *** Create  constraint SYS_C0048357 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP2_TTS MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048358 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP2_TTS MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048359 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP2_TTS MODIFY (FLC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048363 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP2_TTS MODIFY (FLAGS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048361 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP2_TTS MODIFY (FLV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048362 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP2_TTS MODIFY (FLR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048360 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP2_TTS MODIFY (FLI NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BACKUP2_TTS.sql =========*** End *
PROMPT ===================================================================================== 
