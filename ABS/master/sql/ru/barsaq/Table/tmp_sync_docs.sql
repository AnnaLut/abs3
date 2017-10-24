

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_SYNC_DOCS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_SYNC_DOCS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.TMP_SYNC_DOCS 
   (	DOC_ID NUMBER(*,0), 
	STATUS_ID NUMBER(*,0), 
	STATUS_CHANGE_TIME DATE, 
	BANK_BACK_REASON VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE AQTS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_SYNC_DOCS IS '';
COMMENT ON COLUMN BARSAQ.TMP_SYNC_DOCS.DOC_ID IS '';
COMMENT ON COLUMN BARSAQ.TMP_SYNC_DOCS.STATUS_ID IS '';
COMMENT ON COLUMN BARSAQ.TMP_SYNC_DOCS.STATUS_CHANGE_TIME IS '';
COMMENT ON COLUMN BARSAQ.TMP_SYNC_DOCS.BANK_BACK_REASON IS '';




PROMPT *** Create  constraint SYS_C002539198 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_SYNC_DOCS MODIFY (STATUS_CHANGE_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002539197 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_SYNC_DOCS MODIFY (STATUS_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002539196 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_SYNC_DOCS MODIFY (DOC_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_SYNC_DOCS.sql =========*** End *
PROMPT ===================================================================================== 
