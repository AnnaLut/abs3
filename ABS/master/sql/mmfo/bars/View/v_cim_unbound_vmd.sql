

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_UNBOUND_VMD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_UNBOUND_VMD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_UNBOUND_VMD ("VMD_ID", "VMD_TYPE", "VMD_KIND", "DIRECT", "NUM", "OKPO", "NMK", "BENEF_NAME", "BENEF_ADR", "COUNTRY", "KV", "S", "UNBOUND_S", "ALLOW_DATE", "DOC_DATE", "CONTRACT_NUM", "CONTRACT_DATE", "F_NAME", "F_DATE", "N", "BRANCH", "CIM_ORIGINAL") AS 
  select cim_id, 0, 0, direct, num, okpo, translatedos2win(nmk), translatedos2win(benef_name), translatedos2win(benef_adr),
         country, kv, s,
         s-round(nvl((select sum(s_vt) from cim_vmd_bound where delete_date is null and vmd_id=cim_id),0)/100,2),
         allow_dat, cim_date, translatedos2win(contract_num), contract_date, f_name, f_date, n, cim_branch, decode(cim_original, 1, 'Нова', 'Зміна')
   from  v_cim_customs_decl
   where s>cim_boundsum and cim_id is not null
  union all
  select a.act_id, a.act_type, (select kind from cim_act_types where type_id=a.act_type), a.direct, a.num,
         c.okpo, c.nmk, b.benef_name, b.benef_adr, b.country_id, a.kv, round(a.s/100,2),
         round((a.s-nvl((select sum(s_vt) from cim_act_bound where delete_date is null and act_id=a.act_id),0))/100,2),
         a.allow_date, a.act_date, a.contract_num, a.contract_date, null, null, null, a.branch, ' '
   from  cim_acts a, customer c, cim_beneficiaries b
   where b.benef_id=a.benef_id and c.rnk=a.rnk and a.s>a.bound_sum;

PROMPT *** Create  grants  V_CIM_UNBOUND_VMD ***
grant SELECT                                                                 on V_CIM_UNBOUND_VMD to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_UNBOUND_VMD.sql =========*** End 
PROMPT ===================================================================================== 
