

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TM_CARDS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TM_CARDS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TM_CARDS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TM_CARDS'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''TM_CARDS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TM_CARDS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TM_CARDS 
   (	FIO VARCHAR2(100), 
	OKPO VARCHAR2(14), 
	ADDRESS_STREET VARCHAR2(150), 
	ADDRESS_CITY VARCHAR2(50), 
	ADDRESS_DOMAIN VARCHAR2(50), 
	ADDRESS_REGION VARCHAR2(50), 
	ADDRESS_COUNTRY VARCHAR2(50), 
	ADDRESS_ZIP VARCHAR2(10), 
	PASSP_TYPE NUMBER(20,0), 
	PASSP_SERIAL VARCHAR2(20), 
	PASSP_NUMBER VARCHAR2(20), 
	PASSP_DATE DATE, 
	PASSP_ORGAN VARCHAR2(100), 
	REGISTER_DATE DATE, 
	CONTRACT_NUMBER VARCHAR2(20), 
	CONTRACT_DATE DATE, 
	BALANCE NUMBER(24,0), 
	NLS VARCHAR2(20), 
	DAOS DATE, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TM_CARDS ***
 exec bpa.alter_policies('TM_CARDS');


COMMENT ON TABLE BARS.TM_CARDS IS 'Карты и клиенты TransMaster';
COMMENT ON COLUMN BARS.TM_CARDS.FIO IS 'ФИО держателя';
COMMENT ON COLUMN BARS.TM_CARDS.OKPO IS 'ОКПО держателя';
COMMENT ON COLUMN BARS.TM_CARDS.ADDRESS_STREET IS 'Адрес (улица, дом...)';
COMMENT ON COLUMN BARS.TM_CARDS.ADDRESS_CITY IS 'Населеный пункт';
COMMENT ON COLUMN BARS.TM_CARDS.ADDRESS_DOMAIN IS 'Район';
COMMENT ON COLUMN BARS.TM_CARDS.ADDRESS_REGION IS 'Область';
COMMENT ON COLUMN BARS.TM_CARDS.ADDRESS_COUNTRY IS 'Страна';
COMMENT ON COLUMN BARS.TM_CARDS.ADDRESS_ZIP IS 'Индекс';
COMMENT ON COLUMN BARS.TM_CARDS.PASSP_TYPE IS 'Тип документа';
COMMENT ON COLUMN BARS.TM_CARDS.PASSP_SERIAL IS 'Серия документа';
COMMENT ON COLUMN BARS.TM_CARDS.PASSP_NUMBER IS 'Номер документа';
COMMENT ON COLUMN BARS.TM_CARDS.PASSP_DATE IS 'Дата выдачи документа';
COMMENT ON COLUMN BARS.TM_CARDS.PASSP_ORGAN IS 'Кем выдан документ';
COMMENT ON COLUMN BARS.TM_CARDS.REGISTER_DATE IS 'Дата регистраци держателя карты';
COMMENT ON COLUMN BARS.TM_CARDS.CONTRACT_NUMBER IS '№ договора';
COMMENT ON COLUMN BARS.TM_CARDS.CONTRACT_DATE IS 'Дата заключения договора';
COMMENT ON COLUMN BARS.TM_CARDS.BALANCE IS 'Обороты по счету в эквиваленте';
COMMENT ON COLUMN BARS.TM_CARDS.NLS IS 'Номер карточного счета';
COMMENT ON COLUMN BARS.TM_CARDS.DAOS IS 'Дата открытия счета';
COMMENT ON COLUMN BARS.TM_CARDS.BRANCH IS 'Идентификатор подразделения';




PROMPT *** Create  constraint CC_TMCARDS_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TM_CARDS MODIFY (NLS CONSTRAINT CC_TMCARDS_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMCARDS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TM_CARDS MODIFY (BRANCH CONSTRAINT CC_TMCARDS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TMCARDS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TM_CARDS ADD CONSTRAINT PK_TMCARDS PRIMARY KEY (NLS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMCARDS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMCARDS ON BARS.TM_CARDS (NLS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_TMCARDS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_TMCARDS ON BARS.TM_CARDS (OKPO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TM_CARDS ***
grant SELECT                                                                 on TM_CARDS        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TM_CARDS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TM_CARDS        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TM_CARDS        to DPT_ADMIN;
grant SELECT                                                                 on TM_CARDS        to DPT_ROLE;
grant SELECT                                                                 on TM_CARDS        to START1;
grant SELECT                                                                 on TM_CARDS        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TM_CARDS        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TM_CARDS.sql =========*** End *** ====
PROMPT ===================================================================================== 
