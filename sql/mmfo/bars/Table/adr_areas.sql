

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADR_AREAS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADR_AREAS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADR_AREAS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ADR_AREAS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADR_AREAS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADR_AREAS 
   (	AREA_ID NUMBER(10,0), 
	SPIU_AREA_ID NUMBER(10,0), 
	AREA_NAME VARCHAR2(50), 
	AREA_NAME_RU VARCHAR2(50), 
	REGION_ID NUMBER(10,0), 
	KOATUU VARCHAR2(5)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ADR_AREAS ***
 exec bpa.alter_policies('ADR_AREAS');


COMMENT ON TABLE BARS.ADR_AREAS IS 'Довідник районів';
COMMENT ON COLUMN BARS.ADR_AREAS.AREA_ID IS 'Ідентифікатор району';
COMMENT ON COLUMN BARS.ADR_AREAS.SPIU_AREA_ID IS '';
COMMENT ON COLUMN BARS.ADR_AREAS.AREA_NAME IS 'Назва району';
COMMENT ON COLUMN BARS.ADR_AREAS.AREA_NAME_RU IS 'Назва району';
COMMENT ON COLUMN BARS.ADR_AREAS.REGION_ID IS 'Ідентифікатор області';
COMMENT ON COLUMN BARS.ADR_AREAS.KOATUU IS '';




PROMPT *** Create  constraint CC_AREAS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_AREAS MODIFY (AREA_ID CONSTRAINT CC_AREAS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AREAS_SPIUID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_AREAS MODIFY (SPIU_AREA_ID CONSTRAINT CC_AREAS_SPIUID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AREAS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_AREAS MODIFY (AREA_NAME CONSTRAINT CC_AREAS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AREAS_REGIONID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_AREAS MODIFY (REGION_ID CONSTRAINT CC_AREAS_REGIONID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_ADRAREAS_AREANAME ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_ADRAREAS_AREANAME ON BARS.ADR_AREAS (NLSSORT(AREA_NAME,''nls_sort=''''BINARY_CI'''''')) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADR_AREAS ***
grant SELECT                                                                 on ADR_AREAS       to BARSUPL;
grant SELECT                                                                 on ADR_AREAS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ADR_AREAS       to START1;
grant SELECT                                                                 on ADR_AREAS       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADR_AREAS.sql =========*** End *** ===
PROMPT ===================================================================================== 
