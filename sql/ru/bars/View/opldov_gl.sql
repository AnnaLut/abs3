

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPLDOV_GL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view OPLDOV_GL ***

  CREATE OR REPLACE FORCE VIEW BARS.OPLDOV_GL ("REF", "TT", "DK", "ACC", "FDAT", "S", "SQ", "TXT", "STMT", "SOS") AS 
  select o.REF,o.TT,o.DK,o.ACC,o.FDAT,o.S,o.SQ,o.TXT,o.STMT,o.SOS
  from opldok o, v_gl a
  where o.acc=a.acc and a.nbs is not null
union all
  select o.REF,o.TT,o.DK,a.ACCC,o.FDAT,o.S,o.SQ,o.TXT,o.STMT,o.SOS
  from opldok o, v_gl a
  where o.acc=a.acc and a.nbs is null and a.accc is not null;

PROMPT *** Create  grants  OPLDOV_GL ***
grant SELECT                                                                 on OPLDOV_GL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPLDOV_GL       to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPLDOV_GL       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPLDOV_GL.sql =========*** End *** ====
PROMPT ===================================================================================== 
