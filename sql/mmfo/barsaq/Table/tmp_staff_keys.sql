

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_STAFF_KEYS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_STAFF_KEYS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.TMP_STAFF_KEYS 
   (	USER_ID NUMBER(38,0), 
	KEY_TYPE VARCHAR2(3), 
	KEY_ID VARCHAR2(256)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE AQTS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_STAFF_KEYS IS '';
COMMENT ON COLUMN BARSAQ.TMP_STAFF_KEYS.USER_ID IS '';
COMMENT ON COLUMN BARSAQ.TMP_STAFF_KEYS.KEY_TYPE IS '';
COMMENT ON COLUMN BARSAQ.TMP_STAFF_KEYS.KEY_ID IS '';




PROMPT *** Create  constraint SYS_C00109355 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_STAFF_KEYS MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_STAFF_KEYS ***
grant SELECT                                                                 on TMP_STAFF_KEYS  to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_STAFF_KEYS.sql =========*** End 
PROMPT ===================================================================================== 
