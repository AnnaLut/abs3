  CREATE OR REPLACE FUNCTION BARS.F_ND_CLOSE (p_nd integer) RETURN number is

/* Версия 1.0 18-07-2018
   Определение закрытого договора
   -------------------------------------
*/

L_cl  number;

begin
   begin
      select 1 into l_cl from  nd_acc n, accounts a where n.nd = p_nd and N.acc= a.acc and a.tip='LIM' and dazs is not null; 
   EXCEPTION WHEN NO_DATA_FOUND THEN l_cl := 0 ;
   end;
   return (l_cl);
end;
/
 show err;
 
PROMPT *** Create  grants F_ND_CLOSE ***
grant EXECUTE                                                                on F_ND_CLOSE        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_ND_CLOSE        to START1;
