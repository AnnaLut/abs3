CREATE OR REPLACE FORCE VIEW BARS.CM_CLIENT
(
   ID,
   DATEIN,
   DATEMOD,
   OPER_TYPE,
   OPER_STATUS,
   RESP_TXT,
   BRANCH,
   OPENDATE,
   CLIENTTYPE,
   TAXPAYERIDENTIFIER,
   SHORTNAME,
   FIRSTNAME,
   LASTNAME,
   MIDDLENAME,
   ENGFIRSTNAME,
   ENGLASTNAME,
   COUNTRY,
   RESIDENT,
   WORK,
   OFFICE,
   DATE_W,
   ISVIP,
   K060,
   COMPANYNAME,
   SHORTCOMPANYNAME,
   PERSONALISATIONNAME,
   KLAS_CLIENT_ID,
   CONTACTPERSON,
   BIRTHDATE,
   BIRTHPLACE,
   GENDER,
   ADDR1_CITYNAME,
   ADDR1_PCODE,
   ADDR1_DOMAIN,
   ADDR1_REGION,
   ADDR1_STREET,
   ADDR2_CITYNAME,
   ADDR2_PCODE,
   ADDR2_DOMAIN,
   ADDR2_REGION,
   ADDR2_STREET,
   EMAIL,
   PHONENUMBER,
   PHONENUMBER_MOB,
   PHONENUMBER_DOD,
   FAX,
   TYPEDOC,
   PASPNUM,
   PASPSERIES,
   PASPDATE,
   PASPISSUER,
   FOREIGNPASPNUM,
   FOREIGNPASPSERIES,
   FOREIGNPASPDATE,
   FOREIGNPASPENDDATE,
   FOREIGNPASPISSUER,
   CONTRACTNUMBER,
   PRODUCTCODE,
   CARD_TYPE,
   CNTM,
   PIND,
   OKPO_SYSORG,
   KOD_SYSORG,
   RNK,
   REGNUMBERCLIENT,
   REGNUMBEROWNER,
   ACC,
   CL_RNK,
   CL_DT_ISS,
   CARD_BR_ISS,
   CARD_ADDR_ISS,
   DELIVERY_BR,
   KK_SECRET_WORD,
   KK_FLAG,
   KK_REGTYPE,
   KK_CITYAREAID,
   KK_STREETTYPEID,
   KK_STREETNAME,
   KK_APARTMENT,
   KK_POSTCODE,
   ADD_INFO,
   PaspdateTo,
   EDDR,
   SHORTNAMEOWNER,
   KK_PHOTO_DATA
)
AS
with a as (select nvl(getglobaloption('IS_MMFO'), '0') mmfo from dual)
   SELECT c."ID",
          c."DATEIN",
          c."DATEMOD",
          c."OPER_TYPE",
          c."OPER_STATUS",
          c."RESP_TXT",
          c."BRANCH",
          c."OPENDATE",
          c."CLIENTTYPE",
          c."TAXPAYERIDENTIFIER",
          c."SHORTNAME",
          c."FIRSTNAME",
          c."LASTNAME",
          c."MIDDLENAME",
          c."ENGFIRSTNAME",
          c."ENGLASTNAME",
          c."COUNTRY",
          c."RESIDENT",
          c."WORK",
          c."OFFICE",
          c."DATE_W",
          c."ISVIP",
          c."K060",
          c."COMPANYNAME",
          c."SHORTCOMPANYNAME",
          c."PERSONALISATIONNAME",
          c."KLAS_CLIENT_ID",
          c."CONTACTPERSON",
          c."BIRTHDATE",
          c."BIRTHPLACE",
          c."GENDER",
          c."ADDR1_CITYNAME",
          c."ADDR1_PCODE",
          c."ADDR1_DOMAIN",
          c."ADDR1_REGION",
          c."ADDR1_STREET",
          c."ADDR2_CITYNAME",
          c."ADDR2_PCODE",
          c."ADDR2_DOMAIN",
          c."ADDR2_REGION",
          c."ADDR2_STREET",
          c."EMAIL",
          c."PHONENUMBER",
          c."PHONENUMBER_MOB",
          c."PHONENUMBER_DOD",
          c."FAX",
          c."TYPEDOC",
          c."PASPNUM",
          c."PASPSERIES",
          c."PASPDATE",
          c."PASPISSUER",
          c."FOREIGNPASPNUM",
          c."FOREIGNPASPSERIES",
          c."FOREIGNPASPDATE",
          c."FOREIGNPASPENDDATE",
          c."FOREIGNPASPISSUER",
          c."CONTRACTNUMBER",
          c."PRODUCTCODE",
          c."CARD_TYPE",
          c."CNTM",
          c."PIND",
          c."OKPO_SYSORG",
          c."KOD_SYSORG",
          c."RNK",
          c.REGNUMBERCLIENT,
          c.REGNUMBEROWNER,  
          c."ACC",
          c."CL_RNK",
          c."CL_DT_ISS",
          c."CARD_BR_ISS",
          c."CARD_ADDR_ISS",
          c."DELIVERY_BR",
          c."KK_SECRET_WORD",
          c."KK_FLAG",
          c."KK_REGTYPE",
          c."KK_CITYAREAID",
          c."KK_STREETTYPEID",
          c."KK_STREETNAME",
          c."KK_APARTMENT",
          c."KK_POSTCODE",
          c."ADD_INFO",
          c."IDCARDENDDATE",
          c."EDDR_ID",
          c."SHORTNAMEOWNER",
          i.image kk_photo_data
     FROM cm_client_que c, customer_images i, a
    WHERE     c.rnk = i.rnk(+)
          AND i.type_img(+) = 'PHOTO_JPG'
      AND c.oper_status <> 99;

