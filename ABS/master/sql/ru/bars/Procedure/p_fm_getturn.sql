

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FM_GETTURN.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FM_GETTURN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FM_GETTURN (p_dat date, p_mode number)
is
-------------
--   Процедура по накоплению расчетных оборотов по клиентам для анкет ФМ
--   ver.2.0 22/08/2011
--   Параметры:
--           p_dat  - дата формирования (первая дата последующего за отчетным квартала, например 01/10/2011 для данных за 3-й квартал)
--           p_mode - режим с(1)/без(0) переформирования
-------------
  q_Dat_Beg  date := trunc( add_months( p_dat, -3),'Q');     -- первая дата пред.квартала
  q_Dat_End  date := trunc(             p_dat     ,'Q');     -- первая дата текущего квартала

  l_title   varchar2(20) := 'FM P_FM_GETTURN:'; -- для трассировки
  l_datfmt  char(4);
  l_cnt     number;

begin

-- проанализируем входящую дату. выполняем расчет только 01/01, 01/04, 01/07, 01/10 - в начале квартала за предыдущий квартал. иначе - выходим.
 select to_char(p_dat,'DDMM') into l_datfmt from dual;
 if l_datfmt not in ('0101','0104','0107','0110') then return;
 end if;

 select count(*) into l_cnt from  fm_turn_arc where  dat = q_Dat_End;
 if l_cnt > 0 then
   if p_mode = 0 then return;
   else
        delete from fm_turn_arc where  dat = q_Dat_End;
   end if;
 end if;

 bars_audit.trace('%s 1.Старт процедуры накопления расчетных оборотов по клиентам для анкет ФМ.',l_title);

  insert into fm_turn_TMP (acc, dk, s, sq)
    select acc, dk, s, sq
      from opldok
     where sos = 5 and fdat >= q_Dat_Beg and fdat < q_Dat_End ;

  begin
      insert into fm_turn_arc
          (dat, rnk, kv, turn_in, turn_inq, turn_out, turn_outq)
      select q_Dat_End, a.RNK, a.kv,  -- вставляем расчетные данные с датой-идентификатором первый квартал текущего (следующего по отношению в расчетному) квартала
             sum(decode (t.dk, 1, t.s , 0)),
             sum(decode (t.dk, 1, t.sq, 0)),
             sum(decode (t.dk, 0, t.s , 0)),
             sum(decode (t.dk, 0, t.sq, 0))
        from accounts a, fm_turn_TMP t
       where ( substr(a.nls,1,4) in
                           ('2512', '2513',
                            '2520', '2523', '2525', '2526',
                            '2530',
                            '2541', '2542', '2544', '2545', '2546',
                            '2552', '2553', '2554', '2555',
                            '2560', '2561', '2562', '2565',
                            '2570', '2571', '2572',
                            '2600', '2601', '2604', '2605', '2606',
                            '2610', '2611', '2615',
                            '2620', '2622', '2625',
                            '2630', '2635',
                            '2640', '2641', '2642', '2643',
                            '2650', '2651', '2652', '2655','1600')
              or (substr(a.nls,1,4) = '2603' and a.kv = 980)
             )
         and a.acc = t.acc
         and exists (select 1 from customer where custtype in (2,3) and rnk = a.RNK)
       group by a.RNK, a.kv;
  exception when dup_val_on_index then null;
  end;

 commit;
 bars_audit.trace('%s 2.Финиш процедуры накопления расчетных оборотов по клиентам для анкет ФМ.',l_title);

exception when others then
    bars_audit.error (dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
    raise_application_error(-20000, dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());

end p_fm_getturn;
/
show err;

PROMPT *** Create  grants  P_FM_GETTURN ***
grant EXECUTE                                                                on P_FM_GETTURN    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FM_GETTURN    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FM_GETTURN.sql =========*** End 
PROMPT ===================================================================================== 
