CREATE OR REPLACE VIEW VW_ASP_DEBIT_LIST AS
select ACC, TIP, KV, NLS, NMS, OSTB, OSTC,nd
  from (SELECT a.acc,
               a.tip,
               a.kv,
               a.nls,
               a.nms,
               (a.lim + a.ostb) / 100 as ostb,
               (a.lim + a.ostc) / 100 as ostc,
               n.nd
          FROM accounts a, nd_acc n
         WHERE a.nbs < '4'
           AND a.tip IN ('SG', 'ISG', 'DEP')
           and a.acc = n.acc
           and ((a.lim + a.ostb)>0 or  (a.lim + a.ostc) >0));
