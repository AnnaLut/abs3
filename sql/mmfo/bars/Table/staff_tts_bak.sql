

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_TTS_BAK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_TTS_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_TTS_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_TTS_BAK 
   (	TT CHAR(3), 
	ID NUMBER(38,0), 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
	REVOKED NUMBER(1,0), 
	GRANTOR NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_TTS_BAK ***
 exec bpa.alter_policies('STAFF_TTS_BAK');


COMMENT ON TABLE BARS.STAFF_TTS_BAK IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_BAK.TT IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_BAK.ID IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_BAK.APPROVE IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_BAK.ADATE1 IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_BAK.ADATE2 IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_BAK.RDATE1 IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_BAK.RDATE2 IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_BAK.REVOKED IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_BAK.GRANTOR IS '';




PROMPT *** Create  constraint SYS_C0025762 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TTS_BAK MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025763 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TTS_BAK MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_TTS_BAK ***
grant SELECT                                                                 on STAFF_TTS_BAK   to BARSREADER_ROLE;
grant SELECT                                                                 on STAFF_TTS_BAK   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_TTS_BAK.sql =========*** End ***
PROMPT ===================================================================================== 
