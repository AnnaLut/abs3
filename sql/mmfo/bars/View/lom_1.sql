

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/LOM_1.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view LOM_1 ***

  CREATE OR REPLACE FORCE VIEW BARS.LOM_1 ("BRANCH", "ND", "FIO", "DAT1", "DAT4", "SOS", "NLS_2202", "OST_2202", "NLS_2208", "OST_2208", "NLS_9500", "OST_9500", "NAZN") AS 
  SELECT k.branch, k.ND, k.FIO, k.dat1, k.dat4, k.sos,
         k.nls_2202, -k.ost_2202/100, k.nls_2208, -k.ost_2208/100,
         a.nls NLS_9500, -a.ostc/100  OST_9500, n.nazn
  FROM cc_accp p, accounts a, lom_nazn n,
       (SELECT d.branch, d.nd, c.nmk FIO, d.sdate DAT1, d.wdate DAT4, d.sos,
               sum(decode(a.tip,'SS ', a.acc,  0   ))  ACC_2202,
               min(decode(a.tip,'SS ', a.nls, 'not'))  nls_2202,
               sum(decode(a.tip,'SS ', a.ostc, 0   ))  ost_2202,
               min(decode(a.tip,'SN ', a.nls, 'not'))  nls_2208,
               sum(decode(a.tip,'SN ', a.ostc, 0   ))  ost_2208
       from cc_deal d, customer c, nd_acc n, accounts a
       where d.prod = '220205' and d.sos<15 and d.sos>=10 and d.wdate< gl.bd
         and d.rnk  = c.rnk
         and a.kv   = 980
         and n.nd   = d.nd
         and a.acc  = n.acc
         and a.tip in ('SS ', 'SN ')
         and a.ostc = a.ostb
         and a.ostc < 0
         and a.ostc = a.ostb
       group by d.branch, d.nd, c.nmk, d.sdate, d.wdate, d.sos) k
  where k.acc_2202 = p.accs and  a.acc= p.acc
    and n.id   = 1
    and a.kv   = 980
    and a.ostb = a.ostc and a.ostc<0 ;

PROMPT *** Create  grants  LOM_1 ***
grant FLASHBACK,SELECT,UPDATE                                                on LOM_1           to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on LOM_1           to RCC_DEAL;
grant FLASHBACK,SELECT,UPDATE                                                on LOM_1           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/LOM_1.sql =========*** End *** ========
PROMPT ===================================================================================== 
