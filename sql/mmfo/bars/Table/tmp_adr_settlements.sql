

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ADR_SETTLEMENTS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ADR_SETTLEMENTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ADR_SETTLEMENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ADR_SETTLEMENTS 
   (	SETTLEMENT_ID NUMBER(10,0), 
	SETTLEMENT_NAME VARCHAR2(50), 
	SETTLEMENT_NAME_RU VARCHAR2(50), 
	SETTLEMENT_TYPE_ID NUMBER(3,0), 
	POSTAL_CODE_MIN VARCHAR2(5), 
	POSTAL_CODE_MAX VARCHAR2(5), 
	PHONE_CODE_ID NUMBER(10,0), 
	REGION_CENTER_F NUMBER(1,0), 
	AREA_CENTER_F NUMBER(1,0), 
	REGION_ID NUMBER(10,0), 
	AREA_ID NUMBER(10,0), 
	KOATUU VARCHAR2(15), 
	TERRSTATUS VARCHAR2(50), 
	EFF_DT DATE, 
	END_DT DATE, 
	SETTLEMENT_PID NUMBER(10,0), 
	SPIU_CITY_ID NUMBER(10,0), 
	SPIU_SUBURB_ID NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ADR_SETTLEMENTS ***
 exec bpa.alter_policies('TMP_ADR_SETTLEMENTS');


COMMENT ON TABLE BARS.TMP_ADR_SETTLEMENTS IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.SETTLEMENT_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.SETTLEMENT_NAME IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.SETTLEMENT_NAME_RU IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.SETTLEMENT_TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.POSTAL_CODE_MIN IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.POSTAL_CODE_MAX IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.PHONE_CODE_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.REGION_CENTER_F IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.AREA_CENTER_F IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.REGION_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.AREA_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.KOATUU IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.TERRSTATUS IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.EFF_DT IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.END_DT IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.SETTLEMENT_PID IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.SPIU_CITY_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADR_SETTLEMENTS.SPIU_SUBURB_ID IS '';




PROMPT *** Create  constraint SYS_C00119257 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADR_SETTLEMENTS MODIFY (SETTLEMENT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119258 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADR_SETTLEMENTS MODIFY (SETTLEMENT_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119259 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADR_SETTLEMENTS MODIFY (SETTLEMENT_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119260 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADR_SETTLEMENTS MODIFY (POSTAL_CODE_MIN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119261 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADR_SETTLEMENTS MODIFY (POSTAL_CODE_MAX NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119262 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADR_SETTLEMENTS MODIFY (REGION_CENTER_F NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119263 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADR_SETTLEMENTS MODIFY (AREA_CENTER_F NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119264 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADR_SETTLEMENTS MODIFY (EFF_DT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119265 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADR_SETTLEMENTS MODIFY (SPIU_CITY_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ADR_SETTLEMENTS ***
grant SELECT                                                                 on TMP_ADR_SETTLEMENTS to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_ADR_SETTLEMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ADR_SETTLEMENTS.sql =========*** E
PROMPT ===================================================================================== 
