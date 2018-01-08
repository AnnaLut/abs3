

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_TOTALS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_TOTALS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_TOTALS ("KF", "TYPE_NAME", "NBS", "CCY_CODE", "BRANCH", "USER_NM", "DEP_BAL_INPT", "DEP_BAL_INPT_UAH", "DEP_DOS", "DEP_KOS", "DEP_BAL_OTPT", "DEP_BAL_OTPT_UAH", "INT_BAL_INPT", "INT_DOS", "INT_KOS", "INT_BAL_OTPT", "AC_INPT_QTY", "AC_OPN_QTY", "AC_CLS_QTY", "AC_OTPT_QTY", "RATE_AVG_INPT", "RATE_AVG_OTPT", "RATE_AVG_INPT_UAH", "RATE_AVG_OTPT_UAH", "MASK_GRP_SET", "START_RPT_DT", "FINISH_RPT_DT") AS 
  select d.KF
     , p.TYPE_NAME
     , PS.NBS
     , T.LCV                                         as CCY_CODE
     , d.BRANCH
     , u.FIO                                         as USER_NM
     , sum(d.flsum * (d.ost  + d.dos  - d.kos ))/100 as DEP_BAL_INPT
     , sum(d.flsum * (d.ostq + d.dosQ - d.kosQ))/100 as DEP_BAL_INPT_UAH
     , sum(d.flsum * d.dos )/100                     as DEP_DOS
     , sum(d.flsum * d.kos )/100                     as DEP_KOS
     , sum(d.flsum * d.ost )/100                     as DEP_BAL_OTPT
     , sum(d.flsum * d.ostq)/100                     as DEP_BAL_OTPT_UAH
     , sum(d.flsum * (fost(i.acra, DPU_RPT_UTIL.get_finish_dt)
                   + fdos( i.acra, DPU_RPT_UTIL.get_start_dt, DPU_RPT_UTIL.get_finish_dt)
                   - fkos( i.acra, DPU_RPT_UTIL.get_start_dt, DPU_RPT_UTIL.get_finish_dt)))/100 as INT_BAL_INPT
     , sum(d.flsum * fdos( i.acra, DPU_RPT_UTIL.get_start_dt, DPU_RPT_UTIL.get_finish_dt) )/100 as INT_DOS
     , sum(d.flsum * fkos( i.acra, DPU_RPT_UTIL.get_start_dt, DPU_RPT_UTIL.get_finish_dt) )/100 as INT_KOS
     , sum(d.flsum * fost( i.acra, DPU_RPT_UTIL.get_finish_dt)                       )/100 as INT_BAL_OTPT
     , sum(d.flcnt * d.cnt1)                                   as AC_INPT_QTY
     , sum(d.flcnt * d.cnt2)                                   as AC_OPN_QTY
     , sum(d.flcnt * d.cnt3)                                   as AC_CLS_QTY
     , sum(d.flcnt * d.cnt1) + sum(d.flcnt * d.cnt2)
                             - sum(d.flcnt * d.cnt3)           as AC_OYPT_QTY
     , sum(d.rate1 * d.flsum * (d.ost  + d.dos  - d.kos ))/100 as RATE_AVG_INPT
     , sum(d.rate2 * d.flsum * (d.ost                   ))/100 as RATE_AVG_OTPT
     , sum(d.rate1 * d.flsum * (d.ostQ + d.dosQ - d.kosQ))/100 as RATE_AVG_INPT_UAH
     , sum(d.rate2 * d.flsum * (d.ostQ                  ))/100 as RATE_AVG_OTPT_UAH
     , BIN_TO_NUM( GROUPING(u.FIO), GROUPING(D.BRANCH), GROUPING(T.LCV), GROUPING(PS.NBS), GROUPING(p.TYPE_NAME), GROUPING(d.KF) ) as MASK_GRP_SET
     , DPU_RPT_UTIL.get_start_dt
     , DPU_RPT_UTIL.get_finish_dt
  FROM ( SELECT d.kf, d.acc, d.branch, d.VIDD, v.TYPE_ID, v.KV
              , a.isp, a.nbs,
                decode(nvl(d.dpu_add, 1), 0, 0, 1) flsum, -- транші   лінії + звичайні
                decode(nvl(d.dpu_add, 0), 0, 1, 0) flcnt, -- ген.дог. лінії + звичайні
                nvl(acrn.fproc(a.acc, DPU_RPT_UTIL.get_start_dt),  0) rate1,
                nvl(acrn.fproc(a.acc, DPU_RPT_UTIL.get_finish_dt), 0) rate2,
                fdos(a.acc, DPU_RPT_UTIL.get_start_dt, DPU_RPT_UTIL.get_finish_dt) dos,
                fkos(a.acc, DPU_RPT_UTIL.get_start_dt, DPU_RPT_UTIL.get_finish_dt) kos,
                fost(a.acc, DPU_RPT_UTIL.get_finish_dt) ost,
                fdosN(a.kv, a.acc, DPU_RPT_UTIL.get_start_dt, DPU_RPT_UTIL.get_finish_dt) dosq,
                fkosN(a.kv, a.acc, DPU_RPT_UTIL.get_start_dt, DPU_RPT_UTIL.get_finish_dt) kosq,
                gl.p_icurval(a.kv, fost(a.acc, DPU_RPT_UTIL.get_finish_dt), DPU_RPT_UTIL.get_finish_dt) ostq,
                case when a.daos <  DPU_RPT_UTIL.get_start_dt  then 1 else 0 end as cnt1,
                case when a.daos >= DPU_RPT_UTIL.get_start_dt
                      and a.daos <= DPU_RPT_UTIL.get_finish_dt then 1 else 0 end as cnt2,
                case when a.dazs >= DPU_RPT_UTIL.get_start_dt
                      and a.dazs <= DPU_RPT_UTIL.get_finish_dt then 1 else 0 end as cnt3
           from BARS.DPU_DEAL d
           join BARS.DPU_VIDD v
             on ( v.VIDD = d.VIDD )
           join BARS.ACCOUNTS a
             on ( d.ACC  = a.ACC )
          where a.dazs IS NULL
             or a.dazs >= DPU_RPT_UTIL.get_start_dt
     ) d
  join BARS.DPU_TYPES p
    on ( p.TYPE_ID = d.TYPE_ID )
  join BARS.STAFF$BASE u
    on ( u.id = d.ISP )
  join BARS.TABVAL$GLOBAL t
    on ( t.kv = d.KV )
  join BARS.PS
    on ( ps.nbs = d.nbs )
  join BARS.INT_ACCN i
    on ( i.acc = d.acc AND i.id = 1 )
 WHERE ps.xar = 22
 GROUP BY CUBE ( d.KF, p.TYPE_NAME, PS.NBS, t.LCV, D.BRANCH, u.FIO )
;

PROMPT *** Create  grants  V_DPU_TOTALS ***
grant SELECT                                                                 on V_DPU_TOTALS    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_TOTALS.sql =========*** End *** =
PROMPT ===================================================================================== 
