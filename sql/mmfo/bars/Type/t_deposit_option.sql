
PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/type/T_DEPOSIT_OPTION.sql ====== *** Run *** ===
PROMPT ===================================================================================== 

create or replace type t_deposit_option force as object(
        id                  number,
        product_id          number,
        rate_kind_id        number,
        valid_from          date,
        valid_through       date,
        is_active           number,
        option_description  varchar2(100),
        user_id             number,
        sys_time            date,
        list_condition      tt_deposit_condition  
)
/

PROMPT *** Create  grants  T_DEPOSIT_OPTION ***

grant EXECUTE    on T_DEPOSIT_OPTION to WR_ALL_RIGHTS;
grant EXECUTE    on T_DEPOSIT_OPTION to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ====== Scripts /Sql/BARS/type/T_DEPOSIT_OPTION.sql ====== *** End *** ===
PROMPT ===================================================================================== 

