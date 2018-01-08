

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACT_STATUSES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CONTRACT_STATUSES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CONTRACT_STATUSES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACT_STATUSES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CIM_CONTRACT_STATUSES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CONTRACT_STATUSES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CONTRACT_STATUSES 
   (	STATUS_ID NUMBER, 
	STATUS_NAME VARCHAR2(30), 
	COMMENTS VARCHAR2(400)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CONTRACT_STATUSES ***
 exec bpa.alter_policies('CIM_CONTRACT_STATUSES');


COMMENT ON TABLE BARS.CIM_CONTRACT_STATUSES IS 'Статуси контрактів v1.0';
COMMENT ON COLUMN BARS.CIM_CONTRACT_STATUSES.STATUS_ID IS 'Ідентифікатор статусу';
COMMENT ON COLUMN BARS.CIM_CONTRACT_STATUSES.STATUS_NAME IS 'Найменування статусу';
COMMENT ON COLUMN BARS.CIM_CONTRACT_STATUSES.COMMENTS IS 'Коментар';




PROMPT *** Create  constraint PK_CIMCONTRACTSTATUSES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACT_STATUSES ADD CONSTRAINT PK_CIMCONTRACTSTATUSES PRIMARY KEY (STATUS_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRACTSTATUSES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACT_STATUSES MODIFY (STATUS_ID CONSTRAINT CC_CIMCONTRACTSTATUSES_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRACTSTATUSES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACT_STATUSES MODIFY (STATUS_NAME CONSTRAINT CC_CIMCONTRACTSTATUSES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCONTRACTSTATUSES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCONTRACTSTATUSES ON BARS.CIM_CONTRACT_STATUSES (STATUS_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CONTRACT_STATUSES ***
grant SELECT                                                                 on CIM_CONTRACT_STATUSES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACT_STATUSES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CONTRACT_STATUSES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACT_STATUSES to CIM_ROLE;
grant SELECT                                                                 on CIM_CONTRACT_STATUSES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACT_STATUSES.sql =========***
PROMPT ===================================================================================== 
