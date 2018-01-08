

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_TTS_2402.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_TTS_2402 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_TTS_2402 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_TTS_2402 
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




PROMPT *** ALTER_POLICIES to TMP_TTS_2402 ***
 exec bpa.alter_policies('TMP_TTS_2402');


COMMENT ON TABLE BARS.TMP_TTS_2402 IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.TT IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.NAME IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.DK IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.NLSM IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.KV IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.NLSK IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.KVK IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.NLSS IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.FLC IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.FLI IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.FLV IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.FLR IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.S IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.S2 IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.SK IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.PROC IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.S3800 IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.S6201 IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.S7201 IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.RANG IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.FLAGS IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_TTS_2402.ID IS '';




PROMPT *** Create  constraint SYS_C00109885 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TTS_2402 MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109886 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TTS_2402 MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109887 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TTS_2402 MODIFY (FLC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109891 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TTS_2402 MODIFY (FLAGS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109889 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TTS_2402 MODIFY (FLV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109890 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TTS_2402 MODIFY (FLR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109888 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TTS_2402 MODIFY (FLI NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_TTS_2402.sql =========*** End *** 
PROMPT ===================================================================================== 
