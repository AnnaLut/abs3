

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_PRODUCT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_PRODUCT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_PRODUCT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''W4_PRODUCT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_PRODUCT ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_PRODUCT 
   (	CODE VARCHAR2(32), 
	NAME VARCHAR2(100), 
	GRP_CODE VARCHAR2(32), 
	KV NUMBER(3,0), 
	NBS CHAR(4), 
	OB22 CHAR(2), 
	DATE_OPEN DATE, 
	DATE_CLOSE DATE, 
	TIP CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_PRODUCT ***
 exec bpa.alter_policies('W4_PRODUCT');


COMMENT ON TABLE BARS.W4_PRODUCT IS 'W4. Справочник продуктов';
COMMENT ON COLUMN BARS.W4_PRODUCT.CODE IS 'Код продукта';
COMMENT ON COLUMN BARS.W4_PRODUCT.NAME IS 'Название продукта';
COMMENT ON COLUMN BARS.W4_PRODUCT.GRP_CODE IS 'Группа продуктов';
COMMENT ON COLUMN BARS.W4_PRODUCT.KV IS '';
COMMENT ON COLUMN BARS.W4_PRODUCT.NBS IS 'НБС';
COMMENT ON COLUMN BARS.W4_PRODUCT.OB22 IS 'ОБ22';
COMMENT ON COLUMN BARS.W4_PRODUCT.DATE_OPEN IS '';
COMMENT ON COLUMN BARS.W4_PRODUCT.DATE_CLOSE IS '';
COMMENT ON COLUMN BARS.W4_PRODUCT.TIP IS '';




PROMPT *** Create  constraint FK_W4PRODUCT_W4NBSOB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT ADD CONSTRAINT FK_W4PRODUCT_W4NBSOB22 FOREIGN KEY (NBS, OB22, TIP)
	  REFERENCES BARS.W4_NBS_OB22 (NBS, OB22, TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4PRODUCT_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT ADD CONSTRAINT FK_W4PRODUCT_TIPS FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4PRODUCT_W4PRODUCTGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT ADD CONSTRAINT FK_W4PRODUCT_W4PRODUCTGROUPS FOREIGN KEY (GRP_CODE)
	  REFERENCES BARS.W4_PRODUCT_GROUPS (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCT_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT ADD CONSTRAINT CC_W4PRODUCT_KV CHECK (kv in (980, 840, 978)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCT_TIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT ADD CONSTRAINT CC_W4PRODUCT_TIP_NN CHECK (tip is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_W4PRODUCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT ADD CONSTRAINT PK_W4PRODUCT PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCT_OB22_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT MODIFY (OB22 CONSTRAINT CC_W4PRODUCT_OB22_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCT_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT MODIFY (NBS CONSTRAINT CC_W4PRODUCT_NBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCT_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT MODIFY (KV CONSTRAINT CC_W4PRODUCT_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCT_GRPCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT MODIFY (GRP_CODE CONSTRAINT CC_W4PRODUCT_GRPCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCT_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT MODIFY (CODE CONSTRAINT CC_W4PRODUCT_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_W4PRODUCT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_W4PRODUCT ON BARS.W4_PRODUCT (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  W4_PRODUCT ***
grant SELECT                                                                 on W4_PRODUCT      to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on W4_PRODUCT      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_PRODUCT      to BARS_SUP;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_PRODUCT      to OW;
grant SELECT                                                                 on W4_PRODUCT      to UPLD;
grant FLASHBACK,SELECT                                                       on W4_PRODUCT      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_PRODUCT.sql =========*** End *** ==
PROMPT ===================================================================================== 
