

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_VEHICLE_TYPES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_VEHICLE_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_VEHICLE_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_VEHICLE_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_VEHICLE_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_VEHICLE_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_VEHICLE_TYPES 
   (	TYPE_ID NUMBER(5,0), 
	TYPE_NAME VARCHAR2(32)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_VEHICLE_TYPES ***
 exec bpa.alter_policies('GRT_VEHICLE_TYPES');


COMMENT ON TABLE BARS.GRT_VEHICLE_TYPES IS 'Довідник типів траспортних засобів';
COMMENT ON COLUMN BARS.GRT_VEHICLE_TYPES.TYPE_ID IS 'Код типу ТЗ';
COMMENT ON COLUMN BARS.GRT_VEHICLE_TYPES.TYPE_NAME IS 'Тип ТЗ';




PROMPT *** Create  constraint PK_GRTVEHTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VEHICLE_TYPES ADD CONSTRAINT PK_GRTVEHTYPES PRIMARY KEY (TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTVEHTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VEHICLE_TYPES MODIFY (TYPE_NAME CONSTRAINT CC_GRTVEHTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRTVEHTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRTVEHTYPES ON BARS.GRT_VEHICLE_TYPES (TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRT_VEHICLE_TYPES ***
grant SELECT                                                                 on GRT_VEHICLE_TYPES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on GRT_VEHICLE_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GRT_VEHICLE_TYPES to BARS_DM;
grant SELECT                                                                 on GRT_VEHICLE_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_VEHICLE_TYPES.sql =========*** End
PROMPT ===================================================================================== 
