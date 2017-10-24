
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f540.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F540 ( p_sk   oper.sk%type   ,
                                       p_nazn oper.nazn%type ,
                                       p_ref  oper.ref%type  ,
                                       p_new  int            ,
                                       p_kv   oper.kv%type
                                     )
return number is
----------------------------------------------------
 l_ret  int ; ---   = 0  - Не суммируем в 150 тыс
              ---   = 1  - Суммируем в 150 тыс
----------------------------------------------------
 l_sk   oper.sk%type   := nvl(p_sk, 0)  ;
 l_nazn oper.nazn%type := upper (p_nazn);
begin

IF p_kv = 980 then          -------  1).  ГРН  -------------

   If l_sk < 40           or
      l_sk  in (40,50,59) or
      l_sk  = 61 and (l_NAZN like '%КОМАНД%' or l_NAZN like '%В_ДРЯД%')   then

      -- Не суммируем по СКП 40,50,59 и 61 c *відрядж* :

      l_ret := 0 ;

   Else

      -- Не суммируем с доп.рекв. NB540 "Діяльність Черв.Хреста (1-Так)"

      If p_new = 1 then ------- для ввода, который еще в незакрытой сессии

         If NVL(pul.get_mas_ini_val('NB540'),'0')='1' then
            l_ret := 0 ;
         else
            l_ret := 1 ;
         end if ;

      else              ------- для подсчета введенних ранее
         begin
           select 0 into l_ret from OperW where REF= p_ref and TAG ='NB540' and VALUE ='1';
         exception when no_data_found then
           l_ret := 1;
         end;
      end if;

   End If;

ELSE                 ---------   2).  ВАЛЮТA   ------------


   If l_sk < 40 then

      l_ret := 0 ;

      RETURN l_ret;

   End If;


   If p_new = 1 then ------- для ввода, который еще в незакрытой сессии

      If NVL(pul.get_mas_ini_val('NB758'),'0')='1' then
         l_ret := 0 ;
      else
         l_ret := 1 ;
      end if ;

   Else              ------- для подсчета введенних ранее

      begin
        select 0 into l_ret from OperW where REF= p_ref and TAG ='NB758' and VALUE ='1';
      exception when no_data_found then
        l_ret := 1;
      end;

   End if;


END IF;

RETURN l_ret;

end f540 ;
/
 show err;
 
PROMPT *** Create  grants  F540 ***
grant EXECUTE                                                                on F540            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F540            to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f540.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 