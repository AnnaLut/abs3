

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPER_SK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view OPER_SK ***

  CREATE OR REPLACE FORCE VIEW BARS.OPER_SK ("REF", "S", "SK", "VDAT") AS 
  SELECT REF, s, sk, vdat
     FROM oper op
    WHERE  op.vdat >= SYSDATE - 35 and op.pdat >= sysdate - 35 and
           (op.sk IS NOT NULL or
            exists(select 1 
                   from opldok o
                   where op.ref = o.ref and op.sk is null and
                         o.acc in (select acc from accounts a where a.nbs in ('1001','1002','1003','1004') and kv = 980)
                    )
           ) 
 ;

PROMPT *** Create  grants  OPER_SK ***
grant SELECT,UPDATE                                                          on OPER_SK         to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on OPER_SK         to PYOD001;
grant UPDATE                                                                 on OPER_SK         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPER_SK         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPER_SK.sql =========*** End *** ======
PROMPT ===================================================================================== 
