

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_CUSTOMS_DECL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_CUSTOMS_DECL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_CUSTOMS_DECL ("F_NAME", "F_DATE", "N", "DIRECT", "NUM", "OKPO", "NMK", "BENEF_NAME", "BENEF_ADR", "COUNTRY", "KV", "S", "KURS", "ALLOW_DAT", "CONTRACT_NUM", "CONTRACT_DATE", "CIM_ID", "CIM_BRANCH", "CIM_DATE", "CIM_BOUNDSUM", "CHARACTER", "CIM_ORIGINAL") AS 
  select fn, trunc(dat), n, decode(ctype,'öŒ',0,'…Š',1,null), cnum_cst||'/'||cnum_year||'/'||lpad(cnum_num, 6, '0'),
         f_okpo, f_name, decode(ctype,'öŒ',s_name,'…Š',r_name,null), decode(ctype,'öŒ',s_adres,'…Š',r_adres,null),
         to_number(f_country), kv, case when trunc(dat)<to_date('01/12/2012','DD/MM/YYYY') and kurs>0 then round(s*1000000/kurs,2) else round(s/100,2) end,
         kurs, allow_dat, doc, sdate, cim_id, cim_branch, cim_date, round(cim_boundsum/100,2), character, cim_original
    from customs_decl;

PROMPT *** Create  grants  V_CIM_CUSTOMS_DECL ***
grant SELECT                                                                 on V_CIM_CUSTOMS_DECL to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_CUSTOMS_DECL.sql =========*** End
PROMPT ===================================================================================== 
