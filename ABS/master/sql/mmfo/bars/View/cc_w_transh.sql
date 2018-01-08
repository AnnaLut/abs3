

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_W_TRANSH.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_W_TRANSH ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_W_TRANSH ("ACC", "COMM", "DAPP", "D_FAKT", "D_PLAN", "KV", "NLS", "FDAT", "NPP", "REF", "REFP", "SZ", "S", "SV", "TIP", "SV1", "D_PLAN1", "SZ1", "DEL", "OST", "ND", "TXT") AS 
  SELECT acc, comm, DAPP, D_FAKT, D_PLAN, kv, nls, fdat, npp, REF, REFP, SZ, S, SV, TIP, TO_NUMBER (NULL) SV1, TO_DATE (NULL)   D_PLAN1, TO_NUMBER (NULL) SZ1, SV-SZ DEL, OST, ND,
          CASE WHEN TIP = 'SS ' AND D_FAKT IS NULL    THEN       'В роботі'
               WHEN TIP = 'SS ' AND D_FAKT > D_PLAN   THEN       'Винесено на просрочку'
               WHEN TIP = 'SS '                       THEN       'Погашено своєчасно'
               WHEN D_FAKT IS NOT NULL                THEN       'Погашено з порушенням'
               ELSE                                              'НЕпогашений'
           END    TXT
   FROM (  SELECT T.npp, a.TIP, a.kv, a.nls, T.fdat, T.REF, T.sz/100 SZ, T.D_FAKT, T.DAPP, T.REFP, a.acc, T.comm, o.s/100 S, t.d_plan, t.sv/100 SV, -a.ostc/100 OST, n.ND
           FROM   bars.nd_acc n
             JOIN bars.accounts a  ON a.acc = n.acc
             JOIN bars.CC_TRANS t  ON T.acc = a.acc
             LEFT JOIN bars.oper O ON T.REF = o.REF
           WHERE n.nd = TO_NUMBER (pul.get_mas_ini_val ('ND'))
           ORDER BY t.fdat, t.REF, t.D_PLAN
       ) x;

PROMPT *** Create  grants  CC_W_TRANSH ***
grant SELECT                                                                 on CC_W_TRANSH     to BARSREADER_ROLE;
grant SELECT                                                                 on CC_W_TRANSH     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_W_TRANSH     to START1;
grant SELECT                                                                 on CC_W_TRANSH     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_W_TRANSH.sql =========*** End *** ==
PROMPT ===================================================================================== 
