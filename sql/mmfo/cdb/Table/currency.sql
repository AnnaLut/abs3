

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/CURRENCY.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  table CURRENCY ***
begin 
  execute immediate '
  CREATE TABLE CDB.CURRENCY 
   (	ID NUMBER(3,0), 
	ISO_CODE VARCHAR2(3 CHAR), 
	NAME VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.CURRENCY IS '';
COMMENT ON COLUMN CDB.CURRENCY.ID IS '';
COMMENT ON COLUMN CDB.CURRENCY.ISO_CODE IS '';
COMMENT ON COLUMN CDB.CURRENCY.NAME IS '';




PROMPT *** Create  constraint SYS_C00118879 ***
begin   
 execute immediate '
  ALTER TABLE CDB.CURRENCY MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118880 ***
begin   
 execute immediate '
  ALTER TABLE CDB.CURRENCY MODIFY (ISO_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CURRENCY ***
begin   
 execute immediate '
  ALTER TABLE CDB.CURRENCY ADD CONSTRAINT PK_CURRENCY PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CURRENCY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_CURRENCY ON CDB.CURRENCY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CURRENCY ***
grant SELECT                                                                 on CURRENCY        to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/CURRENCY.sql =========*** End *** =====
PROMPT ===================================================================================== 
