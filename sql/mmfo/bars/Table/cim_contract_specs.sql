

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACT_SPECS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CONTRACT_SPECS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CONTRACT_SPECS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACT_SPECS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CIM_CONTRACT_SPECS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CONTRACT_SPECS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CONTRACT_SPECS 
   (	SPEC_ID NUMBER, 
	SPEC_NAME VARCHAR2(30), 
	DELETE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CONTRACT_SPECS ***
 exec bpa.alter_policies('CIM_CONTRACT_SPECS');


COMMENT ON TABLE BARS.CIM_CONTRACT_SPECS IS 'Спеціалізації  контрактів v1.0';
COMMENT ON COLUMN BARS.CIM_CONTRACT_SPECS.SPEC_ID IS 'Ідентифікатор спеціалізації';
COMMENT ON COLUMN BARS.CIM_CONTRACT_SPECS.SPEC_NAME IS 'Найменування спеціалізації';
COMMENT ON COLUMN BARS.CIM_CONTRACT_SPECS.DELETE_DATE IS 'Дата видалення';




PROMPT *** Create  constraint PK_CIMCONTRACTSPECS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACT_SPECS ADD CONSTRAINT PK_CIMCONTRACTSPECS PRIMARY KEY (SPEC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRACTSPECS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACT_SPECS MODIFY (SPEC_ID CONSTRAINT CC_CIMCONTRACTSPECS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRACTSPECS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACT_SPECS MODIFY (SPEC_NAME CONSTRAINT CC_CIMCONTRACTSPECS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCONTRACTSPECS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCONTRACTSPECS ON BARS.CIM_CONTRACT_SPECS (SPEC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CONTRACT_SPECS ***
grant SELECT                                                                 on CIM_CONTRACT_SPECS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACT_SPECS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CONTRACT_SPECS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACT_SPECS to CIM_ROLE;
grant SELECT                                                                 on CIM_CONTRACT_SPECS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACT_SPECS.sql =========*** En
PROMPT ===================================================================================== 
