

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OB22_N34.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OB22_N34 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OB22_N34 ("ACC", "ISP", "NLS", "NMS", "OST", "DAOS") AS 
  select acc,isp,nls,nms,ostc,daos from accounts
where  substr(nls,1,4)='3400' and  dazs is null and acc not in
       (select acc from v_ob22nu )
 ;

PROMPT *** Create  grants  V_OB22_N34 ***
grant SELECT                                                                 on V_OB22_N34      to BARSREADER_ROLE;
grant SELECT                                                                 on V_OB22_N34      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OB22_N34      to NALOG;
grant SELECT                                                                 on V_OB22_N34      to START1;
grant SELECT                                                                 on V_OB22_N34      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OB22_N34      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OB22_N34.sql =========*** End *** ===
PROMPT ===================================================================================== 
