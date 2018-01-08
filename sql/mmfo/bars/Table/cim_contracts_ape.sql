

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACTS_APE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CONTRACTS_APE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CONTRACTS_APE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACTS_APE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACTS_APE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CONTRACTS_APE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CONTRACTS_APE 
   (	APE_ID NUMBER, 
	CONTR_ID NUMBER, 
	NUM VARCHAR2(16), 
	KV NUMBER, 
	S NUMBER, 
	RATE NUMBER DEFAULT 1, 
	S_VK NUMBER, 
	BEGIN_DATE DATE, 
	END_DATE DATE, 
	COMMENTS VARCHAR2(64), 
	DELETE_DATE DATE, 
	DELETE_UID VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CONTRACTS_APE ***
 exec bpa.alter_policies('CIM_CONTRACTS_APE');


COMMENT ON TABLE BARS.CIM_CONTRACTS_APE IS 'Акти цінової експертизи';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_APE.APE_ID IS 'ID акту цінової експертизи';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_APE.CONTR_ID IS 'ID контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_APE.NUM IS 'Номер акту цінової експертизи';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_APE.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_APE.S IS 'Сума';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_APE.RATE IS '';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_APE.S_VK IS '';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_APE.BEGIN_DATE IS 'Дата акту цінової експертизи';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_APE.END_DATE IS 'Дата, до якої дійсний актцінової експертизи';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_APE.COMMENTS IS 'Примітка';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_APE.DELETE_DATE IS 'Дата видалення';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_APE.DELETE_UID IS 'id користувача, який видалив акт';




PROMPT *** Create  constraint CC_CIMAPE_CONTRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_APE MODIFY (CONTR_ID CONSTRAINT CC_CIMAPE_CONTRID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMAPE_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_APE MODIFY (KV CONSTRAINT CC_CIMAPE_KV_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMAPE_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_APE MODIFY (S CONSTRAINT CC_CIMAPE_S_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMAPE_RATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_APE MODIFY (RATE CONSTRAINT CC_CIMAPE_RATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMAPE_SVK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_APE MODIFY (S_VK CONSTRAINT CC_CIMAPE_SVK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMAPE_BEGINDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_APE MODIFY (BEGIN_DATE CONSTRAINT CC_CIMAPE_BEGINDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMAPE_ENDDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_APE MODIFY (END_DATE CONSTRAINT CC_CIMAPE_ENDDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CIMAPE_APEID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_APE ADD CONSTRAINT PK_CIMAPE_APEID PRIMARY KEY (APE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMAPE_APEID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMAPE_APEID ON BARS.CIM_CONTRACTS_APE (APE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CONTRACTS_APE ***
grant SELECT                                                                 on CIM_CONTRACTS_APE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACTS_APE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CONTRACTS_APE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACTS_APE to CIM_ROLE;
grant SELECT                                                                 on CIM_CONTRACTS_APE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACTS_APE.sql =========*** End
PROMPT ===================================================================================== 
