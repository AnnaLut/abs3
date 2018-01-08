

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_DOC_DTLS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_DOC_DTLS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_DOC_DTLS ("POS", "TAG_UKR", "TAG_RUS", "REF_TBL", "REF_COL", "RQD", "DATA_TP") AS 
  SELECT 1              as POS
     , 'Мета купівлі' as TAG_UKR
     , 'Цель покупки' as TAG_RUS
     , 'ZAY_AIMS'     as REF_TBL
     , 'AIM'          as REF_COL
     , 1              as RQD -- Required
     , 'N'            as DATA_TP -- Data Type
  FROM dual
 UNION ALL
SELECT 2, '№ контракту', '№ контракта', NULL, NULL, 1, 'C'
  FROM dual
 UNION ALL
SELECT 3, 'Дата контракту', 'Дата контракта', NULL, NULL, 1, 'D'
  FROM dual
 UNION ALL
SELECT 4, 'Дата останньої ВМД', 'Дата последней ВМД', NULL, NULL, 0, 'D'
  FROM dual
 UNION ALL
SELECT 5, 'Дати інших ВМД', 'Даты других ВМД', NULL, NULL, 0, 'C'
  FROM dual
 UNION ALL
SELECT 6, 'Країна переказу валюти', 'Страна перечисления валюты', 'COUNTRY', 'COUNTRY', 1, 'N'
  FROM dual
 UNION ALL
SELECT 7, 'Підстава для купівлі валюти', 'Основание для покупки валюты', 'V_KOD_70_2', 'P63', 1, 'C'
  FROM dual
 UNION ALL
SELECT 8, 'Країна бенефіціара', 'Страна бенефециара', 'COUNTRY', 'COUNTRY', 1, 'N'
  FROM dual
 UNION ALL
SELECT 9, 'Код иностранного банка', 'Код иностранного банка', 'v_rc_bnk', 'b010', 1, 'C'
  FROM dual
 UNION ALL
SELECT 10,'Назва іноземного банку', 'Наименование иностранного банка', NULL, NULL, 1, 'C'
  FROM dual
 UNION ALL
SELECT 11,'Товарна група', 'Товарная группа', 'V_KOD_70_4', 'P70', 0, 'C'
  FROM dual
 UNION ALL
SELECT 12,'№ останньої ВМД', '№ последней ВМД', NULL, NULL, 0, 'C'
  FROM dual
 UNION ALL
SELECT 13,'Код купівлі за імпортом (#2C)', 'Код покупки по импорту (# 2C)', 'V_P_L_2C', 'ID', 1, 'C'
  FROM dual
 UNION ALL
SELECT 14,'Ознака операції (#2C)', 'Признак операции (# 2C)', 'V_P12_2C', 'CODE', 1, 'C'
  FROM dual;

PROMPT *** Create  grants  V_ZAY_DOC_DTLS ***
grant SELECT                                                                 on V_ZAY_DOC_DTLS  to START1;
grant SELECT                                                                 on V_ZAY_DOC_DTLS  to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_ZAY_DOC_DTLS  to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_DOC_DTLS.sql =========*** End ***
PROMPT ===================================================================================== 
