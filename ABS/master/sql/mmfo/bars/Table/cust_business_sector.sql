

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUST_BUSINESS_SECTOR.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUST_BUSINESS_SECTOR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUST_BUSINESS_SECTOR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUST_BUSINESS_SECTOR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUST_BUSINESS_SECTOR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUST_BUSINESS_SECTOR ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUST_BUSINESS_SECTOR 
   (	ID NUMBER(3,0), 
	NAME VARCHAR2(30), 
	DESCRIPTION VARCHAR2(200), 
	LINE_ID NUMBER(2,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUST_BUSINESS_SECTOR ***
 exec bpa.alter_policies('CUST_BUSINESS_SECTOR');


COMMENT ON TABLE BARS.CUST_BUSINESS_SECTOR IS 'Довідник бізнес-секторів (сегментація клієнтів ЮО)';
COMMENT ON COLUMN BARS.CUST_BUSINESS_SECTOR.ID IS 'Ідентифікатор бізнес-сектору';
COMMENT ON COLUMN BARS.CUST_BUSINESS_SECTOR.NAME IS 'Назва бізнес-сектору';
COMMENT ON COLUMN BARS.CUST_BUSINESS_SECTOR.DESCRIPTION IS 'Опис';
COMMENT ON COLUMN BARS.CUST_BUSINESS_SECTOR.LINE_ID IS 'Ідентифікатор бізнес-напрямку';




PROMPT *** Create  constraint PK_CUSTBIZSECTOR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_BUSINESS_SECTOR ADD CONSTRAINT PK_CUSTBIZSECTOR PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTBIZSECTOR_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_BUSINESS_SECTOR MODIFY (ID CONSTRAINT CC_CUSTBIZSECTOR_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTBIZSECTOR_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_BUSINESS_SECTOR MODIFY (NAME CONSTRAINT CC_CUSTBIZSECTOR_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTBIZSECTOR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTBIZSECTOR ON BARS.CUST_BUSINESS_SECTOR (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUST_BUSINESS_SECTOR ***
grant SELECT                                                                 on CUST_BUSINESS_SECTOR to BARSREADER_ROLE;
grant SELECT                                                                 on CUST_BUSINESS_SECTOR to BARSUPL;
grant SELECT                                                                 on CUST_BUSINESS_SECTOR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUST_BUSINESS_SECTOR to BARS_DM;
grant SELECT                                                                 on CUST_BUSINESS_SECTOR to START1;
grant SELECT                                                                 on CUST_BUSINESS_SECTOR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUST_BUSINESS_SECTOR.sql =========*** 
PROMPT ===================================================================================== 
