

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_PRODUCT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_PRODUCT ***


BEGIN 
        execute immediate  
          'begin  
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




PROMPT *** Create  constraint FK_STOPRODUCT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT ADD CONSTRAINT FK_STOPRODUCT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STO_PROD_REFERENCE_STO_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT ADD CONSTRAINT FK_STO_PROD_REFERENCE_STO_TYPE FOREIGN KEY (ORDER_TYPE_ID)
	  REFERENCES BARS.STO_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_STO_PRODUCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT ADD CONSTRAINT PK_STO_PRODUCT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002755379 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002755378 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT MODIFY (STATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002755377 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT MODIFY (BRANCH_ACCESS_MODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002755376 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT MODIFY (ORDER_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002755375 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT MODIFY (PRODUCT_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002755374 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT MODIFY (PRODUCT_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002755373 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STOPRODUCT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT MODIFY (KF CONSTRAINT CC_STOPRODUCT_KF_NN NOT NULL ENABLE)';
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
grant SELECT                                                                 on STO_PRODUCT     to BARSUPL;
grant SELECT                                                                 on STO_PRODUCT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_PRODUCT     to BARS_DM;
grant SELECT                                                                 on STO_PRODUCT     to SBON;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_PRODUCT.sql =========*** End *** =
PROMPT ===================================================================================== 
