

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BANKS_MOD3.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BANKS_MOD3 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BANKS_MOD3 ("SORT_CODE", "MFO", "SAB", "NB", "BLK") AS 
  select substr(mfo,1,20) as sort_code, banks.mfo, banks.sab, banks.nb, banks.blk from banks where mfo=gl.kf
union all
select substr(mfop||'_'||mfo,1,20) as sort_code, banks.mfo, banks.sab, banks.nb, banks.blk from banks where kodn=6 and mfop=gl.kf
union all
select substr(gl.kf||'_'||mfop||'_'||mfo,1,20) as sort_code, banks.mfo, banks.sab, banks.nb, banks.blk from banks where mfop in (select mfo from banks where kodn=6 and mfop=gl.kf);

PROMPT *** Create  grants  V_BANKS_MOD3 ***
grant SELECT                                                                 on V_BANKS_MOD3    to BARSREADER_ROLE;
grant SELECT                                                                 on V_BANKS_MOD3    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BANKS_MOD3    to START1;
grant SELECT                                                                 on V_BANKS_MOD3    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BANKS_MOD3.sql =========*** End *** =
PROMPT ===================================================================================== 
