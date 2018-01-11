

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CLV_CUSTOMER_REL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CLV_CUSTOMER_REL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CLV_CUSTOMER_REL'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CLV_CUSTOMER_REL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CLV_CUSTOMER_REL'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CLV_CUSTOMER_REL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CLV_CUSTOMER_REL 
   (	RNK NUMBER(22,0), 
	REL_ID NUMBER(22,0), 
	REL_RNK NUMBER(22,0), 
	REL_INTEXT NUMBER(1,0), 
	VAGA1 NUMBER(8,4), 
	VAGA2 NUMBER(8,4), 
	TYPE_ID NUMBER(22,0) DEFAULT 1, 
	POSITION VARCHAR2(100), 
	FIRST_NAME VARCHAR2(70), 
	MIDDLE_NAME VARCHAR2(70), 
	LAST_NAME VARCHAR2(70), 
	DOCUMENT_TYPE_ID NUMBER(22,0) DEFAULT 3, 
	DOCUMENT VARCHAR2(70), 
	TRUST_REGNUM VARCHAR2(38), 
	TRUST_REGDAT DATE, 
	BDATE DATE, 
	EDATE DATE, 
	NOTARY_NAME VARCHAR2(70), 
	NOTARY_REGION VARCHAR2(70), 
	SIGN_PRIVS NUMBER(1,0) DEFAULT 0, 
	SIGN_ID NUMBER(22,0), 
	NAME_R VARCHAR2(100), 
	POSITION_R VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CLV_CUSTOMER_REL ***
 exec bpa.alter_policies('CLV_CUSTOMER_REL');


COMMENT ON TABLE BARS.CLV_CUSTOMER_REL IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.POSITION_R IS 'Должность в родительном падеже';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.NOTARY_REGION IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.SIGN_PRIVS IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.SIGN_ID IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.NAME_R IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.RNK IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.REL_ID IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.REL_RNK IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.REL_INTEXT IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.VAGA1 IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.VAGA2 IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.TYPE_ID IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.POSITION IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.FIRST_NAME IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.MIDDLE_NAME IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.LAST_NAME IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.DOCUMENT_TYPE_ID IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.DOCUMENT IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.TRUST_REGNUM IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.TRUST_REGDAT IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.BDATE IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.EDATE IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_REL.NOTARY_NAME IS '';




PROMPT *** Create  constraint PK_CLVCUSTOMERREL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER_REL ADD CONSTRAINT PK_CLVCUSTOMERREL PRIMARY KEY (RNK, REL_ID, REL_RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCUSTREL_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER_REL MODIFY (RNK CONSTRAINT CC_CLVCUSTREL_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCUSTREL_RELID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER_REL MODIFY (REL_ID CONSTRAINT CC_CLVCUSTREL_RELID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCUSTREL_RELRNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER_REL MODIFY (REL_RNK CONSTRAINT CC_CLVCUSTREL_RELRNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCUSTREL_RELINTEXT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER_REL MODIFY (REL_INTEXT CONSTRAINT CC_CLVCUSTREL_RELINTEXT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLVCUSTOMERREL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CLVCUSTOMERREL ON BARS.CLV_CUSTOMER_REL (RNK, REL_ID, REL_RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLV_CUSTOMER_REL ***
grant SELECT                                                                 on CLV_CUSTOMER_REL to BARSREADER_ROLE;
grant SELECT                                                                 on CLV_CUSTOMER_REL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CLV_CUSTOMER_REL to BARS_DM;
grant SELECT                                                                 on CLV_CUSTOMER_REL to CUST001;
grant SELECT                                                                 on CLV_CUSTOMER_REL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CLV_CUSTOMER_REL.sql =========*** End 
PROMPT ===================================================================================== 
