

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALB_FDAT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view SALB_FDAT ***

  CREATE OR REPLACE FORCE VIEW BARS.SALB_FDAT ("ACC", "FDAT", "DOS", "KOS") AS 
  select s.acc, b.fdat,  s.dos, s.kos
     from saldob s,
          fdat b
    where s.fdat = b.fdat
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALB_FDAT.sql =========*** End *** ====
PROMPT ===================================================================================== 
