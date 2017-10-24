

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SMS_CONFIRM_ADM.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SMS_CONFIRM_ADM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SMS_CONFIRM_ADM ("NAME", "VALUE") AS 
  SELECT 'On/Off параметр CELLPHONE_CONFIRMATION' name,
          to_number(VALUE)
     FROM cac_params
    WHERE name = 'CELLPHONE_CONFIRMATION';

PROMPT *** Create  grants  V_SMS_CONFIRM_ADM ***
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_SMS_CONFIRM_ADM to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SMS_CONFIRM_ADM.sql =========*** End 
PROMPT ===================================================================================== 
