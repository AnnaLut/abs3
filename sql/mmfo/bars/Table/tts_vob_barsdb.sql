

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TTS_VOB_BARSDB.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TTS_VOB_BARSDB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TTS_VOB_BARSDB ***
begin 
  execute immediate '
  CREATE TABLE BARS.TTS_VOB_BARSDB 
   (	TT CHAR(3), 
	VOB NUMBER(38,0), 
	ORD NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TTS_VOB_BARSDB ***
 exec bpa.alter_policies('TTS_VOB_BARSDB');


COMMENT ON TABLE BARS.TTS_VOB_BARSDB IS '';
COMMENT ON COLUMN BARS.TTS_VOB_BARSDB.TT IS '';
COMMENT ON COLUMN BARS.TTS_VOB_BARSDB.VOB IS '';
COMMENT ON COLUMN BARS.TTS_VOB_BARSDB.ORD IS '';




PROMPT *** Create  constraint SYS_C007003 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_VOB_BARSDB MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007004 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_VOB_BARSDB MODIFY (VOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TTS_VOB_BARSDB ***
grant SELECT                                                                 on TTS_VOB_BARSDB  to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TTS_VOB_BARSDB.sql =========*** End **
PROMPT ===================================================================================== 
