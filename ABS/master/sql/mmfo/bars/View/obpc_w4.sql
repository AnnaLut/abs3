

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OBPC_W4.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view OBPC_W4 ***

  CREATE OR REPLACE FORCE VIEW BARS.OBPC_W4 ("BRANCH", "ND", "ACC", "NLS", "KV", "OST", "CARD_ACCT", "SERV_CODE", "EXPIRY", "EXPIRY2", "RNK", "OKPO", "NMK", "STATUS", "WORKS", "W_OKPO", "W4_ACC", "W4_NLS", "W4_DAOS", "W4_DAZS", "W4_IDAT", "W4_IDAT2", "DOC_ID") AS 
  select a.branch, o.nd, a.acc, a.nls, a.kv,
       ( a.ostc
       + decode (o.acc_ovr,  null, 0, b.ostc)
       + decode (o.acc_3570, null, 0, k.ostc)
       + decode (o.acc_2208, null, 0, d.ostc) )/100 ost,
       t.card_acct, t.serv_code, t.expiry, t.expiry,
       c.rnk, c.okpo, upper(c.nmk), t.status, t.works,
       (select b.okpo from bpk_proect b, accountsw w where to_char(b.id) = w.value and w.acc = a.acc and w.tag = 'PK_PRCT') w_okpo,
       v.acc, v.nls w4_nls, v.daos, v.dazs, to_date(w.value, 'dd.mm.yyyy'), to_date(w.value, 'dd.mm.yyyy'),
       nvl2(o.acc_w4, (select 'id in (select doc_id from w4_product_doc where grp_code=''' || wp.grp_code || ''' and doc_id like ''%MIGR%'')'
                         from w4_acc wa, w4_card wc, w4_product wp
                        where wa.acc_pk = o.acc_w4 and wa.card_code = wc.code and wc.product_code = wp.code ), '1=0') doc_id  from bpk_acc o, accounts a, obpc_acct t, customer c, accounts v,
       accounts b, accounts k, accounts d, accountsw w
 where o.acc_pk = a.acc
   and a.acc = t.acc
   and a.rnk = c.rnk
   and o.acc_w4   = v.acc(+)
   and o.acc_ovr  = b.acc(+)
   and o.acc_3570 = k.acc(+)
   and o.acc_2208 = d.acc(+)
   and a.nls like '2625%'
   and a.dazs is null
   and v.acc = w.acc(+) and w.tag(+) = 'PK_IDAT'
   and a.branch like sys_context ('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  OBPC_W4 ***
grant SELECT                                                                 on OBPC_W4         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_W4         to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OBPC_W4.sql =========*** End *** ======
PROMPT ===================================================================================== 
