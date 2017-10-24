

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADR_CITY_DISTRICTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADR_CITY_DISTRICTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADR_CITY_DISTRICTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ADR_CITY_DISTRICTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADR_CITY_DISTRICTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADR_CITY_DISTRICTS 
   (	DISTRICT_ID NUMBER(3,0), 
	DISTRICT_NAME VARCHAR2(50), 
	DISTRICT_NAME_RU VARCHAR2(50), 
	SETTLEMENT_ID NUMBER(10,0), 
	SPIU_DISTRICT_ID NUMBER(10,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ADR_CITY_DISTRICTS ***
 exec bpa.alter_policies('ADR_CITY_DISTRICTS');


COMMENT ON TABLE BARS.ADR_CITY_DISTRICTS IS '������� ��������������� ������';
COMMENT ON COLUMN BARS.ADR_CITY_DISTRICTS.DISTRICT_ID IS '��. ������ � ���';
COMMENT ON COLUMN BARS.ADR_CITY_DISTRICTS.DISTRICT_NAME IS '����� ������';
COMMENT ON COLUMN BARS.ADR_CITY_DISTRICTS.DISTRICT_NAME_RU IS '����� ������ (����� �������)';
COMMENT ON COLUMN BARS.ADR_CITY_DISTRICTS.SETTLEMENT_ID IS '������������� ���������� ������';
COMMENT ON COLUMN BARS.ADR_CITY_DISTRICTS.SPIU_DISTRICT_ID IS 'Original ID from "SPIU.CITYDISTRICTS.CITYDISTRICTID"';




PROMPT *** Create  constraint FK_CITYDISTRICTS_SETTLEMENTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_CITY_DISTRICTS ADD CONSTRAINT FK_CITYDISTRICTS_SETTLEMENTS FOREIGN KEY (SETTLEMENT_ID)
	  REFERENCES BARS.ADR_SETTLEMENTS (SETTLEMENT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CITYDISTRICTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_CITY_DISTRICTS ADD CONSTRAINT PK_CITYDISTRICTS PRIMARY KEY (DISTRICT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CITYDISTRICTS_SPIUDISTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_CITY_DISTRICTS MODIFY (SPIU_DISTRICT_ID CONSTRAINT CC_CITYDISTRICTS_SPIUDISTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CITYDISTRICTS_SETLMNTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_CITY_DISTRICTS MODIFY (SETTLEMENT_ID CONSTRAINT CC_CITYDISTRICTS_SETLMNTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CITYDISTRICTS_DISTNM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_CITY_DISTRICTS MODIFY (DISTRICT_NAME CONSTRAINT CC_CITYDISTRICTS_DISTNM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CITYDISTRICTS_DISTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_CITY_DISTRICTS MODIFY (DISTRICT_ID CONSTRAINT CC_CITYDISTRICTS_DISTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CITYDISTRICTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CITYDISTRICTS ON BARS.ADR_CITY_DISTRICTS (DISTRICT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADR_CITY_DISTRICTS ***
grant SELECT                                                                 on ADR_CITY_DISTRICTS to BARSUPL;
grant SELECT                                                                 on ADR_CITY_DISTRICTS to START1;
grant SELECT                                                                 on ADR_CITY_DISTRICTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADR_CITY_DISTRICTS.sql =========*** En
PROMPT ===================================================================================== 
