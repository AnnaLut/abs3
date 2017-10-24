

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RPTLIC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RPTLIC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RPTLIC ("SRT", "DKSRT", "VOBSRT", "MFO", "NB", "FDAT", "TIP", "ACC", "NLS", "KV", "NMS", "OKPO", "NMK", "ISP", "DAPP", "OSTF", "OSTFQ", "REF", "S", "SQ", "DOSS", "KOSS", "DOSSQ", "KOSSQ", "NLS2", "MFO2", "NB2", "NMK2", "OKPO2", "DK", "ND", "TT", "NAZN", "DATD", "BIS", "BRANCH", "DOSR", "KOSR", "OSTFR", "GRPLIST") AS 
  SELECT NVL (srt, '2') srt,
          NVL (dksrt, '1') dksrt,
          DECODE (vob,  96, 2,  99, 2,  1) vobsrt,
          mfo,
          nb,
          fdat,
          tip,
          o.acc,
          nls,
          kv,
          nms,
          okpo,
          nmk,
          isp,
          dapp,
          o.ostf / 100 ostf,
          o.ostfq / 100 ostfq,
          REF,
          NVL (s, 0) s,
          NVL (sq, 0) sq,
          NVL (doss, 0) doss,
          NVL (koss, 0) koss,
          NVL (dossq, 0) dossq,
          NVL (kossq, 0) kossq,
          nls2,
          mfo2,
          nb2,
          nmk2,
          okpo2,
          dk,
          nd,
          tt,
          nazn,
          datd,
          bis,
          branch,
          dosr,
          kosr,
          ostfr,
          grplist
     FROM (                                                              -----
           -- строка с параметрами счета, параметрами его контрагента
           -- и платежками
           -----
           SELECT '2' srt,
                  DECODE (dk,  0, 1,  3, 2,  dk) dksrt,
                  fdat,
                  acc,
                  REF,
                  s / 100 s,
                  sq / 100 sq,
                  DECODE (SIGN (s),
                          -1, DECODE (bis,  0, s / 100,  1, s / 100,  0),
                          0)
                     doss,
                  DECODE (SIGN (s),
                          1, DECODE (bis,  0, s / 100,  1, s / 100,  0),
                          0)
                     koss,
                  DECODE (SIGN (sq),
                          -1, DECODE (bis,  0, sq / 100,  1, sq / 100,  0),
                          0)
                     dossq,
                  DECODE (SIGN (sq),
                          1, DECODE (bis,  0, sq / 100,  1, sq / 100,  0),
                          0)
                     kossq,
                  nls2,
                  mfo2,
                  nb2,
                  nmk2,
                  okpo2,
                  dk,
                  nd,
                  tt,
                  nazn,
                  datd,
                  bis,
                  vob,
                  branch,
                  0 dosr,
                  0 kosr,
                  0 ostfr
             FROM tmp_licm
            WHERE ROWTYPE = bars_rptlic.rowtype_doc
           UNION ALL
           ----
           -- строка с параметрами счета, параметрами его контрагента
           -- дл€ сбербанка: со вход€щим переоцененным осттаком, а также суммой переоцененных оборотов з отчетный период
           ----
           SELECT '3' srt,
                  0 dksrt,
                  fdat,
                  acc,
                  (CASE WHEN (dosr <> 0 OR kosr <> 0) THEN 0 ELSE NULL END)
                     REF,
                  0 s,
                  0 sq,
                  0 doss,
                  0 koss,
                  0 dossq,
                  0 kossq,
                  NULL nls2,
                  NULL mfo2,
                  NULL nb2,
                  NULL nmk2,
                  NULL okpo2,
                  NULL dk,
                  NULL nd,
                  NULL tt,
                  NULL nazn,
                  NULL datd,
                  0 bis,
                  0 vob,
                  branch,
                  dosr / 100,
                  kosr / 100,
                  ostfr / 100
             FROM (SELECT acc,
                          kv,
                          fdat,
                          ostfr,
                          branch,
                          SUM (dosr) OVER (PARTITION BY acc) dosr,
                          SUM (kosr) OVER (PARTITION BY acc) kosr
                     FROM tmp_licm
                    WHERE ROWTYPE = bars_rptlic.rowtype_rev)
            WHERE fdat = (SELECT MIN (fdat) FROM tmp_licm)) t,
          ( -- выт€гиваем вход€щий остаток, на первый день указанного отчетного периода
           SELECT t0.acc,
                  tip,
                  SYS_CONTEXT ('bars_context', 'user_mfo') mfo,
                  (SELECT val
                     FROM params
                    WHERE par = 'NAME')
                     nb,
                  nls,
                  kv,
                  nms,
                  okpo,
                  nmk,
                  isp,
                  t0.dapp,
                  ostf,
                  ostfq,
                  grplist
             FROM tmp_licm t0
            WHERE     (fdat, t0.acc) IN
                         (  SELECT MIN (fdat), acc
                              FROM tmp_licm
                             WHERE ROWTYPE = bars_rptlic.rowtype_acc
                          GROUP BY acc)
                  AND ROWTYPE = bars_rptlic.rowtype_acc
                  ) o
    WHERE o.acc = t.acc(+);

PROMPT *** Create  grants  V_RPTLIC ***
grant SELECT                                                                 on V_RPTLIC        to ABS_ADMIN;
grant SELECT                                                                 on V_RPTLIC        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_RPTLIC        to RPBN001;
grant SELECT                                                                 on V_RPTLIC        to TASK_LIST;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RPTLIC.sql =========*** End *** =====
PROMPT ===================================================================================== 