COMMENT ON COLUMN BARS.CM_CLIENT.ID IS 'Унікальний ідентифікатор заявки';

COMMENT ON COLUMN BARS.CM_CLIENT.DATEIN IS 'Дата додавання заявки';

COMMENT ON COLUMN BARS.CM_CLIENT.DATEMOD IS 'Дата модификації заявки';

COMMENT ON COLUMN BARS.CM_CLIENT.OPER_TYPE IS 'Тип операції';

COMMENT ON COLUMN BARS.CM_CLIENT.OPER_STATUS IS 'Статус операції';

COMMENT ON COLUMN BARS.CM_CLIENT.RESP_TXT IS 'Опис помилки';

COMMENT ON COLUMN BARS.CM_CLIENT.BRANCH IS 'Код установи банку';

COMMENT ON COLUMN BARS.CM_CLIENT.OPENDATE IS 'Дата відкриття клієнта';

COMMENT ON COLUMN BARS.CM_CLIENT.CLIENTTYPE IS 'Тип клієнта';

COMMENT ON COLUMN BARS.CM_CLIENT.TAXPAYERIDENTIFIER IS 'Ідентифікаційний код клиента';

COMMENT ON COLUMN BARS.CM_CLIENT.SHORTNAME IS 'Найменування клієнта українською';

COMMENT ON COLUMN BARS.CM_CLIENT.FIRSTNAME IS 'Ім’я';

COMMENT ON COLUMN BARS.CM_CLIENT.LASTNAME IS 'Прізвище';

COMMENT ON COLUMN BARS.CM_CLIENT.MIDDLENAME IS 'По-батькові';

COMMENT ON COLUMN BARS.CM_CLIENT.ENGFIRSTNAME IS 'Ім’я що ембосується (на англійський )';

COMMENT ON COLUMN BARS.CM_CLIENT.ENGLASTNAME IS 'Прізвище що ембосується (на англійський)';

COMMENT ON COLUMN BARS.CM_CLIENT.COUNTRY IS 'Громадянство';

COMMENT ON COLUMN BARS.CM_CLIENT.RESIDENT IS 'Ознака резидента';

COMMENT ON COLUMN BARS.CM_CLIENT.WORK IS 'Місце роботи';

COMMENT ON COLUMN BARS.CM_CLIENT.OFFICE IS 'Посада';

COMMENT ON COLUMN BARS.CM_CLIENT.DATE_W IS 'Дата принятия на работу';

COMMENT ON COLUMN BARS.CM_CLIENT.ISVIP IS 'Признак VIP клиента';

COMMENT ON COLUMN BARS.CM_CLIENT.K060 IS 'Признак инсайдера';

COMMENT ON COLUMN BARS.CM_CLIENT.COMPANYNAME IS 'Назва організації';

COMMENT ON COLUMN BARS.CM_CLIENT.SHORTCOMPANYNAME IS 'Краткое наименование организации';

COMMENT ON COLUMN BARS.CM_CLIENT.PERSONALISATIONNAME IS 'Назва компанії що ембосується (на англ.)';

COMMENT ON COLUMN BARS.CM_CLIENT.KLAS_CLIENT_ID IS 'Юр. статус';

COMMENT ON COLUMN BARS.CM_CLIENT.CONTACTPERSON IS 'Прізвище контактної особи';

COMMENT ON COLUMN BARS.CM_CLIENT.BIRTHDATE IS 'Дата народження';

COMMENT ON COLUMN BARS.CM_CLIENT.GENDER IS 'Стать';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR1_CITYNAME IS 'Місто (прописки/реєстрації)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR1_PCODE IS 'Індекс (прописки/реєстрації)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR1_DOMAIN IS 'Область (прописки/реєстрації)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR1_REGION IS 'Район (прописки/реєстрації)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR1_STREET IS 'Вулиця, будинок, квартира (прописки/реєстрації)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR2_CITYNAME IS 'Місто (проживання)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR2_PCODE IS 'Індекс (проживання)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR2_DOMAIN IS 'Область (проживання)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR2_REGION IS 'Район (проживання)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR2_STREET IS 'Вулиця, будинок, квартира (проживання)';

