

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OTCN_FLAG_BLK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OTCN_FLAG_BLK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OTCN_FLAG_BLK ("TP", "DATF", "KODF", "ISP", "FIO", "DAT_BLK") AS 
  select a.TP, a.DATF, a.KODF, a.ISP, b.fio, a.DAT_BLK
from otcn_flag_blk a, staff b
where a.isp = b.id;

PROMPT *** Create  grants  V_OTCN_FLAG_BLK ***
grant SELECT                                                                 on V_OTCN_FLAG_BLK to BARSREADER_ROLE;
grant SELECT                                                                 on V_OTCN_FLAG_BLK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OTCN_FLAG_BLK to RPBN002;
grant SELECT                                                                 on V_OTCN_FLAG_BLK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OTCN_FLAG_BLK.sql =========*** End **
PROMPT ===================================================================================== 
