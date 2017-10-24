
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fostq_sp.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTQ_SP 
  ( p_day int,
    p_kv  int,  -- код вал дл€ экв, или <= дл€ номинала
    p_acc INT,
    p_fdat DATE)
    RETURN DECIMAL IS

    -- Ќепогаш.задолженность свыше p_day дней

    l_nn     DECIMAL:=0;
    l_dat0   date;
    l_dos    number; --  всего вынесено на просрочку (с самого начала до отчетной даты - p_day)
    l_kos    number; --  всего погашено (с самого начала до отчетной даты )
    l_ostf   number;

BEGIN

    select -nvl(ostf,0) into l_ostf from saldoa s
     where pdat is null and fdat = (select min(fdat) from saldoa where acc = s.acc) and acc = p_acc;

    select nvl(sum(dos),0) into l_dos from saldoa where fdat <= p_fdat-p_day and acc = p_acc;

    if l_ostf + l_dos > 0 then
      select nvl(sum(kos),0) into l_kos from saldoa where fdat <= p_fdat  and acc = p_acc;
      l_nn := l_ostf + l_dos - l_kos;
    end if;

    If  p_kv <= 0 then RETURN greatest(                  l_nn,       0);
    else               return greatest(gl.p_icurval(p_kv,l_nn,p_fdat),0);
    end if;

END FOSTQ_SP;
/
 show err;
 
PROMPT *** Create  grants  FOSTQ_SP ***
grant EXECUTE                                                                on FOSTQ_SP        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOSTQ_SP        to RCC_DEAL;
grant EXECUTE                                                                on FOSTQ_SP        to RPBN001;
grant EXECUTE                                                                on FOSTQ_SP        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fostq_sp.sql =========*** End *** =
 PROMPT ===================================================================================== 
 