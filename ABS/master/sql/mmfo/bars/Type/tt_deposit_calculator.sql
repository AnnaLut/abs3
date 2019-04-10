PROMPT ===================================================================================== 
PROMPT *** Run *** ==== Scripts /Sql/BARS/type/TT_DEPOSIT_CALCULATOR.sql === *** Run *** ===
PROMPT =====================================================================================

create or replace type tt_deposit_calculator force as table of t_deposit_calculator
/

PROMPT *** Create  grants  TT_DEPOSIT_CALCULATOR ***

grant EXECUTE    on tt_deposit_calculator to WR_ALL_RIGHTS;
grant EXECUTE    on tt_deposit_calculator to BARS_ACCESS_DEFROLE;

PROMPT ====================================================================================== 
PROMPT *** End *** ==== Scripts /Sql/BARS/type/TT_DEPOSIT_CALCULATOR.sql ==== *** End *** ===
PROMPT ====================================================================================== 