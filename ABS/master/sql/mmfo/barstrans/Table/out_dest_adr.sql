

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/OUT_DEST_ADR.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table OUT_DEST_ADR ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.OUT_DEST_ADR 
   (ADR_NAME VARCHAR2(50), 
	ADR_DESC VARCHAR2(255), 
	BASE_HOST VARCHAR2(255), 
	IS_ACTIVE NUMBER(1,0), 
	IS_LOCAL NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.OUT_DEST_ADR IS 'Довідник адрес веб сервісів';
COMMENT ON COLUMN BARSTRANS.OUT_DEST_ADR.BASE_HOST IS 'Адреса веб сервісу';
COMMENT ON COLUMN BARSTRANS.OUT_DEST_ADR.IS_ACTIVE IS 'Признак актуальності 1-так, 2-ні';
COMMENT ON COLUMN BARSTRANS.OUT_DEST_ADR.IS_LOCAL IS 'Признак передачі даних локально 1-так, 2-ні';
COMMENT ON COLUMN BARSTRANS.OUT_DEST_ADR.ADR_NAME IS 'Назва адреси';
COMMENT ON COLUMN BARSTRANS.OUT_DEST_ADR.ADR_DESC IS 'Опис адреси';




PROMPT *** Create  constraint PK_OUT_DEST_ADR ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_DEST_ADR ADD CONSTRAINT PK_OUT_DEST_ADR PRIMARY KEY (ADR_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OUT_DEST_ADR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_OUT_DEST_ADR ON BARSTRANS.OUT_DEST_ADR (ADR_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/OUT_DEST_ADR.sql =========*** End
PROMPT ===================================================================================== 

