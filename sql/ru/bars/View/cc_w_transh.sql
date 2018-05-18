CREATE OR REPLACE FORCE VIEW BARS.CC_W_TRANSH AS
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

GRANT SELECT ON BARS.CC_W_TRANSH TO BARS_ACCESS_DEFROLE;