COMMENT ON COLUMN BARS.CM_CLIENT.EMAIL IS 'e-mail';

COMMENT ON COLUMN BARS.CM_CLIENT.PHONENUMBER IS 'Телефон';

COMMENT ON COLUMN BARS.CM_CLIENT.PHONENUMBER_MOB IS 'Телефон мобільний';

COMMENT ON COLUMN BARS.CM_CLIENT.PHONENUMBER_DOD IS 'Телефон додатковий';

COMMENT ON COLUMN BARS.CM_CLIENT.FAX IS 'Факс';

COMMENT ON COLUMN BARS.CM_CLIENT.TYPEDOC IS 'Тип документа';

COMMENT ON COLUMN BARS.CM_CLIENT.PASPNUM IS 'Номер документу що засвідчує особу';

COMMENT ON COLUMN BARS.CM_CLIENT.PASPSERIES IS 'Серія документу що засвідчує особу';

COMMENT ON COLUMN BARS.CM_CLIENT.PASPDATE IS 'Дата видачі документу що засвідчує особу';

COMMENT ON COLUMN BARS.CM_CLIENT.PASPISSUER IS 'Ким виданий документ що засвідчує особу';

COMMENT ON COLUMN BARS.CM_CLIENT.FOREIGNPASPNUM IS 'Номер закордонного паспорту';

COMMENT ON COLUMN BARS.CM_CLIENT.FOREIGNPASPSERIES IS 'Серія закордонного паспорту';

COMMENT ON COLUMN BARS.CM_CLIENT.FOREIGNPASPDATE IS 'Дата видачі закордонного паспорту';

COMMENT ON COLUMN BARS.CM_CLIENT.FOREIGNPASPENDDATE IS 'Закордонний паспорт дійсний до';

COMMENT ON COLUMN BARS.CM_CLIENT.FOREIGNPASPISSUER IS 'Ким виданий закордонний паспорт';

COMMENT ON COLUMN BARS.CM_CLIENT.CONTRACTNUMBER IS 'Номер аналітичного рахунку 2625';

COMMENT ON COLUMN BARS.CM_CLIENT.PRODUCTCODE IS 'Код продукту';

COMMENT ON COLUMN BARS.CM_CLIENT.CARD_TYPE IS 'Код Картковий субпродукт';

COMMENT ON COLUMN BARS.CM_CLIENT.CNTM IS 'Количество месяцев действия карты';

COMMENT ON COLUMN BARS.CM_CLIENT.PIND IS 'Таємне слово';

COMMENT ON COLUMN BARS.CM_CLIENT.OKPO_SYSORG IS 'ОКПО системної організаціі';

COMMENT ON COLUMN BARS.CM_CLIENT.KOD_SYSORG IS 'Код підрозділу системної організаціі';

COMMENT ON COLUMN BARS.CM_CLIENT.REGNUMBERCLIENT IS 'Унікальний код клієнта, власника рахунку в АБС';

COMMENT ON COLUMN BARS.CM_CLIENT.REGNUMBEROWNER IS 'Унікальний код клієнта, держателя карти в АБС';

COMMENT ON COLUMN BARS.CM_CLIENT.CL_RNK IS 'РНК кліента в ЦРВ';

COMMENT ON COLUMN BARS.CM_CLIENT.CL_DT_ISS IS 'Дата видачи карти кліенту';

COMMENT ON COLUMN BARS.CM_CLIENT.CARD_BR_ISS IS 'Номер відділення, де буде видаватися картка';

COMMENT ON COLUMN BARS.CM_CLIENT.CARD_ADDR_ISS IS 'Адрес відділення, де буде видаватися картка';

COMMENT ON COLUMN BARS.CM_CLIENT.DELIVERY_BR IS 'Код відділення, куди треба доставити картку';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_SECRET_WORD IS 'Таємне слово для КК';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_FLAG IS 'Признак необходимости передачи данных по КК';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_REGTYPE IS 'Тип реєстрації громадянина';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_CITYAREAID IS 'Код району міста';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_STREETTYPEID IS 'Код типу вулиці';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_STREETNAME IS 'Вулиця';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_APARTMENT IS 'Номер будинку (та квартири)';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_POSTCODE IS 'Поштовий індекс';

COMMENT ON COLUMN BARS.CM_CLIENT.ADD_INFO IS 'Додаткова інформація';

COMMENT ON COLUMN BARS.CM_CLIENT.PaspdateTo IS 'ID-картка дійсна до';

COMMENT ON COLUMN BARS.CM_CLIENT.EDDR IS 'Унікальний номер запису в ЄДДР';

COMMENT ON COLUMN BARS.CM_CLIENT.SHORTNAMEOWNER IS 'Найменування клієнта-держателя українською';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_PHOTO_DATA IS 'Фото';

/