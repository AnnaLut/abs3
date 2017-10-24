

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_PLACES.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_PLACES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_PLACES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_PLACES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_PLACES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_PLACES ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_PLACES 
   (	PLACE_ID NUMBER(4,0), 
	PLACE_NAME VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_PLACES ***
 exec bpa.alter_policies('GRT_PLACES');


COMMENT ON TABLE BARS.GRT_PLACES IS 'Справочник вариантов местонахождения обеспечения';
COMMENT ON COLUMN BARS.GRT_PLACES.PLACE_ID IS 'Идетнификатор местонахождения';
COMMENT ON COLUMN BARS.GRT_PLACES.PLACE_NAME IS 'Наименование местонахождения';




PROMPT *** Create  constraint CC_GRTPLACES_PLACENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_PLACES MODIFY (PLACE_NAME CONSTRAINT CC_GRTPLACES_PLACENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_GRTPLACES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_PLACES ADD CONSTRAINT PK_GRTPLACES PRIMARY KEY (PLACE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRTPLACES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRTPLACES ON BARS.GRT_PLACES (PLACE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRT_PLACES ***
grant SELECT                                                                 on GRT_PLACES      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GRT_PLACES      to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_PLACES.sql =========*** End *** ==
PROMPT ===================================================================================== 
