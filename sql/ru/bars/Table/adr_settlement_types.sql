

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADR_SETTLEMENT_TYPES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADR_SETTLEMENT_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADR_SETTLEMENT_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ADR_SETTLEMENT_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADR_SETTLEMENT_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADR_SETTLEMENT_TYPES 
   (	SETTLEMENT_TP_ID NUMBER(3,0), 
	SETTLEMENT_TP_NM VARCHAR2(50), 
	SETTLEMENT_TP_NM_RU VARCHAR2(50), 
	SETTLEMENT_TP_CODE VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ADR_SETTLEMENT_TYPES ***
 exec bpa.alter_policies('ADR_SETTLEMENT_TYPES');


COMMENT ON TABLE BARS.ADR_SETTLEMENT_TYPES IS 'Довідник типів населених пунктів';
COMMENT ON COLUMN BARS.ADR_SETTLEMENT_TYPES.SETTLEMENT_TP_ID IS 'Ідентифікатор типу населеного пункту';
COMMENT ON COLUMN BARS.ADR_SETTLEMENT_TYPES.SETTLEMENT_TP_NM IS 'Назва типу населеного пункту';
COMMENT ON COLUMN BARS.ADR_SETTLEMENT_TYPES.SETTLEMENT_TP_NM_RU IS 'Назва типу населеного пункту';
COMMENT ON COLUMN BARS.ADR_SETTLEMENT_TYPES.SETTLEMENT_TP_CODE IS '';




PROMPT *** Create  constraint SYS_C003090360 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_SETTLEMENT_TYPES MODIFY (SETTLEMENT_TP_NM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003090359 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_SETTLEMENT_TYPES MODIFY (SETTLEMENT_TP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SETTLEMENTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_SETTLEMENT_TYPES ADD CONSTRAINT PK_SETTLEMENTTYPES PRIMARY KEY (SETTLEMENT_TP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SETTLEMENTTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SETTLEMENTTYPES ON BARS.ADR_SETTLEMENT_TYPES (SETTLEMENT_TP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADR_SETTLEMENT_TYPES ***
grant SELECT                                                                 on ADR_SETTLEMENT_TYPES to BARSUPL;
grant SELECT                                                                 on ADR_SETTLEMENT_TYPES to START1;
grant SELECT                                                                 on ADR_SETTLEMENT_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADR_SETTLEMENT_TYPES.sql =========*** 
PROMPT ===================================================================================== 
