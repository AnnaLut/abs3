

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_ADDRESS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_ADDRESS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_ADDRESS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_ADDRESS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_ADDRESS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_ADDRESS 
   (	RNK NUMBER(38,0), 
	TYPE_ID NUMBER(38,0), 
	COUNTRY NUMBER(3,0), 
	ZIP VARCHAR2(20), 
	DOMAIN VARCHAR2(30), 
	REGION VARCHAR2(30), 
	LOCALITY VARCHAR2(30), 
	ADDRESS VARCHAR2(100), 
	TERRITORY_ID NUMBER(22,0), 
	LOCALITY_TYPE NUMBER(22,0), 
	STREET_TYPE NUMBER(22,0), 
	STREET VARCHAR2(100 CHAR), 
	HOME_TYPE NUMBER(22,0), 
	HOME VARCHAR2(100 CHAR), 
	HOMEPART_TYPE NUMBER(22,0), 
	HOMEPART VARCHAR2(100 CHAR), 
	ROOM_TYPE NUMBER(22,0), 
	ROOM VARCHAR2(100 CHAR), 
	COMM VARCHAR2(4000), 
	CHANGE_DT DATE DEFAULT sysdate, 
	KOATUU VARCHAR2(15), 
	REGION_ID NUMBER(10,0), 
	AREA_ID NUMBER(10,0), 
	SETTLEMENT_ID NUMBER(10,0), 
	STREET_ID NUMBER(10,0), 
	HOUSE_ID NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_ADDRESS ***
 exec bpa.alter_policies('CUSTOMER_ADDRESS');


COMMENT ON TABLE BARS.CUSTOMER_ADDRESS IS 'Адреса клиентов';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.AREA_ID IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.SETTLEMENT_ID IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.STREET_ID IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.HOUSE_ID IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.COMM IS 'Довільний коментар';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.LOCALITY_TYPE IS 'Тип населенного пункта';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.STREET_TYPE IS 'Тип улицы';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.STREET IS 'Улица';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.HOME_TYPE IS 'Тип дома';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.HOME IS '№ дома';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.HOMEPART_TYPE IS 'Тип деления дома(если есть)';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.HOMEPART IS '№ типа деления дома';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.ROOM_TYPE IS 'Тип жилого помещения';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.ROOM IS '№ жилого помещения';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.CHANGE_DT IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.KOATUU IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.REGION_ID IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.RNK IS 'Идентификатор клиента';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.TYPE_ID IS 'Тип адреса';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.COUNTRY IS 'Код страны';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.ZIP IS 'Индекс';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.DOMAIN IS 'Область';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.REGION IS 'Регион';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.LOCALITY IS 'Населенный пукт';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.ADDRESS IS 'Адрес (улица, дом, квартира)';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.TERRITORY_ID IS 'Код адреса';




PROMPT *** Create  constraint FK_CUSTOMERADR_COUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT FK_CUSTOMERADR_COUNTRY FOREIGN KEY (COUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERADR_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT FK_CUSTOMERADR_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERADR_CUSTOMERADRTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT FK_CUSTOMERADR_CUSTOMERADRTYPE FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.CUSTOMER_ADDRESS_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERADR_ROOMTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT FK_CUSTOMERADR_ROOMTYPE FOREIGN KEY (ROOM_TYPE)
	  REFERENCES BARS.ADR_ROOM_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERADR_HOMEPARTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT FK_CUSTOMERADR_HOMEPARTTYPE FOREIGN KEY (HOMEPART_TYPE)
	  REFERENCES BARS.ADR_HOMEPART_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERADR_HOMETYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT FK_CUSTOMERADR_HOMETYPE FOREIGN KEY (HOME_TYPE)
	  REFERENCES BARS.ADR_HOME_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERADR_HOUSES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT FK_CUSTOMERADR_HOUSES FOREIGN KEY (HOUSE_ID)
	  REFERENCES BARS.ADR_HOUSES (HOUSE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERADR_STREETS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT FK_CUSTOMERADR_STREETS FOREIGN KEY (STREET_ID)
	  REFERENCES BARS.ADR_STREETS (STREET_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERADR_SETTLEMENTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT FK_CUSTOMERADR_SETTLEMENTS FOREIGN KEY (SETTLEMENT_ID)
	  REFERENCES BARS.ADR_SETTLEMENTS (SETTLEMENT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERADR_AREAS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT FK_CUSTOMERADR_AREAS FOREIGN KEY (AREA_ID)
	  REFERENCES BARS.ADR_AREAS (AREA_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERADR_REGIONS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT FK_CUSTOMERADR_REGIONS FOREIGN KEY (REGION_ID)
	  REFERENCES BARS.ADR_REGIONS (REGION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUSTOMERADR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT PK_CUSTOMERADR PRIMARY KEY (RNK, TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERADR_COUNTRY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS MODIFY (COUNTRY CONSTRAINT CC_CUSTOMERADR_COUNTRY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERADR_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS MODIFY (TYPE_ID CONSTRAINT CC_CUSTOMERADR_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERADR_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS MODIFY (RNK CONSTRAINT CC_CUSTOMERADR_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERADR_CHANGEDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS MODIFY (CHANGE_DT CONSTRAINT CC_CUSTOMERADR_CHANGEDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERADR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMERADR ON BARS.CUSTOMER_ADDRESS (RNK, TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_ADDRESS ***
grant FLASHBACK,SELECT                                                       on CUSTOMER_ADDRESS to BARSAQ;
grant SELECT                                                                 on CUSTOMER_ADDRESS to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CUSTOMER_ADDRESS to BARSUPL;
grant DELETE,SELECT,UPDATE                                                   on CUSTOMER_ADDRESS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_ADDRESS to BARS_DM;
grant SELECT                                                                 on CUSTOMER_ADDRESS to FINMON;
grant SELECT                                                                 on CUSTOMER_ADDRESS to BARS_SUP;
grant SELECT                                                                 on CUSTOMER_ADDRESS to CUST001;
grant SELECT                                                                 on CUSTOMER_ADDRESS to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMER_ADDRESS to WR_ALL_RIGHTS;
grant SELECT                                                                 on CUSTOMER_ADDRESS to WR_CREDIT;
grant DELETE,SELECT                                                          on CUSTOMER_ADDRESS to WR_CUSTREG;



PROMPT *** Create SYNONYM  to CUSTOMER_ADDRESS ***

--  CREATE OR REPLACE SYNONYM BARSDWH_ACCESS_USER.CUSTOMER_ADDRESS FOR BARS.CUSTOMER_ADDRESS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_ADDRESS.sql =========*** End 
PROMPT ===================================================================================== 
