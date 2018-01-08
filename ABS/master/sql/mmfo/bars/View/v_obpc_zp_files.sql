

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBPC_ZP_FILES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBPC_ZP_FILES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBPC_ZP_FILES ("ID", "FILE_NAME", "FILE_DATE", "TRANSIT_NLS", "TRANSIT_NMS", "FILE_ACC", "FILE_SUM", "PAY_ACC", "PAY_SUM") AS 
  select z.id, z.file_name, z.file_date, a.nls, a.nms,
       z.file_acc, z.file_sum/100, z.pay_acc, z.pay_sum/100
  from obpc_zp_files z, accounts a
 where z.transit_acc = a.acc
   and a.branch like sys_context('bars_context','user_branch') || '%'
 ;

PROMPT *** Create  grants  V_OBPC_ZP_FILES ***
grant SELECT                                                                 on V_OBPC_ZP_FILES to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_ZP_FILES to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_OBPC_ZP_FILES to OBPC;
grant SELECT                                                                 on V_OBPC_ZP_FILES to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_ZP_FILES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBPC_ZP_FILES.sql =========*** End **
PROMPT ===================================================================================== 
