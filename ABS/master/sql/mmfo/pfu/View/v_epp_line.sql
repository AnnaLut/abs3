

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_EPP_LINE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EPP_LINE ***

  CREATE OR REPLACE FORCE VIEW PFU.V_EPP_LINE ("EPP_NUMBER", "TAX_REGISTRATION_NUMBER", "FIO", "PHONE_NUMBERS", "DOCUMENT_ID", "ACCOUNT_NUMBER", "TYPE", "BANK_NUM", "STATE_ID", "ERR_TAG") AS 
  SELECT t.epp_number,
          t.tax_registration_number,
          t.last_name || ' ' || t.first_name || ' ' || t.middle_name fio,
          t.phone_numbers,
          t.document_id,
          t.account_number,
          NULL TYPE,
          t.bank_num,
          t.state_id,
          (SELECT TO_CHAR (p.error_stack)
             FROM pfu_epp_line_tracking p
            WHERE p.id = t.id
                  AND p.id = (SELECT MAX (pp.id)
                                FROM pfu_epp_line_tracking pp
                               WHERE pp.id = t.id))
             err_tag
     FROM PFU_EPP_LINE t;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_EPP_LINE.sql =========*** End *** ====
PROMPT ===================================================================================== 
