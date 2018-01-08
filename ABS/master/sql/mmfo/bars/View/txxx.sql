

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TXXX.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view TXXX ***

  CREATE OR REPLACE FORCE VIEW BARS.TXXX ("FDAT", "DDD", "NAME", "OB6", "SAL6", "OB7", "SAL7", "OB", "SAL") AS 
  SELECT s.fdat,'D'||substr(s.nbs,2,3),p.name,
  round(sum(decode(substr(s.nbs,1,1),'6',s.kos-s.dos,0))/100000,0),
  round(sum(decode(substr(s.nbs,1,1),'6',s.ost,0))/100000,0),
  round(sum(decode(substr(s.nbs,1,1),'7',s.kos-s.dos,0))/100000,0),
  round(sum(decode(substr(s.nbs,1,1),'7',s.ost,0))/100000,0),
  round(sum(s.kos-s.dos)/100000,0),
  round(sum(s.ost)/100000,0)
FROM  sal s, ps p
WHERE substr(s.nbs,1,1) in ('6','7') and p.nbs='6'|| substr(s.nbs,2,3)
GROUP by  s.fdat,'D'||substr(s.nbs,2,3), p.name
UNION all
SELECT s.fdat,'D'||substr(s.nbs,2,2)||' ',p.name,
  round(sum(decode(substr(s.nbs,1,1),'6',s.kos-s.dos,0))/100000,0),
  round(sum(decode(substr(s.nbs,1,1),'6',s.ost,0))/100000,0),
  round(sum(decode(substr(s.nbs,1,1),'7',s.kos-s.dos,0))/100000,0),
  round(sum(decode(substr(s.nbs,1,1),'7',s.ost,0))/100000,0),
  round(sum(s.kos-s.dos)/100000,0),
  round(sum(s.ost)/100000,0)
FROM sal s, ps p
WHERE substr(s.nbs,1,1) in ('6','7') and p.nbs='6'|| substr(s.nbs,2,2)||' '
GROUP by  s.fdat,'D'||substr(s.nbs,2,2), p.name
UNION all
SELECT s.fdat,'D'||substr(s.nbs,2,1)||'  ',p.name,
  round(sum(decode(substr(s.nbs,1,1),'6',s.kos-s.dos,0))/100000,0),
  round(sum(decode(substr(s.nbs,1,1),'6',s.ost,0))/100000,0),
  round(sum(decode(substr(s.nbs,1,1),'7',s.kos-s.dos,0))/100000,0),
  round(sum(decode(substr(s.nbs,1,1),'7',s.ost,0))/100000,0),
  round(sum(s.kos-s.dos)/100000,0),
  round(sum(s.ost)/100000,0)
FROM  sal s, ps p
WHERE substr(s.nbs,1,1) in ('6','7') and p.nbs='6'|| substr(s.nbs,2,1)||'  '
GROUP by  s.fdat,'D'||substr(s.nbs,2,1), p.name
UNION all
SELECT s.fdat,'D   ','Чистий доход',
  round(sum(decode(substr(s.nbs,1,1),'6',s.kos-s.dos,0))/100000,0),
  round(sum(decode(substr(s.nbs,1,1),'6',s.ost,0))/100000,0),
  round(sum(decode(substr(s.nbs,1,1),'7',s.kos-s.dos,0))/100000,0),
  round(sum(decode(substr(s.nbs,1,1),'7',s.ost,0))/100000,0),
  round(sum(s.kos-s.dos)/100000,0),
  round(sum(s.ost)/100000,0)
FROM sal s
WHERE substr(s.nbs,1,1) in ('6','7')
GROUP by  s.fdat;

PROMPT *** Create  grants  TXXX ***
grant SELECT                                                                 on TXXX            to BARSREADER_ROLE;
grant SELECT                                                                 on TXXX            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TXXX            to START1;
grant SELECT                                                                 on TXXX            to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TXXX.sql =========*** End *** =========
PROMPT ===================================================================================== 
