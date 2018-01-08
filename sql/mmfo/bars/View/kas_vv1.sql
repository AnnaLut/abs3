

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KAS_VV1.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view KAS_VV1 ***

  CREATE OR REPLACE FORCE VIEW BARS.KAS_VV1 ("BRANCH", "KV", "LCV", "NAME", "NAME1", "DAT2", "S") AS 
  SELECT a2.branch,
          a2.kv,
          m.lcv,
          m.name,
          'Готiвка' name1,
          TO_CHAR (a2.DAzs, 'dd/mm/yyyy') DAT2,
          a2.pos - 1
     FROM accounts a2,
          specparam_int s2,
          tabval m,
          kas_B b                                               -- добавив НВВ
    WHERE     a2.nbs in ( '1002','1001')
          AND a2.dazs IS NULL
          AND a2.acc = s2.acc
          AND s2.ob22 = '01'
          AND a2.branch = b.branch                              -- добавив НВВ
          AND a2.branch LIKE
                 SYS_CONTEXT ('bars_context', 'user_branch') || '%'
          AND a2.kv = m.kv
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
                         AND a1.ostb <> 0);

PROMPT *** Create  grants  KAS_VV1 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_VV1         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_VV1         to PYOD001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KAS_VV1.sql =========*** End *** ======
PROMPT ===================================================================================== 
