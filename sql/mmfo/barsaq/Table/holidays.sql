

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/HOLIDAYS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table HOLIDAYS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.HOLIDAYS 
   (	HOLIDAY DATE, 
	CUR_ID NUMBER(3,0), 
	 CONSTRAINT PK_HOLIDAYS PRIMARY KEY (HOLIDAY, CUR_ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE AQTS 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.HOLIDAYS IS 'Календарь выходных и праздников';
COMMENT ON COLUMN BARSAQ.HOLIDAYS.HOLIDAY IS 'Дата выходного и праздника';
COMMENT ON COLUMN BARSAQ.HOLIDAYS.CUR_ID IS 'Код валюты';




PROMPT *** Create  constraint CC_HOLIDAYS_HOLIDAY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.HOLIDAYS MODIFY (HOLIDAY CONSTRAINT CC_HOLIDAYS_HOLIDAY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_HOLIDAYS_CURID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.HOLIDAYS MODIFY (CUR_ID CONSTRAINT CC_HOLIDAYS_CURID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_HOLIDAYS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.HOLIDAYS ADD CONSTRAINT PK_HOLIDAYS PRIMARY KEY (HOLIDAY, CUR_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_HOLIDAYS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_HOLIDAYS ON BARSAQ.HOLIDAYS (HOLIDAY, CUR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/HOLIDAYS.sql =========*** End *** ==
PROMPT ===================================================================================== 
