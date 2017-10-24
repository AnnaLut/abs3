

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPE_PRODUCTS.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_PARTNER_TYPE_PRODUCTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_PARTNER_TYPE_PRODUCTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_PARTNER_TYPE_PRODUCTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_PARTNER_TYPE_PRODUCTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_PARTNER_TYPE_PRODUCTS 
   (	ID NUMBER, 
	PRODUCT_ID VARCHAR2(100), 
	PARTNER_ID NUMBER, 
	TYPE_ID NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_PARTNER_TYPE_PRODUCTS ***
 exec bpa.alter_policies('INS_PARTNER_TYPE_PRODUCTS');


COMMENT ON TABLE BARS.INS_PARTNER_TYPE_PRODUCTS IS '���������� �� �� ���� �� � ���������';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_PRODUCTS.ID IS '�������������';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_PRODUCTS.PRODUCT_ID IS '��� ��������';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_PRODUCTS.PARTNER_ID IS '������������� ��';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_PRODUCTS.TYPE_ID IS '������������� ���� ���������� ��������';




PROMPT *** Create  constraint FK_PTNTYPEPRDS_TID_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_PRODUCTS ADD CONSTRAINT FK_PTNTYPEPRDS_TID_TYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.INS_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTNTYPEPRDS_PID_PARTNERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_PRODUCTS ADD CONSTRAINT FK_PTNTYPEPRDS_PID_PARTNERS FOREIGN KEY (PARTNER_ID)
	  REFERENCES BARS.INS_PARTNERS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_PTNTYPEPRODS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_PRODUCTS ADD CONSTRAINT UK_PTNTYPEPRODS UNIQUE (PRODUCT_ID, PARTNER_ID, TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PTNTYPEPRODS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_PRODUCTS ADD CONSTRAINT PK_PTNTYPEPRODS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PTNTYPEPRODS_BRH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_PRODUCTS MODIFY (PRODUCT_ID CONSTRAINT CC_PTNTYPEPRODS_BRH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003101263 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_PRODUCTS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PTNTYPEPRODS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PTNTYPEPRODS ON BARS.INS_PARTNER_TYPE_PRODUCTS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_PTNTYPEPRODS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_PTNTYPEPRODS ON BARS.INS_PARTNER_TYPE_PRODUCTS (PRODUCT_ID, PARTNER_ID, TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPE_PRODUCTS.sql ========
PROMPT ===================================================================================== 
