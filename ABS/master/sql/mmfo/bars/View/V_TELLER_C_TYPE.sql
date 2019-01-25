
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_teller_c_type.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_TELLER_C_TYPE ("C_TYPE") AS 
  select 'http' as c_type from dual
union
select 'https' from dual
;
 show err;
 
PROMPT *** Create  grants  V_TELLER_C_TYPE ***
grant SELECT                                                                 on V_TELLER_C_TYPE to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on V_TELLER_C_TYPE to WR_REFREAD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_teller_c_type.sql =========*** End **
 PROMPT ===================================================================================== 
 