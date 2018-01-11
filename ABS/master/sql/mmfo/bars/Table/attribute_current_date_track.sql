

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_CURRENT_DATE_TRACK.sql =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_CURRENT_DATE_TRACK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_CURRENT_DATE_TRACK'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_CURRENT_DATE_TRACK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_CURRENT_DATE_TRACK 
   (	ATTRIBUTE_KIND_ID NUMBER(5,0), 
	VALUE_DATE DATE, 
	START_TIME DATE, 
	FINISH_TIME DATE, 
	COMMENT_TEXT VARCHAR2(4000), 
	STACK_TRACE CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (STACK_TRACE) STORE AS BASICFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_CURRENT_DATE_TRACK ***
 exec bpa.alter_policies('ATTRIBUTE_CURRENT_DATE_TRACK');


COMMENT ON TABLE BARS.ATTRIBUTE_CURRENT_DATE_TRACK IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_CURRENT_DATE_TRACK.COMMENT_TEXT IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_CURRENT_DATE_TRACK.STACK_TRACE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_CURRENT_DATE_TRACK.VALUE_DATE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_CURRENT_DATE_TRACK.START_TIME IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_CURRENT_DATE_TRACK.FINISH_TIME IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_CURRENT_DATE_TRACK.ATTRIBUTE_KIND_ID IS '';




PROMPT *** Create  constraint SYS_C0025679 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_CURRENT_DATE_TRACK MODIFY (ATTRIBUTE_KIND_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025680 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_CURRENT_DATE_TRACK MODIFY (VALUE_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025681 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_CURRENT_DATE_TRACK MODIFY (START_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_CURRENT_DATE_TRACK ***
grant SELECT                                                                 on ATTRIBUTE_CURRENT_DATE_TRACK to BARSREADER_ROLE;
grant SELECT                                                                 on ATTRIBUTE_CURRENT_DATE_TRACK to BARS_DM;
grant SELECT                                                                 on ATTRIBUTE_CURRENT_DATE_TRACK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_CURRENT_DATE_TRACK.sql =====
PROMPT ===================================================================================== 
