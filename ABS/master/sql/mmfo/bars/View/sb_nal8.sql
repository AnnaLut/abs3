

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SB_NAL8.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view SB_NAL8 ***

  CREATE OR REPLACE FORCE VIEW BARS.SB_NAL8 ("ACC", "ISP", "NLS", "NMS", "OST", "DAOS") AS 
  select acc,isp,nls,nms,ostc,daos from accounts where nbs like '8%' and
nls not in (select nls from nal_dec3 where nls is not null)
and nls not in (select nls from nal_dec3 where nls is not null)
and accc is null and dazs is null
and substr (nbs,1,2) not like '89%'
 ;

PROMPT *** Create  grants  SB_NAL8 ***
grant SELECT                                                                 on SB_NAL8         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_NAL8         to NALOG;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SB_NAL8         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SB_NAL8.sql =========*** End *** ======
PROMPT ===================================================================================== 
