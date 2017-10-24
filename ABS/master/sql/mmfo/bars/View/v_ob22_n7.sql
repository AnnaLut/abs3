

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OB22_N7.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OB22_N7 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OB22_N7 ("ACC", "ISP", "NLS", "NMS", "OST", "DAOS") AS 
  select acc,isp,nls,nms,ostc,daos from accounts
where  substr(nls,1,1)='7' and  dazs is null and acc not in
       (select acc from v_ob22nu )
 ;

PROMPT *** Create  grants  V_OB22_N7 ***
grant SELECT                                                                 on V_OB22_N7       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OB22_N7       to NALOG;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OB22_N7       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OB22_N7.sql =========*** End *** ====
PROMPT ===================================================================================== 
