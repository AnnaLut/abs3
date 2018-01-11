

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KAS_VV3.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view KAS_VV3 ***

  CREATE OR REPLACE FORCE VIEW BARS.KAS_VV3 ("KODV", "NAME", "NAME1", "KV", "BRANCH", "DAT2", "S") AS 
  SELECT m.KOD_MONEY,
          m.NAMEMETAL,
          m.NAMEMONEY,
          a2.kv,
          a2.branch,
          TO_CHAR (a2.DAzs, 'dd/mm/yyyy') DAT2,
          a2.pos - 1 S
     FROM accounts a2, specparam_int s2, spr_mon m
    WHERE     a2.nbs in( '1002','1001')
          AND a2.dazs IS NULL
          AND a2.acc = s2.acc
          AND s2.ob22 = '01'
          AND a2.branch LIKE
                 SYS_CONTEXT ('bars_context', 'user_branch') || '%'
          AND a2.kv = 980
          AND DECODE (m.PR_KUPON, NULL, m.NOMINAL, 0) > 0
          AND EXISTS
                 (SELECT 1
                    FROM accounts a7, specparam_int s7
                   WHERE     a7.nbs = '1007'
                         AND a7.dazs IS NULL
                         AND a7.kv = a2.kv
                         AND a7.acc = s7.acc
                         AND s7.ob22 = '01'
                         AND a7.branch = SUBSTR (a2.branch, 1, 15))
          AND EXISTS
                 (SELECT 1
                    FROM accounts a1, specparam_int s1
                   WHERE     a1.nbs = kasz.SX ('NBS')
                         AND a1.dazs IS NULL
                         AND a1.kv = a2.kv
                         AND a1.acc = s1.acc
                         AND s1.ob22 = '01'
                         AND a1.branch = kasz.SX ('BRN')
                         AND a1.ostb <> 0)
          AND EXISTS
                 (SELECT 1
                    FROM BANK_MON
                   WHERE kod_nbu = m.KOD_MONEY)
   UNION ALL
   SELECT m.KOD_MONEY,
          m.NAMEMETAL,
          m.NAMEMONEY,
          a2.kv,
          a2.branch,
          TO_CHAR (a2.DAzs, 'dd/mm/yyyy') DAT2,
          a2.pos - 1 S
     FROM accounts a2, specparam_int s2, spr_mon m
    WHERE     a2.nbs = '9819'
          AND a2.dazs IS NULL
          AND a2.acc = s2.acc
          AND s2.ob22 = '32'
          AND a2.branch LIKE
                 SYS_CONTEXT ('bars_context', 'user_branch') || '%'
          AND a2.kv = 980
          AND DECODE (m.PR_KUPON, NULL, m.NOMINAL, 0) = 0
          AND EXISTS
                 (SELECT 1
                    FROM accounts a7, specparam_int s7
                   WHERE     a7.nbs = '9899'
                         AND a7.dazs IS NULL
                         AND a7.kv = a2.kv
                         AND a7.acc = s7.acc
                         AND s7.ob22 = '17'
                         AND a7.branch = SUBSTR (a2.branch, 1, 15))
          AND EXISTS
                 (SELECT 1
                    FROM accounts a1, specparam_int s1
                   WHERE     a1.nbs = '9819'
                         AND a1.dazs IS NULL
                         AND a1.kv = a2.kv
                         AND a1.acc = s1.acc
                         AND s1.ob22 = '32'
                         AND a1.branch = kasz.SX ('BRN')
                         AND a1.ostb <> 0)
          AND EXISTS
                 (SELECT 1
                    FROM BANK_MON
                   WHERE kod_nbu = m.KOD_MONEY);

PROMPT *** Create  grants  KAS_VV3 ***
grant SELECT                                                                 on KAS_VV3         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_VV3         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_VV3         to PYOD001;
grant SELECT                                                                 on KAS_VV3         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KAS_VV3.sql =========*** End *** ======
PROMPT ===================================================================================== 
