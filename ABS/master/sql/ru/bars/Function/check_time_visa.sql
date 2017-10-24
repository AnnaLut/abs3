
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/check_time_visa.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CHECK_TIME_VISA RETURN NUMBER IS
  p_cnt  int;

begin
  select count(*)
    into p_cnt
    from oper o, oper_visa v
   where o.pdat > trunc(sysdate)
     and o.sos > 0
     and o.sos < 5
     and o.tt in (select tt from CHECK_TIME_TTS)
     and o.ref = v.ref
     and o.nextvisagrp = (select lpad(chk.to_hex(idchk),2,'0') from chklist_tts c where c.tt = o.tt and c.priority = (select max(priority) from chklist_tts where tt = c.tt))
     and (sysdate - v.dat)*1440 > 15
     and nvl(lpad(chk.to_hex(v.groupid),2,'0'),'0') = nvl(o.currvisagrp,'0')
     and o.branch = sys_context('BARS_CONTEXT','USER_BRANCH');

  if p_cnt > 0 then
    bars_error.raise_nerror('BRS', 'CHECK_TIME_VISA_TT', sys_context('BARS_CONTEXT','USER_BRANCH'));
  else
    return 0;
  end if;

end CHECK_TIME_VISA;
/
 show err;
 
PROMPT *** Create  grants  CHECK_TIME_VISA ***
grant EXECUTE                                                                on CHECK_TIME_VISA to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CHECK_TIME_VISA to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/check_time_visa.sql =========*** En
 PROMPT ===================================================================================== 
 