

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORP_ACCOUNTS_WEB.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORP_ACCOUNTS_WEB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CORP_ACCOUNTS_WEB
(
   CORP_KOD,
   CORP_NAME,
   RNK,
   NMK,
   OKPO,
   ACC,
   NLS,
   KV,
   NMS,
   USTAN_KOD,
   TRKK_KOD,
   USE_INVP,
   ALT_CORP_COD,
   ALT_USTAN_COD,
   BRANCH,
   DAOS,
   DAZS
)
AS
SELECT corp_kod,
          corp_name,
          RNK,
          NMK,
          okpo,
          ACC,
          NLS,
          KV,
          NMS,
          ustan_kod,
          trkk_kod,
          use_invp,
          CASE WHEN W1 <> CWPVAL THEN W1 ELSE NULL END AS ALT_CORP_COD,
          inst_kod AS ALT_USTAN_COD,
          BRANCH,
          DAOS,
          DAZS
     FROM (
           SELECT cwp.VALUE AS corp_kod,
                  (select oba.CORPORATION_NAME FROM OB_CORPORATION oba WHERE oba.EXTERNAL_ID  = cwp.VALUE and oba.PARENT_ID IS NULL) as corp_name,
                  cwp.RNK,
                  (select c.NMK from customer c where c.rnk = cwp.RNK) as NMK,
                  (select c.okpo from customer c where c.rnk = cwp.RNK) as okpo,
                  a.ACC,
                  a.NLS,
                  a.KV,
                  a.NMS,
                  (SELECT cw2.VALUE
                     FROM customerw cw2
                    WHERE a.RNK = cw2.RNK AND cw2.TAG = 'OBCRP')
                     AS ustan_kod,
                  (SELECT s.TYPNLS
                     FROM SPECPARAM_INT s
                    WHERE a.ACC = s.ACC)
                     AS trkk_kod,
                  NVL ( (SELECT w2.VALUE
                           FROM accountsw w2
                          WHERE a.ACC = w2.ACC AND w2.TAG = 'CORPV'),
                       'N')
                     AS use_invp,
                  (SELECT w1.VALUE
                     FROM accountsw w1
                    WHERE a.ACC = w1.ACC AND w1.TAG = 'OBCORP')
                     AS W1,
                  (SELECT w3.VALUE
                     FROM accountsw w3
                    WHERE a.ACC = w3.ACC AND w3.TAG = 'OBCORPCD')
                     AS inst_kod,
                  cwp.VALUE AS CWPVAL,
                  a.BRANCH,
                  a.DAOS,
                  a.DAZS
             FROM accounts a
             JOIN customerw cwp ON cwp.RNK = a.RNK AND cwp.TAG = 'OBPCP')
             where corp_name is not null;
/
GRANT SELECT, UPDATE ON BARS.V_CORP_ACCOUNTS_WEB TO BARS_ACCESS_DEFROLE;
/
GRANT SELECT ON BARS.V_CORP_ACCOUNTS_WEB TO CORP_CLIENT;
/
GRANT SELECT ON BARS.V_CORP_ACCOUNTS_WEB TO UPLD;
/

PROMPT *** Create  grants  V_CORP_ACCOUNTS_WEB ***
grant SELECT                                                                 on V_CORP_ACCOUNTS_WEB to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_CORP_ACCOUNTS_WEB to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CORP_ACCOUNTS_WEB to CORP_CLIENT;
grant SELECT                                                                 on V_CORP_ACCOUNTS_WEB to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORP_ACCOUNTS_WEB.sql =========*** En
PROMPT ===================================================================================== 
