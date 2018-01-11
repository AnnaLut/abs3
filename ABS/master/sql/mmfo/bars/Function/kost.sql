
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/kost.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.KOST (p_acc number, p_dat date) return number is
  -- получение расчетного значения остатка по счету p_acc на календарную дату  P_dat

  b2_dat date := dat_next_u(p_dat, 0); -- банк.дата . которая должна была быть установленной для календарной p_dat
  b3_dat date := dat_next_u(p_dat, 1); -- Следующая банк-бата
  ------------------------------------------
  b1_dat date; -- Предыдущая банк-бата
  l_ost  number := 0;
  l_del  number := 0;
begin

  if false then
    --   b2_dat  = P_dat then
    l_ost := fost(p_acc, b2_dat); --- кал.дата = банковской дате.

  else
    b1_dat := dat_next_u(p_dat, -1); -- кал.дата <  банковской дате. (бОЛЬШЕ не ДОЛЖНО БЫТЬ !)
    l_ost  := fost(p_acc, b1_dat); -- остаток пред раб дня
    -- +  дельта документов выходного дня
    --    по дате-времени вставки в OPER/
    --    Предполагаем, что визирование сделано тогда же.
    --    и потому не опускаемся до анализа в OPER_VISA
    select nvl(sum(decode(o.dk, 0, -1, +1) * o.s), 0)
      into l_del
      from opldok o, oper p
     where o.fdat >= b2_dat
       and o.fdat <= b3_dat
       and o.acc = p_acc
       and o.sos = 5
       and o.ref = p.ref
       and p.pdat < p_dat + 1;
    l_ost := l_ost + l_del;
  end if;
  return l_ost;
end kost;

/
 show err;
 
PROMPT *** Create  grants  KOST ***
grant EXECUTE                                                                on KOST            to ABS_ADMIN;
grant EXECUTE                                                                on KOST            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on KOST            to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/kost.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 