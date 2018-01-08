

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KAS_M_KOLZ0.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view KAS_M_KOLZ0 ***

  CREATE OR REPLACE FORCE VIEW BARS.KAS_M_KOLZ0 ("IDM", "NAME", "KOLZ0") AS 
  SELECT m.idm, m.name, z.kolz0
from kas_m m,
    (select b.idm, count(*) kolz0
     from kas_z k, kas_b b
     where k.sos=0 and k.dat2> gl.bd and k.branch=b.branch
     group by b.idm) z
where  m.idm=z.idm (+) ;

PROMPT *** Create  grants  KAS_M_KOLZ0 ***
grant SELECT                                                                 on KAS_M_KOLZ0     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KAS_M_KOLZ0     to PYOD001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KAS_M_KOLZ0.sql =========*** End *** ==
PROMPT ===================================================================================== 
