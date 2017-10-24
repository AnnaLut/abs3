

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_DEATH.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_DEATH ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_DEATH ("ID", "REQUEST_ID", "COUNT_RES", "DATE_PFU", "DATE_CR", "STATE", "USERID", "PFU_FILE_ID") AS 
  select "ID",
       "REQUEST_ID",
       "COUNT_RES",
       to_date(to_char(d.date_pfu,'dd.mm.yyyy'),'dd.mm.yyyy') "DATE_PFU",
       to_date(to_char(d.date_cr,'dd.mm.yyyy'),'dd.mm.yyyy') "DATE_CR",
       "STATE",
       "USERID",
       "PFU_FILE_ID"
    from pfu_death d;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_DEATH.sql =========*** End *** ===
PROMPT ===================================================================================== 
