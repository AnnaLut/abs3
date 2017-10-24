

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_FILE_STATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_FILE_STATE ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_FILE_STATE ("STATE", "STATE_NAME") AS 
  select state,
          state_name
     from pfu_file_state;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_FILE_STATE.sql =========*** End **
PROMPT ===================================================================================== 
