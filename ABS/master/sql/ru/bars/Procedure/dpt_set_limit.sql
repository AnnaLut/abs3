PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/Procedure/dpt_set_limit.sql =======*** Run ***
PROMPT ===================================================================================== 

create or replace procedure dpt_set_limit is
  l_title constant varchar2(16) := 'dpt_set_limit: ';
  l_bonusval  number;
  p_dat       Date := trunc(sysdate);
  p_prev_dat  Date := trunc(sysdate -1);
  l_ost       bars.dpt_deposit.limit%type;
  l_brate     bars.int_ratn.br%type;
  l_irate     bars.int_ratn.ir%type;
  l_brtype    varchar2(25);
  --===== процедура, обрабатывающая депозиты, открытые безналом, у которых был первичный взнос
  --===== запускается с помощью джоба job_dpt_set_limit, который запускается в 6 утра и анализирует платежи ЗА ВЧЕРА
  
  -- v 1.1 20.03.2018 - by Livshyts
BEGIN
  bc.go('/');
  FOR cur IN (SELECT kf FROM bars.mv_kf) LOOP --cur
    bc.go(cur.kf);
    bars_audit.trace('%s МФО = %s', l_title, cur.kf);

    For i in (
      with op as (select distinct dp.dpt_id  
                   from bars.dpt_payments dp,
                        bars.oper         o
                   where o.ref = dp.ref
                     and o.pdat between p_prev_dat and p_dat
                     and (o.dk = 1 and REGEXP_LIKE(o.nlsb, '^2630|^2635'))
                   )  
                   SELECT dd.deposit_id,
                          dd.acc,
                          dv.duration,
                          nvl(dv.term_add,0) term_add
                   FROM  bars.dpt_deposit dd,
                         bars.dpt_vidd dv,
                         bars.dpt_types dt,
                         op
                   WHERE dv.vidd = dd.vidd
                     and dt.type_id = dv.type_id
                     and (dd.dat_end is null or dd.dat_end > p_dat)                   -- еще не закрытые
                     and dd.dat_begin >= bars.dat_next_u(p_dat, -15)                  -- депозиты, открытые не более 15 банк.дней назад
                     and dt.type_code <> 'AKC'                                        -- не акционный
                     and bars.dpt.f_dptw(dd.deposit_id, 'NCASH') = '1'                -- по безналу
                     and op.dpt_id = dd.deposit_id
                     and kost(dd.acc, p_prev_dat - 1) = 0                                  -- остаток позавчера был 0   
                     and kost(dd.acc, p_prev_dat) > 0                                      -- а вчера стал больше 0  =  первое пополнение
      ) loop

     bars_audit.trace('%s deposit_id = %s  acc = %s  duration = %s term_add = %s', l_title, to_char(i.deposit_id), to_char(i.acc), to_char(i.duration), to_char(i.term_add));

     -- COBUMMFO-5605
     -- меняем лимит депозитам по безсрочным видам вклада, в день их первого пополнения

      if i.term_add <> 0  then
         l_ost := bars.kost(i.acc, p_prev_dat);

          update bars.dpt_deposit
          set limit = l_ost
          where deposit_id = i.deposit_id
            and acc = i.acc;

        bars_audit.trace('%s устанавливаем limit = %s для deposit_id = %s  acc = %s', l_title, to_char(l_ost), to_char(i.deposit_id), to_char(i.acc));
      end if;

     -- пересматриваем бонус после первого пополнения для всех 
        begin
        SELECT nvl(ir.br,0),
             ir.ir
        INTO l_brate, l_irate
        FROM bars.int_ratn ir, bars.brates br
        WHERE br.br_id = ir.br
         and br.br_type = 1 
         AND ir.acc = i.acc
         AND ir.bdat = (SELECT max(r.bdat)
                          FROM bars.int_ratn r
                         WHERE r.acc = ir.acc
                           AND r.bdat <= p_dat);
        exception when no_data_found then
         l_brate := 0;
        end;
        bars_audit.trace('%s для deposit_id = %s и acc = %s базовая ставка - %s бонус = %s ', l_title, to_char(i.deposit_id), to_char(i.acc), to_char(l_brate), to_char(l_irate));

        if l_brate > 0 then      -- #1 исключаем индивидуальные ставки
    
          l_bonusval := 0;
          bars_audit.trace('%s запуск процедуры расчета льгот', l_title);
          dpt_bonus.set_bonus(i.deposit_id); -- рассчитываем бонус
          commit;
          bars_audit.trace('%s льготы рассчитаны', l_title);
          bars_audit.trace('%s поиск бонусной процентной ставки, не требующей подтверждения', l_title);

          delete from dpt_depositw
           where tag = 'BONUS'
             and DPT_ID = i.deposit_id;
          DPT_BONUS.SET_BONUS_RATE(i.deposit_id, p_dat, l_bonusval);
          bars_audit.trace('%s встановлена бонусна ставка = %s',
                           l_title,
                           to_char(l_bonusval));
          commit;
        end if; --#1
        
  end loop; --i

  end loop; --cur
  bc.home;

end;
/
show err;

PROMPT *** Create  grants dpt_set_limit ***
grant EXECUTE                                 on dpt_set_limit      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                 on dpt_set_limit      to ABS_ADMIN;
grant EXECUTE                                 on dpt_set_limit      to WR_ALL_RIGHTS;


PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Procedure/ddpt_set_limit.sql =======*** End ***
PROMPT ===================================================================================== 
