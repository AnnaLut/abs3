
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ret_rate.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_RET_RATE (p_kv cur_rates$base.kv%type, p_dat cur_rates$base.vdate%type, p_fl varchar2 default 'O')
/*
    O --оф. курс
    B --покупки
    S --продажы
*/
    return number
  is
   rato_ cur_rates$base.rate_o%type;
   ratb_ cur_rates$base.rate_b%type;
   rats_ cur_rates$base.rate_s%type;
   bsum_   cur_rates$base.bsum%type;
BEGIN

          begin
           SELECT rate_o,rate_b,rate_s, bsum
               INTO rato_, ratb_, rats_, bsum_
               FROM cur_rates WHERE (kv,vdate) =
            (SELECT kv,MAX(vdate) FROM cur_rates
              WHERE kv=p_kv AND vdate <= p_dat GROUP BY kv);

          EXCEPTION
             WHEN NO_DATA_FOUND THEN
                  raise_application_error(-20000, '9314 - No rate was set for currency #('||p_kv||'@'||p_dat||')');
          end;

         if     p_fl='O' then return rato_/bsum_;
         elsif  p_fl='B' then return ratb_/bsum_;
         elsif  p_fl='S' then return rats_/bsum_;
         else   return null;
         end if;

END f_ret_rate;
/
 show err;
 
PROMPT *** Create  grants  F_RET_RATE ***
grant EXECUTE                                                                on F_RET_RATE      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_RET_RATE      to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ret_rate.sql =========*** End ***
 PROMPT ===================================================================================== 
 