

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/S1521.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view S1521 ***

  CREATE OR REPLACE FORCE VIEW BARS.S1521 ("FDAT", "KV", "NLS", "NMS", "DOS", "DOS_E", "MDATE", "IR_D") AS 
  SELECT s.fdat,
       a.kv,
       a.nls,
       a.nms,
       s.dos,
       gl.p_icurval(a.kv,s.dos,s.fdat) as dos_e,
       a.mdate,
       p.ir
FROM accounts a,
     saldoa s,
     int_ratn p
WHERE a.acc=p.acc(+) and
      a.acc=s.acc    and
      s.dos>0        and
      a.nbs='1521'   and
      s.fdat>to_date('16-11-1998','DD-MM-YYYY') and
      p.bdat in (SELECT max(pp.bdat)
                  FROM int_ratn pp
                  WHERE pp.acc=p.acc and
                        pp.bdat<=s.fdat);

PROMPT *** Create  grants  S1521 ***
grant SELECT                                                                 on S1521           to BARSREADER_ROLE;
grant SELECT                                                                 on S1521           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S1521           to START1;
grant SELECT                                                                 on S1521           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/S1521.sql =========*** End *** ========
PROMPT ===================================================================================== 
