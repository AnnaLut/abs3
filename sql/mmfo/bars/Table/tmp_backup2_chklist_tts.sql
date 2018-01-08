

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BACKUP2_CHKLIST_TTS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BACKUP2_CHKLIST_TTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BACKUP2_CHKLIST_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BACKUP2_CHKLIST_TTS 
   (	TT CHAR(3), 
	IDCHK NUMBER(38,0), 
	PRIORITY NUMBER(5,0), 
	F_BIG_AMOUNT NUMBER(1,0), 
	SQLVAL VARCHAR2(2048), 
	F_IN_CHARGE NUMBER(38,0), 
	FLAGS NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BACKUP2_CHKLIST_TTS ***
 exec bpa.alter_policies('TMP_BACKUP2_CHKLIST_TTS');


COMMENT ON TABLE BARS.TMP_BACKUP2_CHKLIST_TTS IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_CHKLIST_TTS.TT IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_CHKLIST_TTS.IDCHK IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_CHKLIST_TTS.PRIORITY IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_CHKLIST_TTS.F_BIG_AMOUNT IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_CHKLIST_TTS.SQLVAL IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_CHKLIST_TTS.F_IN_CHARGE IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP2_CHKLIST_TTS.FLAGS IS '';




PROMPT *** Create  constraint SYS_C0048368 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP2_CHKLIST_TTS MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048369 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP2_CHKLIST_TTS MODIFY (IDCHK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048370 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP2_CHKLIST_TTS MODIFY (PRIORITY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_BACKUP2_CHKLIST_TTS ***
grant SELECT                                                                 on TMP_BACKUP2_CHKLIST_TTS to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_BACKUP2_CHKLIST_TTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BACKUP2_CHKLIST_TTS.sql =========*
PROMPT ===================================================================================== 
