

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CASH_BRANCH_LIMIT_PG.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CASH_BRANCH_LIMIT_PG ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CASH_BRANCH_LIMIT_PG ("DATM", "DATX", "DAT_LIM", "DNI", "BRANCH", "KV", "ISH", "ISR", "L_T", "LIM_P", "LIM_M", "PERELIM_P", "PERELIM_M") AS 
  select DATM, DATX, DAT_LIM, DNI, BRANCH,  KV,   ISH, ISR, L_T, LIM_P, LIM_M,
       greatest(ISR-LIM_P,0) PERELIM_P, greatest(ISR-LIM_M,0)  PERELIM_M
from (select l.BRANCH, l.kv, l.L_T, l.LIM_P, l.LIM_M, l.DAT_LIM,a.DATM, a.DATX, a.DNI,
            - decode( l.L_T, 2,a.ISH_B,4, a.ISH_B, a.ISH_K)  ISH ,
            - decode( l.L_T, 2,a.ISR_B,4, a.ISR_B, a.ISR_K)  ISR
      from CASH_BRANCH_LIMIT l,
          (SELECT branch,kv,dni,ish_k,ish_b, DATM, DATX,
                 DECODE(dni,0,0,ish_k/dni) isr_k,DECODE(dni,0,0,ish_b/dni) isr_b
           FROM (SELECT branch,kv,COUNT(*) dni,SUM(ish_k) ish_k,SUM(ish_b) ish_b,
                                  min(cdat) DATM, max(cdat) DATX
                 FROM (SELECT v.branch,v.kv,f.cdat,SUM(fost(v.acc,f.cdat))/100 ish_k,
                              SUM(DECODE(nbs,'1004',fost(v.acc,f.cdat),0))/100 ish_b
                       FROM v_gl v,
                           (SELECT c.num - 1 dd, (d.dat1 + c.num - 1) cdat
                            FROM conductor c,
                                (SELECT TRUNC (TO_DATE (pul.get_mas_ini_val ('sFdat1'),'dd.mm.yyyy'), 'MM' ) dat1 FROM DUAL) d
                            where to_char( d.dat1,'yyyymm') = to_char((d.dat1 + c.num - 1),'yyyymm')
                            ) f
                       WHERE v.nbs IN ('1001', '1002', '1004', '1007')
                       GROUP BY v.branch, v.kv, f.cdat
                       )
                 GROUP BY branch, kv
                 )
           ) a
      where a.branch = l.branch and a.kv=l.kv and l.dat_lim =
           (select max(dat_lim)  from CASH_BRANCH_LIMIT
            where BRANCH=l.branch and kv=l.kv  and L_T=l.l_t)
     );

PROMPT *** Create  grants  V_CASH_BRANCH_LIMIT_PG ***
grant SELECT                                                                 on V_CASH_BRANCH_LIMIT_PG to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CASH_BRANCH_LIMIT_PG to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CASH_BRANCH_LIMIT_PG.sql =========***
PROMPT ===================================================================================== 
