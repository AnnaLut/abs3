

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACTIVE_NOTARY_ACCREDITATION.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACTIVE_NOTARY_ACCREDITATION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACTIVE_NOTARY_ACCREDITATION ("ID", "TIN", "NOTARY_NAME", "ACCREDITATION_TYPE_NAME", "ACCREDITATION_START_DATE", "ACCREDITATION_EXPIRY_DATE") AS 
  SELECT na.id,
          n.tin,
          TRIM (n.last_name || ' ' || n.first_name || ' ' || n.middle_name)
             notary_name,
          list_utl.get_item_name ('NOTARY_ACCREDITATION_TYPE',
                                  na.accreditation_type_id)
             accreditation_type_name,
          na.start_date accreditation_start_date,
          na.expiry_date accreditation_expiry_date
     FROM notary n JOIN notary_accreditation na
             ON na.notary_id = n.id
    WHERE     na.state_id = 1
          AND                                      -- тільки діючі акредитації
             na.close_date IS NULL
          AND na.start_date <= bankdate ()
          AND (na.expiry_date IS NULL OR na.expiry_date >= bankdate ());

PROMPT *** Create  grants  V_ACTIVE_NOTARY_ACCREDITATION ***
grant SELECT                                                                 on V_ACTIVE_NOTARY_ACCREDITATION to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACTIVE_NOTARY_ACCREDITATION.sql =====
PROMPT ===================================================================================== 
