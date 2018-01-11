

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_TTS_2705.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_TTS_2705 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_TTS_2705 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_TTS_2705 
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




PROMPT *** ALTER_POLICIES to TMP_TTS_2705 ***
 exec bpa.alter_policies('TMP_TTS_2705');


COMMENT ON TABLE BARS.TMP_TTS_2705 IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.TT IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.NAME IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.DK IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.NLSM IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.KV IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.NLSK IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.KVK IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.NLSS IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.FLC IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.FLI IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.FLV IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.FLR IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.S IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.S2 IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.SK IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.PROC IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.S3800 IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.S6201 IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.S7201 IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.RANG IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.FLAGS IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2705.ID IS '';




PROMPT *** Create  constraint SYS_C00132025 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TTS_2705 MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132026 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TTS_2705 MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132027 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TTS_2705 MODIFY (FLC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132028 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TTS_2705 MODIFY (FLI NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132029 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TTS_2705 MODIFY (FLV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132030 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TTS_2705 MODIFY (FLR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132031 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TTS_2705 MODIFY (FLAGS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_TTS_2705 ***
grant SELECT                                                                 on TMP_TTS_2705    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_TTS_2705.sql =========*** End *** 
PROMPT ===================================================================================== 
