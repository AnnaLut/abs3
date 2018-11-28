
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/view/v_resolutions.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BILLS.V_RESOLUTIONS ("NAME", "RES_CODE", "RES_DATE", "LAST_DT", "RESPONSE", "COURTNAME") AS 
  select d.name, r.res_code, r.res_date, r.last_dt, r.response, r.courtname
  from resolutions r,
       dict_status d
  where r.status = d.code
    and d.type = 'R'
;
 show err;
 
PROMPT *** Create  grants  V_RESOLUTIONS ***
grant SELECT                                                                 on V_RESOLUTIONS   to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/view/v_resolutions.sql =========*** End ***
 PROMPT ===================================================================================== 
 