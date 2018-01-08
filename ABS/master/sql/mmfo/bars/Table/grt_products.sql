

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_PRODUCTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_PRODUCTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_PRODUCTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_PRODUCTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_PRODUCTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_PRODUCTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_PRODUCTS 
   (	DEAL_ID NUMBER(38,0), 
	TYPE_TXT VARCHAR2(48), 
	NAME VARCHAR2(48), 
	MODEL VARCHAR2(32), 
	MODIFICATION VARCHAR2(32), 
	SERIAL_NUM VARCHAR2(32), 
	MADE_DATE DATE, 
	OTHER_COMMENTS VARCHAR2(128)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_PRODUCTS ***
 exec bpa.alter_policies('GRT_PRODUCTS');


COMMENT ON TABLE BARS.GRT_PRODUCTS IS 'Информация о залоговых транспортных средствах';
COMMENT ON COLUMN BARS.GRT_PRODUCTS.DEAL_ID IS 'Идентификатор договора залога';
COMMENT ON COLUMN BARS.GRT_PRODUCTS.TYPE_TXT IS 'Тип товару';
COMMENT ON COLUMN BARS.GRT_PRODUCTS.NAME IS 'Назва товару';
COMMENT ON COLUMN BARS.GRT_PRODUCTS.MODEL IS 'Модель товару';
COMMENT ON COLUMN BARS.GRT_PRODUCTS.MODIFICATION IS 'Модифікація товару';
COMMENT ON COLUMN BARS.GRT_PRODUCTS.SERIAL_NUM IS 'Серійний номер товару';
COMMENT ON COLUMN BARS.GRT_PRODUCTS.MADE_DATE IS 'Дата виробництва товару';
COMMENT ON COLUMN BARS.GRT_PRODUCTS.OTHER_COMMENTS IS 'Інші індивідуальні ознаки';




PROMPT *** Create  constraint PK_GRTPRODUCTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_PRODUCTS ADD CONSTRAINT PK_GRTPRODUCTS PRIMARY KEY (DEAL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTPRODUCTS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_PRODUCTS MODIFY (NAME CONSTRAINT CC_GRTPRODUCTS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTPRODUCTS_MODEL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_PRODUCTS MODIFY (MODEL CONSTRAINT CC_GRTPRODUCTS_MODEL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRTPRODUCTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRTPRODUCTS ON BARS.GRT_PRODUCTS (DEAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRT_PRODUCTS ***
grant SELECT                                                                 on GRT_PRODUCTS    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on GRT_PRODUCTS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GRT_PRODUCTS    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on GRT_PRODUCTS    to START1;
grant SELECT                                                                 on GRT_PRODUCTS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_PRODUCTS.sql =========*** End *** 
PROMPT ===================================================================================== 
