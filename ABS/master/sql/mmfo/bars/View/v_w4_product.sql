

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_PRODUCT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_PRODUCT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_PRODUCT ("PROECT_ID", "PROECT_NAME", "PROECT_OKPO", "GRP_CODE", "GRP_NAME", "CLIENT_TYPE", "SH_ID", "SH_NAME", "PRODUCT_CODE", "PRODUCT_NAME", "KV", "NBS", "OB22", "ACC_RATE", "MOBI_RATE", "CRED_RATE", "OVR_RATE", "LIM_RATE", "GRC_RATE", "MM_MAX", "SUB_CODE", "SUB_NAME", "FLAG_KK", "CARD_CODE") AS 
  SELECT b.id proect_id,
          b.name proect_name,
          b.okpo proect_okpo,
          g.code grp_code,
          g.name grp_name,
          g.client_type client_type,
          m.id sh_id,
          m.name sh_name,
          p.code product_code,
          p.name product_name,
          p.kv kv,
          p.nbs nbs,
          p.ob22 ob22,
          d.percent_osn acc_rate,
          d.percent_mob mobi_rate,
          d.percent_cred cred_rate,
          d.percent_over ovr_rate,
          d.percent_notusedlimit lim_rate,
          d.percent_grace grc_rate,
          c.maxterm,
          s.code sub_code,
          s.name sub_name,
          s.flag_kk,
          c.code card_code
     FROM w4_product_groups g,
          w4_product p,
          w4_subproduct s,
          w4_card c,
          bpk_scheme m,
          cm_product d,
          bpk_proect b,
          bpk_proect_card bb
    WHERE     g.code = 'SALARY'
          AND g.code = p.grp_code
          AND p.code = b.product_code
          AND NVL (b.used_w4, 0) = 1
          AND b.okpo = bb.okpo
          AND NVL (b.okpo_n, 0) = NVL (bb.okpo_n, 0)
          AND bb.card_code = c.code
          AND c.sub_code = s.code
          AND g.scheme_id = m.id
          AND p.code = d.product_code(+)
          AND NVL (g.date_open, bankdate) <= bankdate
          AND NVL (p.date_open, bankdate) <= bankdate
          AND NVL (c.date_open, bankdate) <= bankdate
          AND NVL (g.date_close, bankdate + 1) > bankdate
          AND NVL (p.date_close, bankdate + 1) > bankdate
          AND NVL (c.date_close, bankdate + 1) > bankdate
   UNION ALL
   -- без проекта
   SELECT -1 proect_id,
          '*Власна картка' proect_name,
          NULL proect_okpo,
          g.code grp_code,
          g.name grp_name,
          g.client_type client_type,
          m.id sh_id,
          m.name sh_name,
          p.code product_code,
          p.name product_name,
          p.kv kv,
          p.nbs nbs,
          p.ob22 ob22,
          d.percent_osn acc_rate,
          d.percent_mob mobi_rate,
          d.percent_cred cred_rate,
          d.percent_over ovr_rate,
          d.percent_notusedlimit lim_rate,
          d.percent_grace grc_rate,
          d.mm_max,
          s.code sub_code,
          s.name sub_name,
          s.flag_kk,
          c.code card_code
     FROM w4_product_groups g,
          w4_product p,
          w4_subproduct s,
          w4_card c,
          bpk_scheme m,
          cm_product d
    WHERE     g.code <> 'SALARY'
          AND g.code = p.grp_code
          AND p.code = c.product_code
          AND c.sub_code = s.code
          AND g.scheme_id = m.id
          AND p.code = d.product_code(+)
          AND NVL (g.date_open, bankdate) <= bankdate
          AND NVL (p.date_open, bankdate) <= bankdate
          AND NVL (c.date_open, bankdate) <= bankdate
          AND NVL (g.date_close, bankdate + 1) > bankdate
          AND NVL (p.date_close, bankdate + 1) > bankdate
          AND NVL (c.date_close, bankdate + 1) > bankdate;

PROMPT *** Create  grants  V_W4_PRODUCT ***
grant SELECT                                                                 on V_W4_PRODUCT    to BARSREADER_ROLE;
grant SELECT                                                                 on V_W4_PRODUCT    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_PRODUCT    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_PRODUCT.sql =========*** End *** =
PROMPT ===================================================================================== 
