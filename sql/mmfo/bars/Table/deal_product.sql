

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEAL_PRODUCT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEAL_PRODUCT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEAL_PRODUCT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DEAL_PRODUCT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DEAL_PRODUCT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEAL_PRODUCT ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEAL_PRODUCT 
   (	ID NUMBER(5,0), 
	DEAL_TYPE_ID NUMBER(5,0), 
	PRODUCT_CODE VARCHAR2(35 CHAR), 
	PRODUCT_NAME VARCHAR2(300 CHAR), 
	SEGMENT_OF_BUSINESS_ID NUMBER(5,0), 
	TARIFF_PLAN_ID NUMBER(5,0), 
	VALID_FROM DATE, 
	VALID_THROUGH DATE, 
	STATE_ID NUMBER(5,0), 
	PARENT_PRODUCT_ID NUMBER(5,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEAL_PRODUCT ***
 exec bpa.alter_policies('DEAL_PRODUCT');


COMMENT ON TABLE BARS.DEAL_PRODUCT IS '������� ��������';
COMMENT ON COLUMN BARS.DEAL_PRODUCT.ID IS '������������� ����������� ��������';
COMMENT ON COLUMN BARS.DEAL_PRODUCT.DEAL_TYPE_ID IS '��� ����, �� ����� ���������� ����� �������';
COMMENT ON COLUMN BARS.DEAL_PRODUCT.PRODUCT_CODE IS '��� �������� (��������� � ����� ����� ���� ����)';
COMMENT ON COLUMN BARS.DEAL_PRODUCT.PRODUCT_NAME IS '����� ��������';
COMMENT ON COLUMN BARS.DEAL_PRODUCT.SEGMENT_OF_BUSINESS_ID IS '������������� �������� ������';
COMMENT ON COLUMN BARS.DEAL_PRODUCT.TARIFF_PLAN_ID IS '������������� ��������� ����� ��� ��������';
COMMENT ON COLUMN BARS.DEAL_PRODUCT.VALID_FROM IS '���� ������� 䳿 ��������';
COMMENT ON COLUMN BARS.DEAL_PRODUCT.VALID_THROUGH IS '���� ���������� 䳿 �������� (��������� � ���������� ���, ��� ����� �� ������������)';
COMMENT ON COLUMN BARS.DEAL_PRODUCT.STATE_ID IS '���� �������� (0 - ����� (�� ������������). 1 - ��������, 2 - ����������, 3 - ��������)';
COMMENT ON COLUMN BARS.DEAL_PRODUCT.PARENT_PRODUCT_ID IS '������������� �������� ��������';




PROMPT *** Create  constraint CC_PROD_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT ADD CONSTRAINT CC_PROD_NAME_NN CHECK (PRODUCT_NAME IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PROD_SEG_OF_BUSINESS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT ADD CONSTRAINT CC_PROD_SEG_OF_BUSINESS_NN CHECK (SEGMENT_OF_BUSINESS_ID IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT ADD CONSTRAINT CC_STATE_NN CHECK (STATE_ID IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DEAL_PRODUCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT ADD CONSTRAINT PK_DEAL_PRODUCT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DEAL_PRODUCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT ADD CONSTRAINT UK_DEAL_PRODUCT UNIQUE (DEAL_TYPE_ID, PRODUCT_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PROD_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT MODIFY (ID CONSTRAINT CC_PROD_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PROD_DEAL_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT MODIFY (DEAL_TYPE_ID CONSTRAINT CC_PROD_DEAL_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PROD_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT MODIFY (PRODUCT_CODE CONSTRAINT CC_PROD_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEAL_PRODUCT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEAL_PRODUCT ON BARS.DEAL_PRODUCT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DEAL_PRODUCT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DEAL_PRODUCT ON BARS.DEAL_PRODUCT (DEAL_TYPE_ID, PRODUCT_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEAL_PRODUCT ***
grant SELECT                                                                 on DEAL_PRODUCT    to BARSREADER_ROLE;
grant SELECT                                                                 on DEAL_PRODUCT    to BARS_DM;
grant SELECT                                                                 on DEAL_PRODUCT    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEAL_PRODUCT.sql =========*** End *** 
PROMPT ===================================================================================== 
