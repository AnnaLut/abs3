
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_spisokitem.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SPISOKITEM (s in varchar2, separator in char, ind in int) return varchar2 is
  -- Функція повертає ind - не слово в реченні s з роздыльником separator
  res varchar2(50) := '';
  i   int := 1;
  npp int := 1;
  c   char;
  s2  varchar2(500);
begin
  s2 := s;
  
while i<=length(s2) loop
  c := substr(s2, i, 1);
  if (c = separator) then
    npp := npp + 1;
    if (npp > ind) then
      exit;
    end if;
  else
    if (npp = ind) then
      res := res || c;
    end if;
  end if;
  i := i + 1;
end loop;
--res := trim(res);
return res;

end f_SpisokItem; 
 
/
 show err;
 
PROMPT *** Create  grants  F_SPISOKITEM ***
grant EXECUTE                                                                on F_SPISOKITEM    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_SPISOKITEM    to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_spisokitem.sql =========*** End *
 PROMPT ===================================================================================== 
 