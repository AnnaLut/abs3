

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BACKUP_CHKLIST_TTS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BACKUP_CHKLIST_TTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BACKUP_CHKLIST_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BACKUP_CHKLIST_TTS 
   (	TT CHAR(3), 
	IDCHK NUMBER(38,0), 
	F_IN_CHARGE NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BACKUP_CHKLIST_TTS ***
 exec bpa.alter_policies('TMP_BACKUP_CHKLIST_TTS');


COMMENT ON TABLE BARS.TMP_BACKUP_CHKLIST_TTS IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP_CHKLIST_TTS.TT IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP_CHKLIST_TTS.IDCHK IS '';
COMMENT ON COLUMN BARS.TMP_BACKUP_CHKLIST_TTS.F_IN_CHARGE IS '';




PROMPT *** Create  constraint SYS_C0048356 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP_CHKLIST_TTS MODIFY (IDCHK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048355 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BACKUP_CHKLIST_TTS MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BACKUP_CHKLIST_TTS.sql =========**
PROMPT ===================================================================================== 
