

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_SBON_PRODUCT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_SBON_PRODUCT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_SBON_PRODUCT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STO_SBON_PRODUCT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STO_SBON_PRODUCT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_SBON_PRODUCT ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_SBON_PRODUCT 
   (	ID NUMBER(5,0), 
	CONTRACT_ID NUMBER(5,0), 
	CONTRACT_NUMBER VARCHAR2(30 CHAR), 
	RECEIVER_MFO VARCHAR2(6 CHAR), 
	RECEIVER_ACCOUNT VARCHAR2(34 CHAR), 
	RECEIVER_NAME VARCHAR2(300 CHAR), 
	RECEIVER_EDRPOU VARCHAR2(12 CHAR), 
	PAYMENT_NAME VARCHAR2(4000), 
	TRANSIT_ACCOUNT VARCHAR2(15 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
   execute immediate 'alter table STO_SBON_PRODUCT  modify id number';
end;
/

begin
   execute immediate 'alter table STO_SBON_PRODUCT  modify contract_id number';
end;
/




PROMPT *** ALTER_POLICIES to STO_SBON_PRODUCT ***
 exec bpa.alter_policies('STO_SBON_PRODUCT');


COMMENT ON TABLE BARS.STO_SBON_PRODUCT IS '';
COMMENT ON COLUMN BARS.STO_SBON_PRODUCT.ID IS '';
COMMENT ON COLUMN BARS.STO_SBON_PRODUCT.CONTRACT_ID IS '';
COMMENT ON COLUMN BARS.STO_SBON_PRODUCT.CONTRACT_NUMBER IS '';
COMMENT ON COLUMN BARS.STO_SBON_PRODUCT.RECEIVER_MFO IS '';
COMMENT ON COLUMN BARS.STO_SBON_PRODUCT.RECEIVER_ACCOUNT IS '';
COMMENT ON COLUMN BARS.STO_SBON_PRODUCT.RECEIVER_NAME IS '';
COMMENT ON COLUMN BARS.STO_SBON_PRODUCT.RECEIVER_EDRPOU IS '';
COMMENT ON COLUMN BARS.STO_SBON_PRODUCT.PAYMENT_NAME IS '';
COMMENT ON COLUMN BARS.STO_SBON_PRODUCT.TRANSIT_ACCOUNT IS '';




PROMPT *** Create  constraint PK_STO_SBON_PRODUCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SBON_PRODUCT ADD CONSTRAINT PK_STO_SBON_PRODUCT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008123 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SBON_PRODUCT MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008124 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SBON_PRODUCT MODIFY (CONTRACT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STO_SBON_PRODUCT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STO_SBON_PRODUCT ON BARS.STO_SBON_PRODUCT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_SBON_PRODUCT ***
grant SELECT                                                                 on STO_SBON_PRODUCT to BARSREADER_ROLE;
grant SELECT                                                                 on STO_SBON_PRODUCT to BARSUPL;
grant SELECT                                                                 on STO_SBON_PRODUCT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_SBON_PRODUCT to SBON;
grant SELECT                                                                 on STO_SBON_PRODUCT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_SBON_PRODUCT.sql =========*** End 
PROMPT ===================================================================================== 
