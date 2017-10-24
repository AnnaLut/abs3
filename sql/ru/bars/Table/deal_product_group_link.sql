

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEAL_PRODUCT_GROUP_LINK.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEAL_PRODUCT_GROUP_LINK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEAL_PRODUCT_GROUP_LINK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DEAL_PRODUCT_GROUP_LINK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEAL_PRODUCT_GROUP_LINK ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEAL_PRODUCT_GROUP_LINK 
   (	PRODUCT_ID NUMBER(5,0), 
	GROUP_ID NUMBER(5,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEAL_PRODUCT_GROUP_LINK ***
 exec bpa.alter_policies('DEAL_PRODUCT_GROUP_LINK');


COMMENT ON TABLE BARS.DEAL_PRODUCT_GROUP_LINK IS 'Об'єднання банківських продуктів в групи';
COMMENT ON COLUMN BARS.DEAL_PRODUCT_GROUP_LINK.PRODUCT_ID IS 'Ідентифікатор продукту, включеного в групу';
COMMENT ON COLUMN BARS.DEAL_PRODUCT_GROUP_LINK.GROUP_ID IS 'Ідентифікатор групи, до якої входить продукт';




PROMPT *** Create  constraint FK_PROD_GROUP_REF_GROUP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_GROUP_LINK ADD CONSTRAINT FK_PROD_GROUP_REF_GROUP FOREIGN KEY (GROUP_ID)
	  REFERENCES BARS.OBJECT_GROUP (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PROD_GROUP_REF_PRODUCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_GROUP_LINK ADD CONSTRAINT FK_PROD_GROUP_REF_PRODUCT FOREIGN KEY (PRODUCT_ID)
	  REFERENCES BARS.DEAL_PRODUCT (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DEAL_PRODUCT_GROUP_LINK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_GROUP_LINK ADD CONSTRAINT PK_DEAL_PRODUCT_GROUP_LINK PRIMARY KEY (PRODUCT_ID, GROUP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187814 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_GROUP_LINK MODIFY (GROUP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187813 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_GROUP_LINK MODIFY (PRODUCT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEAL_PRODUCT_GROUP_LINK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEAL_PRODUCT_GROUP_LINK ON BARS.DEAL_PRODUCT_GROUP_LINK (PRODUCT_ID, GROUP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index DEAL_PROD_GROUP_LINK_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.DEAL_PROD_GROUP_LINK_IDX ON BARS.DEAL_PRODUCT_GROUP_LINK (PRODUCT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index DEAL_PROD_GROUP_LINK_IDX2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.DEAL_PROD_GROUP_LINK_IDX2 ON BARS.DEAL_PRODUCT_GROUP_LINK (GROUP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEAL_PRODUCT_GROUP_LINK.sql =========*
PROMPT ===================================================================================== 
