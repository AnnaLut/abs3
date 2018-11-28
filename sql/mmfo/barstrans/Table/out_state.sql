

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/OUT_STATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table OUT_STATE ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.OUT_STATE 
   (	ID NUMBER, 
	CONST_N VARCHAR2(255), 
	NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.OUT_STATE IS 'Статуси вихідного запиту';
COMMENT ON COLUMN BARSTRANS.OUT_STATE.ID IS 'Ід статусу';
COMMENT ON COLUMN BARSTRANS.OUT_STATE.CONST_N IS 'Імя константи';
COMMENT ON COLUMN BARSTRANS.OUT_STATE.NAME IS 'Опис статусу';




PROMPT *** Create  constraint PK_OUT_STATE ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_STATE ADD CONSTRAINT PK_OUT_STATE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OUT_STATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_OUT_STATE ON BARSTRANS.OUT_STATE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/OUT_STATE.sql =========*** End **
PROMPT ===================================================================================== 

