
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_cena_cp.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CENA_CP (p_id int, p_dat date, reg int default 0) return number  is
l_cena_start number;
l_nom number:=0; l_kup number;
l_cena number; l_npp int;
-- v.1.2 28/04-15  28/10-14
-- return cena, kup or npp
begin
begin
select nvl(cena_start,cena)  into l_cena_start
from cp_kod where id=p_id;
EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
 --  l_sErr := l_sErr || l_kv|| ' НЕ знайдено рах '|| nvl(B_4621,'4221');
 --  raise_application_error(  -20203,l_sErr, TRUE);
return null;
end;
begin
select npp, nom, kup into l_npp, l_nom, l_kup
from cp_dat_v where id=p_id and dok <= p_dat and p_dat < dnk;
select l_cena_start - nvl(sum(nvl(nom,0)),0) into l_cena
from cp_dat_v
where id=p_id and dnk < p_dat;
EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
l_cena:=l_cena_start;
end;
if reg=0 then return l_cena;
elsif reg=1 then return l_kup;
elsif reg=2 then return l_npp;
end if;
end;
/
 show err;
 
PROMPT *** Create  grants  F_CENA_CP ***
grant EXECUTE                                                                on F_CENA_CP       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_cena_cp.sql =========*** End *** 
 PROMPT ===================================================================================== 
 