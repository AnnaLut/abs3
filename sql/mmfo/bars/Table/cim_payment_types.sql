

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_PAYMENT_TYPES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_PAYMENT_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_PAYMENT_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_PAYMENT_TYPES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CIM_PAYMENT_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_PAYMENT_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_PAYMENT_TYPES 
   (	TYPE_ID NUMBER, 
	TYPE_NAME VARCHAR2(128), 
	DELETE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_PAYMENT_TYPES ***
 exec bpa.alter_policies('CIM_PAYMENT_TYPES');


COMMENT ON TABLE BARS.CIM_PAYMENT_TYPES IS 'Види платіжних документів version 1.0';
COMMENT ON COLUMN BARS.CIM_PAYMENT_TYPES.TYPE_ID IS 'ID виду';
COMMENT ON COLUMN BARS.CIM_PAYMENT_TYPES.TYPE_NAME IS 'Найменування виду';
COMMENT ON COLUMN BARS.CIM_PAYMENT_TYPES.DELETE_DATE IS 'Дата видалення';




PROMPT *** Create  constraint PK_CIMPAYMENTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENT_TYPES ADD CONSTRAINT PK_CIMPAYMENTTYPES PRIMARY KEY (TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMPAYTYPES_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENT_TYPES MODIFY (TYPE_ID CONSTRAINT CC_CIMPAYTYPES_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMPAYTYPES_TYPENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENT_TYPES MODIFY (TYPE_NAME CONSTRAINT CC_CIMPAYTYPES_TYPENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMPAYMENTTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMPAYMENTTYPES ON BARS.CIM_PAYMENT_TYPES (TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_PAYMENT_TYPES ***
grant SELECT                                                                 on CIM_PAYMENT_TYPES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_PAYMENT_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_PAYMENT_TYPES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_PAYMENT_TYPES to CIM_ROLE;
grant SELECT                                                                 on CIM_PAYMENT_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_PAYMENT_TYPES.sql =========*** End
PROMPT ===================================================================================== 
