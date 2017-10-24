

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_ACT_TYPES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_ACT_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_ACT_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_ACT_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_ACT_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_ACT_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_ACT_TYPES 
   (	TYPE_ID NUMBER, 
	NAME VARCHAR2(30), 
	KIND NUMBER, 
	DELETE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_ACT_TYPES ***
 exec bpa.alter_policies('CIM_ACT_TYPES');


COMMENT ON TABLE BARS.CIM_ACT_TYPES IS 'Типи актів та ВМД';
COMMENT ON COLUMN BARS.CIM_ACT_TYPES.TYPE_ID IS 'Id типу';
COMMENT ON COLUMN BARS.CIM_ACT_TYPES.NAME IS 'Назва типу';
COMMENT ON COLUMN BARS.CIM_ACT_TYPES.KIND IS 'Вид (0-ВМД, 1-Акт)';
COMMENT ON COLUMN BARS.CIM_ACT_TYPES.DELETE_DATE IS 'Дата видалення';




PROMPT *** Create  constraint PK_CIMACTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACT_TYPES ADD CONSTRAINT PK_CIMACTTYPES PRIMARY KEY (TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTTYPES_KIND_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACT_TYPES ADD CONSTRAINT CC_CIMACTTYPES_KIND_CC CHECK (kind=0 or kind=1) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACT_TYPES MODIFY (NAME CONSTRAINT CC_CIMACTTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTTYPES_KIND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACT_TYPES MODIFY (KIND CONSTRAINT CC_CIMACTTYPES_KIND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMACTTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMACTTYPES ON BARS.CIM_ACT_TYPES (TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_ACT_TYPES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_ACT_TYPES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_ACT_TYPES   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_ACT_TYPES   to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_ACT_TYPES.sql =========*** End ***
PROMPT ===================================================================================== 
