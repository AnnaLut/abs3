

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_TOTALS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_TOTALS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_TOTALS ("KF", "TYPE_NAME", "NBS", "CCY_CODE", "BRANCH", "USER_NM", "DEP_BAL_INPT", "DEP_BAL_INPT_UAH", "DEP_DOS", "DEP_KOS", "DEP_BAL_OTPT", "DEP_BAL_OTPT_UAH", "INT_BAL_INPT", "INT_DOS", "INT_KOS", "INT_BAL_OTPT", "AC_INPT_QTY", "AC_OPN_QTY", "AC_CLS_QTY", "AC_OTPT_QTY", "RATE_AVG_INPT", "RATE_AVG_OTPT", "RATE_AVG_INPT_UAH", "RATE_AVG_OTPT_UAH", "MASK_GRP_SET", "START_RPT_DT", "FINISH_RPT_DT") AS 
  SELECT d.KF,
            p.TYPE_NAME,
            PS.NBS,
            T.LCV AS CCY_CODE,
            d.BRANCH,
            u.FIO AS USER_NM,
            SUM (d.flsum * (d.ost + d.dos - d.kos)) / 100 AS DEP_BAL_INPT,
            SUM (d.flsum * (d.ostq + d.dosQ - d.kosQ)) / 100
               AS DEP_BAL_INPT_UAH,
            SUM (d.flsum * d.dos) / 100 AS DEP_DOS,
            SUM (d.flsum * d.kos) / 100 AS DEP_KOS,
            SUM (d.flsum * d.ost) / 100 AS DEP_BAL_OTPT,
            SUM (d.flsum * d.ostq) / 100 AS DEP_BAL_OTPT_UAH,
              SUM (
                   d.flsum
                 * (  fost (i.acra, DPT_RPT_UTIL.get_finish_dt)
                    + fdos (i.acra,
                            DPT_RPT_UTIL.get_start_dt,
                            DPT_RPT_UTIL.get_finish_dt)
                    - fkos (i.acra,
                            DPT_RPT_UTIL.get_start_dt,
                            DPT_RPT_UTIL.get_finish_dt)))
            / 100
               AS INT_BAL_INPT,
              SUM (
                   d.flsum
                 * fdos (i.acra,
                         DPT_RPT_UTIL.get_start_dt,
                         DPT_RPT_UTIL.get_finish_dt))
            / 100
               AS INT_DOS,
              SUM (
                   d.flsum
                 * fkos (i.acra,
                         DPT_RPT_UTIL.get_start_dt,
                         DPT_RPT_UTIL.get_finish_dt))
            / 100
               AS INT_KOS,
            SUM (d.flsum * fost (i.acra, DPT_RPT_UTIL.get_finish_dt)) / 100
               AS INT_BAL_OTPT,
            SUM (d.flsum * d.cnt1) AS AC_INPT_QTY,
            SUM (d.flsum * d.cnt2) AS AC_OPN_QTY,
            SUM (d.flsum * d.cnt3) AS AC_CLS_QTY,
              SUM (d.flsum * d.cnt1)
            + SUM (d.flsum * d.cnt2)
            - SUM (d.flsum * d.cnt3)
               AS AC_OYPT_QTY,
            SUM (d.rate1 * d.flsum * (d.ost + d.dos - d.kos)) / 100
               AS RATE_AVG_INPT,
            SUM (d.rate2 * d.flsum * (d.ost)) / 100 AS RATE_AVG_OTPT,
            SUM (d.rate1 * d.flsum * (d.ostQ + d.dosQ - d.kosQ)) / 100
               AS RATE_AVG_INPT_UAH,
            SUM (d.rate2 * d.flsum * (d.ostQ)) / 100 AS RATE_AVG_OTPT_UAH,
            BIN_TO_NUM (GROUPING (u.FIO),
                        GROUPING (D.BRANCH),
                        GROUPING (T.LCV),
                        GROUPING (PS.NBS),
                        GROUPING (p.TYPE_NAME),
                        GROUPING (d.KF))
               AS MASK_GRP_SET,
            DPT_RPT_UTIL.get_start_dt,
            DPT_RPT_UTIL.get_finish_dt
       FROM (SELECT d.kf,
                    d.acc,
                    d.branch,
                    d.VIDD,
                    v.TYPE_ID,
                    v.KV,
                    a.isp,
                    a.nbs,
                    d.limit flsum,
                    NVL (acrn.fproc (a.acc, DPT_RPT_UTIL.get_start_dt), 0)
                       rate1,
                    NVL (acrn.fproc (a.acc, DPT_RPT_UTIL.get_finish_dt), 0)
                       rate2,
                    fdos (a.acc,
                          DPT_RPT_UTIL.get_start_dt,
                          DPT_RPT_UTIL.get_finish_dt)
                       dos,
                    fkos (a.acc,
                          DPT_RPT_UTIL.get_start_dt,
                          DPT_RPT_UTIL.get_finish_dt)
                       kos,
                    fost (a.acc, DPU_RPT_UTIL.get_finish_dt) ost,
                    fdosN (a.kv,
                           a.acc,
                           DPT_RPT_UTIL.get_start_dt,
                           DPT_RPT_UTIL.get_finish_dt)
                       dosq,
                    fkosN (a.kv,
                           a.acc,
                           DPT_RPT_UTIL.get_start_dt,
                           DPT_RPT_UTIL.get_finish_dt)
                       kosq,
                    gl.p_icurval (a.kv,
                                  fost (a.acc, DPT_RPT_UTIL.get_finish_dt),
                                  DPT_RPT_UTIL.get_finish_dt)
                       ostq,
                    CASE
                       WHEN a.daos < DPT_RPT_UTIL.get_start_dt THEN 1
                       ELSE 0
                    END
                       AS cnt1,
                    CASE
                       WHEN     a.daos >= DPT_RPT_UTIL.get_start_dt
                            AND a.daos <= DPT_RPT_UTIL.get_finish_dt
                       THEN
                          1
                       ELSE
                          0
                    END
                       AS cnt2,
                    CASE
                       WHEN     a.dazs >= DPT_RPT_UTIL.get_start_dt
                            AND a.dazs <= DPT_RPT_UTIL.get_finish_dt
                       THEN
                          1
                       ELSE
                          0
                    END
                       AS cnt3
               FROM BARS.dpt_deposit d
                    JOIN BARS.DPt_VIDD v ON (v.VIDD = d.VIDD)
                    JOIN BARS.ACCOUNTS a ON (d.ACC = a.ACC)
              WHERE a.dazs IS NULL OR a.dazs >= DPT_RPT_UTIL.get_start_dt) d
            JOIN BARS.DPT_TYPES p ON (p.TYPE_ID = d.TYPE_ID)
            JOIN BARS.STAFF$BASE u ON (u.id = d.ISP)
            JOIN BARS.TABVAL$GLOBAL t ON (t.kv = d.KV)
            JOIN BARS.PS ON (ps.nbs = d.nbs)
            JOIN BARS.INT_ACCN i ON (i.acc = d.acc AND i.id = 1)
      WHERE ps.xar = 22
   GROUP BY CUBE (d.KF,
                  p.TYPE_NAME,
                  PS.NBS,
                  t.LCV,
                  D.BRANCH,
                  u.FIO);

PROMPT *** Create  grants  V_DPT_TOTALS ***
grant SELECT                                                                 on V_DPT_TOTALS    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_TOTALS.sql =========*** End *** =
PROMPT ===================================================================================== 
