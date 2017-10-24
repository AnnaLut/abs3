

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_PRODUCT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_PRODUCT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_PRODUCT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_PRODUCT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_PRODUCT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_PRODUCT ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_PRODUCT 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(100), 
	TYPE VARCHAR2(1), 
	CARD_TYPE NUMBER(1,0), 
	KV NUMBER(3,0), 
	KK VARCHAR2(1), 
	COND_SET NUMBER(38,0), 
	NBS CHAR(4), 
	OB22 CHAR(2), 
	LIMIT NUMBER(1,0) DEFAULT 0, 
	D_CLOSE DATE, 
	ID_DOC VARCHAR2(35), 
	ID_DOC_CRED VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_PRODUCT ***
 exec bpa.alter_policies('BPK_PRODUCT');


COMMENT ON TABLE BARS.BPK_PRODUCT IS 'БПК. Продукти';
COMMENT ON COLUMN BARS.BPK_PRODUCT.ID IS 'Код продукта';
COMMENT ON COLUMN BARS.BPK_PRODUCT.NAME IS 'Назва продукта';
COMMENT ON COLUMN BARS.BPK_PRODUCT.TYPE IS 'Тип картки';
COMMENT ON COLUMN BARS.BPK_PRODUCT.CARD_TYPE IS 'Карткова система';
COMMENT ON COLUMN BARS.BPK_PRODUCT.KV IS 'Валюта';
COMMENT ON COLUMN BARS.BPK_PRODUCT.KK IS 'Категорія клієнта';
COMMENT ON COLUMN BARS.BPK_PRODUCT.COND_SET IS '';
COMMENT ON COLUMN BARS.BPK_PRODUCT.NBS IS 'БР';
COMMENT ON COLUMN BARS.BPK_PRODUCT.OB22 IS 'ОБ22';
COMMENT ON COLUMN BARS.BPK_PRODUCT.LIMIT IS 'Ознака встановлення ліміту';
COMMENT ON COLUMN BARS.BPK_PRODUCT.D_CLOSE IS 'Дата припинення дії продукта';
COMMENT ON COLUMN BARS.BPK_PRODUCT.ID_DOC IS 'Шаблон договору';
COMMENT ON COLUMN BARS.BPK_PRODUCT.ID_DOC_CRED IS 'Шаблон кредитного договору';




PROMPT *** Create  constraint CC_BPKPRODUCT_LIMIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT ADD CONSTRAINT CC_BPKPRODUCT_LIMIT CHECK (limit in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BPKPRODUCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT ADD CONSTRAINT PK_BPKPRODUCT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPRODUCT_LIMIT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT MODIFY (LIMIT CONSTRAINT CC_BPKPRODUCT_LIMIT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPRODUCT_OB22_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT MODIFY (OB22 CONSTRAINT CC_BPKPRODUCT_OB22_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPRODUCT_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT MODIFY (NBS CONSTRAINT CC_BPKPRODUCT_NBS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPRODUCT_CONDSET_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT MODIFY (COND_SET CONSTRAINT CC_BPKPRODUCT_CONDSET_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPRODUCT_KK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT MODIFY (KK CONSTRAINT CC_BPKPRODUCT_KK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPRODUCT_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT MODIFY (KV CONSTRAINT CC_BPKPRODUCT_KV_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPRODUCT_CARDTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT MODIFY (CARD_TYPE CONSTRAINT CC_BPKPRODUCT_CARDTYPE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPRODUCT_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT MODIFY (TYPE CONSTRAINT CC_BPKPRODUCT_TYPE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPRODUCT_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT MODIFY (NAME CONSTRAINT CC_BPKPRODUCT_NAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_BPKPRODUCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT ADD CONSTRAINT UK_BPKPRODUCT UNIQUE (TYPE, CARD_TYPE, KV, KK, COND_SET, NBS, OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPKPRODUCT_DEMANDACCTYPE2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT ADD CONSTRAINT FK_BPKPRODUCT_DEMANDACCTYPE2 FOREIGN KEY (TYPE, CARD_TYPE)
	  REFERENCES BARS.DEMAND_ACC_TYPE (TYPE, CARD_TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPKPRODUCT_DEMANDKK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT ADD CONSTRAINT FK_BPKPRODUCT_DEMANDKK FOREIGN KEY (KK)
	  REFERENCES BARS.DEMAND_KK (KK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPKPRODUCT_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT ADD CONSTRAINT FK_BPKPRODUCT_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPKPRODUCT_BPKNBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT ADD CONSTRAINT FK_BPKPRODUCT_BPKNBS FOREIGN KEY (NBS, OB22)
	  REFERENCES BARS.BPK_NBS (NBS, OB22) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPRODUCT_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT MODIFY (ID CONSTRAINT CC_BPKPRODUCT_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKPRODUCT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKPRODUCT ON BARS.BPK_PRODUCT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_BPKPRODUCT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_BPKPRODUCT ON BARS.BPK_PRODUCT (TYPE, CARD_TYPE, KV, KK, COND_SET, NBS, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_PRODUCT ***
grant SELECT                                                                 on BPK_PRODUCT     to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_PRODUCT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_PRODUCT     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_PRODUCT     to OBPC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_PRODUCT.sql =========*** End *** =
PROMPT ===================================================================================== 
