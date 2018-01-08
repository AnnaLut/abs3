

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SUBPRODUCTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SUBPRODUCTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SUBPRODUCTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SUBPRODUCTS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	PRODUCT_ID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SUBPRODUCTS ***
 exec bpa.alter_policies('WCS_SUBPRODUCTS');


COMMENT ON TABLE BARS.WCS_SUBPRODUCTS IS 'Субпродукты';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCTS.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCTS.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCTS.PRODUCT_ID IS 'Иденификатор продукта';




PROMPT *** Create  constraint PK_SUBPRODUCTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCTS ADD CONSTRAINT PK_SUBPRODUCTS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SUBPRDS_PRDID_PRDS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCTS ADD CONSTRAINT FK_SUBPRDS_PRDID_PRDS_ID FOREIGN KEY (PRODUCT_ID)
	  REFERENCES BARS.WCS_PRODUCTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SUBPRODUCTS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCTS MODIFY (NAME CONSTRAINT CC_SUBPRODUCTS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SUBPRODUCTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SUBPRODUCTS ON BARS.WCS_SUBPRODUCTS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SUBPRODUCTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SUBPRODUCTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SUBPRODUCTS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SUBPRODUCTS to START1;
grant SELECT                                                                 on WCS_SUBPRODUCTS to WCS_SYNC_USER;



PROMPT *** Create SYNONYM  to WCS_SUBPRODUCTS ***

  CREATE OR REPLACE PUBLIC SYNONYM WCS_SUBPRODUCTS FOR BARS.WCS_SUBPRODUCTS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCTS.sql =========*** End *
PROMPT ===================================================================================== 
