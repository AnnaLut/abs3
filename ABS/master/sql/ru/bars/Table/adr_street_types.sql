

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADR_STREET_TYPES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADR_STREET_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADR_STREET_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ADR_STREET_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADR_STREET_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADR_STREET_TYPES 
   (	STR_TP_ID NUMBER(3,0), 
	STR_TP_NM VARCHAR2(12), 
	STR_TP_NM_RU VARCHAR2(12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ADR_STREET_TYPES ***
 exec bpa.alter_policies('ADR_STREET_TYPES');


COMMENT ON TABLE BARS.ADR_STREET_TYPES IS 'Довідник типів вулиць';
COMMENT ON COLUMN BARS.ADR_STREET_TYPES.STR_TP_ID IS 'Ід.   типу вулиці';
COMMENT ON COLUMN BARS.ADR_STREET_TYPES.STR_TP_NM IS 'Назва типу вулиці';
COMMENT ON COLUMN BARS.ADR_STREET_TYPES.STR_TP_NM_RU IS 'Назва типу вулиці';




PROMPT *** Create  constraint PK_STREETTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_STREET_TYPES ADD CONSTRAINT PK_STREETTYPES PRIMARY KEY (STR_TP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003090380 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_STREET_TYPES MODIFY (STR_TP_NM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003090379 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_STREET_TYPES MODIFY (STR_TP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STREETTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STREETTYPES ON BARS.ADR_STREET_TYPES (STR_TP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADR_STREET_TYPES ***
grant SELECT                                                                 on ADR_STREET_TYPES to BARSUPL;
grant SELECT                                                                 on ADR_STREET_TYPES to START1;
grant SELECT                                                                 on ADR_STREET_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADR_STREET_TYPES.sql =========*** End 
PROMPT ===================================================================================== 
