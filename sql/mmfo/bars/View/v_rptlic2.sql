CREATE OR REPLACE VIEW V_RPTLIC2 AS
SELECT NVL (srt, '2') srt,
          NVL (dksrt, '1') dksrt,
          DECODE (vob,  96, 2,  99, 2,  1) vobsrt,
          mfo,
          nb,
          o.fdat,
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
          grplist,
          vob,
          paydate,
          nlsalt
     FROM (                                                              -----
                    -- строка с параметрами счета, параметрами его контрагента
                                                               -- и платежками
                                                                         -----
          SELECT '2' srt,
                 DECODE (dk,  0, 1,  3, 2,  dk) dksrt,
                 fdat,
                 acc,
                 t.REF,
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
                 NVL (o.dat,
                      (SELECT pdat
                         FROM oper
                        WHERE REF = t.REF))
                    paydate,
                 dosr / 100 dosr,
                 kosr / 100 kosr,
                 ostfr / 100 ostfr
            FROM tmp_licm t,
                 (SELECT dat, REF
                    FROM oper_visa o
                   WHERE     groupid NOT IN (77,
                                             80,
                                             81,
                                             30)
                         AND status = 2) o
           WHERE ROWTYPE = bars_rptlic.rowtype_doc AND t.REF = o.REF(+)
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
                 NULL paydate,
                 dosr / 100,
                 kosr / 100,
                 ostfr / 100
            FROM tmp_licm
           WHERE ROWTYPE = bars_rptlic.rowtype_rev) t,
          ( -- выт€гиваем вход€щий остаток, на первый день указанного отчетного периода
           SELECT acc,
                  tip,
                  fdat,
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
                  dapp,
                  ostf,
                  ostfq,
                  grplist,
                  nlsalt
             FROM tmp_licm
            WHERE ROWTYPE = bars_rptlic.rowtype_acc) o
    WHERE o.acc = t.acc(+) AND o.fdat = t.fdat(+)
;
