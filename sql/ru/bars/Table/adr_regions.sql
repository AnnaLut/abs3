

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADR_REGIONS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADR_REGIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADR_REGIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ADR_REGIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADR_REGIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADR_REGIONS 
   (	REGION_ID NUMBER(10,0), 
	REGION_NAME VARCHAR2(50), 
	REGION_NAME_RU VARCHAR2(50), 
	COUNTRY_ID NUMBER(3,0) DEFAULT 804, 
	KOATUU VARCHAR2(2), 
	ISO3166_2 VARCHAR2(5)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ADR_REGIONS ***
 exec bpa.alter_policies('ADR_REGIONS');


COMMENT ON TABLE BARS.ADR_REGIONS IS 'Довідник областей';
COMMENT ON COLUMN BARS.ADR_REGIONS.REGION_ID IS 'Ідентифікатор області';
COMMENT ON COLUMN BARS.ADR_REGIONS.REGION_NAME IS 'Назва області';
COMMENT ON COLUMN BARS.ADR_REGIONS.REGION_NAME_RU IS 'Назва області';
COMMENT ON COLUMN BARS.ADR_REGIONS.COUNTRY_ID IS 'Код країни';
COMMENT ON COLUMN BARS.ADR_REGIONS.KOATUU IS '';
COMMENT ON COLUMN BARS.ADR_REGIONS.ISO3166_2 IS '';




PROMPT *** Create  constraint FK_REGIONS_COUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_REGIONS ADD CONSTRAINT FK_REGIONS_COUNTRY FOREIGN KEY (COUNTRY_ID)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_REGIONS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_REGIONS ADD CONSTRAINT PK_REGIONS PRIMARY KEY (REGION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003090347 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_REGIONS MODIFY (COUNTRY_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003090346 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_REGIONS MODIFY (REGION_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003090345 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_REGIONS MODIFY (REGION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REGIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REGIONS ON BARS.ADR_REGIONS (REGION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADR_REGIONS ***
grant SELECT                                                                 on ADR_REGIONS     to BARSUPL;
grant SELECT                                                                 on ADR_REGIONS     to START1;
grant SELECT                                                                 on ADR_REGIONS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADR_REGIONS.sql =========*** End *** =
PROMPT ===================================================================================== 
