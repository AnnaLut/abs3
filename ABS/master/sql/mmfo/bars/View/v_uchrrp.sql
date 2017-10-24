

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_UCHRRP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UCHRRP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_UCHRRP ("MFO", "KV", "SAB", "KODN", "BLK", "FMI", "FMO", "IDR", "FILE_ENCODING") AS 
  select banks.mfo, lkl_rrp.kv, banks.sab, banks.kodn,
	   lkl_rrp.blk, banks.fmi, banks.fmo, lkl_rrp.idr, lkl_rrp.file_encoding
from lkl_rrp, banks
where banks.mfop = gl.kf
  and banks.mfo=lkl_rrp.mfo
 ;

PROMPT *** Create  grants  V_UCHRRP ***
grant SELECT                                                                 on V_UCHRRP        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_UCHRRP        to TOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_UCHRRP        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_UCHRRP.sql =========*** End *** =====
PROMPT ===================================================================================== 
