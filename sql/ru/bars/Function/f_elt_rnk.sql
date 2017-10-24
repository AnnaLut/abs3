
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_elt_rnk.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ELT_RNK (p_NLS varchar2, p_KV int default 980, p_reg int default 0)
return char is
l_nd varchar2(38);
l_rnk int;
l_nls varchar2(15);  l_nmk varchar2(38);
-- ! Только для портфеля абонплаты
-- Возвращает NLS/RNK или NMKK клиента для договора по р/счету (E_DEAL.nls26)

BEGIN
 begin
   select max(rnk) into l_rnk
          from e_deal
          where nls26=p_NLS;
   EXCEPTION WHEN NO_DATA_FOUND THEN l_rnk:=NULL;
 end;

begin
select trim(nvl(nmkk,nmk)) into l_nmk
from customer where rnk=l_rnk;
exception when NO_DATA_FOUND then l_nmk:='?';
end;

if p_reg=1 then
return ' '||p_nls||'/'||to_char(l_rnk);
else
return ' '||l_nmk;
end if;
end F_ELT_RNK;
/
 show err;
 
PROMPT *** Create  grants  F_ELT_RNK ***
grant EXECUTE                                                                on F_ELT_RNK       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_ELT_RNK       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_elt_rnk.sql =========*** End *** 
 PROMPT ===================================================================================== 
 