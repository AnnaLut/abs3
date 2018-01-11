

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ATTRIBUTE_HISTORY_102.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ATTRIBUTE_HISTORY_102 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ATTRIBUTE_HISTORY_102 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ATTRIBUTE_HISTORY_102 
   (	ID NUMBER(10,0), 
	OBJECT_ID NUMBER(12,0), 
	ATTRIBUTE_ID NUMBER(5,0), 
	VALUE_DATE DATE, 
	USER_ID NUMBER(5,0), 
	SYS_TIME DATE, 
	IS_DELETE CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ATTRIBUTE_HISTORY_102 ***
 exec bpa.alter_policies('TMP_ATTRIBUTE_HISTORY_102');


COMMENT ON TABLE BARS.TMP_ATTRIBUTE_HISTORY_102 IS '';
COMMENT ON COLUMN BARS.TMP_ATTRIBUTE_HISTORY_102.ID IS '';
COMMENT ON COLUMN BARS.TMP_ATTRIBUTE_HISTORY_102.OBJECT_ID IS '';
COMMENT ON COLUMN BARS.TMP_ATTRIBUTE_HISTORY_102.ATTRIBUTE_ID IS '';
COMMENT ON COLUMN BARS.TMP_ATTRIBUTE_HISTORY_102.VALUE_DATE IS '';
COMMENT ON COLUMN BARS.TMP_ATTRIBUTE_HISTORY_102.USER_ID IS '';
COMMENT ON COLUMN BARS.TMP_ATTRIBUTE_HISTORY_102.SYS_TIME IS '';
COMMENT ON COLUMN BARS.TMP_ATTRIBUTE_HISTORY_102.IS_DELETE IS '';




PROMPT *** Create  constraint SYS_C00139287 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ATTRIBUTE_HISTORY_102 MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139288 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ATTRIBUTE_HISTORY_102 MODIFY (OBJECT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139289 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ATTRIBUTE_HISTORY_102 MODIFY (ATTRIBUTE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139290 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ATTRIBUTE_HISTORY_102 MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139291 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ATTRIBUTE_HISTORY_102 MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DEL_4 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_DEL_4 ON BARS.TMP_ATTRIBUTE_HISTORY_102 (OBJECT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ATTRIBUTE_HISTORY_102 ***
grant SELECT                                                                 on TMP_ATTRIBUTE_HISTORY_102 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ATTRIBUTE_HISTORY_102.sql ========
PROMPT ===================================================================================== 
