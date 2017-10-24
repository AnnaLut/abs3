

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_CATEGORY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_CATEGORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_CATEGORY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_CATEGORY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_CATEGORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_CATEGORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_CATEGORY 
   (	RNK NUMBER(22,0), 
	CATEGORY_ID NUMBER(22,0), 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	USER_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_CATEGORY ***
 exec bpa.alter_policies('CUSTOMER_CATEGORY');


COMMENT ON TABLE BARS.CUSTOMER_CATEGORY IS 'Належність до особових категорій клієнтів';
COMMENT ON COLUMN BARS.CUSTOMER_CATEGORY.RNK IS 'РНК';
COMMENT ON COLUMN BARS.CUSTOMER_CATEGORY.CATEGORY_ID IS 'Код категорії';
COMMENT ON COLUMN BARS.CUSTOMER_CATEGORY.DAT_BEGIN IS 'Дата встановлення категорії';
COMMENT ON COLUMN BARS.CUSTOMER_CATEGORY.DAT_END IS 'Дата закінчення';
COMMENT ON COLUMN BARS.CUSTOMER_CATEGORY.USER_ID IS 'Користувач, що встановив категорію';




PROMPT *** Create  constraint PK_CUSTOMERCTG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_CATEGORY ADD CONSTRAINT PK_CUSTOMERCTG PRIMARY KEY (RNK, CATEGORY_ID, DAT_BEGIN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERCTG_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_CATEGORY ADD CONSTRAINT FK_CUSTOMERCTG_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERCTG_FMCATEGORY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_CATEGORY ADD CONSTRAINT FK_CUSTOMERCTG_FMCATEGORY FOREIGN KEY (CATEGORY_ID)
	  REFERENCES BARS.FM_CATEGORY (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERCTG_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_CATEGORY ADD CONSTRAINT FK_CUSTOMERCTG_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERCTG_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_CATEGORY MODIFY (RNK CONSTRAINT CC_CUSTOMERCTG_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERCTG_CATEGORYID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_CATEGORY MODIFY (CATEGORY_ID CONSTRAINT CC_CUSTOMERCTG_CATEGORYID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERCTG_DATBEGIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_CATEGORY MODIFY (DAT_BEGIN CONSTRAINT CC_CUSTOMERCTG_DATBEGIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERCTG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMERCTG ON BARS.CUSTOMER_CATEGORY (RNK, CATEGORY_ID, DAT_BEGIN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_CATEGORY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_CATEGORY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_CATEGORY to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_CATEGORY to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_CATEGORY.sql =========*** End
PROMPT ===================================================================================== 
