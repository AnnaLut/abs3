

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BPK_PROECT_WEB.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view BPK_PROECT_WEB ***

  CREATE OR REPLACE FORCE VIEW BARS.BPK_PROECT_WEB ("ID", "NAME", "OKPO", "PRODUCT_CODE") AS 
  select id, replace(name,'''','`') name, okpo, product_code
  from bpk_proect;

PROMPT *** Create  grants  BPK_PROECT_WEB ***
grant SELECT                                                                 on BPK_PROECT_WEB  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BPK_PROECT_WEB.sql =========*** End ***
PROMPT ===================================================================================== 
