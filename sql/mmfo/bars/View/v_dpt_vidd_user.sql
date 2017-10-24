

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_VIDD_USER.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_VIDD_USER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_VIDD_USER ("VIDD", "TYPE_NAME", "KV", "TYPE_ID") AS 
  (SELECT vidd,
           type_name,
           kv,
           type_id
      FROM dpt_vidd
     WHERE flag = 1
           AND (SELECT NVL (val, '0')
                  FROM params$global
                 WHERE par = 'DPT_ADM') = '0'
    UNION
    SELECT v.vidd,
           v.type_name,
           v.kv,
           v.type_id
      FROM dpt_vidd v, dpt_vidd_staff s, params$global p
     WHERE     v.flag = 1
           AND v.vidd = s.vidd
           AND s.userid = user_id
           AND s.approve = 1
           AND date_is_valid (s.adate1,
                              s.adate2,
                              s.rdate1,
                              s.rdate2) = 1
           AND p.par = 'DPT_ADM'
           AND p.val IN ('1', '2')
    UNION
    SELECT v.vidd,
           v.type_name,
           v.kv,
           v.type_id
      FROM dpt_vidd v, dpt_vidd_branch b, params$global p
     WHERE     v.flag = 1
           AND v.vidd = b.vidd
           AND b.branch = SYS_CONTEXT ('bars_context', 'user_branch')
           AND p.par = 'DPT_ADM'
           AND p.val = '2');

PROMPT *** Create  grants  V_DPT_VIDD_USER ***
grant SELECT                                                                 on V_DPT_VIDD_USER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_VIDD_USER to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_VIDD_USER to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_VIDD_USER.sql =========*** End **
PROMPT ===================================================================================== 
