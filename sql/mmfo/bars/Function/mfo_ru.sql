
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/mfo_ru.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.MFO_RU (mfo_ varchar2) return number IS
  nRU_ int;
begin
  select r.ru
  into nRU_
  from BANKS_RU r, banks b
  where decode(b.mfop, gl.amfo, b.mfo, b.mfop) = r.mfo and b.mfo=mfo_;

  return nRU_;
end mfo_ru ;
/
 show err;
 
PROMPT *** Create  grants  MFO_RU ***
grant EXECUTE                                                                on MFO_RU          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MFO_RU          to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/mfo_ru.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 