

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/BANK_UFILE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table BANK_UFILE ***
begin 
  execute immediate '
  CREATE TABLE FINMON.BANK_UFILE 
   (	BRANCH_ID VARCHAR2(15), 
	STATUS NUMBER(3,0), 
	FILE_ID VARCHAR2(15), 
	ID NUMBER(18,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.BANK_UFILE IS '';
COMMENT ON COLUMN FINMON.BANK_UFILE.BRANCH_ID IS '';
COMMENT ON COLUMN FINMON.BANK_UFILE.STATUS IS '';
COMMENT ON COLUMN FINMON.BANK_UFILE.FILE_ID IS '';
COMMENT ON COLUMN FINMON.BANK_UFILE.ID IS '';




PROMPT *** Create  constraint FK_BANK_UFILE_BRANCH_ID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK_UFILE ADD CONSTRAINT FK_BANK_UFILE_BRANCH_ID FOREIGN KEY (BRANCH_ID)
	  REFERENCES FINMON.BANK (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANK_UFILE_STATUS ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK_UFILE ADD CONSTRAINT FK_BANK_UFILE_STATUS FOREIGN KEY (STATUS)
	  REFERENCES FINMON.STATUS_FILE (STATUS_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANK_UFILE_FILE_ID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK_UFILE ADD CONSTRAINT FK_BANK_UFILE_FILE_ID FOREIGN KEY (FILE_ID, BRANCH_ID)
	  REFERENCES FINMON.FILE_OUT (ID, BRANCH_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_BANK_UFILE_ID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK_UFILE ADD CONSTRAINT XPK_BANK_UFILE_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032072 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK_UFILE MODIFY (BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032074 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK_UFILE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032073 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK_UFILE MODIFY (STATUS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BANK_UFILE_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_BANK_UFILE_ID ON FINMON.BANK_UFILE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/BANK_UFILE.sql =========*** End *** 
PROMPT ===================================================================================== 
