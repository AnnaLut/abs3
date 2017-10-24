

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACTIVE_NOTARY_ACCREDITATION.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACTIVE_NOTARY_ACCREDITATION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACTIVE_NOTARY_ACCREDITATION ("ID", "TIN", "NOTARY_NAME", "ACCREDITATION_TYPE_NAME", "ACCREDITATION_START_DATE", "ACCREDITATION_EXPIRY_DATE") AS 
  select na.id,
       n.tin,
       trim(n.last_name || ' ' || n.first_name || ' ' || n.middle_name) notary_name,
       list_utl.get_item_name('NOTARY_ACCREDITATION_TYPE', na.accreditation_type_id) accreditation_type_name,
       na.start_date accreditation_start_date,
       na.expiry_date accreditation_expiry_date
from   notary n
join   notary_accreditation na on na.notary_id = n.id
where  na.state_id in (1) and -- тільки діючі акредитації
       na.close_date is null and
       na.start_date <= bankdate() and
       (na.expiry_date is null or na.expiry_date >= bankdate()) and
       na.id in (select sv.object_id
                 from   attribute_value sv
                 where  sys_context('bars_context', 'user_branch') like sv.string_value || '%' and
                        sv.attribute_id = (select ak.id
                                           from   attribute_kind ak
                                           where  ak.attribute_code = 'NOTARY_ACCR_BRANCHES'))
;

PROMPT *** Create  grants  V_ACTIVE_NOTARY_ACCREDITATION ***
grant SELECT                                                                 on V_ACTIVE_NOTARY_ACCREDITATION to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACTIVE_NOTARY_ACCREDITATION.sql =====
PROMPT ===================================================================================== 
