

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ADR_HOUSES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ADR_HOUSES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ADR_HOUSES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ADR_HOUSES 
   (	HOUSE_ID NUMBER(10,0), 
	STREET_ID NUMBER(10,0), 
	DISTRICT_ID NUMBER(10,0), 
	HOUSE_NUM VARCHAR2(5), 
	HOUSE_NUM_ADD VARCHAR2(15), 
	POSTAL_CODE VARCHAR2(5), 
	LATITUDE VARCHAR2(15), 
	LONGITUDE VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ADR_HOUSES ***
 exec bpa.alter_policies('TMP_ADR_HOUSES');


COMMENT ON TABLE BARS.TMP_ADR_HOUSES IS '';
COMMENT ON COLUMN BARS.TMP_ADR_HOUSES.HOUSE_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADR_HOUSES.STREET_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADR_HOUSES.DISTRICT_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADR_HOUSES.HOUSE_NUM IS '';
COMMENT ON COLUMN BARS.TMP_ADR_HOUSES.HOUSE_NUM_ADD IS '';
COMMENT ON COLUMN BARS.TMP_ADR_HOUSES.POSTAL_CODE IS '';
COMMENT ON COLUMN BARS.TMP_ADR_HOUSES.LATITUDE IS '';
COMMENT ON COLUMN BARS.TMP_ADR_HOUSES.LONGITUDE IS '';




PROMPT *** Create  constraint SYS_C00119255 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADR_HOUSES MODIFY (HOUSE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119256 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADR_HOUSES MODIFY (STREET_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ADR_HOUSES ***
grant SELECT                                                                 on TMP_ADR_HOUSES  to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_ADR_HOUSES  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ADR_HOUSES.sql =========*** End **
PROMPT ===================================================================================== 
