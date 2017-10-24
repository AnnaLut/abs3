

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEAL_PRODUCT_CHECK.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEAL_PRODUCT_CHECK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEAL_PRODUCT_CHECK'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEAL_PRODUCT_CHECK ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEAL_PRODUCT_CHECK 
   (	PRODUCT_ID NUMBER(5,0), 
	ATTRIBUTE_ID NUMBER(5,0), 
	VALID_FROM DATE, 
	VALID_THROUGH DATE, 
	CHECK_ID NUMBER(5,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEAL_PRODUCT_CHECK ***
 exec bpa.alter_policies('DEAL_PRODUCT_CHECK');


COMMENT ON TABLE BARS.DEAL_PRODUCT_CHECK IS 'Прив'язка';
COMMENT ON COLUMN BARS.DEAL_PRODUCT_CHECK.PRODUCT_ID IS 'Продукт, для якого працює дана перевірка';
COMMENT ON COLUMN BARS.DEAL_PRODUCT_CHECK.ATTRIBUTE_ID IS 'Ідентифікатор атрибуту угоди, при встановленні значення якого, викликається дана перевірка';
COMMENT ON COLUMN BARS.DEAL_PRODUCT_CHECK.VALID_FROM IS 'Дата початку дії перевірки';
COMMENT ON COLUMN BARS.DEAL_PRODUCT_CHECK.VALID_THROUGH IS 'Дата завершення дії перевірки';
COMMENT ON COLUMN BARS.DEAL_PRODUCT_CHECK.CHECK_ID IS 'Посилання на правило перевірки';




PROMPT *** Create  constraint FK_DEAL_PRO_REFERENCE_DEAL_CHE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_CHECK ADD CONSTRAINT FK_DEAL_PRO_REFERENCE_DEAL_CHE FOREIGN KEY (CHECK_ID)
	  REFERENCES BARS.DEAL_CHECK (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PROD_CHECK_REF_PRODUCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_CHECK ADD CONSTRAINT FK_PROD_CHECK_REF_PRODUCT FOREIGN KEY (PRODUCT_ID)
	  REFERENCES BARS.DEAL_PRODUCT (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DEAL_PRO_REFERENCE_ATTRIBUT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_CHECK ADD CONSTRAINT FK_DEAL_PRO_REFERENCE_ATTRIBUT FOREIGN KEY (ATTRIBUTE_ID)
	  REFERENCES BARS.ATTRIBUTE_KIND (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187817 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_CHECK MODIFY (CHECK_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187816 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_CHECK MODIFY (PRODUCT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index DEAL_PROD_CHECK_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.DEAL_PROD_CHECK_IDX ON BARS.DEAL_PRODUCT_CHECK (PRODUCT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index DEAL_PROD_CHECK_IDX2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.DEAL_PROD_CHECK_IDX2 ON BARS.DEAL_PRODUCT_CHECK (CHECK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEAL_PRODUCT_CHECK.sql =========*** En
PROMPT ===================================================================================== 
