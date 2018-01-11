

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TTS_BACKUP_07062016.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TTS_BACKUP_07062016 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TTS_BACKUP_07062016 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TTS_BACKUP_07062016 
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




PROMPT *** ALTER_POLICIES to TTS_BACKUP_07062016 ***
 exec bpa.alter_policies('TTS_BACKUP_07062016');


COMMENT ON TABLE BARS.TTS_BACKUP_07062016 IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.TT IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.NAME IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.DK IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.NLSM IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.KV IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.NLSK IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.KVK IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.NLSS IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.NLSA IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.NLSB IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.MFOB IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.FLC IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.FLI IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.FLV IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.FLR IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.S IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.S2 IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.SK IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.PROC IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.S3800 IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.S6201 IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.S7201 IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.RANG IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.FLAGS IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.NAZN IS '';
COMMENT ON COLUMN BARS.TTS_BACKUP_07062016.ID IS '';




PROMPT *** Create  constraint SYS_C0030727 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_BACKUP_07062016 MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0030728 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_BACKUP_07062016 MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0030729 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_BACKUP_07062016 MODIFY (FLC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0030730 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_BACKUP_07062016 MODIFY (FLI NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0030731 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_BACKUP_07062016 MODIFY (FLV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0030732 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_BACKUP_07062016 MODIFY (FLR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0030733 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_BACKUP_07062016 MODIFY (FLAGS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TTS_BACKUP_07062016 ***
grant SELECT                                                                 on TTS_BACKUP_07062016 to BARSREADER_ROLE;
grant SELECT                                                                 on TTS_BACKUP_07062016 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TTS_BACKUP_07062016.sql =========*** E
PROMPT ===================================================================================== 
