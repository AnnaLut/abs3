
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_swi_sum_980.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SWI_SUM_980 (p_mode int)  return number is
/* ‘ункци€ расчета коммисий по платежам по внешним системами - SWI (Single Windows Interface) */
-- p_mode = 0 обща€ комисси€   в грн = saq_
-- p_mode = 1 комисси€ банку   в грн = sbq_
-- p_mode = 2 комисси€ системы в грн = ssq_
-- p_mode = 3 комисси€ системы в вал = ssn_
  saq_ number;
  sbq_ number;
  ssq_ number;
  ssn_ number;
  kv_ int    ;
  l_date_tran date default sysdate;
begin

 begin
    select to_number (w.value) *100 into saq_ from operw w where w.ref = gl.aRef and w.tag  = 'PCOMA';
    select kv                       into kv_  from oper    where   ref = gl.aRef ;
 exception when no_data_found then return 0;
 end;

 if p_mode = 0 then --обща€ комисси€   в грн
    return saq_;
 end if;

 begin
     select to_number (w.value) *100 into sbq_ from operw w where w.ref = gl.aref and w.tag  = 'PCOMB';
 exception when no_data_found then  sbq_ :=0 ;
 end;

 -- вычиcл€ем коммисию банка, если не передали, согласно процентному коэфициенту из таблицы swi_mti_curr
 barsweb_session.set_session_id(sys_context('bars_global','session_id'));
 if sbq_ <= 0 then
    begin
      select round( saq_*v.pcomb/100-0.5, 0) -- заведомо уменьшаем на пол копейки, чтобы при округлении "больше" досталось агенту
      into  sbq_
      from  swi_mti_curr v where num = barsweb_session.get_varchar2('swi_mti_code') and kv= kv_ and v.pcomb is not null;
    exception when no_data_found then  sbq_ :=0 ;
    end;
 end if;

 if p_mode = 1 then --комисси€ банку   в грн
    return sbq_;
 end if;

 if kv_ = 980 then
 	return 0;
 end if;

 ssq_ :=saq_ - sbq_;
 If p_mode = 2 then --комисси€ системы в грн
    return ssq_;
 end if;

 l_date_tran := sysdate;
 begin
    select to_date (w.value, 'DD/MM/YYYY' ) into l_date_tran from operw w where w.ref = gl.aRef and w.tag  = 'DATT';
 exception when others then l_date_tran := trunc(sysdate);
 end;

 if p_mode = 3 then --комисси€ системы в вал (дабавл€ем 1 коп., чтобы не "обидеть" агента)
    return gl.p_ncurval ( kv_, ssq_+1, trunc(l_date_tran) );
 end if;

 return 0;

end f_swi_sum_980;
/
 show err;
 
PROMPT *** Create  grants  F_SWI_SUM_980 ***
grant EXECUTE                                                                on F_SWI_SUM_980   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_SWI_SUM_980   to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_swi_sum_980.sql =========*** End 
 PROMPT ===================================================================================== 
 