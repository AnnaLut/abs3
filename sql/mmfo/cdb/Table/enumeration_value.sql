

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/ENUMERATION_VALUE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table ENUMERATION_VALUE ***
begin 
  execute immediate '
  CREATE TABLE CDB.ENUMERATION_VALUE 
   (	ENUMERATION_TYPE_ID NUMBER(5,0), 
	ENUMERATION_ID NUMBER(5,0), 
	ENUMERATION_CODE VARCHAR2(30 CHAR), 
	ENUMERATION_NAME VARCHAR2(300 CHAR), 
	PARENT_ID NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.ENUMERATION_VALUE IS '';
COMMENT ON COLUMN CDB.ENUMERATION_VALUE.ENUMERATION_TYPE_ID IS '';
COMMENT ON COLUMN CDB.ENUMERATION_VALUE.ENUMERATION_ID IS '';
COMMENT ON COLUMN CDB.ENUMERATION_VALUE.ENUMERATION_CODE IS '';
COMMENT ON COLUMN CDB.ENUMERATION_VALUE.ENUMERATION_NAME IS '';
COMMENT ON COLUMN CDB.ENUMERATION_VALUE.PARENT_ID IS '';




PROMPT *** Create  constraint SYS_C00118905 ***
begin   
 execute immediate '
  ALTER TABLE CDB.ENUMERATION_VALUE MODIFY (ENUMERATION_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118906 ***
begin   
 execute immediate '
  ALTER TABLE CDB.ENUMERATION_VALUE MODIFY (ENUMERATION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118907 ***
begin   
 execute immediate '
  ALTER TABLE CDB.ENUMERATION_VALUE MODIFY (ENUMERATION_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ENUMERATION_VALUE ***
begin   
 execute immediate '
  ALTER TABLE CDB.ENUMERATION_VALUE ADD CONSTRAINT PK_ENUMERATION_VALUE PRIMARY KEY (ENUMERATION_TYPE_ID, ENUMERATION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ENUMERATION_VALUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_ENUMERATION_VALUE ON CDB.ENUMERATION_VALUE (ENUMERATION_TYPE_ID, ENUMERATION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index ENUMERATION_VAL_IDX ***
begin   
 execute immediate '
  CREATE INDEX CDB.ENUMERATION_VAL_IDX ON CDB.ENUMERATION_VALUE (ENUMERATION_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ENUMERATION_VALUE ***
grant SELECT                                                                 on ENUMERATION_VALUE to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/ENUMERATION_VALUE.sql =========*** End 
PROMPT ===================================================================================== 
