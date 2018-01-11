

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_UCHRRP_EXT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UCHRRP_EXT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_UCHRRP_EXT ("MFO", "KV", "SAB", "KODN", "BLK", "FMI", "FMO", "IDR", "FILE_ENCODING") AS 
  select b.mfo, l.kv, b.sab, b.kodn, l.blk, b.fmi, b.fmo, l.idr, l.file_encoding
from banks b, lkl_rrp l
where b.mfop=gl.kf and b.mfo=l.mfo
union all
-- филиалы наших филиалов
select b.mfo, l.kv, b.sab, b2.kodn, decode(b.blk,0,l.blk,b.blk) blk, b2.fmi, b2.fmo, l.idr, l.file_encoding
from banks b, lkl_rrp l, banks b2
where b.mfop in (select mfo from banks where mfop=gl.kf and mfo<>gl.kf and kodn<>3)
and l.mfo=b.mfop and b2.mfo=l.mfo
 ;

PROMPT *** Create  grants  V_UCHRRP_EXT ***
grant SELECT                                                                 on V_UCHRRP_EXT    to BARSREADER_ROLE;
grant SELECT                                                                 on V_UCHRRP_EXT    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_UCHRRP_EXT    to TOSS;
grant SELECT                                                                 on V_UCHRRP_EXT    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_UCHRRP_EXT    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_UCHRRP_EXT.sql =========*** End *** =
PROMPT ===================================================================================== 
