

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_KF_CUR_RATES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KF_CUR_RATES ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_KF_CUR_RATES ("VDATE", "KF", "KV", "BSUM", "RATE_O", "RATE_B", "RATE_S") AS 
  select c.vdate, substr(c.branch,2,6) kf, c.kv, c.bsum, c.rate_o, c.rate_b, c.rate_s
	from bars.cur_rates$base c
    where branch like '/______/';



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_KF_CUR_RATES.sql =========*** End *
PROMPT ===================================================================================== 
