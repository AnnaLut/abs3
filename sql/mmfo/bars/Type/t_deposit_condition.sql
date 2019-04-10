 
PROMPT ===================================================================================== 
PROMPT *** Run *** ==== Scripts /Sql/BARS/type/T_DEPOSIT_CONDITION.sql ===== *** Run *** ===
PROMPT ===================================================================================== 

create or replace type t_deposit_condition force as object
   (
        id                          number
       ,interest_option_id          number
       ,currency_id                 number
       ,term_unit                   number
       ,term_from                   number
       ,amount_from                 number
       ,interest_rate               number
       -- deposit_payment, deposit_capitalization
       ,payment_term_id             number
       -- deposit_prolongation
       ,apply_to_first              number
      -- rate_for_return_tranche
       ,rate_from                   number
       ,penalty_rate                number
      -- deposit_amount_setting
       ,min_sum_tranche             number
       ,max_sum_tranche             number
       ,min_replenishment_amount    number
       ,max_replenishment_amount    number
      -- terms_replenishment_tranche
      ,tranche_term                 number
      ,days_to_close_replenish      number
      -- terms_replenishment_tranche, deposit_amount_setting
      ,product_id                   number
      -- deposit_on_demand_calc_type
      ,calculation_type_id          number
      -- deposit_replenishment
      ,is_replenishment             number
      -- deposit_prolongation_bonus  
      ,is_prolongation              number
  )
/

PROMPT *** Create  grants  T_DEPOSIT_CONDITION ***

grant EXECUTE    on T_DEPOSIT_CONDITION to WR_ALL_RIGHTS;
grant EXECUTE    on T_DEPOSIT_CONDITION to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ==== Scripts /Sql/BARS/type/T_DEPOSIT_CONDITION.sql ===== *** End *** ===
PROMPT ===================================================================================== 
