PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/OUT_URI.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table OUT_URI ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.OUT_URI 
   (	GR_NAME VARCHAR2(50), 
	KF VARCHAR2(10), 
	ADR_NAME VARCHAR2(50), 
	USERNAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.OUT_URI IS 'Довідник адресатів';
COMMENT ON COLUMN BARSTRANS.OUT_URI.GR_NAME IS 'Імя групи розсилки';
COMMENT ON COLUMN BARSTRANS.OUT_URI.KF IS 'Ід адресата';
COMMENT ON COLUMN BARSTRANS.OUT_URI.ADR_NAME IS 'Імя адресата(значення з довідника адресатів)';
COMMENT ON COLUMN BARSTRANS.OUT_URI.USERNAME IS 'Імя облікових даних для авторизації';




PROMPT *** Create  constraint PK_OUT_URI2 ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_URI ADD CONSTRAINT PK_OUT_URI2 PRIMARY KEY (GR_NAME, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OUT_URI2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_OUT_URI2 ON BARSTRANS.OUT_URI (GR_NAME, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/OUT_URI.sql =========*** End *** 
PROMPT ===================================================================================== 

