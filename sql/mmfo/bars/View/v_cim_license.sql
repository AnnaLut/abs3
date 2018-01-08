

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_LICENSE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_LICENSE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_LICENSE ("LICENSE_ID", "OKPO", "NUM", "TYPE", "TYPE_TXT", "KV", "S", "BEGIN_DATE", "END_DATE", "COMMENTS", "S_DOC", "EA_URL") AS 
  select l.license_id, l.okpo, l.num, l.type, (select type_name from cim_license_type where type_id=l.type),
         l.kv, round(l.s/100,2), l.begin_date, l.end_date, l.comments,
         (select round(nvl(sum(s),0)/100,2) from cim_license_link where delete_date is null and license_id=l.license_id),
         (select par_value from cim_params where par_name='EA_URL')||'document?clientcode='||l.okpo||
           '&'||'typecode=36&'||'number='||cim_mgr.form_url_encode(l.num)||'&'||'date='||to_char(l.begin_date, 'yyyy-mm-dd') as ea_url
    from cim_license l where delete_date is null;

PROMPT *** Create  grants  V_CIM_LICENSE ***
grant SELECT                                                                 on V_CIM_LICENSE   to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_LICENSE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_LICENSE   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_LICENSE.sql =========*** End *** 
PROMPT ===================================================================================== 
