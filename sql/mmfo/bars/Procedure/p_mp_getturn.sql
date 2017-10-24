

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_MP_GETTURN.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_MP_GETTURN ***

  CREATE OR REPLACE PROCEDURE BARS.P_MP_GETTURN (p_dat date)
is
-------------
--   Процедура по накоплению оборотов по перечню счетов. Сбербанк, для М.П.
--   ver.1.0 02/12/2013
--   Параметры:
--         p_dat  - дата формирования 
-------------
  q_Dat_Beg  date := trunc(add_months(p_dat,-1),'MM');     -- первая дата пред.месяца
  q_Dat_End  date := trunc(               p_dat,'MM');     -- первая дата текущего месяца 

  l_title   varchar2(20) := 'P_MP_GETTURN:'; -- для трассировки
  l_cnt     number;
  l_datfmt  char(2);
  
begin

 -- проанализируем входящую дату. выполняем расчет только 01/01, 01/04, 01/07, 01/10 - в начале квартала за предыдущий квартал. иначе - выходим.
 select to_char(p_dat,'DD') into l_datfmt from dual;
 if l_datfmt <> '01' then return;
 end if;

 delete from mp_turn;
 commit;

 bars_audit.trace('%s 1.Старт процедуры накопления оборотов по счетам для М.П.',l_title);
 
  insert into mp_turn_TMP (fdat, ref, acc, dk, s, sq, stmt)
    select fdat, ref, acc, dk, s, sq, stmt
      from opldok o
     where sos = 5 and fdat >= q_Dat_Beg and fdat < q_Dat_End; 
       

  begin
    for k in (select m.nlsa, a.acc acca, m.nlsb, aa.acc accb from mp_turn_acc m, accounts a, accounts aa where a.nls = m.nlsa and a.kv = m.kva and aa.nls = m.nlsb and aa.kv = m.kvb  )
       loop
         for l in (select o1.fdat, sum(o1.s)/100  ss 
                     from mp_turn_TMP o1, mp_turn_TMP o2
                    where o1.acc = k.acca and o1.dk = 0 and o1.stmt = o2.stmt and o1.ref = o2.ref 
                      and o2.dk = 1 and o2.acc = k.accb
                      group by o1.fdat)
                 loop  
                    insert into mp_turn (   dat,   nlsa,   nlsb,  summa)
                               values   (l.fdat, k.nlsa, k.nlsb,   l.ss);
                 end loop;   
       end loop;
  end;     
  
 commit;  
 bars_audit.trace('%s 2.Финиш процедуры накопления оборотов по счетам для М.П.',l_title);

exception when others then 
    bars_audit.error (dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace()); 
    raise_application_error(-20000, dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
    
end p_mp_getturn;
/
show err;

PROMPT *** Create  grants  P_MP_GETTURN ***
grant EXECUTE                                                                on P_MP_GETTURN    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_MP_GETTURN    to MVO;
grant EXECUTE                                                                on P_MP_GETTURN    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_MP_GETTURN.sql =========*** End 
PROMPT ===================================================================================== 
