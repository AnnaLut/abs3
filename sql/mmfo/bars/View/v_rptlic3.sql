

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RPTLIC3.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RPTLIC3 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RPTLIC3 ("SRT", "DKSRT", "VOBSRT", "MFO", "NB", "FDAT", "TIP", "ACC", "NLS", "KV", "NMS", "OKPO", "NMK", "ISP", "DAPP", "OSTF", "OSTFQ", "REF", "S", "SQ", "DOSS", "KOSS", "DOSSQ", "KOSSQ", "NLS2", "MFO2", "NB2", "NMK2", "OKPO2", "DK", "ND", "TT", "NAZN", "DATD", "BIS", "BRANCH", "DOSR", "KOSR", "OSTFR", "GRPLIST", "VOB", "ROW_TYPE", "PAYDATE", "D_REC") AS 
  select nvl(srt,'2')   srt,
       nvl(dksrt,'1') dksrt,
       decode (vob, 96, 2, 99, 2, 1 )  vobsrt,
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
       o.ostf/100   ostf,
       o.ostfq/100  ostfq,
       ref,
       nvl(s/100    ,0) s,
       nvl(sq/100   ,0) sq,
       nvl(doss/100 ,0) doss,
       nvl(koss/100 ,0) koss,
       nvl(dossq/100,0) dossq,
       nvl(kossq/100,0) kossq,
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
       dosr/100  dosr,
       kosr/100  kosr,
       ostfr/100 ostfr,
       grplist,
       vob,
       o.rowtype  row_type,
       paydate,
       d_rec
  from
      (
       -----
       -- строка с параметрами счета, параметрами его контрагента
       -- и платежками
       -----
      select '2' srt,
             -- 1 - платежные,  2 - информационные запросы
             case when bis =0 or bis=1 then
                     decode(dk, 0, 1,  3,  2,  dk)
                  else
                     1  --все бисы касаютс€ только платежнх док-тов.
             end dksrt,
             fdat,
             acc,
             t.ref,
	     s             s,
             sq            sq,
             decode(sign(s),  -1,  decode(bis, 0,  s, 1,  s,0), 0)   doss,
             decode(sign(s),   1,  decode(bis, 0,  s, 1,  s,0), 0)   koss,
             decode(sign(sq), -1,  decode(bis, 0, sq, 1, sq,0), 0)   dossq,
             decode(sign(sq),  1,  decode(bis, 0, sq, 1, sq,0), 0)   kossq,
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
             nvl(o.dat, (select to_date(to_char(gl.bd,'ddmmyyyy')||to_char(pdat,'hh24:mi:ss'),'ddmmyyyyhh24:mi:ss')
                           from oper where ref = t.ref))  paydate,
             d_rec,
             0   dosr,
             0   kosr,
             0   ostfr,
             rowtype
        from tmp_licm t, (select dat, ref
                            from oper_visa o
                           where groupid not in (77,80,81,30) and status = 2) o
       where rowtype = bars_rptlic.rowtype_doc
         and t.ref = o.ref(+)
       union all
       ----
       -- строка с параметрами счета, параметрами его контрагента
       -- дл€ сбербанка: со вход€щим переоцененным осттаком, а также суммой переоцененных оборотов з отчетный период
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
             null paydate,
             null d_rec,
             dosr,
             kosr,
             ostfr,
             rowtype
        from ( select rowtype, acc, kv,  fdat, ostfr, branch, sum(dosr) over (partition by acc) dosr, sum(kosr) over(partition by acc) kosr
                 from tmp_licm
                where rowtype = bars_rptlic.rowtype_rev
             )
       where fdat = (select min(fdat) from tmp_licm)
    ) t,
    (-- выт€гиваем вход€щий остаток, на первый день указанного отчетного периода
     select acc, tip,
            sys_context('bars_context','user_mfo') mfo,
            (select val from params where par = 'NAME') nb,
            nls, kv, nms, okpo, nmk, isp,
            dapp, ostf, ostfq, grplist,
            rowtype
       from tmp_licm
      where (fdat, acc) in (select min(fdat), acc
                              from tmp_licm
                             where rowtype = bars_rptlic.rowtype_acc
                             group by acc
                           )
        and rowtype = bars_rptlic.rowtype_acc
    ) o
   where o.acc = t.acc(+);

PROMPT *** Create  grants  V_RPTLIC3 ***
grant SELECT                                                                 on V_RPTLIC3       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_RPTLIC3       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RPTLIC3.sql =========*** End *** ====
PROMPT ===================================================================================== 
