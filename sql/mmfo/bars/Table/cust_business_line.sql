

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUST_BUSINESS_LINE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUST_BUSINESS_LINE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUST_BUSINESS_LINE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUST_BUSINESS_LINE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUST_BUSINESS_LINE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUST_BUSINESS_LINE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUST_BUSINESS_LINE 
   (	ID NUMBER(2,0), 
	NAME VARCHAR2(30), 
	DESCRIPTION VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUST_BUSINESS_LINE ***
 exec bpa.alter_policies('CUST_BUSINESS_LINE');


COMMENT ON TABLE BARS.CUST_BUSINESS_LINE IS 'Довідник бізнес-напрямків (сегментація клієнтів ЮО)';
COMMENT ON COLUMN BARS.CUST_BUSINESS_LINE.ID IS 'Ідентифікатор бізнес-напрямку';
COMMENT ON COLUMN BARS.CUST_BUSINESS_LINE.NAME IS 'Назва бізнес-напрямку';
COMMENT ON COLUMN BARS.CUST_BUSINESS_LINE.DESCRIPTION IS 'Опис';




PROMPT *** Create  constraint PK_CUSTBIZLINE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_BUSINESS_LINE ADD CONSTRAINT PK_CUSTBIZLINE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTBIZLINE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_BUSINESS_LINE MODIFY (ID CONSTRAINT CC_CUSTBIZLINE_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTBIZLINE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_BUSINESS_LINE MODIFY (NAME CONSTRAINT CC_CUSTBIZLINE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTBIZLINE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTBIZLINE ON BARS.CUST_BUSINESS_LINE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUST_BUSINESS_LINE ***
grant SELECT                                                                 on CUST_BUSINESS_LINE to BARSREADER_ROLE;
grant SELECT                                                                 on CUST_BUSINESS_LINE to BARSUPL;
grant SELECT                                                                 on CUST_BUSINESS_LINE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUST_BUSINESS_LINE to BARS_DM;
grant SELECT                                                                 on CUST_BUSINESS_LINE to START1;
grant SELECT                                                                 on CUST_BUSINESS_LINE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUST_BUSINESS_LINE.sql =========*** En
PROMPT ===================================================================================== 
