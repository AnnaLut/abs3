 
PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/type/TT_DEPOSIT_OPTION.sql ===== *** Run *** ===
PROMPT =====================================================================================

create or replace type tt_deposit_option force as table of t_deposit_option;
/

PROMPT *** Create  grants  TT_DEPOSIT_OPTION ***

grant EXECUTE    on TT_DEPOSIT_OPTION to WR_ALL_RIGHTS;
grant EXECUTE    on TT_DEPOSIT_OPTION to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ====== Scripts /Sql/BARS/type/TT_DEPOSIT_OPTION.sql ===== *** End *** ===
PROMPT =====================================================================================