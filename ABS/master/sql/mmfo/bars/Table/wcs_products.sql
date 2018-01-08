

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_PRODUCTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_PRODUCTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_PRODUCTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_PRODUCTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_PRODUCTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_PRODUCTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_PRODUCTS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_PRODUCTS ***
 exec bpa.alter_policies('WCS_PRODUCTS');


COMMENT ON TABLE BARS.WCS_PRODUCTS IS 'Продукты';
COMMENT ON COLUMN BARS.WCS_PRODUCTS.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_PRODUCTS.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_WCSPRODUCTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PRODUCTS ADD CONSTRAINT PK_WCSPRODUCTS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSPRODUCTS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PRODUCTS MODIFY (NAME CONSTRAINT CC_WCSPRODUCTS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSPRODUCTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSPRODUCTS ON BARS.WCS_PRODUCTS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_PRODUCTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_PRODUCTS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_PRODUCTS    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_PRODUCTS    to START1;
grant SELECT                                                                 on WCS_PRODUCTS    to WCS_SYNC_USER;



PROMPT *** Create SYNONYM  to WCS_PRODUCTS ***

  CREATE OR REPLACE PUBLIC SYNONYM WCS_PRODUCTS FOR BARS.WCS_PRODUCTS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_PRODUCTS.sql =========*** End *** 
PROMPT ===================================================================================== 
