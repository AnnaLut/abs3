

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_FOUND_PAYMENTS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_FOUND_PAYMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_FOUND_PAYMENTS ("REF", "CUST_RNK", "CUST_OKPO", "CUST_NMK", "CUST_ND", "BENEF_NMK", "ACC", "NLS", "PDAT", "PLAN_VDAT", "VDAT", "KV", "TOTAL_SUM", "UNBOUND_SUM", "NAZN", "OP_TYPE_ID", "OP_TYPE", "PAY_TYPE", "PAY_TYPE_NAME", "IS_VISED", "TT", "DIRECT", "DIRECT_NAME") AS 
  select o.ref, c.rnk, c.okpo, c.nmk, c.nd, decode(o.direct, 0, o.nam_a, o.nam_b), a.acc, a.nls, o.pdat, o.vdat,
       (select max(fdat) from opldok where ref=o.ref),
       o.kv, o.s/100, (o.s-cim_mgr.get_payments_bound_sum(o.ref))/100, o.nazn,
       (select to_number(value) from operw where tag='CIMTO' and ref = o.ref),
       (select type_name from cim_operation_types
                        where type_id = (select to_number(value) from operw where tag='CIMTO' and ref = o.ref)),
       0, (select type_name from cim_payment_types where type_id=0), case when cim_mgr.f_check_visa_status(o.ref)<2 then 1 else 0 end,
       o.tt, o.direct, (select type_name from cim_types where type_id=o.direct)
from accounts a, customer c,
     (select o.ref, o.nam_a, o.nam_b, o.nlsa, o.nlsb, o.pdat, o.vdat, o.kv, o.s, (o.s-cim_mgr.get_payments_bound_sum(o.ref))/100 as unbound_sum,
             o.nazn, case when cim_mgr.f_check_visa_status(o.ref)<2 then 1 else 0 end as is_vised, o.tt, o.kf,
             cim_mgr.check_visa_condition(dk, kv, nlsa, nlsb) as direct, o.branch
        from oper o where o.dk=1) o
       where a.rnk=c.rnk and
             (o.branch like SYS_CONTEXT ('bars_context', 'user_branch_mask') or a.branch like SYS_CONTEXT ('bars_context', 'user_branch_mask'))
             and o.kv=a.kv and a.kf=o.kf and nvl(decode(o.direct, 0, o.nlsb, o.nlsa),null) = a.nls and o.direct<2;

PROMPT *** Create  grants  V_CIM_FOUND_PAYMENTS ***
grant SELECT                                                                 on V_CIM_FOUND_PAYMENTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_FOUND_PAYMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_FOUND_PAYMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_FOUND_PAYMENTS.sql =========*** E
PROMPT ===================================================================================== 
