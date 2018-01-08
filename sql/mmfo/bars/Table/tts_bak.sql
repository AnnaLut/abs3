

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TTS_BAK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TTS_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TTS_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TTS_BAK 
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




PROMPT *** ALTER_POLICIES to TTS_BAK ***
 exec bpa.alter_policies('TTS_BAK');


COMMENT ON TABLE BARS.TTS_BAK IS '';
COMMENT ON COLUMN BARS.TTS_BAK.TT IS '';
COMMENT ON COLUMN BARS.TTS_BAK.NAME IS '';
COMMENT ON COLUMN BARS.TTS_BAK.DK IS '';
COMMENT ON COLUMN BARS.TTS_BAK.NLSM IS '';
COMMENT ON COLUMN BARS.TTS_BAK.KV IS '';
COMMENT ON COLUMN BARS.TTS_BAK.NLSK IS '';
COMMENT ON COLUMN BARS.TTS_BAK.KVK IS '';
COMMENT ON COLUMN BARS.TTS_BAK.NLSS IS '';
COMMENT ON COLUMN BARS.TTS_BAK.NLSA IS '';
COMMENT ON COLUMN BARS.TTS_BAK.NLSB IS '';
COMMENT ON COLUMN BARS.TTS_BAK.MFOB IS '';
COMMENT ON COLUMN BARS.TTS_BAK.FLC IS '';
COMMENT ON COLUMN BARS.TTS_BAK.FLI IS '';
COMMENT ON COLUMN BARS.TTS_BAK.FLV IS '';
COMMENT ON COLUMN BARS.TTS_BAK.FLR IS '';
COMMENT ON COLUMN BARS.TTS_BAK.S IS '';
COMMENT ON COLUMN BARS.TTS_BAK.S2 IS '';
COMMENT ON COLUMN BARS.TTS_BAK.SK IS '';
COMMENT ON COLUMN BARS.TTS_BAK.PROC IS '';
COMMENT ON COLUMN BARS.TTS_BAK.S3800 IS '';
COMMENT ON COLUMN BARS.TTS_BAK.S6201 IS '';
COMMENT ON COLUMN BARS.TTS_BAK.S7201 IS '';
COMMENT ON COLUMN BARS.TTS_BAK.RANG IS '';
COMMENT ON COLUMN BARS.TTS_BAK.FLAGS IS '';
COMMENT ON COLUMN BARS.TTS_BAK.NAZN IS '';
COMMENT ON COLUMN BARS.TTS_BAK.ID IS '';




PROMPT *** Create  constraint SYS_C0030792 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_BAK MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0030793 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_BAK MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0030794 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_BAK MODIFY (FLC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0030795 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_BAK MODIFY (FLI NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0030796 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_BAK MODIFY (FLV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0030797 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_BAK MODIFY (FLR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0030798 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_BAK MODIFY (FLAGS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TTS_BAK ***
grant SELECT                                                                 on TTS_BAK         to BARSREADER_ROLE;
grant SELECT                                                                 on TTS_BAK         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TTS_BAK.sql =========*** End *** =====
PROMPT ===================================================================================== 
