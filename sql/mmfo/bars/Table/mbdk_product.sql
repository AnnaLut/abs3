

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MBDK_PRODUCT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MBDK_PRODUCT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MBDK_PRODUCT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MBDK_PRODUCT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MBDK_PRODUCT ***
begin 
  execute immediate '
  CREATE TABLE BARS.MBDK_PRODUCT 
   (	CODE_PRODUCT NUMBER(*,0), 
	NAME_PRODUCT VARCHAR2(100), 
	NBS CHAR(4), 
	OB22 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MBDK_PRODUCT ***
 exec bpa.alter_policies('MBDK_PRODUCT');


COMMENT ON TABLE BARS.MBDK_PRODUCT IS 'Справочник продуктов МБДК';
COMMENT ON COLUMN BARS.MBDK_PRODUCT.CODE_PRODUCT IS 'Код продукта';
COMMENT ON COLUMN BARS.MBDK_PRODUCT.NAME_PRODUCT IS 'Наименование продукта';
COMMENT ON COLUMN BARS.MBDK_PRODUCT.NBS IS 'Бал.рах.продукту';
COMMENT ON COLUMN BARS.MBDK_PRODUCT.OB22 IS 'ОБ22 продукту';




PROMPT *** Create  constraint PK_MBDK_PRODUCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBDK_PRODUCT ADD CONSTRAINT PK_MBDK_PRODUCT PRIMARY KEY (CODE_PRODUCT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MBDK_PRODUCT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MBDK_PRODUCT ON BARS.MBDK_PRODUCT (CODE_PRODUCT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MBDK_PRODUCT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on MBDK_PRODUCT    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on MBDK_PRODUCT    to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on MBDK_PRODUCT    to START1;
grant FLASHBACK,SELECT                                                       on MBDK_PRODUCT    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MBDK_PRODUCT.sql =========*** End *** 
PROMPT ===================================================================================== 
