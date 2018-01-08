

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/ATTRIBUTE_HISTORY_STRING.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  table ATTRIBUTE_HISTORY_STRING ***
begin 
  execute immediate '
  CREATE TABLE CDB.ATTRIBUTE_HISTORY_STRING 
   (	ID NUMBER(10,0), 
	VALUE VARCHAR2(500 CHAR)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.ATTRIBUTE_HISTORY_STRING IS '';
COMMENT ON COLUMN CDB.ATTRIBUTE_HISTORY_STRING.ID IS '';
COMMENT ON COLUMN CDB.ATTRIBUTE_HISTORY_STRING.VALUE IS 'Значение типа строка';




PROMPT *** Create  constraint PK_ATTRIBUTE_HISTORY_STRING ***
begin   
 execute immediate '
  ALTER TABLE CDB.ATTRIBUTE_HISTORY_STRING ADD CONSTRAINT PK_ATTRIBUTE_HISTORY_STRING PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118857 ***
begin   
 execute immediate '
  ALTER TABLE CDB.ATTRIBUTE_HISTORY_STRING MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ATTRIBUTE_HISTORY_STRING ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_ATTRIBUTE_HISTORY_STRING ON CDB.ATTRIBUTE_HISTORY_STRING (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_HISTORY_STRING ***
grant SELECT                                                                 on ATTRIBUTE_HISTORY_STRING to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/ATTRIBUTE_HISTORY_STRING.sql =========*
PROMPT ===================================================================================== 
