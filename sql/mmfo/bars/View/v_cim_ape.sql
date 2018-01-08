

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_APE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_APE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_APE ("CONTR_ID", "APE_ID", "NUM", "KV", "S", "RATE", "KV_K", "S_VK", "BEGIN_DATE", "END_DATE", "COMMENTS", "ZS_VK", "EA_URL") AS 
  select a.contr_id, a.ape_id, a.num, a.kv, round(a.s/100,2), a.rate, (select kv from cim_contracts where contr_id=a.contr_id),
          round(a.s_vk/100,2), a.begin_date, a.end_date, a.comments,
          round((a.s_vk-nvl((select sum(s) from cim_ape_link where delete_date is null and ape_id=a.ape_id),0))/100,2),
          (select par_value from cim_params where par_name='EA_URL')||'document?clientcode='||(select okpo from cim_contracts k where k.contr_id=a.contr_id)||
           '&'||'typecode=37&'||'number='||cim_mgr.form_url_encode(a.num)||'&'||'date='||to_char(a.begin_date, 'yyyy-mm-dd') as ea_url
   from cim_contracts_ape a where delete_date is null;

PROMPT *** Create  grants  V_CIM_APE ***
grant SELECT                                                                 on V_CIM_APE       to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_APE       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_APE       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_APE.sql =========*** End *** ====
PROMPT ===================================================================================== 
