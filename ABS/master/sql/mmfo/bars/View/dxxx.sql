

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DXXX.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view DXXX ***

  CREATE OR REPLACE FORCE VIEW BARS.DXXX ("FDAT", "DDD", "NAME", "OB6", "SAL6", "OB7", "SAL7", "OB", "SAL") AS 
  SELECT s.fdat,'D'||substr(s.nbs,2,3),p.name,
  sum(decode(substr(s.nbs,1,1),'6',s.kos-s.dos,0)),
  sum(decode(substr(s.nbs,1,1),'6',s.ost,0)),
  sum(decode(substr(s.nbs,1,1),'7',s.kos-s.dos,0)),
  sum(decode(substr(s.nbs,1,1),'7',s.ost,0)),
  sum(s.kos-s.dos),
  sum(s.ost)
FROM  sal s, ps p
WHERE substr(s.nbs,1,1) in ('6','7') and p.nbs='6'|| substr(s.nbs,2,3)
GROUP by  s.fdat,'D'||substr(s.nbs,2,3), p.name
UNION all
SELECT s.fdat,'D'||substr(s.nbs,2,2)||' ',p.name,
  sum(decode(substr(s.nbs,1,1),'6',s.kos-s.dos,0)),
  sum(decode(substr(s.nbs,1,1),'6',s.ost,0)),
  sum(decode(substr(s.nbs,1,1),'7',s.kos-s.dos,0)),
  sum(decode(substr(s.nbs,1,1),'7',s.ost,0)),
  sum(s.kos-s.dos),
  sum(s.ost)
FROM sal s, ps p
WHERE substr(s.nbs,1,1) in ('6','7') and p.nbs='6'|| substr(s.nbs,2,2)||' '
GROUP by  s.fdat,'D'||substr(s.nbs,2,2), p.name
UNION all
SELECT s.fdat,'D'||substr(s.nbs,2,1)||'  ',p.name,
  sum(decode(substr(s.nbs,1,1),'6',s.kos-s.dos,0)),
  sum(decode(substr(s.nbs,1,1),'6',s.ost,0)),
  sum(decode(substr(s.nbs,1,1),'7',s.kos-s.dos,0)),
  sum(decode(substr(s.nbs,1,1),'7',s.ost,0)),
  sum(s.kos-s.dos),
  sum(s.ost)
FROM  sal s, ps p
WHERE substr(s.nbs,1,1) in ('6','7') and p.nbs='6'|| substr(s.nbs,2,1)||'  '
GROUP by  s.fdat,'D'||substr(s.nbs,2,1), p.name
UNION all
SELECT s.fdat,'D   ','Чистий доход',
  sum(decode(substr(s.nbs,1,1),'6',s.kos-s.dos,0)),
  sum(decode(substr(s.nbs,1,1),'6',s.ost,0)),
  sum(decode(substr(s.nbs,1,1),'7',s.kos-s.dos,0)),
  sum(decode(substr(s.nbs,1,1),'7',s.ost,0)),
  sum(s.kos-s.dos),
  sum(s.ost)
FROM sal s
WHERE substr(s.nbs,1,1) in ('6','7')
GROUP by  s.fdat;

PROMPT *** Create  grants  DXXX ***
grant SELECT                                                                 on DXXX            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DXXX            to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DXXX.sql =========*** End *** =========
PROMPT ===================================================================================== 
