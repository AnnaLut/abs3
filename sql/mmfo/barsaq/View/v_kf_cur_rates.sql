

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_KF_CUR_RATES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KF_CUR_RATES ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_KF_CUR_RATES ("VDATE", "KF", "KV", "BSUM", "RATE_O", "RATE_B", "RATE_S") AS 
  SELECT c.vdate,
          SUBSTR (c.branch, 2, 6) kf,
          c.kv,
          c.bsum,
          c.rate_o,
          c.rate_b,
          c.rate_s
     FROM bars.cur_rates$base c, bars.tabval$global t
    WHERE c.kv=t.kv and branch LIKE '/______/';



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_KF_CUR_RATES.sql =========*** End *
PROMPT ===================================================================================== 
