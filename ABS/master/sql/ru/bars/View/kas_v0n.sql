

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KAS_V0N.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view KAS_V0N ***

  CREATE OR REPLACE FORCE VIEW BARS.KAS_V0N ("VID", "NAME", "VVOD", "KORR") AS 
  select vid, name,
    make_url('/barsroot/barsweb/references/refbook.aspx?tabname=KAS_VV'||vid||
                '&mode=RW&force=1','Ввод') VVOD,
    make_url('/barsroot/barsweb/references/refbook.aspx?tabname=KAS_ZV'||vid||
                '&mode=RW&force=1','Перегл+Корр') KORR
from kas_VID v;

PROMPT *** Create  grants  KAS_V0N ***
grant SELECT                                                                 on KAS_V0N         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KAS_V0N         to PYOD001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KAS_V0N.sql =========*** End *** ======
PROMPT ===================================================================================== 
