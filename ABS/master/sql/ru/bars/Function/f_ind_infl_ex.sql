
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ind_infl_ex.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_IND_INFL_EX 

( p_S number  , -- сумма начальная -номинальная
  p_DAT0 date , -- дата признания номинальной суммы
  p_DATi date   -- Отчетная дата для получения расчетной "инфлированной" суммы
) RETURN number IS

  l_DAT0  date;
  l_DATi  date;
  i_      int ;
  l_Si  number;
  l_ir  number;

begin

  l_DAT0 := trunc (      p_DAT0                                    , 'MM' ) ;
  l_DATi := trunc ( nvl (p_DATi, nvl(gl.BDATE , trunc(sysdate) ) ) , 'MM' ) ;

  i_    := months_between  (l_DATi, l_DAT0);
  l_Si  := p_S ;

  If I_ <= 0 then return l_Si; end if;
  ------------------------------------
  for k in (select add_months(l_DAT0,c.num) FDAT  from conductor c where c.num <= i_ order by c.num )
  loop
     begin
       select IR into l_Ir from IND_INFL where IDAT = k.FDAT;
     exception when no_data_found then l_IR := 100 ;
     end;
     l_Si :=  l_Si * l_IR / 100;
  end loop;

  RETURN round(l_Si,0) ;

end F_IND_INFL_ex;
/
 show err;
 
PROMPT *** Create  grants  F_IND_INFL_EX ***
grant EXECUTE                                                                on F_IND_INFL_EX   to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ind_infl_ex.sql =========*** End 
 PROMPT ===================================================================================== 
 