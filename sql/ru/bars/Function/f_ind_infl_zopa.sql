
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ind_infl_zopa.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_IND_INFL_ZOPA ( p_S number,p_DAT0 date) RETURN number IS
  DAT0_ date;  DATi_ date; i_ int; S_ number; IR_ number;
begin
  DAT0_ := trunc( p_DAT0   , 'MM' );
  DATi_ := trunc( gl.BDATE , 'MM' );
  i_    := months_between  (DATi_,DAT0_);
  S_    := p_S ;
  If I_ <= 0 then return S_; end if;
  ----------------------------------
  for k in (select add_months(DAT0_,c.num) FDAT
            from conductor c
            where c.num <= i_
            order by c.num )
  loop
     begin
       select IR into ir_ from IND_INFL where IDAT = k.FDAT;
     exception when no_data_found then IR_:=0;
     end;
     S_ :=  S_ * IR_/100;
  end loop;
  if
   S_<p_s then
   S_ :=p_s;
   end if;
 RETURN s_;

end F_IND_INFL_ZOPA;
/
 show err;
 
PROMPT *** Create  grants  F_IND_INFL_ZOPA ***
grant EXECUTE                                                                on F_IND_INFL_ZOPA to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_IND_INFL_ZOPA to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ind_infl_zopa.sql =========*** En
 PROMPT ===================================================================================== 
 