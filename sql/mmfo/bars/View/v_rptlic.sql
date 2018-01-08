

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RPTLIC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RPTLIC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RPTLIC ("SRT", "DKSRT", "VOBSRT", "MFO", "NB", "FDAT", "TIP", "ACC", "NLS", "NLSALT", "KV", "NMS", "OKPO", "NMK", "ISP", "DAPP", "OSTF", "OSTFQ", "REF", "S", "SQ", "DOSS", "KOSS", "DOSSQ", "KOSSQ", "NLS2", "MFO2", "NB2", "NMK2", "OKPO2", "DK", "ND", "TT", "NAZN", "DATD", "BIS", "BRANCH", "DOSR", "KOSR", "OSTFR", "GRPLIST") AS 
  select nvl(srt,'2')   srt,
       nvl(dksrt,'1') dksrt,
       decode (vob, 96, 2, 99, 2, 1 )  vobsrt,
       mfo,
       nb,
       fdat,
       tip,
       o.acc,
       nls,
       nlsalt,
       kv,
       nms,
       okpo,
       nmk,
       isp,
       dapp,
       o.ostf/100   ostf,
       o.ostfq/100  ostfq,
       ref,
       nvl(s,   0)  s,
       nvl(sq,  0)  sq,
       nvl(doss,0)  doss,
       nvl(koss,0)  koss,
       nvl(dossq,0) dossq,
       nvl(kossq,0) kossq,
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
  from
      (
       -----
       -- строка с параметрами счета, параметрами его контрагента
       -- и платежками
       -----
      select '2' srt,
             decode(dk, 0, 1,  3,  2,  dk)  dksrt,
             fdat,
             acc,
             ref,
       s/100             s,
             sq/100            sq,
             decode(sign(s),  -1,  decode(bis, 0,  s/100, 1,  s/100,0), 0)   doss,
             decode(sign(s),   1,  decode(bis, 0,  s/100, 1,  s/100,0), 0)   koss,
             decode(sign(sq), -1,  decode(bis, 0, sq/100, 1, sq/100,0), 0)   dossq,
             decode(sign(sq),  1,  decode(bis, 0, sq/100, 1, sq/100,0), 0)   kossq,
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
             0   dosr,
             0   kosr,
             0   ostfr
        from tmp_licm
       where rowtype = bars_rptlic.rowtype_doc
       union all
       ----
       -- строка с параметрами счета, параметрами его контрагента
       -- для сбербанка: со входящим переоцененным осттаком, а также суммой переоцененных оборотов з отчетный период
       ----
      select '3' srt,
             0 dksrt,
             fdat,
             acc,
             (case when (dosr<>0 or kosr<>0) then 0 else null end)  ref,
       0       s,
             0       sq,
             0       doss,
             0       koss,
             0       dossq,
             0       kossq,
             null    nls2,
             null    mfo2,
             null    nb2,
             null    nmk2,
             null    okpo2,
             null    dk,
             null    nd,
             null    tt,
             null    nazn,
             null    datd,
             0       bis,
             0       vob,
             branch,
             dosr/100,
             kosr/100,
             ostfr/100
        from ( select acc, kv,  fdat, ostfr, branch, sum(dosr) over (partition by acc) dosr, sum(kosr) over(partition by acc) kosr
                 from tmp_licm
                where rowtype = bars_rptlic.rowtype_rev
             )
       where fdat = (select min(fdat) from tmp_licm)
    ) t,
    (-- вытягиваем входящий остаток, на первый день указанного отчетного периода
     select acc, tip,
            sys_context('bars_context','user_mfo') mfo,
            (select val from params where par = 'NAME') nb,
            nls, kv, nms, nlsalt, okpo, nmk, isp, dapp, ostf, ostfq, grplist
       from tmp_licm
      where (fdat, acc) in (select min(fdat), acc
                              from tmp_licm
                             where rowtype = bars_rptlic.rowtype_acc
                             group by acc
                           )
        and rowtype = bars_rptlic.rowtype_acc
    ) o
   where o.acc = t.acc(+);

PROMPT *** Create  grants  V_RPTLIC ***
grant SELECT                                                                 on V_RPTLIC        to ABS_ADMIN;
grant SELECT                                                                 on V_RPTLIC        to BARSREADER_ROLE;
grant SELECT                                                                 on V_RPTLIC        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_RPTLIC        to RPBN001;
grant SELECT                                                                 on V_RPTLIC        to TASK_LIST;
grant SELECT                                                                 on V_RPTLIC        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RPTLIC.sql =========*** End *** =====
PROMPT ===================================================================================== 
