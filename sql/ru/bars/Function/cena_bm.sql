
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cena_bm.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CENA_BM ( p_mod IN Int, p_kod IN bank_metals$local.kod%type ) return   bank_metals$local.cena%type IS
   cena_ bank_metals$local.cena%type;
   sdat_ date :=  trunc(sysdate);
   pdat_ date;
begin

    begin
         select max(fdat)
		 into pdat_   -- попередня банківська дата
		 from fdat
		 where fdat <gl.BD;
    EXCEPTION WHEN NO_DATA_FOUND THEN  cena_ := null;
  end;

  begin
    SELECT decode( p_mod, 1, L.cena, L.cena_k )  into cena_ from bank_metals$local L
    where L.kod  =  p_kod
      and ((L.fdat =  (select max(fdat) from bank_metals$local  where kod = L.kod and fdat between pdat_ and sysdate)
      and sdat_  >  pdat_
      and sdat_  < gl.bd)
            or (L.fdat =  (select max(fdat) from bank_metals$local  where kod = L.kod and fdat between sdat_ and sysdate)
                and  sdat_  = gl.bd ));
  EXCEPTION WHEN NO_DATA_FOUND THEN  cena_ := null;
  end;
    return cena_;
end cena_bm;
/
 show err;
 
PROMPT *** Create  grants  CENA_BM ***
grant EXECUTE                                                                on CENA_BM         to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cena_bm.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 