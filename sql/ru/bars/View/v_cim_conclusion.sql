

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_CONCLUSION.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_CONCLUSION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_CONCLUSION ("ID", "CONTR_ID", "ORG_ID", "ORG_NAME", "OUT_NUM", "OUT_DATE", "KV", "S", "BEGIN_DATE", "END_DATE", "S_DOC", "CREATE_DATE", "CREATE_UID", "EA_URL") AS 
  SELECT c.id, c.contr_id, c.org_id, (select name from cim_conclusion_org where id=c.org_id), c.out_num, c.out_date,
         c.kv, round(c.s/100,2), c.begin_date, c.end_date,
         round((select nvl(sum(s),0) from cim_conclusion_link where delete_date is null and cnc_id=c.id)/100,2),
         c.create_date, c.create_uid,
         (select par_value from cim_params where par_name='EA_URL')||'document?clientcode='||(select okpo from cim_contracts k where k.contr_id=c.contr_id)||
           '&'||'typecode=35&'||'number='||cim_mgr.form_url_encode(c.out_num)||'&'||'date='||to_char(c.out_date, 'yyyy-mm-dd') as ea_url
    FROM cim_conclusion c WHERE delete_date is null;

PROMPT *** Create  grants  V_CIM_CONCLUSION ***
grant SELECT                                                                 on V_CIM_CONCLUSION to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_CONCLUSION.sql =========*** End *
PROMPT ===================================================================================== 
