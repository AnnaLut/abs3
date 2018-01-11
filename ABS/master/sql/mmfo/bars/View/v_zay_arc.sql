

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_ARC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_ARC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_ARC ("MFO", "DK", "ID", "REF", "KV2", "S2", "RNK", "ND_RNK", "CUST_BRANCH", "NMK", "FDAT", "KURS_Z", "KURS_F", "PRIORNAME", "KOM", "SKOM", "VDATE", "SOS", "DIG", "OBZ", "IDENTKB", "KV_CONV", "AIM_NAME", "CONTRACT", "DAT2_VMD", "NUM_VMD", "DAT_VMD", "DAT5_VMD", "COUNTRY", "BASIS", "BENEFCOUNTRY", "BANK_CODE", "PRODUCT_GROUP", "S_PF", "REF_PF", "REF_SPS", "CLOSE_TYPE_NAME", "GRN_SUM") AS 
  SELECT v_zay.mfo,
          v_zay.dk,
          v_zay.id,
          v_zay.REF,
          v_zay.kv2,
          v_zay.s2/100 s2,
          v_zay.rnk,
          v_zay.nd_rnk,
          v_zay.cust_branch,
          v_zay.nmk,
          v_zay.fdat,
          v_zay.kurs_z,
          v_zay.kurs_f,
          v_zay.priorname,
          v_zay.kom,
          v_zay.skom,
          v_zay.vdate,
          o.sos,
          v_zay.dig,
          NVL (v_zay.obz, 0) obz,
          identkb,
          kv_conv,
          v_zay.aim_name,
          v_zay.contract,
          v_zay.dat2_vmd,
          v_zay.num_vmd,
          v_zay.dat_vmd,
          v_zay.dat5_vmd,
          v_zay.country,
          v_zay.basis,
          v_zay.benefcountry,
          v_zay.bank_code,
          v_zay.product_group || ' ' || v_zay.product_group_name
             product_group,
          v_zay.s_pf,
          v_zay.ref_pf,
          v_zay.ref_sps,
          close_type_name,
          CASE
             WHEN (v_zay.dk IN (3, 4) AND v_zay.kv_conv = v_zay.kv_base)
             THEN
                v_zay.s2 / v_zay.kurs_f / 100
             ELSE
                v_zay.s2 * v_zay.kurs_f / 100
          END
             grn_sum
     FROM v_zay, oper o
    WHERE     v_zay.REF = o.REF
          AND v_zay.mfo = SYS_CONTEXT ('bars_context', 'user_mfo')
          AND pdat >= TRUNC (SYSDATE) - 30
          AND pdat <= SYSDATE
   UNION ALL
   SELECT v_zay.mfo,
          v_zay.dk,
          v_zay.id,
          v_zay.REF,
          v_zay.kv2,
          v_zay.s2/100 s2,
          v_zay.rnk,
          v_zay.nd_rnk,
          v_zay.cust_branch,
          v_zay.nmk,
          v_zay.fdat,
          v_zay.kurs_z,
          v_zay.kurs_f,
          v_zay.priorname,
          v_zay.kom,
          v_zay.skom,
          v_zay.vdate,
          NULL,
          v_zay.dig,
          NVL (v_zay.obz, 0),
          identkb,
          kv_conv,
          v_zay.aim_name,
          v_zay.contract,
          v_zay.dat2_vmd,
          v_zay.num_vmd,
          v_zay.dat_vmd,
          v_zay.dat5_vmd,
          v_zay.country,
          v_zay.basis,
          v_zay.benefcountry,
          v_zay.bank_code,
          v_zay.product_group || ' ' || v_zay.product_group_name
             product_group,
          v_zay.s_pf,
          v_zay.ref_pf,
          v_zay.ref_sps,
          close_type_name,
          CASE
             WHEN (v_zay.dk IN (3, 4) AND v_zay.kv_conv = v_zay.kv_base)
             THEN
                v_zay.s2 / v_zay.kurs_f / 100
             ELSE
                v_zay.s2 * v_zay.kurs_f / 100
          END
             grn_sum
     FROM v_zay
    WHERE v_zay.mfo <> f_ourmfo_g;

PROMPT *** Create  grants  V_ZAY_ARC ***
grant SELECT                                                                 on V_ZAY_ARC       to BARSREADER_ROLE;
grant SELECT                                                                 on V_ZAY_ARC       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_ARC       to UPLD;
grant SELECT                                                                 on V_ZAY_ARC       to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_ARC.sql =========*** End *** ====
PROMPT ===================================================================================== 
