PROMPT ====================================================================================== 
PROMPT *** Run *** ==== Scripts /Sql/BARS/type/t_deposit_calculator.sql ===== *** Run *** ===
PROMPT ====================================================================================== 

create or replace type t_deposit_calculator force is object
    (
        id                  number
       ,account_id          number
       ,start_date          date
       ,end_date            date
       ,amount_deposit      number
       ,amount_for_accrual  number
       ,interest_rate       number
       ,interest_amount     number
       ,interest_tail       number
       ,accrual_method      number
       ,currency_id         number
       ,comment_            varchar2(500)
)
/

PROMPT *** Create  grants  T_DEPOSIT_CALCULATOR ***

grant EXECUTE    on t_deposit_calculator to WR_ALL_RIGHTS;
grant EXECUTE    on t_deposit_calculator to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ==== Scripts /Sql/BARS/type/t_deposit_calculator.sql ==== *** End *** ===
PROMPT ===================================================================================== 
