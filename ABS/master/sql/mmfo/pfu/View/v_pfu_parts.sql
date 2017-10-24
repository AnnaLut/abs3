

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_PARTS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_PARTS ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_PARTS ("SESSION_ID", "REQUEST_ID", "PART", "PART_DATA") AS 
  SELECT p.session_id,
            p.request_id,
            p.part,
            p.part_data
       FROM pfu_request_parts p
   ORDER BY part;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_PARTS.sql =========*** End *** ===
PROMPT ===================================================================================== 
