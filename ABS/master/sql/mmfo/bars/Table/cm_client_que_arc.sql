

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CM_CLIENT_QUE_ARC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CM_CLIENT_QUE_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CM_CLIENT_QUE_ARC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CM_CLIENT_QUE_ARC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CM_CLIENT_QUE_ARC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CM_CLIENT_QUE_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CM_CLIENT_QUE_ARC 
   (	IDUPD NUMBER(22,0), 
	DONEBY VARCHAR2(64), 
	CHGDATE DATE DEFAULT sysdate, 
	CHGACTION NUMBER(1,0), 
	ID NUMBER(*,0), 
	DATEIN DATE, 
	DATEMOD DATE, 
	OPER_TYPE NUMBER(*,0), 
	OPER_STATUS NUMBER(*,0), 
	RESP_TXT VARCHAR2(1000), 
	BRANCH VARCHAR2(30), 
	OPENDATE DATE, 
	CLIENTTYPE NUMBER(*,0), 
	TAXPAYERIDENTIFIER VARCHAR2(10), 
	SHORTNAME VARCHAR2(105), 
	FIRSTNAME VARCHAR2(105), 
	LASTNAME VARCHAR2(105), 
	MIDDLENAME VARCHAR2(105), 
	ENGFIRSTNAME VARCHAR2(64), 
	ENGLASTNAME VARCHAR2(64), 
	COUNTRY VARCHAR2(3), 
	RESIDENT NUMBER(*,0), 
	WORK VARCHAR2(254), 
	OFFICE VARCHAR2(32), 
	DATE_W DATE, 
	ISVIP VARCHAR2(1), 
	K060 VARCHAR2(2), 
	COMPANYNAME VARCHAR2(200), 
	SHORTCOMPANYNAME VARCHAR2(32), 
	PERSONALISATIONNAME VARCHAR2(32), 
	KLAS_CLIENT_ID NUMBER(*,0), 
	CONTACTPERSON VARCHAR2(105), 
	BIRTHDATE DATE, 
	BIRTHPLACE VARCHAR2(1024), 
	GENDER VARCHAR2(1), 
	ADDR1_CITYNAME VARCHAR2(100), 
	ADDR1_PCODE VARCHAR2(10), 
	ADDR1_DOMAIN VARCHAR2(48), 
	ADDR1_REGION VARCHAR2(48), 
	ADDR1_STREET VARCHAR2(100), 
	ADDR2_CITYNAME VARCHAR2(100), 
	ADDR2_PCODE VARCHAR2(10), 
	ADDR2_DOMAIN VARCHAR2(48), 
	ADDR2_REGION VARCHAR2(48), 
	ADDR2_STREET VARCHAR2(100), 
	EMAIL VARCHAR2(32), 
	PHONENUMBER VARCHAR2(12), 
	PHONENUMBER_MOB VARCHAR2(12), 
	PHONENUMBER_DOD VARCHAR2(12), 
	FAX VARCHAR2(12), 
	TYPEDOC NUMBER(*,0), 
	PASPNUM VARCHAR2(16), 
	PASPSERIES VARCHAR2(16), 
	PASPDATE DATE, 
	PASPISSUER VARCHAR2(128), 
	FOREIGNPASPNUM VARCHAR2(16), 
	FOREIGNPASPSERIES VARCHAR2(16), 
	FOREIGNPASPDATE DATE, 
	FOREIGNPASPENDDATE DATE, 
	FOREIGNPASPISSUER VARCHAR2(128), 
	CONTRACTNUMBER VARCHAR2(19), 
	PRODUCTCODE VARCHAR2(32), 
	CARD_TYPE VARCHAR2(36), 
	CNTM NUMBER(*,0), 
	PIND VARCHAR2(32), 
	OKPO_SYSORG VARCHAR2(10), 
	KOD_SYSORG NUMBER(*,0), 
	REGNUMBERCLIENT VARCHAR2(32), 
	REGNUMBEROWNER VARCHAR2(32), 
	ACC NUMBER(22,0), 
	RNK NUMBER(22,0), 
	CL_RNK VARCHAR2(32), 
	CL_DT_ISS DATE, 
	CARD_BR_ISS VARCHAR2(30), 
	CARD_ADDR_ISS VARCHAR2(100), 
	DELIVERY_BR VARCHAR2(30), 
	KK_SECRET_WORD VARCHAR2(32), 
	KK_FLAG NUMBER(1,0), 
	KK_REGTYPE NUMBER(1,0), 
	KK_CITYAREAID NUMBER(10,0), 
	KK_STREETTYPEID NUMBER(10,0), 
	KK_STREETNAME VARCHAR2(64), 
	KK_APARTMENT VARCHAR2(32), 
	KK_POSTCODE VARCHAR2(5), 
	ADD_INFO VARCHAR2(500), 
	IDCARDENDDATE DATE, 
	EDDR_ID VARCHAR2(20), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	SHORTNAMEOWNER VARCHAR2(105)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** Add columns for CM *************
begin   
 execute immediate '
	alter table cm_client_que_arc add (
		addr1_city_type varchar2(30)   ,
		addr1_street_type  varchar2(25)  ,
		addr1_address varchar2(70)  ,
		addr1_house  varchar2(5) ,
		addr1_flat varchar2(5) ,
		addr2_city_type varchar2(30)  ,
		addr2_street_type  varchar2(25)  ,
		addr2_address varchar2(70)  ,
		addr2_house  varchar2(5) ,
		addr2_flat varchar2(5)     ) ';
exception when others then
  if  sqlcode=-955 or sqlcode=-01430 then null; else raise; end if;
 end;
/


alter table cm_client_que_arc modify  addr1_house varchar2(100 char);
alter table cm_client_que_arc modify  addr2_house varchar2(100 char);
alter table cm_client_que_arc modify  addr1_flat  varchar2(100 char);
alter table cm_client_que_arc modify  addr2_flat  varchar2(100 char);



PROMPT *** ALTER_POLICIES to CM_CLIENT_QUE_ARC ***
 exec bpa.alter_policies('CM_CLIENT_QUE_ARC');

/
-- Add comments to the columns 
comment on column CM_CLIENT_QUE_ARC.id          is 'Унікальний ідентифікатор заявки';
comment on column CM_CLIENT_QUE_ARC.datein      is 'Дата додавання заявки';
comment on column CM_CLIENT_QUE_ARC.datemod     is 'Дата модификації заявки';
comment on column CM_CLIENT_QUE_ARC.oper_type   is 'Тип операції';
comment on column CM_CLIENT_QUE_ARC.oper_status  is 'Статус операції';
comment on column CM_CLIENT_QUE_ARC.resp_txt     is 'Опис помилки';
comment on column CM_CLIENT_QUE_ARC.branch       is 'Код установи банку';
comment on column CM_CLIENT_QUE_ARC.opendate     is 'Дата відкриття клієнта';
comment on column CM_CLIENT_QUE_ARC.clienttype   is 'Тип клієнта';
comment on column CM_CLIENT_QUE_ARC.taxpayeridentifier   is 'Ідентифікаційний код клиента';
comment on column CM_CLIENT_QUE_ARC.shortname            is 'Найменування клієнта українською';
comment on column CM_CLIENT_QUE_ARC.firstname            is 'Ім’я';
comment on column CM_CLIENT_QUE_ARC.lastname             is 'Прізвище';
comment on column CM_CLIENT_QUE_ARC.middlename           is 'По-батькові';
comment on column CM_CLIENT_QUE_ARC.engfirstname         is 'Ім’я що ембосується (на англійський )';
comment on column CM_CLIENT_QUE_ARC.englastname          is 'Прізвище що ембосується (на англійський)';
comment on column CM_CLIENT_QUE_ARC.country              is 'Громадянство';
comment on column CM_CLIENT_QUE_ARC.resident             is 'Ознака резидента';
comment on column CM_CLIENT_QUE_ARC.work                 is 'Місце роботи';
comment on column CM_CLIENT_QUE_ARC.office               is 'Посада';
comment on column CM_CLIENT_QUE_ARC.date_w               is 'Дата принятия на работу';
comment on column CM_CLIENT_QUE_ARC.isvip                is 'Признак VIP клиента';
comment on column CM_CLIENT_QUE_ARC.k060                 is 'Признак инсайдера';
comment on column CM_CLIENT_QUE_ARC.companyname          is 'Назва організації';
comment on column CM_CLIENT_QUE_ARC.shortcompanyname     is 'Краткое наименование организации';
comment on column CM_CLIENT_QUE_ARC.personalisationname  is 'Назва компанії що ембосується (на англ.)';
comment on column CM_CLIENT_QUE_ARC.klas_client_id       is 'Юр. статус';
comment on column CM_CLIENT_QUE_ARC.contactperson        is 'Прізвище контактної особи';
comment on column CM_CLIENT_QUE_ARC.birthdate            is 'Дата народження';
comment on column CM_CLIENT_QUE_ARC.birthplace           is 'Місце народження';
comment on column CM_CLIENT_QUE_ARC.gender               is 'Стать';
comment on column CM_CLIENT_QUE_ARC.addr1_cityname       is 'Місто (прописки/реєстрації)';
comment on column CM_CLIENT_QUE_ARC.addr1_pcode          is 'Індекс (прописки/реєстрації)';
comment on column CM_CLIENT_QUE_ARC.addr1_domain         is 'Область (прописки/реєстрації)';
comment on column CM_CLIENT_QUE_ARC.addr1_region         is 'Район (прописки/реєстрації)';
comment on column CM_CLIENT_QUE_ARC.addr1_street         is 'Вулиця, будинок, квартира (прописки/реєстрації)';
comment on column CM_CLIENT_QUE_ARC.addr2_cityname       is 'Місто (проживання)';
comment on column CM_CLIENT_QUE_ARC.addr2_pcode          is 'Індекс (проживання)';
comment on column CM_CLIENT_QUE_ARC.addr2_domain         is 'Область (проживання)';
comment on column CM_CLIENT_QUE_ARC.addr2_region         is 'Район (проживання)';
comment on column CM_CLIENT_QUE_ARC.addr2_street         is 'Вулиця, будинок, квартира (проживання)';
comment on column CM_CLIENT_QUE_ARC.email                is 'e-mail';
comment on column CM_CLIENT_QUE_ARC.phonenumber          is 'Телефон';
comment on column CM_CLIENT_QUE_ARC.phonenumber_mob      is 'Телефон мобільний';
comment on column CM_CLIENT_QUE_ARC.phonenumber_dod      is 'Телефон додатковий';
comment on column CM_CLIENT_QUE_ARC.fax                  is 'Факс';
comment on column CM_CLIENT_QUE_ARC.typedoc              is 'Тип документа';
comment on column CM_CLIENT_QUE_ARC.paspnum              is 'Номер документу що засвідчує особу';
comment on column CM_CLIENT_QUE_ARC.paspseries           is 'Серія документу що засвідчує особу';
comment on column CM_CLIENT_QUE_ARC.paspdate             is 'Дата видачі документу що засвідчує особу';
comment on column CM_CLIENT_QUE_ARC.paspissuer           is 'Ким виданий документ що засвідчує особу';
comment on column CM_CLIENT_QUE_ARC.foreignpaspnum       is 'Номер закордонного паспорту';
comment on column CM_CLIENT_QUE_ARC.foreignpaspseries    is 'Серія закордонного паспорту';
comment on column CM_CLIENT_QUE_ARC.foreignpaspdate      is 'Дата видачі закордонного паспорту';
comment on column CM_CLIENT_QUE_ARC.foreignpaspenddate   is 'Закордонний паспорт дійсний до';
comment on column CM_CLIENT_QUE_ARC.foreignpaspissuer    is 'Ким виданий закордонний паспорт';
comment on column CM_CLIENT_QUE_ARC.contractnumber       is 'Номер аналітичного рахунку 2625';
comment on column CM_CLIENT_QUE_ARC.productcode          is 'Код продукту';
comment on column CM_CLIENT_QUE_ARC.card_type            is 'Код Картковий субпродукт';
comment on column CM_CLIENT_QUE_ARC.cntm                 is 'Количество месяцев действия карты';
comment on column CM_CLIENT_QUE_ARC.pind                 is 'Таємне слово';
comment on column CM_CLIENT_QUE_ARC.okpo_sysorg          is 'ОКПО системної організаціі';
comment on column CM_CLIENT_QUE_ARC.kod_sysorg           is 'Код підрозділу системної організаціі';
comment on column CM_CLIENT_QUE_ARC.regnumberclient      is 'Унікальний код клієнта, власника рахунку в АБС';
comment on column CM_CLIENT_QUE_ARC.regnumberowner       is 'Унікальний код клієнта, держателя карти в АБС';
comment on column CM_CLIENT_QUE_ARC.rnk                  is 'Реєстраційний номер клієнта';
comment on column CM_CLIENT_QUE_ARC.cl_rnk               is 'РНК кліента в ЦРВ';
comment on column CM_CLIENT_QUE_ARC.cl_dt_iss            is 'Дата видачи карти кліенту';
comment on column CM_CLIENT_QUE_ARC.card_br_iss          is 'Номер відділення, де буде видаватися картка';
comment on column CM_CLIENT_QUE_ARC.card_addr_iss        is 'Адрес відділення, де буде видаватися картка';
comment on column CM_CLIENT_QUE_ARC.delivery_br          is 'Код відділення, куди треба доставити картку';
comment on column CM_CLIENT_QUE_ARC.kk_secret_word       is 'Таємне слово для КК';
comment on column CM_CLIENT_QUE_ARC.kk_flag              is 'Признак необходимости передачи данных по КК';
comment on column CM_CLIENT_QUE_ARC.kk_regtype           is 'Тип реєстрації громадянина';
comment on column CM_CLIENT_QUE_ARC.kk_cityareaid        is 'Код району міста';
comment on column CM_CLIENT_QUE_ARC.kk_streettypeid      is 'Код типу вулиці';
comment on column CM_CLIENT_QUE_ARC.kk_streetname        is 'Вулиця';
comment on column CM_CLIENT_QUE_ARC.kk_apartment         is 'Номер будинку (та квартири)';
comment on column CM_CLIENT_QUE_ARC.kk_postcode          is 'Поштовий індекс';
comment on column CM_CLIENT_QUE_ARC.add_info             is 'Додаткова інформація';
comment on column CM_CLIENT_QUE_ARC.shortnameowner       is 'Найменування клієнта-держателя українською';
comment on column CM_CLIENT_QUE_ARC.addr2_city_type           is 'Тип населеного пункту (фактична адреса)';
comment on column CM_CLIENT_QUE_ARC.addr2_street_type          is 'Тип вулиці (фактична адреса)';
comment on column CM_CLIENT_QUE_ARC.addr2_address               is 'Вулиця (фактична адреса)';
comment on column CM_CLIENT_QUE_ARC.addr2_house                is 'Номер будинку (фактична адреса)';
comment on column CM_CLIENT_QUE_ARC.addr2_flat                 is 'Номер квартири (фактична адреса)';
comment on column CM_CLIENT_QUE_ARC.addr1_city_type           is 'Тип населеного пункту (юридична адреса)';
comment on column CM_CLIENT_QUE_ARC.addr1_street_type          is 'Тип вулиці (юридична адреса)';
comment on column CM_CLIENT_QUE_ARC.addr1_address              is 'Вулиця (юридична адреса)';
comment on column CM_CLIENT_QUE_ARC.addr1_house                is 'Номер будинку (юридична адреса)';
comment on column CM_CLIENT_QUE_ARC.addr1_flat                 is 'Номер квартири (юридична адреса)';

/


PROMPT *** Create  constraint FK_CMCLIENTQUEARC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CLIENT_QUE_ARC ADD CONSTRAINT FK_CMCLIENTQUEARC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CMLIENTQUEARC_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CLIENT_QUE_ARC MODIFY (IDUPD CONSTRAINT CC_CMLIENTQUEARC_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CMLIENTQUEARC_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CLIENT_QUE_ARC MODIFY (DONEBY CONSTRAINT CC_CMLIENTQUEARC_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CMLIENTQUEARC_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CLIENT_QUE_ARC MODIFY (CHGDATE CONSTRAINT CC_CMLIENTQUEARC_CHGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CMLIENTQUEARC_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CLIENT_QUE_ARC MODIFY (CHGACTION CONSTRAINT CC_CMLIENTQUEARC_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CMCLIENTQUEARC_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CLIENT_QUE_ARC MODIFY (ID CONSTRAINT CC_CMCLIENTQUEARC_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CMCLIENTQUEARC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CLIENT_QUE_ARC MODIFY (KF CONSTRAINT CC_CMCLIENTQUEARC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CMCLIENTQUEARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CLIENT_QUE_ARC ADD CONSTRAINT PK_CMCLIENTQUEARC PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_CMCLIENTQUEARC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_CMCLIENTQUEARC ON BARS.CM_CLIENT_QUE_ARC (DATEIN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_CMCLIENTQUEARC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_CMCLIENTQUEARC ON BARS.CM_CLIENT_QUE_ARC (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CMCLIENTQUEARC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_CMCLIENTQUEARC ON BARS.CM_CLIENT_QUE_ARC (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CMCLIENTQUEARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CMCLIENTQUEARC ON BARS.CM_CLIENT_QUE_ARC (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CM_CLIENT_QUE_ARC ***
grant INSERT,SELECT                                                          on CM_CLIENT_QUE_ARC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CM_CLIENT_QUE_ARC to BARS_DM;
grant INSERT,SELECT                                                          on CM_CLIENT_QUE_ARC to OW;





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CM_CLIENT_QUE_ARC.sql =========*** End
PROMPT ===================================================================================== 
