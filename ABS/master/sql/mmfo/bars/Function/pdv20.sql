
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/pdv20.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.PDV20 ( nazn1_ varchar2) return varchar2  IS

  NAZN2_ varchar2(160) := NAZN1_;
  PDV_   varchar2(160) ;
begin
  begin

    select ' '|| trim(to_char(round(s/6,0),'9999999999.99'))
    into PDV_
    from oper where ref=gl.aRef;

    If length(NAZN1_) + length(PDV_) <= 160 then
       NAZN2_ := NAZN1_ || PDV_;
    end if;

  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end;

  Return(NAZN2_);

end PDV20;
 
/
 show err;
 
PROMPT *** Create  grants  PDV20 ***
grant EXECUTE                                                                on PDV20           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PDV20           to START1;
grant EXECUTE                                                                on PDV20           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/pdv20.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 