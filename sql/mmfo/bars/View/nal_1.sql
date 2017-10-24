

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NAL_1.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view NAL_1 ***

  CREATE OR REPLACE FORCE VIEW BARS.NAL_1 ("NLS", "NMS") AS 
  SELECT distinct nls,nms from nal_dec where nls is not null;

PROMPT *** Create  grants  NAL_1 ***
grant SELECT                                                                 on NAL_1           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NAL_1           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NAL_1.sql =========*** End *** ========
PROMPT ===================================================================================== 
