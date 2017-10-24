

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NOTARY_ACCREDITATION.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NOTARY_ACCREDITATION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NOTARY_ACCREDITATION ("ID", "NOTARY_ID", "TYPE_ACCR", "START_DATE", "EXPIRY_DATE", "CLOSE_DATE", "ACCOUNT_NUMBER", "ACCOUNT_MFO", "ACCREDITATION_TYPE_ID", "STATE_ID", "STATE_ACCR") AS 
  select a.ID                     ,
       a.NOTARY_ID              ,
       list_utl.get_item_name('NOTARY_ACCREDITATION_TYPE', a.accreditation_type_id) type_accr,
       a.START_DATE             ,
       a.EXPIRY_DATE            ,
       a.CLOSE_DATE             ,
       a.ACCOUNT_NUMBER         ,
       a.ACCOUNT_MFO            ,
       a.ACCREDITATION_TYPE_ID  ,
       a.STATE_ID               ,
       list_utl.get_item_name('NOTARY_ACCREDITATION_STATE', a.state_id) state_accr
from   NOTARY_ACCREDITATION       a;

PROMPT *** Create  grants  V_NOTARY_ACCREDITATION ***
grant SELECT                                                                 on V_NOTARY_ACCREDITATION to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NOTARY_ACCREDITATION.sql =========***
PROMPT ===================================================================================== 
