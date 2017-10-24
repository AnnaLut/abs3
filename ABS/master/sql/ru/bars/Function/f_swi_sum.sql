
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_swi_sum.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SWI_SUM (p_mode int)  return number is
/* Функция расчета коммисий по платежам по внешним системами - SWI (Single Windows Interface) */
-- p_mode = 0 общая комиссия   в грн = saq_
-- p_mode = 1 комиссия банку   в грн = sbq_
-- p_mode = 2 комиссия системы в грн = ssq_
-- p_mode = 3 комиссия системы в вал = ssn_
-- p_mode = 2 комиссия системы в грн = ssq (отдельный режим для доч. C4F (CN4))
  saq_ number; -- валюта
  sbq_ number;
  ssq_ number;
  ssn_ number;
  kv_ int    ;
  l_date_tran date default sysdate;
  l_cclc int default NULL;
begin

 barsweb_session.set_session_id(sys_context('bars_global','session_id'));
 begin
    select round(to_number (w.value) *100) into saq_ from operw w where w.ref = gl.aRef and w.tag  = 'PCOMA';
    select kv                       into kv_  from oper    where   ref = gl.aRef ;
 exception when no_data_found then return 0;
 end;

 -- вычисляем дату операции - реквизит DATT, курсы считаем за нее
 l_date_tran := trunc(sysdate);
 begin
    select to_date (w.value, 'DD/MM/YYYY' ) into l_date_tran from operw w where w.ref = gl.aRef and w.tag  = 'DATT';
 exception when others then l_date_tran := trunc(sysdate);
 end;
-- вычисляем признак поступления комиссии в нац. валюте
 begin
    select v.cclc into l_cclc from swi_mti_curr v where v.num = barsweb_session.get_varchar2('swi_mti_code') and v.kv= kv_;
    exception when others then l_cclc := NULL;
 end;
 if p_mode = 0 then --общая комиссия   в грн
	if kv_ = GL.BASEVAL then
		return saq_;
    else
        return gl.p_icurval( kv_, saq_, l_date_tran);
    end if;
 end if;

 begin
     select round(to_number (w.value) *100) into sbq_ from operw w where w.ref = gl.aref and w.tag  = 'PCOMB';
 exception when no_data_found then  sbq_ :=0 ;
 end;
 -- учитываем вариант акционной комиссии
 if saq_ < sbq_ then
    begin
       sbq_ := saq_;
       saq_ := 0;
    end;
 end if;
 -- вычиcляем коммисию банка, если не передали, согласно процентному коэфициенту из таблицы swi_mti_curr
 --barsweb_session.set_session_id(sys_context('bars_global','session_id'));
 if sbq_ <= 0 then
    begin
      select
      -- учитываем алгоритм расчета комиссии в СМП (v.alg = 1 - Кб, иначе Ko-Ka )
      decode(nvl(v.alg,0),1,round( saq_ * v.pcomb / 100, 0),saq_ - round( saq_ * (100 - v.pcomb) / 100, 0))
      into  sbq_
      from  swi_mti_curr v where num = barsweb_session.get_varchar2('swi_mti_code') and kv= kv_ and v.pcomb is not null;
    exception when no_data_found then  sbq_ :=0 ;
    end;
 end if;

 if p_mode = 1 then --комиссия банку   в грн
    if kv_ = GL.BASEVAL then
        return sbq_;
    else
        if l_cclc is not null then
            -- расчет по комиссии в грн не нужно подстраиваться под ошибки оругления, сколько насчитали столько и берем себе
            return gl.p_icurval ( kv_, sbq_, l_date_tran);
        else
            return abs(gl.p_icurval ( kv_, saq_, l_date_tran) - gl.p_icurval ( kv_, saq_ - sbq_, l_date_tran)); --gl.p_icurval ( kv_, sbq_, l_date_tran);
        end if;
    end    if;
 end if;

 if kv_ = GL.BASEVAL and p_mode <> 4 then
     return 0;
 end if;

 ssq_ :=saq_ - sbq_;
 If p_mode = 2 then --комиссия системы в грн
    if ssq_ > 0 then
        if l_cclc is not null then
            return 0;
        else
            return gl.p_icurval( kv_, ssq_, l_date_tran);
        end if;
    else
        return 0;
    end if;
 end if;

 if p_mode = 3 then --комиссия системы в вал (дабавляем 1 коп., чтобы не "обидеть" агента)
    if ssq_ > 0 then
        if l_cclc is not null then
            return 0;
        else
            return ssq_;
        end if;
    else
        return 0;
    end if;
 end if;
--комиссия системы в грн отдельный режим для доч. C4F (CN4)
if p_mode = 4 then
    if ssq_ > 0 then
		if kv_ = GL.BASEVAL then
			return ssq_;
		else
			if l_cclc is not null then
				return gl.p_icurval( kv_, ssq_, l_date_tran);
			else
				return 0;
			end if;
		end if;
	else
		return 0;
	end if;
end if;
 return 0;

end f_swi_sum;
/
 show err;
 
PROMPT *** Create  grants  F_SWI_SUM ***
grant EXECUTE                                                                on F_SWI_SUM       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_SWI_SUM       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_swi_sum.sql =========*** End *** 
 PROMPT ===================================================================================== 
 