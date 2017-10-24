

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/COLLECT_SALDOHOLIDAY.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure COLLECT_SALDOHOLIDAY ***

  CREATE OR REPLACE PROCEDURE BARS.COLLECT_SALDOHOLIDAY 
is
  c_title     constant varchar2(100) := 'collect_salho';
  l_minacrdat date;
begin

  bars_audit.trace( '%s: entry.', c_title );

  select min(acr_dat)
    into l_minacrdat
    from int_accn    i
    join dpt_deposit d on (d.acc = i.acc)
   where dat_end >= gl.bd
     and i.id = 1;

  -- Сбрасываем флаг работы по накопительной таблице
  acrn.set_collect_salho(0);

  -- Очищаем таблицу
  execute immediate 'truncate table saldo_holiday';
  bars_audit.trace( '%s: table saldo_holiday cleared.', c_title );

  -- execute immediate 'ALTER SESSION ENABLE PARALLEL DML';

  -- Наполняем таблицу
  insert into saldo_holiday
    ( fdat, cdat, acc, dos, kos )
  select /*+ parallel */
         pay_bankdate fdat,
         trunc(pay_caldate) cdat,
         l.acc,
         nvl(sum(decode(dk, 0, s)), 0) dos,
         nvl(sum(decode(dk, 1, s)), 0) kos
    from ( select p.pay_caldate, pay_bankdate, o.acc, o.fdat, o.s, o.dk
             from oper_ext p,
                  opldok o
            where p.ref = o.ref
              and o.sos = 5
              and p.pay_bankdate > l_minacrdat
         ) l,
         saldoa s
   where s.acc(+) = l.acc
     and s.fdat(+) = trunc(pay_caldate)
     and s.acc is null
  group by pay_bankdate, trunc(pay_caldate), l.acc;

  commit;

  bars_audit.trace( '%s: table saldo_holiday collected.', c_title );

  -- Устанавливаем флаг работы по накопительной таблице
  acrn.set_collect_salho(1);

end collect_saldoholiday;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/COLLECT_SALDOHOLIDAY.sql =========
PROMPT ===================================================================================== 
