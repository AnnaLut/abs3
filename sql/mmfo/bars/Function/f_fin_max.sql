CREATE OR REPLACE FUNCTION BARS.F_FIN_MAX (p_dat01 date, p_nd integer, p_fin integer, p_tipa integer) RETURN date is

/* Версия 1.0   10-04-2018 
   Дата возникновения максимального значения фин.класса
*/

l_fdat    nbu23_rez.fdat%type; 
l_start   date := to_date('03-01-2017','dd-mm-yyyy'); -- дата початку дії постанови 351  ( COBUSUPABS-7190 "Заявка загальні доопрацювання продовження.pdf п.5)

begin
   for k in (select distinct fdat,nd,fin from rez_cr where fdat >=l_start and  fdat <= P_dat01 and nd = p_nd and pd_0<>1 and tipa = p_tipa order by fdat desc)
   loop
      if k.fin = p_fin THEN   l_fdat := k.fdat;
      else  
      return least(l_fdat,p_dat01);
      end if;             
   end loop;
   return least(l_fdat,p_dat01);
end;
/
 show err;
 
PROMPT *** Create  grants  F_FIN_MAX ***
grant EXECUTE                        on F_FIN_MAX to BARS_ACCESS_DEFROLE;
grant EXECUTE                        on F_FIN_MAX to START1;

