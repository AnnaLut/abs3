

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/ENUMERATION_TYPE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table ENUMERATION_TYPE ***
begin 
  execute immediate '
  CREATE TABLE CDB.ENUMERATION_TYPE 
   (	ID NUMBER(5,0), 
	ENUMERATION_NAME VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.ENUMERATION_TYPE IS '';
COMMENT ON COLUMN CDB.ENUMERATION_TYPE.ID IS '';
COMMENT ON COLUMN CDB.ENUMERATION_TYPE.ENUMERATION_NAME IS '';




PROMPT *** Create  constraint SYS_C00118855 ***
begin   
 execute immediate '
  ALTER TABLE CDB.ENUMERATION_TYPE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118856 ***
begin   
 execute immediate '
  ALTER TABLE CDB.ENUMERATION_TYPE MODIFY (ENUMERATION_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ENUMERATION_TYPE ***
begin   
 execute immediate '
  ALTER TABLE CDB.ENUMERATION_TYPE ADD CONSTRAINT PK_ENUMERATION_TYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ENUMERATION_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_ENUMERATION_TYPE ON CDB.ENUMERATION_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ENUMERATION_TYPE ***
grant SELECT                                                                 on ENUMERATION_TYPE to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/ENUMERATION_TYPE.sql =========*** End *
PROMPT ===================================================================================== 
