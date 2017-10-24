

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TMS_RUN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TMS_RUN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TMS_RUN ("ID", "CURRENT_BANK_DATE", "NEW_BANK_DATE", "RUN_STATE") AS 
  select t.id, t.current_bank_date, t.new_bank_date, list_utl.get_item_name('BANKDATE_RUN_STATE', t.state_id) run_state
from   tms_run t;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TMS_RUN.sql =========*** End *** ====
PROMPT ===================================================================================== 
