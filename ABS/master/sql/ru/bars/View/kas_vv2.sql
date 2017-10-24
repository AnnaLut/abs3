

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KAS_VV2.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view KAS_VV2 ***

  CREATE OR REPLACE FORCE VIEW BARS.KAS_VV2 ("KODV", "KV", "NAME", "NAME1", "BRANCH", "DAT2", "S") AS 
  SELECT m.kod,
          a2.kv,
          m.NAME,
          m.name1,
          a2.branch,
          TO_CHAR (a2.dazs, 'dd/mm/yyyy') dat2,
          a2.pos - 1 s
     FROM accounts a2,
          (SELECT kod,
                  kv,
                  name_comment name1,
                  SUBSTR ('00' || type_, -2) ob22,
                  DECODE (type_,
                          1, 'Зливок',
                          2, 'Монета',
                          'Порошок')
                     NAME
             FROM bank_metals) m
    WHERE     a2.nbs in ( '1102', '1101')
          AND a2.dazs IS NULL
          AND a2.ob22 = m.ob22
          AND a2.kv = m.kv
          AND a2.branch LIKE
                 SYS_CONTEXT ('bars_context', 'user_branch') || '%'
          AND EXISTS
                 (SELECT 1
                    FROM accounts a7
                   WHERE     a7.nbs = '1107'
                         AND a7.dazs IS NULL
                         AND a7.kv = a2.kv
                         AND a7.ob22 = a2.ob22
                         AND a7.branch = SUBSTR (a2.branch, 1, 15))
          AND EXISTS
                 (SELECT 1
                    FROM accounts a1
                   WHERE     a1.nbs = '110' || SUBSTR (kasz.SX ('NBS'), -1)
                         AND a1.dazs IS NULL
                         AND a1.kv = a2.kv
                         AND a1.ob22 = a2.ob22
                         AND a1.branch = kasz.SX ('BRN')
                         AND a1.ostb <> 0);

PROMPT *** Create  grants  KAS_VV2 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_VV2         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_VV2         to PYOD001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KAS_VV2.sql =========*** End *** ======
PROMPT ===================================================================================== 
