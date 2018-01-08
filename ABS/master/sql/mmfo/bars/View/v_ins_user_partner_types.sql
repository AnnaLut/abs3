

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_USER_PARTNER_TYPES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_USER_PARTNER_TYPES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_USER_PARTNER_TYPES ("PARTNER_ID", "PARTNER_NAME", "PARTNER_RNK", "PARTNER_INN", "PARTNER_ACTIVE", "TYPE_ID", "TYPE_NAME", "OBJECT_TYPE", "TARIFF_ID", "FEE_ID", "LIMIT_ID", "ACTIVE", "TARIFF_NAME", "FEE_NAME", "LIMIT_NAME") AS 
  select pt."PARTNER_ID",pt."PARTNER_NAME",pt."PARTNER_RNK",pt."PARTNER_INN",pt."PARTNER_ACTIVE",pt."TYPE_ID",pt."TYPE_NAME",pt."OBJECT_TYPE",pt."TARIFF_ID",pt."FEE_ID",pt."LIMIT_ID",pt."ACTIVE",pt."TARIFF_NAME",pt."FEE_NAME",pt."LIMIT_NAME"
  from v_ins_partner_types pt
 where pt.partner_active = 1
   and pt.active = 1
   and exists
 (select 1
          from ins_partner_type_branches ptb
         where sys_context('bars_context', 'user_branch') like
               ptb.branch || decode(ptb.apply_hier, 1, '%', '')
           and (ptb.partner_id = pt.partner_id or ptb.partner_id is null)
           and (ptb.type_id = pt.type_id or ptb.type_id is null))
 order by pt.partner_id, pt.type_id;

PROMPT *** Create  grants  V_INS_USER_PARTNER_TYPES ***
grant SELECT                                                                 on V_INS_USER_PARTNER_TYPES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_USER_PARTNER_TYPES.sql =========*
PROMPT ===================================================================================== 
