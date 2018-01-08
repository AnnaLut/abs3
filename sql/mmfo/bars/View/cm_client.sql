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

COMMENT ON COLUMN BARS.CM_CLIENT.ID IS '��������� ������������� ������';

COMMENT ON COLUMN BARS.CM_CLIENT.DATEIN IS '���� ��������� ������';

COMMENT ON COLUMN BARS.CM_CLIENT.DATEMOD IS '���� ����������� ������';

COMMENT ON COLUMN BARS.CM_CLIENT.OPER_TYPE IS '��� ��������';

COMMENT ON COLUMN BARS.CM_CLIENT.OPER_STATUS IS '������ ��������';

COMMENT ON COLUMN BARS.CM_CLIENT.RESP_TXT IS '���� �������';

COMMENT ON COLUMN BARS.CM_CLIENT.BRANCH IS '��� �������� �����';

COMMENT ON COLUMN BARS.CM_CLIENT.OPENDATE IS '���� �������� �볺���';

COMMENT ON COLUMN BARS.CM_CLIENT.CLIENTTYPE IS '��� �볺���';

COMMENT ON COLUMN BARS.CM_CLIENT.TAXPAYERIDENTIFIER IS '���������������� ��� �������';

COMMENT ON COLUMN BARS.CM_CLIENT.SHORTNAME IS '������������ �볺��� ����������';

COMMENT ON COLUMN BARS.CM_CLIENT.FIRSTNAME IS '���';

COMMENT ON COLUMN BARS.CM_CLIENT.LASTNAME IS '�������';

COMMENT ON COLUMN BARS.CM_CLIENT.MIDDLENAME IS '��-�������';

COMMENT ON COLUMN BARS.CM_CLIENT.ENGFIRSTNAME IS '��� �� ���������� (�� ���������� )';

COMMENT ON COLUMN BARS.CM_CLIENT.ENGLASTNAME IS '������� �� ���������� (�� ����������)';

COMMENT ON COLUMN BARS.CM_CLIENT.COUNTRY IS '������������';

COMMENT ON COLUMN BARS.CM_CLIENT.RESIDENT IS '������ ���������';

COMMENT ON COLUMN BARS.CM_CLIENT.WORK IS '̳��� ������';

COMMENT ON COLUMN BARS.CM_CLIENT.OFFICE IS '������';

COMMENT ON COLUMN BARS.CM_CLIENT.DATE_W IS '���� �������� �� ������';

COMMENT ON COLUMN BARS.CM_CLIENT.ISVIP IS '������� VIP �������';

COMMENT ON COLUMN BARS.CM_CLIENT.K060 IS '������� ���������';

COMMENT ON COLUMN BARS.CM_CLIENT.COMPANYNAME IS '����� ����������';

COMMENT ON COLUMN BARS.CM_CLIENT.SHORTCOMPANYNAME IS '������� ������������ �����������';

COMMENT ON COLUMN BARS.CM_CLIENT.PERSONALISATIONNAME IS '����� ������ �� ���������� (�� ����.)';

COMMENT ON COLUMN BARS.CM_CLIENT.KLAS_CLIENT_ID IS '��. ������';

COMMENT ON COLUMN BARS.CM_CLIENT.CONTACTPERSON IS '������� ��������� �����';

COMMENT ON COLUMN BARS.CM_CLIENT.BIRTHDATE IS '���� ����������';

COMMENT ON COLUMN BARS.CM_CLIENT.GENDER IS '�����';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR1_CITYNAME IS '̳��� (��������/���������)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR1_PCODE IS '������ (��������/���������)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR1_DOMAIN IS '������� (��������/���������)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR1_REGION IS '����� (��������/���������)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR1_STREET IS '������, �������, �������� (��������/���������)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR2_CITYNAME IS '̳��� (����������)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR2_PCODE IS '������ (����������)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR2_DOMAIN IS '������� (����������)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR2_REGION IS '����� (����������)';

COMMENT ON COLUMN BARS.CM_CLIENT.ADDR2_STREET IS '������, �������, �������� (����������)';

COMMENT ON COLUMN BARS.CM_CLIENT.EMAIL IS 'e-mail';

COMMENT ON COLUMN BARS.CM_CLIENT.PHONENUMBER IS '�������';

COMMENT ON COLUMN BARS.CM_CLIENT.PHONENUMBER_MOB IS '������� ��������';

