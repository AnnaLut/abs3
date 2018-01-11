

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_TEMPLATES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_TEMPLATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_TEMPLATES ("TEMPLATE_ID", "TEMPLATE_NAME", "TEMPLATE", "DOCEXP_TYPE_ID", "DOCEXP_TYPE_NAME", "FILE_NAME") AS 
  select t.template_id,
       dt.name          as template_name,
       dt.template,
       t.docexp_type_id,
       det.name         as docexp_type_name,
       dt.file_name
  from wcs_templates t, v_doc_templates dt, wcs_docexport_types det
 where t.template_id = dt.id
   and dt.fr = 1
   and t.docexp_type_id = det.id
 order by t.template_id;

PROMPT *** Create  grants  V_WCS_TEMPLATES ***
grant SELECT                                                                 on V_WCS_TEMPLATES to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_TEMPLATES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_TEMPLATES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_TEMPLATES.sql =========*** End **
PROMPT ===================================================================================== 
