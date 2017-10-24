

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KAS_V0.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view KAS_V0 ***

  CREATE OR REPLACE FORCE VIEW BARS.KAS_V0 ("TABID_V", "TABID_K", "VID", "NAME", "VVOD", "KORR") AS 
  select tabid_v, tabid_k,vid, name,
       make_url('/barsroot/barsweb/references/refbook.aspx?tabid='||tabid_v||
                '&mode=RW&force=1','Ввод') VVOD,
       make_url('/barsroot/barsweb/references/refbook.aspx?tabid='||tabid_k||
                '&mode=RW&force=1','Перегл+Корр') KORR
from
(select v.vid, v.name,
       (select tabid from meta_tables where tabname='KAS_VV'||v.vid) tabid_v,
       (select tabid from meta_tables where tabname='KAS_ZV'||v.vid) tabid_k
from kas_VID v )
;

PROMPT *** Create  grants  KAS_V0 ***
grant SELECT                                                                 on KAS_V0          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KAS_V0          to PYOD001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KAS_V0.sql =========*** End *** =======
PROMPT ===================================================================================== 
