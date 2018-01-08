

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CHKLIST_TTS_GOU.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CHKLIST_TTS_GOU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CHKLIST_TTS_GOU ***
begin 
  execute immediate '
  CREATE TABLE BARS.CHKLIST_TTS_GOU 
   (	TT CHAR(3), 
	IDCHK NUMBER(*,0), 
	PRIORITY NUMBER(*,0), 
	F_BIG_AMOUNT NUMBER(1,0), 
	SQLVAL VARCHAR2(2048), 
	F_IN_CHARGE NUMBER(*,0), 
	FLAGS NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CHKLIST_TTS_GOU ***
 exec bpa.alter_policies('CHKLIST_TTS_GOU');


COMMENT ON TABLE BARS.CHKLIST_TTS_GOU IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_GOU.TT IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_GOU.IDCHK IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_GOU.PRIORITY IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_GOU.F_BIG_AMOUNT IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_GOU.SQLVAL IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_GOU.F_IN_CHARGE IS '';
COMMENT ON COLUMN BARS.CHKLIST_TTS_GOU.FLAGS IS '';




PROMPT *** Create  constraint SYS_C008951 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_TTS_GOU MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008952 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_TTS_GOU MODIFY (IDCHK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CHKLIST_TTS_GOU ***
grant SELECT                                                                 on CHKLIST_TTS_GOU to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CHKLIST_TTS_GOU.sql =========*** End *
PROMPT ===================================================================================== 
