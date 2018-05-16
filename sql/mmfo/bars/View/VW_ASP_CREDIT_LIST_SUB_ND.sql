CREATE OR REPLACE VIEW VW_ASP_CREDIT_LIST_SUB_ND AS
SELECT DPLAN, FDAT, NPP, ACC, TIP, KV, NLS, NMS, OSTB, OSTC, ND, ndg
  FROM (SELECT to_date(null) dplan,
                to_date(null) FDAT,
                to_number(null) npp,
                a.acc,
                a.tip,
                a.kv,
                a.nls,
                a.nms,
                a.ostb / 100 ostb,
                a.ostc / 100 ostc,
                d.nd,
                d.ndg
           FROM accounts a, nd_acc n, cc_deal d
          WHERE a.acc = n.acc
            and d.nd = n.nd
            and d.rnk = a.rnk
            and (a.nbs < '4' and a.ostb < 0 or a.tip in ('ISG', 'SDI', 'SN8'))
            and not exists (select 1 from cc_trans where acc = a.acc)
         union all
         SELECT t.d_plan,
                t.FDAT,
                to_number(null) npp,
                a.acc,
                a.tip,
                a.kv,
                a.nls,
                a.nms,
                a.ostb / 100 ostb,
                - (t.sv - t.sz) / 100 ostc,
                d.nd,
                d.ndg
           FROM accounts a, nd_acc n, cc_trans t, cc_deal d
          WHERE /*n.nd = :nd
                                        and */
          a.acc = n.acc
       and d.nd = n.nd
       and d.rnk = a.rnk
       and (a.nbs < '4' and a.ostb < 0)
       and a.acc = t.acc
       and t.d_fakt is null
         union all
         SELECT to_date(null),
                to_date(null),
                to_number(null) npp,
                a.acc,
                a.tip,
                a.kv,
                a.nls,
                a.nms,
                a.ostb / 100 ostb,
                (a.ostc / 100 + ct.ss / 100) ostc,
                d.nd,
                d.ndg
           FROM accounts a,
                nd_acc n,
                cc_deal d,
                (select acc, sum(sv - sz) ss
                   from cc_trans
                  where d_fakt is null
                  group by acc) ct
          WHERE /*n.nd = :nd
                                        and*/
          a.acc = n.acc
       and d.nd = n.nd
       and d.rnk = a.rnk
       and exists (select 1 from cc_trans where acc = a.acc)
       and a.acc = ct.acc
       and (a.ostc / 100 + ct.ss / 100) > 0);
comment on table VW_ASP_CREDIT_LIST_SUB_ND is 'Рахунки для погашенння по субдоговорах';

GRANT SELECT ON BARS.VW_ASP_CREDIT_LIST_SUB_ND TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.V_CCK_RU TO BARSREADER_ROLE;

