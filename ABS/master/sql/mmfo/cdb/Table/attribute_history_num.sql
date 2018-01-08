

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/ATTRIBUTE_HISTORY_NUM.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table ATTRIBUTE_HISTORY_NUM ***
begin 
  execute immediate '
  CREATE TABLE CDB.ATTRIBUTE_HISTORY_NUM 
   (	ID NUMBER(10,0), 
	VALUE NUMBER(32,12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.ATTRIBUTE_HISTORY_NUM IS '';
COMMENT ON COLUMN CDB.ATTRIBUTE_HISTORY_NUM.ID IS '';
COMMENT ON COLUMN CDB.ATTRIBUTE_HISTORY_NUM.VALUE IS 'Значение типа строка';




PROMPT *** Create  constraint PK_ATTRIBUTE_HISTORY_NUM ***
begin   
 execute immediate '
  ALTER TABLE CDB.ATTRIBUTE_HISTORY_NUM ADD CONSTRAINT PK_ATTRIBUTE_HISTORY_NUM PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118860 ***
begin   
 execute immediate '
  ALTER TABLE CDB.ATTRIBUTE_HISTORY_NUM MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ATTRIBUTE_HISTORY_NUM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_ATTRIBUTE_HISTORY_NUM ON CDB.ATTRIBUTE_HISTORY_NUM (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_HISTORY_NUM ***
grant SELECT                                                                 on ATTRIBUTE_HISTORY_NUM to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/ATTRIBUTE_HISTORY_NUM.sql =========*** 
PROMPT ===================================================================================== 
