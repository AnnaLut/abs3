

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_UNITS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_UNITS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_UNITS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_UNITS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_UNITS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_UNITS ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_UNITS 
   (	UNIT_ID NUMBER(4,0), 
	UNIT_SHORT_NAME VARCHAR2(7), 
	UNIT_FULL_NAME VARCHAR2(24), 
	UNIT_DESC VARCHAR2(128)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_UNITS ***
 exec bpa.alter_policies('GRT_UNITS');


COMMENT ON TABLE BARS.GRT_UNITS IS 'Справочник едениц измерения залогового имущества';
COMMENT ON COLUMN BARS.GRT_UNITS.UNIT_ID IS 'Идетнификатор еденицы измерения';
COMMENT ON COLUMN BARS.GRT_UNITS.UNIT_SHORT_NAME IS 'Сокращенное наименование еденицы измерения';
COMMENT ON COLUMN BARS.GRT_UNITS.UNIT_FULL_NAME IS 'Полное наименование еденицы измерения';
COMMENT ON COLUMN BARS.GRT_UNITS.UNIT_DESC IS 'Описание еденицы измерения';




PROMPT *** Create  constraint PK_GRTUNITS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_UNITS ADD CONSTRAINT PK_GRTUNITS PRIMARY KEY (UNIT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTUNITS_UNITSHNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_UNITS MODIFY (UNIT_SHORT_NAME CONSTRAINT CC_GRTUNITS_UNITSHNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTUNITS_UNITFULLNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_UNITS MODIFY (UNIT_FULL_NAME CONSTRAINT CC_GRTUNITS_UNITFULLNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTUNITS_UNITDESC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_UNITS MODIFY (UNIT_DESC CONSTRAINT CC_GRTUNITS_UNITDESC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRTUNITS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRTUNITS ON BARS.GRT_UNITS (UNIT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRT_UNITS ***
grant SELECT                                                                 on GRT_UNITS       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on GRT_UNITS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GRT_UNITS       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on GRT_UNITS       to START1;
grant SELECT                                                                 on GRT_UNITS       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_UNITS.sql =========*** End *** ===
PROMPT ===================================================================================== 
