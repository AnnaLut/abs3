CREATE OR REPLACE VIEW V0_SNO AS
SELECT d.vidd
      ,d.nd
      ,d.ndi
      ,d.sdate
      ,d.wdate
      ,d.sos
      ,d.rnk
      ,d.branch
      ,d.cc_id
      ,a.kv
      ,a.nls
      ,a.tip
      ,a.acc
      ,-a.ostc / 100 spn
      ,to_number(NULL) spn1
      ,(SELECT -ostc
          FROM accounts aa, nd_acc nn
         WHERE nn.nd = d.nd
           AND nn.acc = aa.acc
           AND aa.tip = 'LIM') / 100 lim
      ,NULL refp
  FROM accounts a, cc_deal d, nd_acc n
 WHERE a.acc = n.acc
   AND a.tip = 'SPN'
   AND n.nd = d.nd
   AND d.vidd IN (1, 2, 3, 11, 12, 13)
   AND a.ostc < 0
   AND a.ostc = a.ostb
   AND d.wdate > gl.bd
   AND d.branch LIKE sys_context('bars_context', 'user_branch') || '%';
