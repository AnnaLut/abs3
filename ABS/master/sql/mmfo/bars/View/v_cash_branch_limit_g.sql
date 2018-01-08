

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CASH_BRANCH_LIMIT_G.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CASH_BRANCH_LIMIT_G ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CASH_BRANCH_LIMIT_G ("DAT_KAS", "DAT_LIM", "BRANCH_CODE", "BRANCH_NAME", "KV", "ISH", "L_T", "LIM_P", "LIM_M", "PERELIM_P", "PERELIM_M") AS 
  select CDAT as DAT_KAS,
       DAT_LIM,
       BRANCH,
       BRANCH_NAME,
       KV,
       ISH,
       L_T,
       LIM_P,
       LIM_M,
       greatest(ISH-LIM_P, 0) as PERELIM_P,
       greatest(ISH-LIM_M, 0) as PERELIM_M
  from ( select l.BRANCH,   -- ліміти кас
                b.NAME as BRANCH_NAME,
                l.kv,
                l.L_T,
                l.LIM_P,
                l.LIM_M,
                l.DAT_LIM,
                a.ISH,
                a.CDAT
           from CASH_BRANCH_LIMIT l,
                ( select f.CDAT,
                         v.BRANCH,
                         v.kv,
                         - sum(FOST(v.acc, f.CDAT))/100 as ISH
                    from V_GL v,
                         ( select to_date(pul.Get_Mas_Ini_Val('sFdat1'),'dd.mm.yyyy') as CDAT from DUAL ) f
                   where v.NBS in ('1001','1002','1007')
                   group by f.CDAT, v.BRANCH, v.kv
                ) a,
                BRANCH b
          where l.branch  = a.branch
            and l.kv      = a.kv
            and l.dat_lim = ( select max(dat_lim)
                                from CASH_BRANCH_LIMIT
                               where branch = l.branch
                                 and kv = l.kv
                                 and l_t = l.l_t
                                 and l_t in ( 1, 3 )
                                 and dat_lim <= a.cdat
                              )
            and l.branch = b.branch
          UNION ALL
         select a.BRANCH,   -- ліміти банкоматів
                a.NMS,
                a.KV,
                '2' as L_T,
                l.LIM_CURRENT,
                l.LIM_MAX,
                l.LIM_DATE,
                - fost(a.ACC, f.CDAT)/100 as ISH,
                f.CDAT
           from CASH_LIMITS_ATM l,
                ACCOUNTS a,
                ( select to_date(pul.Get_Mas_Ini_Val('sFdat1'),'dd.mm.yyyy') as CDAT from DUAL ) f
          where a.ACC = l.ACC
            and (l.ACC, l.LIM_DATE) in ( select ACC, max(LIM_DATE)
                                           from CASH_LIMITS_ATM
                                          where LIM_DATE <= f.CDAT
                                          group by ACC )
       );

PROMPT *** Create  grants  V_CASH_BRANCH_LIMIT_G ***
grant SELECT                                                                 on V_CASH_BRANCH_LIMIT_G to BARSREADER_ROLE;
grant SELECT                                                                 on V_CASH_BRANCH_LIMIT_G to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CASH_BRANCH_LIMIT_G to RPBN001;
grant SELECT                                                                 on V_CASH_BRANCH_LIMIT_G to START1;
grant SELECT                                                                 on V_CASH_BRANCH_LIMIT_G to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CASH_BRANCH_LIMIT_G.sql =========*** 
PROMPT ===================================================================================== 
