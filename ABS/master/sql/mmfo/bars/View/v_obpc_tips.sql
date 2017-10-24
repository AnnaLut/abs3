

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBPC_TIPS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBPC_TIPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBPC_TIPS ("OB22", "OB22_NAME", "TIP", "TIP_NAME", "FILE_CHAR") AS 
  select o.ob22, o.txt, t.tip, t.name, f.file_char
  from obpc_tips ot, sb_ob22 o, tips t, obpc_out_files f
 where ot.ob22 = o.ob22 and o.r020 = '2625'
   and ot.tip  = t.tip
   and ot.tip  = f.acc_type(+)
 ;

PROMPT *** Create  grants  V_OBPC_TIPS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_TIPS     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_OBPC_TIPS     to OBPC;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_TIPS     to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_OBPC_TIPS     to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on V_OBPC_TIPS     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBPC_TIPS.sql =========*** End *** ==
PROMPT ===================================================================================== 
