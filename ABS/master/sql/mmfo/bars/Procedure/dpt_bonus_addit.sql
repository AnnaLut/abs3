
PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/Procedure/dpt_bonus_addit.sql =======*** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create  procedure dpt_bonus_addit ***

create or replace procedure dpt_bonus_addit is
  l_title constant varchar2(16) := 'dpt_bonus_addit:';
  l_bonusval  number;
  l_totalbonus number;
  l_bonus_cnt number;
  p_dat       DATE := trunc(sysdate);
  l_prev_bdat Date := dat_next_u(trunc(sysdate) , -1);
  l_brate     bars.int_ratn.br%type;
  l_irate     bars.int_ratn.ir%type;
  l_indrate   bars.Dpt_Vidd_Extdesc%rowtype;
  l_brtype    varchar2(25);

  -- v 1.3 13.09.2017 - by Petrishe
  -- v 2.9 01.03.2018 - by Livshyts
  -- v 3.0 16.03.2018 - by Livshyts
  --== Переделан основной запрос, отбирающий депозиты, чтобы выбирались не все, у кого сумма изменилась и попала в бонусную сетку,
  --== а только те, что "перескочили ступеньку" и у них должен поменяться бонус
  -- v 3.1 24.05.2018 - by Livshyts --== Добавлено условие - для ступенчатых ставок бонус не должен уменьшаться
  -- v 3.3 14.06.2018 - by Livshyts --== Бонус рассчитывается с учетом бонуса за пролонгацию 

BEGIN
  bc.go('/');
  FOR cur IN (SELECT kf FROM bars.mv_kf) LOOP --cur
    bc.go(cur.kf);
    bars_audit.trace('%s РУ = %s', l_title, cur.kf);

    For i in (
       with op as (select distinct dp.dpt_id, case when trunc(o.pdat) = o.bdat then o.bdat else trunc(o.pdat) end pdat
                   from bars.dpt_payments dp,
                        bars.oper         o
                   where o.ref = dp.ref
                     and o.pdat between l_prev_bdat and (p_dat + 1)
                     and ((o.dk = 0 and REGEXP_LIKE(o.nlsa, '^2630|^2635')) or (o.dk = 1 and REGEXP_LIKE(o.nlsb, '^2630|^2635')))
                   ),  -- были платежи за вчера (банк.дата) и сегодня (календ.дата)
            bs as (select db.*, nvl(lead(s-1) over (partition by dpt_type, dpt_vidd, kv, bonus_id order by db.s), 999999999999999999999) maxx
                   from bars.dpt_bonus_settings db
                   where bonus_id = dpt_bonus.get_bonus_id('EXCL')
                     and p_dat between db.dat_begin and nvl(db.dat_end, to_date('31.12.4999','DD.MM.YYYY'))
                   )   -- бонусная сетка
       SELECT dd.deposit_id,    -- были платежи
              dd.vidd,
              dd.kv,
              dd.kf,
              dd.rnk,
              dd.acc,
              dd.branch,
              dd.cnt_dubl,
              dd.dat_end,
              dd.datz,
              dt.type_code,
              dt.type_id,
              bs.val,
              nvl(dv.extension_id, 0) ext_id,
              dv.duration,
        op.pdat
       FROM bars.dpt_deposit  dd,
            bars.dpt_vidd     dv,
            bars.dpt_types    dt,
            op,
            bs
       WHERE dd.vidd = dv.vidd
         and dt.type_id = dv.type_id
         and dt.type_code <> 'AKC'      -- не акционный
         and dd.deposit_id = op.dpt_id
         and (dd.dat_end is null or dd.dat_end > p_dat)
         and bs.dpt_type = dt.type_id
         and bs.kv = dd.kv
         -- был "прыжок через ступеньку"
         and kost(dd.acc, op.pdat) between bs.s and maxx
         and kost(dd.acc, op.pdat - 1) < bs.s  ) loop -- i

    begin

     SELECT nvl(ir.br,0),
             ir.ir,
             case
               when br.br_type = 1 then
                'NORMAL'
               when br.br_type = 4 then
                'FORMULA'
               else
                'TIER'
             end
        INTO l_brate, l_irate, l_brtype
        FROM bars.int_ratn ir, bars.brates br
       WHERE br.br_id = ir.br
         --and br.br_type = 1 -- убрать, когда ступенчатую ставку переведут на плоскую
         AND ir.acc = i.acc
         AND ir.bdat = (SELECT max(r.bdat)
                          FROM bars.int_ratn r
                         WHERE r.acc = ir.acc
                           AND r.bdat <= p_dat);
    exception
      when no_data_found then
        l_brate := 0;
    end;
    bars_audit.trace('%s для deposit_id = %s и acc = %s базовая ставка - %s бонус = %s (тип ставки - %s) ', l_title, to_char(i.deposit_id), to_char(i.acc),
                    to_char(l_brate), to_char(l_irate), to_char(l_brtype));

    if l_brate > 0 then      -- #1 исключаем индивидуальные ставки
      if (l_brtype = 'TIER' and l_irate > 0.5) then        --#2 должно быть: если ступенчатая и бонус больше 0.5 , то пропускаем.
        null;
      elsif l_brtype = 'FORMULA' then        --#2
        null;
      else --#2 плоские ставки и ступенчатые с бонусом 0.5 и меньше

        l_bonusval := 0;
        bc.go(i.kf);
        bars_audit.trace('%s запуск процедуры расчета льгот', l_title);

        dpt_bonus.set_bonus(i.deposit_id); -- рассчитываем бонус
        commit;
        bars_audit.trace('%s льготы рассчитаны', l_title);

        SELECT nvl(sum(bonus_value_fact),0)
         INTO l_totalbonus
         FROM dpt_bonus_requests
         WHERE dpt_id = i.deposit_id
           AND request_state = 'ALLOW'
           AND request_deleted = 'N';
         bars_audit.trace('%s суммарная льгота = %s', l_title, to_char(l_totalbonus));

        -- если депозит ступенчатый, ставка не должна уменьшаться
        if (l_brtype = 'TIER' and l_totalbonus > l_irate) or (l_brtype <> 'TIER') then
        --поэтому, если ставка ступенчата и бонус больше, чем есть или ставка не ступенчатая
        --устанавливаем бонус
         
         delete from dpt_depositw
          where tag = 'BONUS'
            and DPT_ID = i.deposit_id;

         DPT_BONUS.SET_BONUS_RATE_LONG(i.deposit_id, i.pdat + 1, l_bonusval);
        
         bars_audit.trace('%s встановлена бонусна ставка = %s',
                           l_title,
                           to_char(l_bonusval));
        else
          null;
        end if;

      end if; --#2
    end if; --#1

    commit;

  end loop; --i

  end loop; --cur
  bc.home;

end;
/
show err;

PROMPT *** Create  grants  dpt_bonus_addit ***
grant EXECUTE                                 on dpt_bonus_addit      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                 on dpt_bonus_addit      to ABS_ADMIN;
grant EXECUTE                                 on dpt_bonus_addit      to WR_ALL_RIGHTS;

PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Procedure/dpt_bonus_addit.sql ======*** End ***
PROMPT ===================================================================================== 
