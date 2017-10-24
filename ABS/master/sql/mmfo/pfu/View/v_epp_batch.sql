

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_EPP_BATCH.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EPP_BATCH ***

  CREATE OR REPLACE FORCE VIEW PFU.V_EPP_BATCH ("ID", "NAME", "BATCH_DATE", "BATCH_LINES_COUNT", "COUNT_GOOD", "STATE") AS 
  SELECT t.id,
          t.pfu_batch_id name,
          t.batch_date,
          t.batch_lines_count,
          (SELECT COUNT (1)
             FROM pfu_epp_line p
            WHERE p.batch_request_id = t.id AND p.state_id NOT IN (3, 4))
             count_good,
          r.state
     FROM pfu_epp_batch_request t, pfu_request r
    WHERE r.id = t.id;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_EPP_BATCH.sql =========*** End *** ===
PROMPT ===================================================================================== 
