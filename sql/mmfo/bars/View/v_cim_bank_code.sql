

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_BANK_CODE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_BANK_CODE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_BANK_CODE ("BIC", "B010", "BANK_NAME") AS 
  select b.bic, r.b010, b.name as bank_name from sw_banks b left outer join rc_bnk r on translate(r.swift_code, 'p ','p') =substr(b.bic,1,8)
   union all
   select null, null, null from dual;

PROMPT *** Create  grants  V_CIM_BANK_CODE ***
grant SELECT                                                                 on V_CIM_BANK_CODE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_BANK_CODE.sql =========*** End **
PROMPT ===================================================================================== 
