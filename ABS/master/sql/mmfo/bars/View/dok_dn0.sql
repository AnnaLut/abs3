

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DOK_DN0.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view DOK_DN0 ***

  CREATE OR REPLACE FORCE VIEW BARS.DOK_DN0 ("FDAT", "ID", "KOL", "S") AS 
  SELECT vdat, id, count(*), sum(s)
FROM (select vdat,
        af1(tt,userid,kv,kv2,substr(nlsa,1,4),substr(nlsb,1,4),mfoa,mfob) ID,
        af2(ref,vdat) S
      from oper where sos=5
       )
GROUP BY vdat, id
;

PROMPT *** Create  grants  DOK_DN0 ***
grant SELECT                                                                 on DOK_DN0         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DOK_DN0         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DOK_DN0.sql =========*** End *** ======
PROMPT ===================================================================================== 
