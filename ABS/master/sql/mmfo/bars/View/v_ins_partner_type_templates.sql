

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_PARTNER_TYPE_TEMPLATES.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_PARTNER_TYPE_TEMPLATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_PARTNER_TYPE_TEMPLATES ("PARTNER_ID", "TYPE_ID", "TEMPLATE_ID", "TEMPLATE_NAME", "PRT_FORMAT") AS 
  select pt.partner_id,
       pt.type_id,
       ptt.template_id,
       ds.name as template_name,
       ptt.prt_format
  from ins_partner_types pt, ins_partner_type_templates ptt, doc_scheme ds
 where (pt.partner_id = ptt.partner_id or ptt.partner_id is null)
   and (pt.type_id = ptt.type_id or ptt.type_id is null)
   and ptt.template_id = ds.id
 order by ptt.template_id;

PROMPT *** Create  grants  V_INS_PARTNER_TYPE_TEMPLATES ***
grant SELECT                                                                 on V_INS_PARTNER_TYPE_TEMPLATES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_PARTNER_TYPE_TEMPLATES.sql ======
PROMPT ===================================================================================== 
