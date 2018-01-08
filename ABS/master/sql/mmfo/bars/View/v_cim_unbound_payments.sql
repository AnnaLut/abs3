

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_UNBOUND_PAYMENTS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_UNBOUND_PAYMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_UNBOUND_PAYMENTS ("REF", "CUST_RNK", "CUST_OKPO", "CUST_NMK", "CUST_ND", "BENEF_NMK", "ACC", "NLS", "VDAT", "KV", "TOTAL_SUM", "UNBOUND_SUM", "NAZN", "OP_TYPE_ID", "OP_TYPE", "PAY_TYPE", "PAY_TYPE_NAME", "IS_VISED", "DIRECT", "DIRECT_NAME", "TT", "BACKGROUND_COLOR") AS 
  select ref, cust_rnk, cust_okpo, cust_nmk, cust_nd, benef_nmk, acc, nls, vdat, kv, total_sum, unbound_sum, nazn, op_type_id, op_type,
         pay_type, pay_type_name, is_vised, direct, direct_name, tt, background_color
    from v_cim_out_unbound_payments
  union all
  select ref, cust_rnk, cust_okpo, cust_nmk, cust_nd, benef_nmk, acc, nls, vdat, kv, total_sum, unbound_sum, nazn, op_type_id, op_type,
         pay_type, pay_type_name, is_vised, direct, direct_name, tt, background_color
    from  v_cim_in_unbound_payments;

PROMPT *** Create  grants  V_CIM_UNBOUND_PAYMENTS ***
grant SELECT                                                                 on V_CIM_UNBOUND_PAYMENTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_UNBOUND_PAYMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_UNBOUND_PAYMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_UNBOUND_PAYMENTS.sql =========***
PROMPT ===================================================================================== 
