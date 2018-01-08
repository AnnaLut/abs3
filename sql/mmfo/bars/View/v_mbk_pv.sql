

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBK_PV.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBK_PV ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBK_PV ("ND", "PV") AS 
  select e.ND,
       round( SUM( m.S/POWER((1+e.IR/100), (m.FDAT - TO_DATE (pul.get_mas_ini_val('sFdat1'),'dd.mm.yyyy'))/ 365) )
             ,0) /100 PV
FROM test_many_mbk m, cc_deal e
WHERE e.nd = m.ND AND m.fdat >= TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy')
  and e.vidd >1500 and e.vidd < 1600  and Dat_Next_U (e.sdate, 1) < e.wdate group by e.nd ;

PROMPT *** Create  grants  V_MBK_PV ***
grant SELECT                                                                 on V_MBK_PV        to BARSREADER_ROLE;
grant SELECT                                                                 on V_MBK_PV        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBK_PV.sql =========*** End *** =====
PROMPT ===================================================================================== 
