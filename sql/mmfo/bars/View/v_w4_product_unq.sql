

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_PRODUCT_UNQ.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_PRODUCT_UNQ ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_PRODUCT_UNQ ("PROECT_ID", "PRODUCT_CODE", "PRODUCT_NAME", "GRP_CODE", "ACC_RATE", "MOBI_RATE", "CRED_RATE", "OVR_RATE", "LIM_RATE", "GRC_RATE") AS 
  select unique proect_id,
       product_code,
       product_name,
       grp_code,
       acc_rate,
       mobi_rate,
       cred_rate,
       ovr_rate,
       lim_rate,
       grc_rate
  from v_w4_product;

PROMPT *** Create  grants  V_W4_PRODUCT_UNQ ***
grant SELECT                                                                 on V_W4_PRODUCT_UNQ to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_PRODUCT_UNQ to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_PRODUCT_UNQ.sql =========*** End *
PROMPT ===================================================================================== 
