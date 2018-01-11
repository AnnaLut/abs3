

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SB_NAL7.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view SB_NAL7 ***

  CREATE OR REPLACE FORCE VIEW BARS.SB_NAL7 ("ACC", "ISP", "NLS", "NMS", "OST", "DAOS") AS 
  select acc,isp,nls,nms,ostc,daos from accounts
where  nbs like '7%' and accc is null and dazs is null
 ;

PROMPT *** Create  grants  SB_NAL7 ***
grant SELECT                                                                 on SB_NAL7         to BARSREADER_ROLE;
grant SELECT                                                                 on SB_NAL7         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_NAL7         to NALOG;
grant SELECT                                                                 on SB_NAL7         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SB_NAL7         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SB_NAL7.sql =========*** End *** ======
PROMPT ===================================================================================== 
