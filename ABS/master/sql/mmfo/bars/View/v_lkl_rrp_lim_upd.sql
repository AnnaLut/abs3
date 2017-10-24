

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_LKL_RRP_LIM_UPD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_LKL_RRP_LIM_UPD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_LKL_RRP_LIM_UPD ("DAT", "USERID", "LIM", "LNO", "DAT_SYS", "FIO") AS 
  SELECT  l.DAT,l.USERID,l.LIM,l.LNO,to_char(l.DAT_SYS,'dd/mm/yyyy HH24:MI:SS') DAT_SYS,s.fio
   FROM lkl_rrp_update l, staff$base s
   WHERE l.mfo=pul.Get_Mas_Ini_Val ('DMFO') and l.USERID =s.id
   ORDER BY l.DAT_SYS desc;

PROMPT *** Create  grants  V_LKL_RRP_LIM_UPD ***
grant SELECT                                                                 on V_LKL_RRP_LIM_UPD to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_LKL_RRP_LIM_UPD.sql =========*** End 
PROMPT ===================================================================================== 
