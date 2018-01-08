

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_RISK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_RISK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_RISK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_RISK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_RISK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_RISK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_RISK 
   (	RNK NUMBER(22,0), 
	RISK_ID NUMBER(22,0), 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	USER_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_RISK ***
 exec bpa.alter_policies('CUSTOMER_RISK');


COMMENT ON TABLE BARS.CUSTOMER_RISK IS 'Риски клиентов';
COMMENT ON COLUMN BARS.CUSTOMER_RISK.RNK IS 'РНК';
COMMENT ON COLUMN BARS.CUSTOMER_RISK.RISK_ID IS 'Код критерия риска';
COMMENT ON COLUMN BARS.CUSTOMER_RISK.DAT_BEGIN IS 'Дата установки риска';
COMMENT ON COLUMN BARS.CUSTOMER_RISK.DAT_END IS 'Дата окончания';
COMMENT ON COLUMN BARS.CUSTOMER_RISK.USER_ID IS 'Польз-ль, который установил риск';




PROMPT *** Create  constraint PK_CUSTOMERRISK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_RISK ADD CONSTRAINT PK_CUSTOMERRISK PRIMARY KEY (RNK, RISK_ID, DAT_BEGIN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERRISK_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_RISK ADD CONSTRAINT FK_CUSTOMERRISK_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERRISK_FMRISKCRITERIA ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_RISK ADD CONSTRAINT FK_CUSTOMERRISK_FMRISKCRITERIA FOREIGN KEY (RISK_ID)
	  REFERENCES BARS.FM_RISK_CRITERIA (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERRISK_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_RISK ADD CONSTRAINT FK_CUSTOMERRISK_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERRISK_DATBEGIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_RISK MODIFY (DAT_BEGIN CONSTRAINT CC_CUSTOMERRISK_DATBEGIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERRISK_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_RISK MODIFY (RNK CONSTRAINT CC_CUSTOMERRISK_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERRISK_RISKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_RISK MODIFY (RISK_ID CONSTRAINT CC_CUSTOMERRISK_RISKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERRISK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMERRISK ON BARS.CUSTOMER_RISK (RNK, RISK_ID, DAT_BEGIN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_RISK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_RISK   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_RISK   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_RISK   to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_RISK.sql =========*** End ***
PROMPT ===================================================================================== 
