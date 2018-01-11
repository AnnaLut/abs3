

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PS4.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** Create  view PS4 ***

  CREATE OR REPLACE FORCE VIEW BARS.PS4 ("NBS", "XAR", "NAME") AS 
  (
select
 NBS,
 XAR,
 NAME
from ps
   where nbs in (
          select nbs from accounts
           )
);

PROMPT *** Create  grants  PS4 ***
grant SELECT                                                                 on PS4             to BARSREADER_ROLE;
grant SELECT                                                                 on PS4             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PS4             to START1;
grant SELECT                                                                 on PS4             to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PS4.sql =========*** End *** ==========
PROMPT ===================================================================================== 
