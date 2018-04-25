

PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/Procedure/dpt_bonus_addit.sql =======*** Run ***
PROMPT ===================================================================================== 

create or replace procedure dpt_bonus_addit is
  l_title constant varchar2(16) := 'dpt_bonus_addit:';
  l_bonusval  number;
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
         and br.br_type = 1 -- убрать, когда ступенчатую ставку переведут на плоскую
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
      if (l_brtype = 'TIER' /* and l_irate > 0.5*/) then        --#2 должно быть: если ступенчатая и бонус больше 0.5 , то пропускаем. Сейчас: пропускаем любые ступенчатые
        null;
      elsif l_brtype = 'FORMULA' then        --#2
        null;
      else --#2 плоские ставки (после реализации 6487 будут еще ступенчатые (с бонусом 0.5 и меньше)) 

        l_bonusval := 0;
        bc.go(i.kf);
        bars_audit.trace('%s запуск процедуры расчета льгот', l_title);

        dpt_bonus.set_bonus(i.deposit_id); -- рассчитываем бонус
        commit;
        bars_audit.trace('%s льготы рассчитаны', l_title);
        bars_audit.trace('%s поиск бонусной процентной ставки, не требующей подтверждения', l_title);

        delete from dpt_depositw
           where tag = 'BONUS'
             and DPT_ID = i.deposit_id;
        DPT_BONUS.SET_BONUS_RATE(i.deposit_id, i.pdat + 1, l_bonusval);
        bars_audit.trace('%s встановлена бонусна ставка = %s',
                           l_title,
                           to_char(l_bonusval));

        -- если прогрессивный
        if i.type_code = 'MPRG' then       --#3

          begin
            select *
              into l_indrate --индивидуальная ставка для этого кол-ва пролонгаций
              from bars.Dpt_Vidd_Extdesc dve
             where dve.base_rate = l_brate
               and dve.ext_num = i.cnt_dubl
               and dve.type_id = i.ext_id;

          exception
            when others then
              l_indrate := null;
          end;

         if nvl(l_indrate.indv_rate,0) <> 0 --#4
         then
           l_bonusval := l_bonusval + l_indrate.indv_rate;

         begin
          insert into bars.Int_Ratn (acc, id, bdat, ir, br, op)
          values(i.acc, 1, i.pdat + 1, l_bonusval, l_indrate.base_rate, l_indrate.oper_id);
         exception when dup_val_on_index then
          update bars.int_ratn
          set ir = l_bonusval,
              op = case when nvl(l_indrate.indv_rate, 0) != 0 and nvl(l_indrate.oper_id, 0) = 0
                   then 1  else l_indrate.oper_id end
          where acc = i.acc and bdat = i.pdat + 1 and id = 1;
         when others then
             bars_error.raise_nerror('DPT', 'SET_BONUS_RATE_FAILED',
              ' acc = '||to_char(i.acc), ' ir = '||to_char(l_bonusval), ' dat = '||to_char(p_dat+1 ,'DD/MM/YYYY'));
          end;

           begin
              INSERT INTO dpt_depositw (dpt_id, tag, value, branch)
              VALUES (i.deposit_id, 'BONUS', to_char(l_bonusval), i.branch);
           exception when dup_val_on_index then
              update dpt_depositw
              set value = to_char(l_bonusval),
               branch = i.branch
              where tag = 'BONUS' and dpt_id = i.deposit_id;
            end;
            bars_audit.trace('%s значение бонуса записано в доп.реквизиты вклада', l_title);

          end if; --#4
        end if; --#3

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