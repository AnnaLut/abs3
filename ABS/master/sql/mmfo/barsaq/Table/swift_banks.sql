

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/SWIFT_BANKS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table SWIFT_BANKS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.SWIFT_BANKS 
   (	BIC_ID VARCHAR2(11), 
	NAME VARCHAR2(254), 
	OFFICE VARCHAR2(254), 
	CITY VARCHAR2(35), 
	COUNTRY VARCHAR2(64), 
	CLOSING_DATE DATE, 
	 CONSTRAINT PK_SWIFTBANKS PRIMARY KEY (BIC_ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE AQTS 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.SWIFT_BANKS IS 'SWIFT банки';
COMMENT ON COLUMN BARSAQ.SWIFT_BANKS.BIC_ID IS 'BIC код банку';
COMMENT ON COLUMN BARSAQ.SWIFT_BANKS.NAME IS 'Назва банку(міжнародна, англ.)';
COMMENT ON COLUMN BARSAQ.SWIFT_BANKS.OFFICE IS 'Адреса офісу';
COMMENT ON COLUMN BARSAQ.SWIFT_BANKS.CITY IS 'Місто, де знаходиться банк';
COMMENT ON COLUMN BARSAQ.SWIFT_BANKS.COUNTRY IS 'Країна, де знаходиться банк';
COMMENT ON COLUMN BARSAQ.SWIFT_BANKS.CLOSING_DATE IS 'Дата закриття банку';




PROMPT *** Create  constraint CC_SWIFTBANKS_BIC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.SWIFT_BANKS MODIFY (BIC_ID CONSTRAINT CC_SWIFTBANKS_BIC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWIFTBANKS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.SWIFT_BANKS MODIFY (NAME CONSTRAINT CC_SWIFTBANKS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWIFTBANKS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.SWIFT_BANKS ADD CONSTRAINT PK_SWIFTBANKS PRIMARY KEY (BIC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWIFTBANKS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_SWIFTBANKS ON BARSAQ.SWIFT_BANKS (BIC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SWIFT_BANKS ***
grant SELECT                                                                 on SWIFT_BANKS     to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/SWIFT_BANKS.sql =========*** End ***
PROMPT ===================================================================================== 
