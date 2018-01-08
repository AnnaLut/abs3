

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_GARANTEES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_GARANTEES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_GARANTEES ("GARANTEE_ID", "GARANTEE_NAME", "GRT_TABLE_ID", "GRT_TABLE_NAME", "SCOPY_ID", "SCOPY_NAME", "SURVEY_ID", "SURVEY_NAME", "INS_CNT", "TPL_CNT", "WS_ID") AS 
  select g.id as garantee_id,
       g.name as garantee_name,
       g.grt_table_id,
       dt.table_name as grt_table_name,
       g.scopy_id,
       s.scopy_name,
       g.survey_id,
       ss.survey_name,
       (select count(*)
          from wcs_garantee_insurances gi
         where gi.garantee_id = g.id) as ins_cnt,
       (select count(*)
          from wcs_garantee_templates gt
         where gt.garantee_id = g.id) as tpl_cnt,
       g.ws_id
  from wcs_garantees     g,
       grt_detail_tables dt,
       v_wcs_scancopies  s,
       v_wcs_surveys     ss
 where g.grt_table_id = dt.table_id
   and g.scopy_id = s.scopy_id(+)
   and g.survey_id = ss.survey_id(+)
 order by g.id;

PROMPT *** Create  grants  V_WCS_GARANTEES ***
grant SELECT                                                                 on V_WCS_GARANTEES to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_GARANTEES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_GARANTEES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_GARANTEES.sql =========*** End **
PROMPT ===================================================================================== 
