

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_AUTO.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_AUTO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_AUTO ("OP_REF", "OP_NAZN", "OP_NAMA", "OP_NAMB", "A_ACC_NBS", "A_OP_ACC", "A_ACC_NLS", "A_ACC_KV", "A_ACC_DAOS", "A_OP_SUM", "A_OP_DK", "A_OP_FDAT", "A_CUST_RNK", "A_CUST_CUSTTYPE", "A_CUST_DATEON", "A_CUST_VED", "B_ACC_NBS", "B_OP_ACC", "B_ACC_NLS", "B_ACC_KV", "B_ACC_DAOS", "B_OP_SUM", "B_OP_DK", "B_OP_FDAT", "B_CUST_RNK", "B_CUST_CUSTTYPE", "B_CUST_DATEON", "B_CUST_VED") AS 
  select o.ref, o.nazn, o.nam_a, o.nam_b,
       aa.nbs, aa.acc, aa.nls, aa.kv, aa.daos,
       pa.s, pa.dk, pa.fdat,
       ca.rnk, ca.custtype, ca.date_on, ca.ved,
       ab.nbs, ab.acc, ab.nls, ab.kv, ab.daos,
       pb.s, pb.dk, pb.fdat,
       cb.rnk, cb.custtype, cb.date_on, cb.ved
FROM oper o,
     opldok pa, accounts aa, customer ca,
     opldok pb, accounts ab, customer cb
WHERE o.sos   = 5
  and o.ref   = pa.ref
  and pa.acc  = aa.acc
  and aa.rnk  = ca.rnk
  and pa.dk   = 0
  and pb.dk   = 1
  and pa.fdat = bankdate
  and pa.ref  = pb.ref
  and pa.stmt = pb.stmt
  and pb.acc  = ab.acc
  and ab.rnk  = cb.rnk
  and not exists (select 1 from finmon_que where ref=o.ref)
 ;

PROMPT *** Create  grants  V_FM_AUTO ***
grant SELECT                                                                 on V_FM_AUTO       to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_AUTO       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_FM_AUTO       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_AUTO.sql =========*** End *** ====
PROMPT ===================================================================================== 
