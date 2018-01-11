

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPE_PRODUCTS.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_PARTNER_TYPE_PRODUCTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_PARTNER_TYPE_PRODUCTS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
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
	TYPE_ID NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_PARTNER_TYPE_PRODUCTS ***
 exec bpa.alter_policies('INS_PARTNER_TYPE_PRODUCTS');


COMMENT ON TABLE BARS.INS_PARTNER_TYPE_PRODUCTS IS 'Доступність СК та типів СД у продуктах';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_PRODUCTS.KF IS '';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_PRODUCTS.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_PRODUCTS.PRODUCT_ID IS 'Код продукту';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_PRODUCTS.PARTNER_ID IS 'Ідентифікатор СК';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_PRODUCTS.TYPE_ID IS 'Ідентифікатор типу страхового договору';




PROMPT *** Create  constraint PK_PTNTYPEPRODS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_PRODUCTS ADD CONSTRAINT PK_PTNTYPEPRODS PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_PTNTYPEPRODS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_PRODUCTS ADD CONSTRAINT UK_PTNTYPEPRODS UNIQUE (PRODUCT_ID, PARTNER_ID, TYPE_ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033380 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_PRODUCTS MODIFY (ID NOT NULL ENABLE)';
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




PROMPT *** Create  index PK_PTNTYPEPRODS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PTNTYPEPRODS ON BARS.INS_PARTNER_TYPE_PRODUCTS (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_PTNTYPEPRODS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_PTNTYPEPRODS ON BARS.INS_PARTNER_TYPE_PRODUCTS (PRODUCT_ID, PARTNER_ID, TYPE_ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_PARTNER_TYPE_PRODUCTS ***
grant SELECT                                                                 on INS_PARTNER_TYPE_PRODUCTS to BARSREADER_ROLE;
grant SELECT                                                                 on INS_PARTNER_TYPE_PRODUCTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPE_PRODUCTS.sql ========
PROMPT ===================================================================================== 
