

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_IN_UNBOUND_PAYMENTS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_IN_UNBOUND_PAYMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_IN_UNBOUND_PAYMENTS ("REF", "CUST_RNK", "CUST_OKPO", "CUST_NMK", "CUST_ND", "BENEF_NMK", "ACC", "NLS", "PDAT", "VDAT", "KV", "TOTAL_SUM", "UNBOUND_SUM", "NAZN", "OP_TYPE_ID", "OP_TYPE", "PAY_TYPE", "PAY_TYPE_NAME", "IS_VISED", "DIRECT", "DIRECT_NAME", "TT", "BACKGROUND_COLOR") AS 
  select ip.ref, c.rnk, c.okpo, c.nmkk, c.nd, ip.nam_a, a.acc, a.nls, ip.pdat, ip.vdat, ip.kv, round(ip.s/100,2),
         round((ip.s-cim_mgr.get_payments_bound_sum(ip.ref))/100,2), ip.nazn,
         (select to_number(value) from operw where tag='CIMTO' and ref = ip.ref),
         (select type_name from cim_operation_types
            where type_id = (select to_number(value) from operw where tag='CIMTO' and ref = ip.ref)),
         0, pt.type_name, 0, 0, dn.type_name, ip.tt, 0
  from v_cim_all_payments ip
       join accounts a
         on (ip.branch like SYS_CONTEXT ('bars_context', 'user_branch_mask') or a.branch like SYS_CONTEXT ('bars_context', 'user_branch_mask')) and
            ip.mfob=a.kf and ip.kv=a.kv and ip.nlsb=a.nls
       join customer c on c.rnk=a.rnk,
       (select type_name from cim_payment_types where type_id=0) pt,
       (select type_name from cim_types where type_id=0) dn
  where ip.direct=0
union all
  select o.ref, c.rnk, c.okpo, c.nmkk, c.nd, o.nam_a, a.acc, a.nls, o.pdat, o.vdat, o.kv, round(o.s/100,2), round(pb.s/100,2), o.nazn,
         (select to_number(value) from operw where tag='CIMTO' and ref = pb.ref),
         (select type_name from cim_operation_types
            where type_id = (select to_number(value) from operw where tag='CIMTO' and ref = pb.ref)), 0, pt.type_name, 1, 0, dn.type_name, o.tt, 0
  from cim_payments_bound pb
       join oper o on o.ref=pb.ref
       join accounts a on a.kf=o.mfob and a.kv=o.kv and a.nls=o.nlsb
       join customer c on c.rnk=a.rnk,
       (select type_name from cim_payment_types where type_id=0) pt,
       (select type_name from cim_types where type_id=0) dn
  where pb.branch like SYS_CONTEXT ('bars_context', 'user_branch_mask') and pb.delete_date is null and pb.direct=0 and pb.contr_id is null
union all
  select fb.fantom_id, c.rnk, c.okpo, c.nmkk, c.nd, b.benef_name, null, null, o.bank_date, o.val_date, o.kv, round(o.s/100,2), round(fb.s/100,2),
         o.details, o.oper_type, (select type_name from cim_operation_types where type_id = o.oper_type),
         o.payment_type, (select type_name from cim_payment_types where type_id=o.payment_type), 1, 0, dn.type_name, null, 0
    from cim_fantoms_bound fb, cim_fantom_payments o, cim_beneficiaries b, customer c, (select type_name from cim_types where type_id=0) dn
   where o.benef_id=b.benef_id and o.rnk=c.rnk and fb.fantom_id = o.fantom_id and fb.branch like SYS_CONTEXT ('bars_context', 'user_branch_mask')
         and fb.delete_date is null and fb.direct=0 and fb.contr_id is null;

PROMPT *** Create  grants  V_CIM_IN_UNBOUND_PAYMENTS ***
grant SELECT                                                                 on V_CIM_IN_UNBOUND_PAYMENTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_IN_UNBOUND_PAYMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_IN_UNBOUND_PAYMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_IN_UNBOUND_PAYMENTS.sql =========
PROMPT ===================================================================================== 
