

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TMP_STATIC_LAYOUT_DETAIL_A.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TMP_STATIC_LAYOUT_DETAIL_A ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TMP_STATIC_LAYOUT_DETAIL_A ("ID", "ND", "KV", "BRANCH", "BRANCH_NAME", "NLS_A", "NAMA", "OKPOA", "MFOB", "MFOB_NAME", "NLS_B", "NAMB", "OKPOB", "PERCENT", "SUMM_A", "SUMM_B", "DELTA", "TT", "VOB", "NAZN", "REF", "NLS_COUNT", "ORD", "USERID") AS 
  select v.id,
            v.nd,
            v.kv,
            v.branch,
            v.branch_name,
            v.nls_a,
            v.nama,
            v.okpoa,
            v.mfob,
            v.mfob_name,
            v.nls_b,
            v.namb,
            v.okpob,
            v.percent,
            v.summ_a / 100 as summ_a,
            v.summ_b / 100 as summ_b,
            v.delta / 100 delta,
            v.tt,
            v.vob,
            nvl (m.nazn, v.nazn) nazn,
            v.ref,
            v.nls_count,
            m.ord,
            v.userid
       from bars.tmp_dynamic_layout_detail v, mf1 m
      where v.userid = bars.user_id and v.nls_count = m.grp and v.id = m.id
   order by m.ord;

PROMPT *** Create  grants  V_TMP_STATIC_LAYOUT_DETAIL_A ***
grant SELECT                                                                 on V_TMP_STATIC_LAYOUT_DETAIL_A to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TMP_STATIC_LAYOUT_DETAIL_A.sql ======
PROMPT ===================================================================================== 
