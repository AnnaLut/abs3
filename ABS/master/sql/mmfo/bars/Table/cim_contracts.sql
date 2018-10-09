

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CONTRACTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CONTRACTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CONTRACTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CONTRACTS 
   (	CONTR_ID NUMBER, 
	CONTR_TYPE NUMBER, 
	RNK NUMBER, 
	OKPO VARCHAR2(14), 
	NUM VARCHAR2(60), 
	OPEN_DATE DATE, 
	CLOSE_DATE DATE, 
	S NUMBER, 
	KV NUMBER, 
	BENEF_ID NUMBER, 
	STATUS_ID NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	COMMENTS VARCHAR2(250), 
	SUBNUM VARCHAR2(20), 
	OWNER_UID NUMBER DEFAULT sys_context(''bars_global'',''user_id''), 
	BIC VARCHAR2(11), 
	B010 VARCHAR2(10), 
	SERVICE_BRANCH VARCHAR2(30), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BANK_CHANGE VARCHAR2(300)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CONTRACTS ***
 exec bpa.alter_policies('CIM_CONTRACTS');


COMMENT ON TABLE BARS.CIM_CONTRACTS IS 'Довідник контрактів v1.0';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.CONTR_ID IS 'Внутрішній код контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.CONTR_TYPE IS 'Тип контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.RNK IS 'Внутрішній номер (rnk) контрагента контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.OKPO IS 'Код ЄДРПОУ клієнта';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.NUM IS 'Символьний номер контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.OPEN_DATE IS 'Дата відкриття';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.CLOSE_DATE IS 'Дата закриття ';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.S IS 'Сума контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.KV IS 'Валюта контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.BENEF_ID IS 'Код клієнта-неризидента';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.STATUS_ID IS 'Статус контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.BRANCH IS 'Номер відділеня';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.COMMENTS IS 'Деталі контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.SUBNUM IS 'Субномер контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.OWNER_UID IS 'Id користувача, за яким закріплено контракт';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.BIC IS 'BIC-код банку нерезидента';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.B010 IS 'Код B010 банку нерезидента';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.SERVICE_BRANCH IS '';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.KF IS '';
COMMENT ON COLUMN BARS.CIM_CONTRACTS.BANK_CHANGE IS 'Інформація про перехід з іншого банку';




PROMPT *** Create  constraint PK_CIMCONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS ADD CONSTRAINT PK_CIMCONTRACTS PRIMARY KEY (CONTR_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRACTS_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS MODIFY (KV CONSTRAINT CC_CIMCONTRACTS_KV_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRACTS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS MODIFY (CONTR_ID CONSTRAINT CC_CIMCONTRACTS_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRACTS_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS MODIFY (CONTR_TYPE CONSTRAINT CC_CIMCONTRACTS_TYPE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRACTS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS MODIFY (RNK CONSTRAINT CC_CIMCONTRACTS_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CONTRACTS_OKPO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS MODIFY (OKPO CONSTRAINT CC_CONTRACTS_OKPO_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRACTS_NUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS MODIFY (NUM CONSTRAINT CC_CIMCONTRACTS_NUM_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRACTS_OPENDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS MODIFY (OPEN_DATE CONSTRAINT CC_CIMCONTRACTS_OPENDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRACTS_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS MODIFY (STATUS_ID CONSTRAINT CC_CIMCONTRACTS_STATUS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRACTS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS MODIFY (BRANCH CONSTRAINT CC_CIMCONTRACTS_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCONTRACTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCONTRACTS ON BARS.CIM_CONTRACTS (CONTR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_CIM_CONTRACTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_CIM_CONTRACTS ON BARS.CIM_CONTRACTS (RNK, UPPER(NUM), OPEN_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_CIM_CONTRACTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_CIM_CONTRACTS ON BARS.CIM_CONTRACTS (CONTR_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  index I3_CIM_CONTRACTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_CIM_CONTRACTS ON BARS.CIM_CONTRACTS (KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CONTRACTS ***
grant SELECT                                                                 on CIM_CONTRACTS   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACTS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CONTRACTS   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACTS   to CIM_ROLE;
grant SELECT                                                                 on CIM_CONTRACTS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACTS.sql =========*** End ***
PROMPT ===================================================================================== 
