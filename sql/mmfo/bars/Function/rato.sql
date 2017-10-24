
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/rato.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.RATO (
    p_kv        number,
    p_dat       date)
return number
-- кеш базуємо на таблиці, а не на view
result_cache relies_on (cur_rates$base)
--
-- Повертаємо офіційний курс валюти за дату
-- SERG, 17/05/2010
--
-- Нагадування для себе:
-- Реалізація cur_rates$base не зовсім корректна,
-- бо офіційний курс однаковий для всіх, а він множиться по бранчах в cur_rates$base,
-- необхідно переписати
-- cur_rates = cur_rates_official(один для всіх) + cur_rates_commercial(в розрізі бранчів)
--
-- SERG 18/05/2010
--
is
 l_rat number;
begin
    select rate_o/bsum into l_rat
    from cur_rates
    where (kv,vdate) =
            ( select kv,max(vdate) from cur_rates
               where vdate <= p_dat and kv = p_kv
               group by kv);
    return l_rat;
exception when no_data_found then
    raise_application_error(-(20207),'\9314 - Не встановлено офіційний курс валюти '||p_kv
    ||' за дату '||to_char(p_dat,'DD.MM.YYYY')
    ||' по відділенню '||sys_context('bars_context','user_branch')
    ,true);
end rato;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/rato.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 