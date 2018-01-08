

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADR_SETTLEMENTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADR_SETTLEMENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADR_SETTLEMENTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ADR_SETTLEMENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADR_SETTLEMENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADR_SETTLEMENTS 
   (	SETTLEMENT_ID NUMBER(10,0), 
	SETTLEMENT_NAME VARCHAR2(50), 
	SETTLEMENT_NAME_RU VARCHAR2(50), 
	SETTLEMENT_TYPE_ID NUMBER(3,0), 
	POSTAL_CODE_MIN VARCHAR2(5), 
	POSTAL_CODE_MAX VARCHAR2(5), 
	PHONE_CODE_ID NUMBER(10,0), 
	REGION_CENTER_F NUMBER(1,0) DEFAULT 0, 
	AREA_CENTER_F NUMBER(1,0) DEFAULT 0, 
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




PROMPT *** ALTER_POLICIES to ADR_SETTLEMENTS ***
 exec bpa.alter_policies('ADR_SETTLEMENTS');


COMMENT ON TABLE BARS.ADR_SETTLEMENTS IS 'Довідник населених пунктів';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.SETTLEMENT_ID IS 'Ідентифікатор населеного пункту (equal to "SPIU.SUMMARYSETTLEMENTS.SUMMARYSETTLEMENTID"';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.SETTLEMENT_NAME IS 'Назва населеного пункту';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.SETTLEMENT_NAME_RU IS 'Назва населеного пункту';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.SETTLEMENT_TYPE_ID IS 'Ідентифікатор типу населеного пункту';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.POSTAL_CODE_MIN IS 'Мінімальний індекс для населеного пункту';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.POSTAL_CODE_MAX IS 'Максимальний індекс для населеного пункту';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.PHONE_CODE_ID IS '';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.REGION_CENTER_F IS 'Чи є населений пункт обласним центром';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.AREA_CENTER_F IS 'Чи є населений пункт районним центром';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.REGION_ID IS 'Ід. області (для міст обласного підпорядкування)';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.AREA_ID IS 'Ід. району';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.KOATUU IS 'Код населеного пункту згідно класифікатора об`єктів адміністративно-територіального устрою України (КОАТУУ)';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.TERRSTATUS IS 'Спеціальний статус території (Зона АТО, Тимчасово окупована територія - Крим)';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.EFF_DT IS 'The date from which an instance of the entity is valid.';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.END_DT IS 'The date after which an instance of the entity is no longer valid.';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.SETTLEMENT_PID IS 'Previous Ідентифікатор населеного пункту';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.SPIU_CITY_ID IS '';
COMMENT ON COLUMN BARS.ADR_SETTLEMENTS.SPIU_SUBURB_ID IS '';




PROMPT *** Create  constraint CC_SETTLEMENTS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_SETTLEMENTS MODIFY (SETTLEMENT_ID CONSTRAINT CC_SETTLEMENTS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SETTLEMENTS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_SETTLEMENTS MODIFY (SETTLEMENT_NAME CONSTRAINT CC_SETTLEMENTS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SETTLEMENTS_SPIUSETLID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_SETTLEMENTS MODIFY (SPIU_CITY_ID CONSTRAINT CC_SETTLEMENTS_SPIUSETLID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SETTLEMENTS_EFFDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_SETTLEMENTS MODIFY (EFF_DT CONSTRAINT CC_SETTLEMENTS_EFFDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SETTLEMENTS_AREACENTERF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_SETTLEMENTS MODIFY (AREA_CENTER_F CONSTRAINT CC_SETTLEMENTS_AREACENTERF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SETTLEMENTS_REGNCENTERF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_SETTLEMENTS MODIFY (REGION_CENTER_F CONSTRAINT CC_SETTLEMENTS_REGNCENTERF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SETTLEMENTS_POSTCODEMAX_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_SETTLEMENTS MODIFY (POSTAL_CODE_MAX CONSTRAINT CC_SETTLEMENTS_POSTCODEMAX_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SETTLEMENTS_POSTCODEMIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_SETTLEMENTS MODIFY (POSTAL_CODE_MIN CONSTRAINT CC_SETTLEMENTS_POSTCODEMIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SETTLEMENTS_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_SETTLEMENTS MODIFY (SETTLEMENT_TYPE_ID CONSTRAINT CC_SETTLEMENTS_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADR_SETTLEMENTS ***
grant SELECT                                                                 on ADR_SETTLEMENTS to BARSUPL;
grant SELECT                                                                 on ADR_SETTLEMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ADR_SETTLEMENTS to START1;
grant SELECT                                                                 on ADR_SETTLEMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADR_SETTLEMENTS.sql =========*** End *
PROMPT ===================================================================================== 
