

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PEREOC.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view PEREOC ***

  CREATE OR REPLACE FORCE VIEW BARS.PEREOC ("FDAT", "KV", "NLS", "OST", "OSTQ", "DELTA") AS 
  select fdat, kv,  nls, ost, gl.p_icurval(kv,ost,fdat),
( gl.p_icurval( kv, ost,         fdat   ) -
  gl.p_icurval( kv, ost+dos-kos, fdat-1 ) -
  gl.p_icurval( kv,     kos-dos, fdat   ) )
from sal_branch

 ;

PROMPT *** Create  grants  PEREOC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PEREOC          to ABS_ADMIN;
grant SELECT                                                                 on PEREOC          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PEREOC          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PEREOC          to START1;
grant SELECT                                                                 on PEREOC          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PEREOC          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PEREOC.sql =========*** End *** =======
PROMPT ===================================================================================== 
