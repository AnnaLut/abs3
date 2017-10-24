
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_d3801.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_D3801 (ref_ number, tt_ varchar2,
              acc3801_ number, dk_ number, accd_ number, acck_ number) return number is
 -------------------------------------------------------------------
 -- ¬≈–—»я:  03.12.2004
 -------------------------------------------------------------------
 -- расчет суммы эквивалента, дл€ дочерних операций в валютообменных
 --   операций по кассе
 -- параметры:
 --    ref_ - идентификатор документа
 --    tt_ - код операции
 --    acc3801_ - код счета еквивалента
 --    dk_ - дебет/кредит
 --    accd_ - код счета результата торговли валютой по дебету
 --    acck_ - код счета результата торговли валютой по кредиту
 -------------------------------------------------------------------
	sum_ number;
	l_dk_ number:=1-dk_;
begin
	select sum(o.s)
	into sum_
	from opldok o, opldok o1, accounts a1
	where o.ref=ref_
	  and o.acc=acc3801_
	  and o.dk=dk_
      and o1.ref=o.ref
      and o1.tt=tt_
      and o1.tt=o.tt
      and o1.stmt=o.stmt
      and o1.dk=l_dk_
      and o1.acc not in (accd_, acck_)
      and o1.acc=a1.acc
	  and substr(a1.nls,1,3) in ('100','110') and a1.kv=980 ;

	return sum_;
exception
   when no_data_found then
  	    return 0;
end;
 
/
 show err;
 
PROMPT *** Create  grants  F_D3801 ***
grant EXECUTE                                                                on F_D3801         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_D3801         to RPBN002;
grant EXECUTE                                                                on F_D3801         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_d3801.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 