 
PROMPT ===================================================================================== 
PROMPT *** Run *** ==== Scripts /Sql/BARS/type/TT_DEPOSIT_CONDITION.sql ==== *** Run *** ===
PROMPT =====================================================================================

create or replace type tt_deposit_condition force as table of t_deposit_condition
/

PROMPT *** Create  grants  TT_DEPOSIT_CONDITION ***

grant EXECUTE    on TT_DEPOSIT_CONDITION to WR_ALL_RIGHTS;
grant EXECUTE    on TT_DEPOSIT_CONDITION to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ==== Scripts /Sql/BARS/type/TT_DEPOSIT_CONDITION.sql ==== *** End *** ===
PROMPT ===================================================================================== 