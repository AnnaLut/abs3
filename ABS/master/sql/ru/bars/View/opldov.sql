

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPLDOV.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view OPLDOV ***

  CREATE OR REPLACE FORCE VIEW BARS.OPLDOV ("REF", "TT", "DK", "ACC", "FDAT", "S", "SQ", "TXT", "STMT", "SOS") AS 
  select o.REF,o.TT,o.DK,o.ACC,o.FDAT,o.S,o.SQ,o.TXT,o.STMT,o.SOS
  from opldok o, accounts a
  where o.acc=a.acc and a.nbs is not null
union all
  select o.REF,o.TT,o.DK,a.ACCC,o.FDAT,o.S,o.SQ,o.TXT,o.STMT,o.SOS
  from opldok o, accounts a
  where o.acc=a.acc and a.nbs is null and a.accc is not null;

PROMPT *** Create  grants  OPLDOV ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPLDOV          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPLDOV.sql =========*** End *** =======
PROMPT ===================================================================================== 
