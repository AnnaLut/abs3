

PROMPT ===================================================================================== 
PROMPT *** Run ** = Scripts /Sql/BARS/View/v_trans2017_forecast_branch.sql =*** Run *** ====
PROMPT ===================================================================================== 




PROMPT *** Create  view v_trans2017_forecast_branch ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TRANS2017_FORECAST_BRANCH AS 
  SELECT tf.kf, tf.kv, tf.acc, tf.nbs, tf.nls, tf.ob22, tf.new_nbs, tf.new_ob22, tf.new_nls, tf.insert_date, ac.branch 
  FROM bars.transform_2017_forecast tf, bars.accounts ac
  WHERE ac.acc = tf.acc and ac.kf = tf.kf;

PROMPT *** Create  grants  V_TRANS2017_FORECAST_BRANCH ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_TRANS2017_FORECAST_BRANCH         to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_TRANS2017_FORECAST_BRANCH         to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_TRANS2017_FORECAST_BRANCH         to WR_ALL_RIGHTS;

PROMPT ===================================================================================== 
PROMPT *** End *** = Scripts /Sql/BARS/View/V_TRANS2017_FORECAST_BRANCH.sql =*** End *** ===
PROMPT ===================================================================================== 
