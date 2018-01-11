

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/BARS_DOCUMENT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table BARS_DOCUMENT ***
begin 
  execute immediate '
  CREATE TABLE CDB.BARS_DOCUMENT 
   (	ID NUMBER(10,0), 
	OPERATION_TYPE VARCHAR2(3 CHAR), 
	DOCUMENT_KIND NUMBER(5,0), 
	ACCOUNT_A_ID NUMBER(10,0), 
	ACCOUNT_B_ID NUMBER(10,0), 
	AMOUNT NUMBER(22,2), 
	CURRENCY_ID NUMBER(3,0), 
	PURPOSE VARCHAR2(4000), 
	SYS_TIME DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.BARS_DOCUMENT IS '';
COMMENT ON COLUMN CDB.BARS_DOCUMENT.ID IS '';
COMMENT ON COLUMN CDB.BARS_DOCUMENT.OPERATION_TYPE IS '';
COMMENT ON COLUMN CDB.BARS_DOCUMENT.DOCUMENT_KIND IS '';
COMMENT ON COLUMN CDB.BARS_DOCUMENT.ACCOUNT_A_ID IS '';
COMMENT ON COLUMN CDB.BARS_DOCUMENT.ACCOUNT_B_ID IS '';
COMMENT ON COLUMN CDB.BARS_DOCUMENT.AMOUNT IS '';
COMMENT ON COLUMN CDB.BARS_DOCUMENT.CURRENCY_ID IS '';
COMMENT ON COLUMN CDB.BARS_DOCUMENT.PURPOSE IS '';
COMMENT ON COLUMN CDB.BARS_DOCUMENT.SYS_TIME IS '';




PROMPT *** Create  constraint PK_BARS_DOCUMENT ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_DOCUMENT ADD CONSTRAINT PK_BARS_DOCUMENT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118891 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_DOCUMENT MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118892 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_DOCUMENT MODIFY (OPERATION_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118893 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_DOCUMENT MODIFY (DOCUMENT_KIND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118894 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_DOCUMENT MODIFY (AMOUNT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118895 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_DOCUMENT MODIFY (CURRENCY_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118896 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_DOCUMENT MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BARS_DOCUMENT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_BARS_DOCUMENT ON CDB.BARS_DOCUMENT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BARS_DOCUMENT ***
grant SELECT                                                                 on BARS_DOCUMENT   to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/BARS_DOCUMENT.sql =========*** End *** 
PROMPT ===================================================================================== 
