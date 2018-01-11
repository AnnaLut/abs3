

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CHKLIST_TTS_UPDATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CHKLIST_TTS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CHKLIST_TTS_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CHKLIST_TTS_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CHKLIST_TTS_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CHKLIST_TTS_UPDATE 
   (	TT CHAR(3), 
	IDCHK NUMBER(38,0), 
	PRIORITY NUMBER(5,0), 
	F_BIG_AMOUNT NUMBER(1,0), 
	SQLVAL VARCHAR2(2048), 
	F_IN_CHARGE NUMBER(38,0), 
	FLAGS NUMBER(*,0), 
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




PROMPT *** ALTER_POLICIES to CHKLIST_TTS_UPDATE ***
 exec bpa.alter_policies('CHKLIST_TTS_UPDATE');


COMMENT ON TABLE BARS.CHKLIST_TTS_UPDATE IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_UPDATE.F_BIG_AMOUNT IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_UPDATE.SQLVAL IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_UPDATE.F_IN_CHARGE IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_UPDATE.FLAGS IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_UPDATE.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_UPDATE.MACHINE IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_UPDATE.IP IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_UPDATE.OSUSERS IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_UPDATE.TT IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_UPDATE.IDCHK IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_UPDATE.PRIORITY IS '';




PROMPT *** Create  constraint PK_CHKLIST_TTS_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_TTS_UPDATE ADD CONSTRAINT PK_CHKLIST_TTS_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CHKLIST_TTS_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CHKLIST_TTS_UPDATE ON BARS.CHKLIST_TTS_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CHKLIST_TTS_UPDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_CHKLIST_TTS_UPDATE ON BARS.CHKLIST_TTS_UPDATE (CHGDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CHKLIST_TTS_UPDATE ***
grant SELECT                                                                 on CHKLIST_TTS_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CHKLIST_TTS_UPDATE.sql =========*** En
PROMPT ===================================================================================== 
