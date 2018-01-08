

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SB_NAL6.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view SB_NAL6 ***

  CREATE OR REPLACE FORCE VIEW BARS.SB_NAL6 ("ACC", "ISP", "NLS", "NMS", "OST", "DAOS") AS 
  select acc,isp,nls,nms,ostc,daos from accounts
where  nbs like '6%' and accc is null and dazs is null
 ;

PROMPT *** Create  grants  SB_NAL6 ***
grant SELECT                                                                 on SB_NAL6         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_NAL6         to NALOG;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SB_NAL6         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SB_NAL6.sql =========*** End *** ======
PROMPT ===================================================================================== 
