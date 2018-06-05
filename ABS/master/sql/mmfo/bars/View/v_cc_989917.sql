

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_989917.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_989917 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_989917 ("REF1", "OPL", "BRANCH", "NLSB", "NAM_B", "S", "FIO", "ND", "VA_KC", "NLSA", "REF2", "ACC") AS 
  SELECT REF1,
            0 AS OPL,
            BRANCH,
            NLSA AS NLSB,
            NAM_A AS NAM_B,
            S / 100,
            FIO,
            ND,
            VA_KC,
            NBS_OB22_NULL (SUBSTR (VA_KC, 2, 4),
                           SUBSTR (VA_KC, 7, 2),
                           SYS_CONTEXT ('bars_context', 'user_branch'))
               AS NLSA,
            REF2,
            acc
       FROM (SELECT C.*,
                    O.NLSA,
                    O.NAM_A,
                    O.S,
                    F_DOP (C.REF1, 'VA_KC') VA_KC,
                    F_DOP (C.REF1, 'FIO') FIO,
                    F_DOP (C.REF1, 'ND') ND,
                    O.NAZN
               FROM accounts a, CC_989917_REF c, OPER O
              WHERE a.branch LIKE  DECODE (SYS_CONTEXT ('bars_context','user_branch'),KASZ.SX (TAG_ => 'BRN'), '/'||f_ourmfo||'%',cash_sxo.bs) 
                    and nbs = '9899' and ob22 = '17'
                    AND c.acc = a.acc
                    AND C.REF1 = O.REF
                    and C.ref2 IS NULL
                    AND SOS = 5)
   ORDER BY BRANCH,
            fio,
            ND,
            VA_KC;

PROMPT *** Create  grants  V_CC_989917 ***
grant SELECT                                                                 on V_CC_989917     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,SELECT,UPDATE                                         on V_CC_989917     to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,SELECT,UPDATE                                         on V_CC_989917     to RCC_DEAL;
grant SELECT                                                                 on V_CC_989917     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CC_989917     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_989917.sql =========*** End *** ==
PROMPT ===================================================================================== 
