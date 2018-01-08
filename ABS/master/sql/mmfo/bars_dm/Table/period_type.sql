

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/PERIOD_TYPE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table PERIOD_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.PERIOD_TYPE 
   (	ID VARCHAR2(10), 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.PERIOD_TYPE IS 'Типи імпорту';
COMMENT ON COLUMN BARS_DM.PERIOD_TYPE.ID IS 'Код типу імпорту';
COMMENT ON COLUMN BARS_DM.PERIOD_TYPE.NAME IS 'Назва типу імпорту';




PROMPT *** Create  constraint PK_PERIODTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.PERIOD_TYPE ADD CONSTRAINT PK_PERIODTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PERIODTYPE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.PERIOD_TYPE MODIFY (NAME CONSTRAINT CC_PERIODTYPE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PERIODTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS_DM.PK_PERIODTYPE ON BARS_DM.PERIOD_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PERIOD_TYPE ***
grant SELECT                                                                 on PERIOD_TYPE     to BARSREADER_ROLE;
grant SELECT                                                                 on PERIOD_TYPE     to BARSUPL;
grant SELECT                                                                 on PERIOD_TYPE     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/PERIOD_TYPE.sql =========*** End **
PROMPT ===================================================================================== 
