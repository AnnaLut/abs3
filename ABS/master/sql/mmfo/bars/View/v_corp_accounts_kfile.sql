

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORP_ACCOUNTS_KFILE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORP_ACCOUNTS_KFILE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CORP_ACCOUNTS_KFILE ("CORP_KOD", "CORP_NAME", "RNK", "NMK", "ACC", "NLS", "KV", "NMS", "INST_KOD", "INST_NAME", "USE_INVP", "BRANCH", "DAOS", "DAZS", "TRKK_KOD") AS 
  SELECT to_char(t5.id) corp_kod,
          T5.CORPORATION_NAME AS corp_name,
          t1.rnk AS rnk,
          t1.nmk AS nmk,
          t2.acc AS acc,
          t2.nls AS nls,
          t2.kv AS kv,
          T2.NMS AS nms,
          T6.ID AS inst_kod,
          T6.CORPORATION_NAME AS inst_name,
          NVL (t7.VALUE, 'N') AS use_invp,
          t2.branch as branch,
          t2.daos as daos,
          t2.dazs as dazs,
          T8.TYPNLS as trkk_kod
     FROM customer t1,
          accounts t2,
          accountsw t3,
          accountsw t4,
          ob_corporation t5,
          ob_corporation t6,
          accountsw t7,
          specparam_int t8
    WHERE     t1.rnk = t2.rnk
          AND t2.acc = t3.acc
          AND t2.acc = t4.acc
          AND T3.TAG = 'OBCORP'
          AND t4.tag = 'OBCORPCD'
          AND t3.VALUE = T5.ID
          AND T4.VALUE = t6.id
          AND t2.acc = t7.acc
          AND t7.tag = 'CORPV'
          and T7.VALUE = 'Y'
          and t2.acc = t8.acc(+);

PROMPT *** Create  grants  V_CORP_ACCOUNTS_KFILE ***
grant SELECT                                                                 on V_CORP_ACCOUNTS_KFILE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CORP_ACCOUNTS_KFILE to CORP_CLIENT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORP_ACCOUNTS_KFILE.sql =========*** 
PROMPT ===================================================================================== 
