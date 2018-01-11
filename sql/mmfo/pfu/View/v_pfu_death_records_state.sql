

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_DEATH_RECORDS_STATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_DEATH_RECORDS_STATE ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_DEATH_RECORDS_STATE ("ID", "NAME") AS 
  select "ID","NAME"
    from pfu_death_records_state;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_DEATH_RECORDS_STATE.sql =========*
PROMPT ===================================================================================== 
