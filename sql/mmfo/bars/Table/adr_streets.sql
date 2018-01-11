

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADR_STREETS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADR_STREETS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADR_STREETS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ADR_STREETS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADR_STREETS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADR_STREETS 
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




PROMPT *** ALTER_POLICIES to ADR_STREETS ***
 exec bpa.alter_policies('ADR_STREETS');


COMMENT ON TABLE BARS.ADR_STREETS IS 'Довідник вулиць';
COMMENT ON COLUMN BARS.ADR_STREETS.STREET_ID IS 'Ідентифікатор вулиці';
COMMENT ON COLUMN BARS.ADR_STREETS.STREET_NAME IS 'Назва вулиці';
COMMENT ON COLUMN BARS.ADR_STREETS.STREET_NAME_RU IS 'Назва вулиці (RUS)';
COMMENT ON COLUMN BARS.ADR_STREETS.STREET_TYPE IS 'Ідентифікатор типу вулиці';
COMMENT ON COLUMN BARS.ADR_STREETS.SETTLEMENT_ID IS 'Ідентифікатор населеного пункту';
COMMENT ON COLUMN BARS.ADR_STREETS.EFF_DT IS '';
COMMENT ON COLUMN BARS.ADR_STREETS.END_DT IS '';




PROMPT *** Create  constraint CC_STREETS_STREETID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_STREETS MODIFY (STREET_ID CONSTRAINT CC_STREETS_STREETID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREETS_STREETNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_STREETS MODIFY (STREET_NAME CONSTRAINT CC_STREETS_STREETNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREETS_STREETTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_STREETS MODIFY (STREET_TYPE CONSTRAINT CC_STREETS_STREETTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREETS_SETTLEMENTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_STREETS MODIFY (SETTLEMENT_ID CONSTRAINT CC_STREETS_SETTLEMENTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREETS_EFFDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_STREETS MODIFY (EFF_DT CONSTRAINT CC_STREETS_EFFDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADR_STREETS ***
grant SELECT                                                                 on ADR_STREETS     to BARSREADER_ROLE;
grant SELECT                                                                 on ADR_STREETS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADR_STREETS.sql =========*** End *** =
PROMPT ===================================================================================== 
