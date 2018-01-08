

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ADR_STREETS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ADR_STREETS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ADR_STREETS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ADR_STREETS 
   (	STREET_ID NUMBER(10,0), 
	STREET_NAME VARCHAR2(50), 
	STREET_NAME_RU VARCHAR2(50), 
	STREET_TYPE NUMBER(3,0), 
	SETTLEMENT_ID NUMBER(10,0), 
	EFF_DT DATE, 
	END_DT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ADR_STREETS ***
 exec bpa.alter_policies('TMP_ADR_STREETS');


COMMENT ON TABLE BARS.TMP_ADR_STREETS IS '';
COMMENT ON COLUMN BARS.TMP_ADR_STREETS.STREET_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADR_STREETS.STREET_NAME IS '';
COMMENT ON COLUMN BARS.TMP_ADR_STREETS.STREET_NAME_RU IS '';
COMMENT ON COLUMN BARS.TMP_ADR_STREETS.STREET_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_ADR_STREETS.SETTLEMENT_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADR_STREETS.EFF_DT IS '';
COMMENT ON COLUMN BARS.TMP_ADR_STREETS.END_DT IS '';




PROMPT *** Create  constraint SYS_C00119266 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADR_STREETS MODIFY (STREET_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119267 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADR_STREETS MODIFY (STREET_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119268 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADR_STREETS MODIFY (STREET_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119269 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADR_STREETS MODIFY (SETTLEMENT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119270 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADR_STREETS MODIFY (EFF_DT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ADR_STREETS ***
grant SELECT                                                                 on TMP_ADR_STREETS to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_ADR_STREETS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ADR_STREETS.sql =========*** End *
PROMPT ===================================================================================== 
