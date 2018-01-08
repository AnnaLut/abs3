

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_INSURANCES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_INSURANCES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_INSURANCES ("INSURANCE_ID", "INSURANCE_NAME", "INS_TYPE_ID", "INS_TYPE_NAME", "SURVEY_ID", "SURVEY_NAME") AS 
  select i.id           as insurance_id,
       i.name         as insurance_name,
       it.id          as ins_type_id,
       it.name        as ins_type_name,
       i.survey_id,
       ss.survey_name
  from wcs_insurances i, ins_types it, v_wcs_surveys ss
 where i.ins_type_id = it.id
   and i.survey_id = ss.survey_id(+)
 order by i.id;

PROMPT *** Create  grants  V_WCS_INSURANCES ***
grant SELECT                                                                 on V_WCS_INSURANCES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_INSURANCES.sql =========*** End *
PROMPT ===================================================================================== 
