

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_ADDRESS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_ADDRESS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_ADDRESS'', ''CENTER'' , null, null, null, null);
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
	COMM VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


--
-- add column CHANGE_DT
--
begin
  execute immediate q'[alter table BARS.CUSTOMER_ADDRESS ADD CHANGE_DT DATE]';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "CHANGE_DT" already exists in table.');
    else raise;
    end if;
end;
/
--
-- KOATUU
--
begin
  execute immediate 'alter table BARS.CUSTOMER_ADDRESS ADD KOATUU VARCHAR2(15)';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "KOATUU" already exists in table.');
    else raise;
    end if;
end;
/

--
-- REGION
--
begin
  execute immediate q'[ALTER TABLE BARS.CUSTOMER_ADDRESS ADD REGION_ID NUMBER(10)]';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "REGION_ID" already exists in table.');
    else raise;
    end if;
end;
/

begin
  execute immediate q'[ALTER TABLE BARS.CUSTOMER_ADDRESS ADD AREA_ID NUMBER(10)]';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "AREA_ID" already exists in table.');
    else raise;
    end if;
end;
/

begin
  execute immediate q'[ALTER TABLE BARS.CUSTOMER_ADDRESS ADD SETTLEMENT_ID NUMBER(10)]';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "SETTLEMENT_ID" already exists in table.');
    else raise;
    end if;
end;
/

begin
  execute immediate q'[ALTER TABLE BARS.CUSTOMER_ADDRESS ADD STREET_ID NUMBER(10)]';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "STREET_ID" already exists in table.');
    else raise;
    end if;
end;
/



begin
  execute immediate q'[ALTER TABLE BARS.CUSTOMER_ADDRESS ADD HOUSE_ID NUMBER(10)]';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "HOUSE_ID" already exists in table.');
    else raise;
    end if;
end;
/


begin
  execute immediate q'[ALTER TABLE BARS.CUSTOMER_ADDRESS ADD locality_type_n NUMBER(10)]';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "locality_type_n" already exists in table.');
    else raise;
    end if;
end;
/

begin
  execute immediate q'[ALTER TABLE BARS.CUSTOMER_ADDRESS ADD street_type_n NUMBER(10)]';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "street_type_n" already exists in table.');
    else raise;
    end if;
end;
/



PROMPT *** ALTER_POLICIES to CUSTOMER_ADDRESS ***
 exec bpa.alter_policies('CUSTOMER_ADDRESS');


COMMENT ON TABLE BARS.CUSTOMER_ADDRESS IS 'Адреса клиентов';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.RNK IS 'Идентификатор клиента';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.TYPE_ID IS 'Тип адреса';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.COUNTRY IS 'Код страны';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.ZIP IS 'Индекс';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.DOMAIN IS 'Область';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.REGION IS 'Регион';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.LOCALITY IS 'Населенный пукт';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.ADDRESS IS 'Адрес (улица, дом, квартира)';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.TERRITORY_ID IS 'Код адреса';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.LOCALITY_TYPE IS 'Тип населенного пункта';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.STREET_TYPE IS 'Тип улицы';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.STREET IS 'Улица';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.HOME_TYPE IS 'Тип дома';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.HOME IS '№ дома';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.HOMEPART_TYPE IS 'Тип деления дома(если есть)';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.HOMEPART IS '№ типа деления дома';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.ROOM_TYPE IS 'Тип жилого помещения';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.ROOM IS '№ жилого помещения';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS.COMM IS 'Довільний коментар';




PROMPT *** Create  constraint FK_CUSTOMERADR_COUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT FK_CUSTOMERADR_COUNTRY FOREIGN KEY (COUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERADR_CUSTOMERADRTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT FK_CUSTOMERADR_CUSTOMERADRTYPE FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.CUSTOMER_ADDRESS_TYPE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERADR_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS ADD CONSTRAINT FK_CUSTOMERADR_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
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




PROMPT *** Create  constraint CC_CUSTOMERADR_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS MODIFY (TYPE_ID CONSTRAINT CC_CUSTOMERADR_TYPEID_NN NOT NULL ENABLE)';
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
grant SELECT                                                                 on CUSTOMER_ADDRESS to CUST001;
grant SELECT                                                                 on CUSTOMER_ADDRESS to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMER_ADDRESS to WR_ALL_RIGHTS;
grant SELECT                                                                 on CUSTOMER_ADDRESS to WR_CREDIT;
grant DELETE,SELECT                                                          on CUSTOMER_ADDRESS to WR_CUSTREG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_ADDRESS.sql =========*** End 
PROMPT ===================================================================================== 
