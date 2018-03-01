PROMPT View V_XML_3K;

CREATE OR REPLACE FORCE VIEW BARS.V_XML_3K
(
   REPORT_DATE,
   KF,
   VERSION_ID,
   Q003_1,
   F091,
   R030,
   T071,
   K020,
   K021,
   Q001,
   Q024,
   D100,
   S180,
   F089,
   F092,
   Q003_2,
   Q007_1,
   Q006,
   REF,
   CUST_ID,
   ACC_ID,
   ACC_NUM,
   KV
)
AS
select a.*, d.REF, d.CUST_ID, d.ACC_ID, d.acc_num, d.kv
from (SELECT v.REPORT_DATE,
              v.KF,
              v.VERSION_ID,
              EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q003_1') AS Q003_1,
              EXTRACTVALUE (COLUMN_VALUE, 'DATA/F091') AS F091,
              EXTRACTVALUE (COLUMN_VALUE, 'DATA/R030') AS R030,
              EXTRACTVALUE (COLUMN_VALUE, 'DATA/T071') AS T071,
              EXTRACTVALUE (COLUMN_VALUE, 'DATA/K020') AS K020,
              EXTRACTVALUE (COLUMN_VALUE, 'DATA/K021') AS K021,
              EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q001') AS Q001,
              EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q024') AS Q024,
              EXTRACTVALUE (COLUMN_VALUE, 'DATA/D100') AS D100,
              EXTRACTVALUE (COLUMN_VALUE, 'DATA/S180') AS S180,
              EXTRACTVALUE (COLUMN_VALUE, 'DATA/F089') AS F089,
              EXTRACTVALUE (COLUMN_VALUE, 'DATA/F092') AS F092,
              EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q003_2') AS Q003_2,
              EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q007_1') AS Q007_1,
              EXTRACTVALUE (COLUMN_VALUE, 'DATA/Q006') AS Q006
         FROM NBUR_REF_FILES f,
              NBUR_LST_FILES v,
              TABLE (
                 XMLSEQUENCE (
                    XMLType (v.FILE_BODY).EXTRACT ('/NBUSTATREPORT/DATA'))) t
        WHERE     f.ID = v.FILE_ID
              AND f.FILE_CODE = '#3K'
              AND f.FILE_FMT = 'XML'
              AND v.FILE_STATUS IN ('FINISHED', 'BLOCKED')
              AND v.FILE_BODY LIKE '<?xml version=%') a,
          (select unique REPORT_DATE, KF, VERSION_ID, REPORT_CODE, substr(FIELD_CODE, 5, 3) Q003_1, ACC_ID, ACC_NUM, KV, CUST_ID, REF
           from NBUR_DETAIL_PROTOCOLS_ARCH 
           where report_code = '#3K') d            
   where a.REPORT_DATE = d.report_date 
     and a.kf = d.kf
     and a.VERSION_ID = d.VERSION_ID
     and a.Q003_1 = d.Q003_1;

COMMENT ON TABLE BARS.V_XML_3K IS 'Файл 3KX - Дані про купівлю, продаж безготівкової іноземної валюти';

COMMENT ON COLUMN BARS.V_XML_3K.Q003_1 IS 'Умовний порядковий номер';

COMMENT ON COLUMN BARS.V_XML_3K.F091 IS 'Код операції';

COMMENT ON COLUMN BARS.V_XML_3K.R030 IS 'Код валюти/ металу';

COMMENT ON COLUMN BARS.V_XML_3K.T071 IS 'Сума купівлі/ продажу';

COMMENT ON COLUMN BARS.V_XML_3K.K020 IS 'Ідентифікаційний код (номер) покупця/продавця';

COMMENT ON COLUMN BARS.V_XML_3K.K021 IS 'Ознака коду (номера)';

COMMENT ON COLUMN BARS.V_XML_3K.Q001 IS 'Назва покупця/ продавця';

COMMENT ON COLUMN BARS.V_XML_3K.Q024 IS 'Тип контрагента';

COMMENT ON COLUMN BARS.V_XML_3K.D100 IS 'Код умов валютної операції';

COMMENT ON COLUMN BARS.V_XML_3K.S180 IS 'Строк валютної операції';

COMMENT ON COLUMN BARS.V_XML_3K.F089 IS 'Ознака консолідації';

COMMENT ON COLUMN BARS.V_XML_3K.F092 IS 'Підстава для купівлі/ мета продажу';

COMMENT ON COLUMN BARS.V_XML_3K.Q003_2 IS 'Номер контракту';

COMMENT ON COLUMN BARS.V_XML_3K.Q007_1 IS 'Дата контракту';

COMMENT ON COLUMN BARS.V_XML_3K.Q006 IS 'Відомості про операцію';

COMMENT ON COLUMN BARS.V_XML_3K.ACC_ID IS 'Ідентифікатор рахунку';

COMMENT ON COLUMN BARS.V_XML_3K.ACC_NUM IS 'Особовий номер рахунку';

COMMENT ON COLUMN BARS.V_XML_3K.KV IS 'Валюта рахунку';

COMMENT ON COLUMN BARS.V_XML_3K.CUST_ID IS 'РНК контрагента';

COMMENT ON COLUMN BARS.V_XML_3K.REF IS 'РЕФ документа';

Prompt Privs on VIEW V_XML_3K TO BARSREADER_ROLE to BARSREADER_ROLE;
GRANT SELECT ON BARS.V_XML_3K TO BARSREADER_ROLE;

Prompt Privs on VIEW V_XML_3K TO BARS_ACCESS_DEFROLE to BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.V_XML_3K TO BARS_ACCESS_DEFROLE;
