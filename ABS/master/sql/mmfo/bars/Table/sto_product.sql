

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_PRODUCT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_PRODUCT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_PRODUCT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STO_PRODUCT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''STO_PRODUCT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_PRODUCT ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_PRODUCT 
   (	ID NUMBER(5,0), 
	PRODUCT_CODE VARCHAR2(30 CHAR), 
	PRODUCT_NAME VARCHAR2(300 CHAR), 
	ORDER_TYPE_ID NUMBER(5,0), 
	BRANCH_ACCESS_MODE NUMBER(5,0), 
	STATE NUMBER(5,0), 
	BRANCH VARCHAR2(30 CHAR), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
   execute immediate 'alter table sto_product modify id number';
end;
/

PROMPT *** ALTER_POLICIES to STO_PRODUCT ***
 exec bpa.alter_policies('STO_PRODUCT');


COMMENT ON TABLE BARS.STO_PRODUCT IS '';
COMMENT ON COLUMN BARS.STO_PRODUCT.ID IS '';
COMMENT ON COLUMN BARS.STO_PRODUCT.PRODUCT_CODE IS '';
COMMENT ON COLUMN BARS.STO_PRODUCT.PRODUCT_NAME IS '';
COMMENT ON COLUMN BARS.STO_PRODUCT.ORDER_TYPE_ID IS '';
COMMENT ON COLUMN BARS.STO_PRODUCT.BRANCH_ACCESS_MODE IS '';
COMMENT ON COLUMN BARS.STO_PRODUCT.STATE IS '';
COMMENT ON COLUMN BARS.STO_PRODUCT.BRANCH IS '';
COMMENT ON COLUMN BARS.STO_PRODUCT.KF IS '';




PROMPT *** Create  constraint PK_STO_PRODUCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT ADD CONSTRAINT PK_STO_PRODUCT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005467 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT MODIFY (PRODUCT_CODE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005466 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT MODIFY (ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005468 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT MODIFY (PRODUCT_NAME NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005469 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT MODIFY (ORDER_TYPE_ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005470 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT MODIFY (BRANCH_ACCESS_MODE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005471 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT MODIFY (STATE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005472 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT MODIFY (BRANCH NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STOPRODUCT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT MODIFY (KF CONSTRAINT CC_STOPRODUCT_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STO_PRODUCT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STO_PRODUCT ON BARS.STO_PRODUCT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_PRODUCT ***
grant SELECT                                                                 on STO_PRODUCT     to BARSREADER_ROLE;
grant SELECT                                                                 on STO_PRODUCT     to BARSUPL;
grant SELECT                                                                 on STO_PRODUCT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_PRODUCT     to SBON;
grant SELECT                                                                 on STO_PRODUCT     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_PRODUCT.sql =========*** End *** =
PROMPT ===================================================================================== 
