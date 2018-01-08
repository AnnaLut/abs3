

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CLV_CUSTOMER_RISK.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CLV_CUSTOMER_RISK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CLV_CUSTOMER_RISK'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CLV_CUSTOMER_RISK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CLV_CUSTOMER_RISK'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CLV_CUSTOMER_RISK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CLV_CUSTOMER_RISK 
   (	RNK NUMBER(38,0), 
	RISK_ID NUMBER(22,0), 
	USER_ID NUMBER(22,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CLV_CUSTOMER_RISK ***
 exec bpa.alter_policies('CLV_CUSTOMER_RISK');


COMMENT ON TABLE BARS.CLV_CUSTOMER_RISK IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_RISK.RNK IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_RISK.RISK_ID IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMER_RISK.USER_ID IS '';




PROMPT *** Create  constraint PK_CLVCUSTOMERRISK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER_RISK ADD CONSTRAINT PK_CLVCUSTOMERRISK PRIMARY KEY (RNK, RISK_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCUSTOMERRISK_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER_RISK MODIFY (RNK CONSTRAINT CC_CLVCUSTOMERRISK_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCUSTOMERRISK_RISKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER_RISK MODIFY (RISK_ID CONSTRAINT CC_CLVCUSTOMERRISK_RISKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCUSTOMERRISK_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMER_RISK MODIFY (USER_ID CONSTRAINT CC_CLVCUSTOMERRISK_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLVCUSTOMERRISK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CLVCUSTOMERRISK ON BARS.CLV_CUSTOMER_RISK (RNK, RISK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLV_CUSTOMER_RISK ***
grant SELECT                                                                 on CLV_CUSTOMER_RISK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CLV_CUSTOMER_RISK to BARS_DM;
grant SELECT                                                                 on CLV_CUSTOMER_RISK to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CLV_CUSTOMER_RISK.sql =========*** End
PROMPT ===================================================================================== 
