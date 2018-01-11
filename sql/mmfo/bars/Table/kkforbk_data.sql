

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KKFORBK_DATA.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KKFORBK_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KKFORBK_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KKFORBK_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KKFORBK_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.KKFORBK_DATA 
   (	ID NUMBER, 
	SURNAME VARCHAR2(64), 
	NAME VARCHAR2(32), 
	FNAME VARCHAR2(32), 
	LATNAME VARCHAR2(26), 
	PASSWORD VARCHAR2(24), 
	SEX NUMBER(1,0), 
	BIRTHDATE DATE, 
	SERIES VARCHAR2(10), 
	NUM VARCHAR2(10), 
	ISSDATE DATE, 
	ISSUER VARCHAR2(100), 
	IDENTCODE VARCHAR2(10), 
	REGION VARCHAR2(32), 
	AREA VARCHAR2(32), 
	CITY VARCHAR2(32), 
	ADDRESS VARCHAR2(64), 
	HOUSE VARCHAR2(32), 
	ZIPCODE VARCHAR2(5), 
	PHONE VARCHAR2(15), 
	MPHONE VARCHAR2(15), 
	EMAIL VARCHAR2(100), 
	TYPEDOC NUMBER(1,0), 
	PHOTODATA BLOB, 
	BRANCH VARCHAR2(30), 
	CARD_CODE VARCHAR2(60), 
	IS_SOCIAL NUMBER(1,0), 
	ERRCODE NUMBER, 
	ERRMSG VARCHAR2(4000), 
	RNK NUMBER, 
	NLS VARCHAR2(15), 
	REGDATE DATE DEFAULT sysdate, 
	PROCDATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (PHOTODATA) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KKFORBK_DATA ***
 exec bpa.alter_policies('KKFORBK_DATA');


COMMENT ON TABLE BARS.KKFORBK_DATA IS '';
COMMENT ON COLUMN BARS.KKFORBK_DATA.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.KKFORBK_DATA.SURNAME IS 'Прізвище';
COMMENT ON COLUMN BARS.KKFORBK_DATA.NAME IS 'Ім'я';
COMMENT ON COLUMN BARS.KKFORBK_DATA.FNAME IS 'По-батькові';
COMMENT ON COLUMN BARS.KKFORBK_DATA.LATNAME IS 'Ім’я та прізвище латиною';
COMMENT ON COLUMN BARS.KKFORBK_DATA.PASSWORD IS 'Слово-пароль';
COMMENT ON COLUMN BARS.KKFORBK_DATA.SEX IS 'Стать';
COMMENT ON COLUMN BARS.KKFORBK_DATA.BIRTHDATE IS 'Дата народження';
COMMENT ON COLUMN BARS.KKFORBK_DATA.SERIES IS 'Серія документа';
COMMENT ON COLUMN BARS.KKFORBK_DATA.NUM IS '№ документа';
COMMENT ON COLUMN BARS.KKFORBK_DATA.ISSDATE IS 'Дата видачі документу';
COMMENT ON COLUMN BARS.KKFORBK_DATA.ISSUER IS 'Ким виданий документ';
COMMENT ON COLUMN BARS.KKFORBK_DATA.IDENTCODE IS 'ІНН';
COMMENT ON COLUMN BARS.KKFORBK_DATA.REGION IS 'Область проживання';
COMMENT ON COLUMN BARS.KKFORBK_DATA.AREA IS 'Район проживання';
COMMENT ON COLUMN BARS.KKFORBK_DATA.CITY IS 'Місто проживання';
COMMENT ON COLUMN BARS.KKFORBK_DATA.ADDRESS IS 'Адреса проживання';
COMMENT ON COLUMN BARS.KKFORBK_DATA.HOUSE IS 'Номер будинку (та квартири)';
COMMENT ON COLUMN BARS.KKFORBK_DATA.ZIPCODE IS 'Поштовий індекс';
COMMENT ON COLUMN BARS.KKFORBK_DATA.PHONE IS 'Номер стаціонарного телефону';
COMMENT ON COLUMN BARS.KKFORBK_DATA.MPHONE IS 'Номер мобільного телефону';
COMMENT ON COLUMN BARS.KKFORBK_DATA.EMAIL IS 'Адреса e-mail';
COMMENT ON COLUMN BARS.KKFORBK_DATA.TYPEDOC IS 'Код типу документу';
COMMENT ON COLUMN BARS.KKFORBK_DATA.PHOTODATA IS 'Фотографія';
COMMENT ON COLUMN BARS.KKFORBK_DATA.BRANCH IS 'Відділення доставки картки';
COMMENT ON COLUMN BARS.KKFORBK_DATA.CARD_CODE IS 'Код продукту';
COMMENT ON COLUMN BARS.KKFORBK_DATA.IS_SOCIAL IS 'Призак соцільної льготи';
COMMENT ON COLUMN BARS.KKFORBK_DATA.ERRCODE IS 'Код відповіді';
COMMENT ON COLUMN BARS.KKFORBK_DATA.ERRMSG IS 'Текст';
COMMENT ON COLUMN BARS.KKFORBK_DATA.RNK IS 'Реєстраційний номер клієнта';
COMMENT ON COLUMN BARS.KKFORBK_DATA.NLS IS 'Рахунок';
COMMENT ON COLUMN BARS.KKFORBK_DATA.REGDATE IS 'Дата реєстрації';
COMMENT ON COLUMN BARS.KKFORBK_DATA.PROCDATE IS 'Дата обробки';




PROMPT *** Create  constraint SYS_C0035022 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KKFORBK_DATA MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KKFORBK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KKFORBK_DATA ADD CONSTRAINT PK_KKFORBK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_KKFORBK_DOC_BIRTH ***
begin   
 execute immediate '
  ALTER TABLE BARS.KKFORBK_DATA ADD CONSTRAINT UK_KKFORBK_DOC_BIRTH UNIQUE (SERIES, NUM, BIRTHDATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_KKFORBK_NLS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_KKFORBK_NLS ON BARS.KKFORBK_DATA (NLS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_KKFORBK_RNK ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_KKFORBK_RNK ON BARS.KKFORBK_DATA (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KKFORBK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KKFORBK ON BARS.KKFORBK_DATA (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_KKFORBK_DOC_BIRTH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_KKFORBK_DOC_BIRTH ON BARS.KKFORBK_DATA (SERIES, NUM, BIRTHDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KKFORBK_DATA ***
grant SELECT                                                                 on KKFORBK_DATA    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KKFORBK_DATA    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KKFORBK_DATA    to CM_ACCESS_ROLE;
grant SELECT                                                                 on KKFORBK_DATA    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KKFORBK_DATA.sql =========*** End *** 
PROMPT ===================================================================================== 
