
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tarif_op.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TARIF_OP 
 (p_type    in number,        -- 1-5 -тип суми комисии
  p_tarif   in number,        -- код тариаф
  p_curid   in oper.kv%type,  -- код валюты
  p_amount  in oper.s%type,   -- сума основной операции
  p_accnum  in oper.nlsb%type,-- счет
  p_tt      in oper.tt%type,  -- код операции
  p_percent in number)        -- процент комисии в валюте
  return number
is
  l_amount number(38);  -- сумма комисии

/*
 04-11-2010 Sta
    Грн-экв.комисии по оф.курсу от trunc(SYSDATE)
    См: --1. и --2.
*/

begin
  -- сумма комиссии в валюте
   if p_type = 1 then

     if p_tt = 'CD1' then
     --Тариф для орерации CD1
          if p_amount <= 1000001 then
             l_amount := f_tarif(p_tarif, p_curid, p_accnum, p_amount);
          else
             l_amount := 13500 + round(((1000000 + ceil((p_amount-1000000)/100000)*100000)-1000000)/100000)*1000;
          end if;
     elsif p_tt = 'CA1' then
     --Тариф для орерации CA1
          if p_amount <= 300001 then
             l_amount := f_tarif(p_tarif, p_curid, p_accnum, p_amount);
          else
             l_amount :=12000 + round(((300000 + ceil((p_amount-300000)/50000)*50000)-300000)/50000)*2000;
          end if;
     elsif p_tt = 'CA2' then
    --Тариф для орерации CA2
       if p_amount <= 200001 then
          l_amount := f_tarif(p_tarif, p_curid, p_accnum, p_amount);
       else
          l_amount := 4000 + round(((200000 + ceil((p_amount-200000)/50000)*50000)-200000)/50000)*1000;
       end if;
      elsif  p_tt ='CA3' then
      --Тариф для орерации CA3
       if p_amount <= 10000001 then
          l_amount := f_tarif(p_tarif, p_curid, p_accnum, p_amount);
       else
          l_amount := 180000 + round(((10000000 + ceil((p_amount-10000000)/2000000)*2000000)-10000000)/2000000)*30000;
       end if;
       elsif p_tt = 'CAG' then
    --Тариф для операции CAG
       if p_amount <= 200001 then
          l_amount := f_tarif(p_tarif, p_curid, p_accnum, p_amount);
       else
          l_amount := 4000 + round(((200000 + ceil((p_amount-200000)/50000)*50000)-200000)/50000)*1000;
       end if;
      elsif p_tt = 'CDD' then
      --Тариф для орерации CDD
       if p_amount <= 350001 then
          l_amount := f_tarif(p_tarif, p_curid, p_accnum, p_amount);
       else
          l_amount := 12900 + round(((350000 + ceil((p_amount-350000)/50000)*50000)-350000)/50000)*2000;
       end if;
     end if;

  -- сумма комиссии в грн.эквиваленте
  elsif p_type = 2 then
      l_amount := f_tarif_op(1, p_tarif, p_curid, p_amount, p_accnum, p_tt, p_percent);
--1.  l_amount := gl.p_icurval(p_curid, l_amount, bankdate);
      l_amount := gl.p_icurval(p_curid, l_amount, trunc(sysdate)  );

  -- 60% от суммы комиссии в валюте
  elsif p_type = 3 then
     -- l_amount := f_tarif_op(2, p_tarif, p_curid, p_amount, p_accnum, p_tt, p_percent) * p_percent;
     --l_amount := gl.p_ncurval (p_curid, l_amount, bankdate);
      l_amount := f_tarif_op(1, p_tarif, p_curid, p_amount, p_accnum, p_tt, p_percent) * p_percent;

  -- 60% от суммы комиссии в грн.эквиваленте
  elsif p_type = 4 then
      l_amount := f_tarif_op(3, p_tarif, p_curid, p_amount, p_accnum, p_tt, p_percent);
--2.  l_amount := gl.p_icurval (p_curid, l_amount, bankdate);
      l_amount := gl.p_icurval (p_curid, l_amount, trunc(sysdate) );

  -- 40% от суммы комиссии в грн.эквиваленте
  elsif p_type = 5 then
      l_amount := f_tarif_op(2, p_tarif, p_curid, p_amount, p_accnum, p_tt, p_percent)
                - f_tarif_op(4, p_tarif, p_curid, p_amount, p_accnum, p_tt, p_percent);
  else
      l_amount := 0;
  end if;
  return round(l_amount);
end F_TARIF_OP;
/
 show err;
 
PROMPT *** Create  grants  F_TARIF_OP ***
grant EXECUTE                                                                on F_TARIF_OP      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_TARIF_OP      to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tarif_op.sql =========*** End ***
 PROMPT ===================================================================================== 
 