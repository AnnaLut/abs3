

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CM_CLIENT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CM_CLIENT ***

  CREATE OR REPLACE FORCE VIEW BARS.CM_CLIENT ("ID", "DATEIN", "DATEMOD", "OPER_TYPE", "OPER_STATUS", "RESP_TXT", "BRANCH", "OPENDATE", "CLIENTTYPE", "TAXPAYERIDENTIFIER", "SHORTNAME", "FIRSTNAME", "LASTNAME", "MIDDLENAME", "ENGFIRSTNAME", "ENGLASTNAME", "COUNTRY", "RESIDENT", "WORK", "OFFICE", "DATE_W", "ISVIP", "K060", "COMPANYNAME", "SHORTCOMPANYNAME", "PERSONALISATIONNAME", "KLAS_CLIENT_ID", "CONTACTPERSON", "BIRTHDATE", "BIRTHPLACE", "GENDER", "ADDR1_CITYNAME", "ADDR1_PCODE", "ADDR1_DOMAIN", "ADDR1_REGION", "ADDR1_STREET", "ADDR2_CITYNAME", "ADDR2_PCODE", "ADDR2_DOMAIN", "ADDR2_REGION", "ADDR2_STREET", "EMAIL", "PHONENUMBER", "PHONENUMBER_MOB", "PHONENUMBER_DOD", "FAX", "TYPEDOC", "PASPNUM", "PASPSERIES", "PASPDATE", "PASPISSUER", "FOREIGNPASPNUM", "FOREIGNPASPSERIES", "FOREIGNPASPDATE", "FOREIGNPASPENDDATE", "FOREIGNPASPISSUER", "CONTRACTNUMBER", "PRODUCTCODE", "CARD_TYPE", "CNTM", "PIND", "OKPO_SYSORG", "KOD_SYSORG", "RNK", "REGNUMBERCLIENT", "REGNUMBEROWNER", "ACC", "CL_RNK", "CL_DT_ISS", "CARD_BR_ISS", "CARD_ADDR_ISS", "DELIVERY_BR", "KK_SECRET_WORD", "KK_FLAG", "KK_REGTYPE", "KK_CITYAREAID", "KK_STREETTYPEID", "KK_STREETNAME", "KK_APARTMENT", "KK_POSTCODE", "ADD_INFO", "PASPDATETO", "EDDR", "SHORTNAMEOWNER", "KK_PHOTO_DATA") AS 
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

PROMPT *** Create  grants  CM_CLIENT ***
grant SELECT                                                                 on CM_CLIENT       to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on CM_CLIENT       to CM_ACCESS_ROLE;
grant SELECT                                                                 on CM_CLIENT       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CM_CLIENT.sql =========*** End *** ====
PROMPT ===================================================================================== 
