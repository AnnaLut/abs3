--КП ЮО - робочий  10.10.2017 Суб.угоди по одному КД 

CREATE OR REPLACE FORCE VIEW BARS.V_CCK_RU0 AS
 select x.*, to_number (( SELECT txt FROM bars.nd_txt WHERE  nd = x.ndG AND tag = 'PR_TR') ) PR_TR ,
             (select nmk from customer where rnk = x.RNK) NMK 
 FROM (SELECT d.CC_ID, d.nd, d.ndi, d.ndg, a.RNK, a.nls, -a.ostc / 100 SS, a.acc, a.kv, a.daos, a.mdate, a.dazs, acrn.fprocn (a.acc, 0, gl.bd) pr, d.sos, a.accc ACC8,
              (SELECT -a1.ostc / 100    FROM accounts a1, nd_acc n1   WHERE a1.tip = 'SP ' AND a1.acc = n1.acc AND n1.nd = d.nd)  SP,
              (SELECT -a1.ostc / 100    FROM accounts a1, nd_acc n1   WHERE a1.tip = 'SN ' AND a1.acc = n1.acc AND n1.nd = d.nd)  SN,
              (SELECT -a1.ostc / 100    FROM accounts a1, nd_acc n1   WHERE a1.tip = 'SPN' AND a1.acc = n1.acc AND n1.nd = d.nd)  SPN,
              (SELECT -a1.ostc / 100    FROM accounts a1, nd_acc n1   WHERE a1.tip = 'SDI' AND a1.acc = n1.acc AND n1.nd = d.nd)  SDI,
              (SELECT -a1.ostc / 100    FROM accounts a1, nd_acc n1   WHERE a1.tip = 'SNA' AND a1.acc = n1.acc AND n1.nd = d.nd)  SNA,
              (SELECT SUM(-a1.ostc)/100 FROM accounts a1, nd_acc n1   WHERE a1.tip = 'SNO' AND a1.acc = n1.acc AND n1.nd = d.nd)  SNO
       FROM bars.cc_deal d, bars.nd_acc n, bars.accounts a
       WHERE d.NDG = TO_NUMBER (pul.Get ('NDG')) AND d.nd <> d.ndG AND d.nd = n.nd AND n.acc = a.acc AND a.tip = 'LIM' 
) x;


GRANT SELECT ON BARS.V_CCK_RU0 TO BARS_ACCESS_DEFROLE;