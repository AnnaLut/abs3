

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORP_ACCOUNTS_WEB.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORP_ACCOUNTS_WEB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CORP_ACCOUNTS_WEB ("CORP_KOD", "CORP_NAME", "RNK", "NMK", "OKPO", "ACC", "NLS", "KV", "NMS", "INST_KOD", "TRKK_KOD", "USE_INVP", "ALT_CORP_COD", "BRANCH", "DAOS", "DAZS", "ALT_CORP_NAME") AS 
  WITH K
        AS (    SELECT t.*, CONNECT_BY_ROOT external_id AS root_ext_id
                  FROM OB_CORPORATION t
            START WITH t.PARENT_ID IS NULL
            CONNECT BY PRIOR id = parent_id)
   SELECT obc.EXTERNAL_ID corp_kod,
          obc.CORPORATION_NAME corp_name,
          c.RNK,
          c.NMK,
          c.okpo,
          a.ACC,
          a.NLS,
          a.KV,
          a.NMS,
          --код подразделения для счета, если не найдем - пишем подразделение клиента (? - уточнить)
          w3.VALUE inst_kod,
          s.TYPNLS trkk_kod,
          NVL (w2.VALUE, 'N') use_invp,
          --мы нашли валидную установу для счета, при этом её корпорация не соответствует корпорации контрагента - пишем её корпорацию в альтернативу
          --иначе ничего не пишем
          CASE
             WHEN                                 /*w3.VALUE is not null and*/
                 w1.VALUE IS NOT NULL AND cwp.VALUE != w1.VALUE
             THEN
                w1.VALUE
             ELSE
                NULL
          END
             alt_corp_cod,
          a.BRANCH,
          a.DAOS,
          a.DAZS,
          CASE
             WHEN                                 /*w3.VALUE is not null and*/
                 w1.VALUE IS NOT NULL AND cwp.VALUE != w1.VALUE
             THEN
                oba.CORPORATION_NAME
             ELSE
                NULL
          END
             alt_corp_name
     FROM customer c
          JOIN customerw cwp ON cwp.RNK = c.RNK AND cwp.TAG = 'OBPCP' --|код корпорации контрагента
          JOIN OB_CORPORATION obc
             ON cwp.VALUE = obc.EXTERNAL_ID AND obc.PARENT_ID IS NULL --|заодно удостоверимся, что это корневая корпорация
          LEFT JOIN
          customerw cw
             ON     cw.RNK = c.RNK
                AND cw.TAG = 'OBCRP'
          JOIN accounts a ON a.RNK = c.RNK
          LEFT JOIN accountsw w1 ON a.ACC = w1.ACC AND w1.TAG = 'OBCORP' --|код корпорации для счета
          LEFT JOIN
          OB_CORPORATION oba
             ON     w1.VALUE IS NOT NULL
                AND w1.VALUE = oba.EXTERNAL_ID
                AND oba.PARENT_ID IS NULL                                  --|
          LEFT JOIN accountsw w2 ON a.ACC = w2.ACC AND w2.TAG = 'CORPV' --включение в выписку
          --ищем код подразделения для счета и удостоверяемся, что он принадлежит указанной для счета родительской корпорации; иначе - не находим
          LEFT JOIN
          accountsw w3
             ON     a.ACC = w3.ACC
                AND w3.TAG = 'OBCORPCD'

          LEFT JOIN SPECPARAM_INT s ON a.ACC = s.ACC;

PROMPT *** Create  grants  V_CORP_ACCOUNTS_WEB ***
grant SELECT                                                                 on V_CORP_ACCOUNTS_WEB to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_CORP_ACCOUNTS_WEB to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CORP_ACCOUNTS_WEB to CORP_CLIENT;
grant SELECT                                                                 on V_CORP_ACCOUNTS_WEB to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORP_ACCOUNTS_WEB.sql =========*** En
PROMPT ===================================================================================== 
