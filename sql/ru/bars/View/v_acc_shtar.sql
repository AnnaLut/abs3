

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACC_SHTAR.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACC_SHTAR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACC_SHTAR ("ACC", "NLS", "KV", "NMS", "SHTAR", "RNK", "BRANCH", "NBS", "DAPP") AS 
  SELECT     a.ACC, a.NLS, a.KV, a.NMS, to_number(w.VALUE),
           a.RNK, a.BRANCH, a.NBS, a.DAPP
     FROM  V_GL a, AccountsW w
     WHERE a.ACC=w.ACC and w.TAG='SHTAR'
       and a.DAZS is NULL
union all
SELECT     a.ACC, a.NLS, a.KV, a.NMS, NULL,  --- Eсли № пакета у счета нет, то
           a.RNK, a.BRANCH, a.NBS, a.DAPP    --- V_ACC_SHTAR.SHTAR = NULL
     FROM  V_GL a
     WHERE a.ACC not in (Select ACC from AccountsW where TAG='SHTAR')
       and a.DAZS is NULL;

PROMPT *** Create  grants  V_ACC_SHTAR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_ACC_SHTAR     to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ACC_SHTAR     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACC_SHTAR     to CUST001;
grant SELECT                                                                 on V_ACC_SHTAR     to START1;
grant FLASHBACK,SELECT                                                       on V_ACC_SHTAR     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACC_SHTAR.sql =========*** End *** ==
PROMPT ===================================================================================== 