COMMENT ON COLUMN BARS.CM_CLIENT.PHONENUMBER_DOD IS '������� ����������';

COMMENT ON COLUMN BARS.CM_CLIENT.FAX IS '����';

COMMENT ON COLUMN BARS.CM_CLIENT.TYPEDOC IS '��� ���������';

COMMENT ON COLUMN BARS.CM_CLIENT.PASPNUM IS '����� ��������� �� ������� �����';

COMMENT ON COLUMN BARS.CM_CLIENT.PASPSERIES IS '���� ��������� �� ������� �����';

COMMENT ON COLUMN BARS.CM_CLIENT.PASPDATE IS '���� ������ ��������� �� ������� �����';

COMMENT ON COLUMN BARS.CM_CLIENT.PASPISSUER IS '��� ������� �������� �� ������� �����';

COMMENT ON COLUMN BARS.CM_CLIENT.FOREIGNPASPNUM IS '����� ������������ ��������';

COMMENT ON COLUMN BARS.CM_CLIENT.FOREIGNPASPSERIES IS '���� ������������ ��������';

COMMENT ON COLUMN BARS.CM_CLIENT.FOREIGNPASPDATE IS '���� ������ ������������ ��������';

COMMENT ON COLUMN BARS.CM_CLIENT.FOREIGNPASPENDDATE IS '����������� ������� ������ ��';

COMMENT ON COLUMN BARS.CM_CLIENT.FOREIGNPASPISSUER IS '��� ������� ����������� �������';

COMMENT ON COLUMN BARS.CM_CLIENT.CONTRACTNUMBER IS '����� ����������� ������� 2625';

COMMENT ON COLUMN BARS.CM_CLIENT.PRODUCTCODE IS '��� ��������';

COMMENT ON COLUMN BARS.CM_CLIENT.CARD_TYPE IS '��� ��������� ����������';

COMMENT ON COLUMN BARS.CM_CLIENT.CNTM IS '���������� ������� �������� �����';

COMMENT ON COLUMN BARS.CM_CLIENT.PIND IS '����� �����';

COMMENT ON COLUMN BARS.CM_CLIENT.OKPO_SYSORG IS '���� �������� ����������';

COMMENT ON COLUMN BARS.CM_CLIENT.KOD_SYSORG IS '��� �������� �������� ����������';

COMMENT ON COLUMN BARS.CM_CLIENT.REGNUMBERCLIENT IS '��������� ��� �볺���, �������� ������� � ���';

COMMENT ON COLUMN BARS.CM_CLIENT.REGNUMBEROWNER IS '��������� ��� �볺���, ��������� ����� � ���';

COMMENT ON COLUMN BARS.CM_CLIENT.CL_RNK IS '��� ������ � ���';

COMMENT ON COLUMN BARS.CM_CLIENT.CL_DT_ISS IS '���� ������ ����� ������';

COMMENT ON COLUMN BARS.CM_CLIENT.CARD_BR_ISS IS '����� ��������, �� ���� ���������� ������';

COMMENT ON COLUMN BARS.CM_CLIENT.CARD_ADDR_ISS IS '����� ��������, �� ���� ���������� ������';

COMMENT ON COLUMN BARS.CM_CLIENT.DELIVERY_BR IS '��� ��������, ���� ����� ��������� ������';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_SECRET_WORD IS '����� ����� ��� ��';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_FLAG IS '������� ������������� �������� ������ �� ��';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_REGTYPE IS '��� ��������� �����������';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_CITYAREAID IS '��� ������ ����';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_STREETTYPEID IS '��� ���� ������';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_STREETNAME IS '������';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_APARTMENT IS '����� ������� (�� ��������)';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_POSTCODE IS '�������� ������';

COMMENT ON COLUMN BARS.CM_CLIENT.ADD_INFO IS '��������� ����������';

COMMENT ON COLUMN BARS.CM_CLIENT.PaspdateTo IS 'ID-������ ����� ��';

COMMENT ON COLUMN BARS.CM_CLIENT.EDDR IS '��������� ����� ������ � ����';

COMMENT ON COLUMN BARS.CM_CLIENT.SHORTNAMEOWNER IS '������������ �볺���-��������� ����������';

COMMENT ON COLUMN BARS.CM_CLIENT.KK_PHOTO_DATA IS '����';

/