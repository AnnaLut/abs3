

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CLV_CUSTOMER.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CLV_CUSTOMER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CLV_CUSTOMER'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CLV_CUSTOMER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CLV_CUSTOMER'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CLV_CUSTOMER ***
begin 
  execute immediate '
  CREATE TABLE BARS.CLV_CUSTOMER 
   (	RNK NUMBER(38,0), 
	DATE_ON DATE, 
	CUSTTYPE NUMBER(1,0), 
	CODCAGENT NUMBER(1,0), 
	COUNTRY NUMBER(3,0), 
	TGR NUMBER(1,0), 
	NMK VARCHAR2(70), 
	NMKV VARCHAR2(70), 
	NMKK VARCHAR2(38), 
	OKPO VARCHAR2(14), 
	ADR VARCHAR2(70), 
	PRINSIDER NUMBER(38,0), 
	SAB VARCHAR2(6), 
	C_REG NUMBER(2,0), 
	C_DST NUMBER(2,0), 
	ADM VARCHAR2(70), 
	RGADM VARCHAR2(30), 
	DATEA DATE, 
	RGTAX VARCHAR2(30), 
	DATET DATE, 
	STMT NUMBER(5,0), 
	NOTES VARCHAR2(140), 
	NOTESEC VARCHAR2(256), 
	CRISK NUMBER(38,0), 
	ND VARCHAR2(10), 
	RNKP NUMBER(38,0), 
	ISE CHAR(5), 
	FS CHAR(2), 
	OE CHAR(5), 
	VED CHAR(5), 
	SED CHAR(4), 
	K050 CHAR(3), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	ISP NUMBER(38,0), 
	TAXF VARCHAR2(12), 
	NOMPDV VARCHAR2(9), 
	NREZID_CODE VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CLV_CUSTOMER ***
 exec bpa.alter_policies('CLV_CUSTOMER');


COMMENT ON TABLE BARS.CLV_CUSTOMER IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.RNK IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.DATE_ON IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.CODCAGENT IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.COUNTRY IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.TGR IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.NMK IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.NMKV IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.NMKK IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.OKPO IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.ADR IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.PRINSIDER IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.SAB IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.C_REG IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.C_DST IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.ADM IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.RGADM IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.DATEA IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.RGTAX IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.DATET IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.STMT IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.NOTES IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.NOTESEC IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.CRISK IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.ND IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.RNKP IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.ISE IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.FS IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.OE IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.VED IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.SED IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.K050 IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.BRANCH IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.ISP IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.TAXF IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.NOMPDV IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER.NREZID_CODE IS '';




PROMPT *** Create  constraint CC_CLVCUSTOMER_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER MODIFY (RNK CONSTRAINT CC_CLVCUSTOMER_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CLVCUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER ADD CONSTRAINT PK_CLVCUSTOMER PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCUSTOMER_CUSTTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER MODIFY (CUSTTYPE CONSTRAINT CC_CLVCUSTOMER_CUSTTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCUSTOMER_CODCAGENT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER MODIFY (CODCAGENT CONSTRAINT CC_CLVCUSTOMER_CODCAGENT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCUSTOMER_COUNTRY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER MODIFY (COUNTRY CONSTRAINT CC_CLVCUSTOMER_COUNTRY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCUSTOMER_TGR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER MODIFY (TGR CONSTRAINT CC_CLVCUSTOMER_TGR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCUSTOMER_NMK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER MODIFY (NMK CONSTRAINT CC_CLVCUSTOMER_NMK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCUSTOMER_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER MODIFY (BRANCH CONSTRAINT CC_CLVCUSTOMER_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLVCUSTOMER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CLVCUSTOMER ON BARS.CLV_CUSTOMER (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLV_CUSTOMER ***
grant SELECT                                                                 on CLV_CUSTOMER    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CLV_CUSTOMER    to BARS_DM;
grant SELECT                                                                 on CLV_CUSTOMER    to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CLV_CUSTOMER.sql =========*** End *** 
PROMPT ===================================================================================== 
