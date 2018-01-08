

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOKTIME.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOKTIME ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOKTIME ("REF", "ND", "MFOA", "NLSA", "ID_A", "MFOB", "NLSB", "ID_B", "S", "NAZN", "DOK_TIM", "FDAT", "TT") AS 
  SELECT p.REF,p.ND,p.mfoa,p.nlsa,p.id_a,p.mfob,p.nlsb,p.id_b,o.s/100,p.nazn,
       nvl( v.dat,p.pdat), o.FDAT , p.TT
FROM  opldok o, accounts a, oper p,
    (select ref, dat from oper_visa where status=2) v,
    (select nvl ( TO_DATE (pul.get_mas_ini_val ('sFdat1'),'dd.mm.yyyy'), gl.bd) FDAT1,
            nvl ( TO_DATE (pul.get_mas_ini_val ('sFdat2'),'dd.mm.yyyy'), gl.bd) FDAT2
     from dual) d
where a.kv   = 980
-- and a.nls in ('26037305283','26034301268','260313011490')
 and a.dapp >= d.FDAT1
 and a.dapp <= d.FDAT2
 and a.nbs in '2603'
 and a.acc  = o.acc
 and o.sos >= 4
 and p.ref  = v.ref (+)
 and p.ref  = o.ref
 and o.fdat >= d.FDAT1
 and o.fdat <= d.fdat2 ;

PROMPT *** Create  grants  V_DOKTIME ***
grant SELECT                                                                 on V_DOKTIME       to BARSREADER_ROLE;
grant SELECT                                                                 on V_DOKTIME       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DOKTIME       to SALGL;
grant SELECT                                                                 on V_DOKTIME       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOKTIME.sql =========*** End *** ====
PROMPT ===================================================================================== 
