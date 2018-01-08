

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACT_TYPES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CONTRACT_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CONTRACT_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACT_TYPES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CIM_CONTRACT_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CONTRACT_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CONTRACT_TYPES 
   (	CONTR_TYPE_ID NUMBER, 
	CONTR_TYPE_NAME VARCHAR2(128)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CONTRACT_TYPES ***
 exec bpa.alter_policies('CIM_CONTRACT_TYPES');


COMMENT ON TABLE BARS.CIM_CONTRACT_TYPES IS 'Типи контрактів version 1.0';
COMMENT ON COLUMN BARS.CIM_CONTRACT_TYPES.CONTR_TYPE_ID IS 'ID типу';
COMMENT ON COLUMN BARS.CIM_CONTRACT_TYPES.CONTR_TYPE_NAME IS 'Найменування типу';




PROMPT *** Create  constraint PK_CIMCONTRACTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACT_TYPES ADD CONSTRAINT PK_CIMCONTRACTTYPES PRIMARY KEY (CONTR_TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRTYPES_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACT_TYPES MODIFY (CONTR_TYPE_ID CONSTRAINT CC_CIMCONTRTYPES_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRTYPES_TYPENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACT_TYPES MODIFY (CONTR_TYPE_NAME CONSTRAINT CC_CIMCONTRTYPES_TYPENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCONTRACTTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCONTRACTTYPES ON BARS.CIM_CONTRACT_TYPES (CONTR_TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CONTRACT_TYPES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACT_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CONTRACT_TYPES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACT_TYPES to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACT_TYPES.sql =========*** En
PROMPT ===================================================================================== 
