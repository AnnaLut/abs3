PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/Procedure/dpt_bonus_addit.sql =======*** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create  procedure dpt_bonus_addit ***

create or replace procedure dpt_bonus_addit is
  l_title constant varchar2(16) := 'dpt_bonus_addit:';
  l_bonusval  number;
  l_bonus_cnt number;
  p_dat       DATE := trunc(sysdate);
  l_brate     bars.int_ratn.br%type;
  l_irate     bars.int_ratn.ir%type;
  l_indrate   bars.Dpt_Vidd_Extdesc%rowtype;
  l_brtype    varchar2(25);
  -- v 1.3 13.09.2017 - by Petrishe
  -- v 2.5 22.01.2018 - by Livshyts
BEGIN

  For i in (

            select dep.deposit_id,
                    dep.vidd,
                    dep.kv,
                    dep.kf,
                    dep.rnk,
                    dep.acc,
                    dep.branch,
                    kost(dep.acc, trunc(p_dat)) ost,
                    dt.type_id,
                    dt.type_code,
                    dep.cnt_dubl,
                    nvl(dv.extension_id, 0) ext_id,
                    dv.duration,
                    bars.dpt.f_dptw(dep.deposit_id, 'NCASH') bnal
              from  -- отбор депозитов по которым
                     (SELECT dd.deposit_id,     --были изменения по ЗП-картам
                             dd.vidd,
                             dd.kv,
                             dd.kf,
                             dd.rnk,
                             dd.acc,
                             dd.branch,
                             dd.cnt_dubl,
                             dd.dat_end
                        FROM bars.dpt_deposit dd
                       WHERE (dd.dat_end is null or dd.dat_end > p_dat)
                         and dd.rnk in
                             (select rnk
                                from bars.accounts a
                               where a.nbs = 2625
                                 and a.ob22 in ('24', '27', '31')
                                 and (a.daos = p_dat or a.dazs = p_dat))
                      union
                      SELECT dd.deposit_id,    -- были платежи
                             dd.vidd,
                             dd.kv,
                             dd.kf,
                             dd.rnk,
                             dd.acc,
                             dd.branch,
                             dd.cnt_dubl,
                             dd.dat_end
                        FROM bars.dpt_deposit  dd,
                             (select distinct dp.dpt_id
                             from
                             bars.dpt_payments dp,
                             bars.oper         o
                             where o.ref = dp.ref
                             and o.pdat between p_dat and p_dat + 1
                             and ((o.dk = 0 and REGEXP_LIKE(o.nlsa, '^2630|^2635')) or
                             (o.dk = 1 and REGEXP_LIKE(o.nlsb, '^2630|^2635'))) ) opl

                       WHERE dd.deposit_id = opl.dpt_id
                         and (dd.dat_end is null or dd.dat_end > p_dat)
                         and KOST(dd.ACC, p_dat) >
                                     (SELECT NVL(MIN(S), 0)
                                        FROM BARS.DPT_BONUS_SETTINGS -- сумма превышает минимальную граничную для бонусов этого вида
                                       WHERE KV = dd.KV
                                         AND DPT_TYPE = (SELECT TYPE_ID FROM BARS.DPT_VIDD WHERE VIDD = dd.VIDD))
                       union
                       SELECT ds.deposit_id,    
                            ds.vidd,
                            ds.kv,
                            ds.kf,
                            ds.rnk,
                            ds.acc,
                            ds.branch,
                            ds.cnt_dubl,
                            ds.dat_end 
                       FROM (SELECT dd.*,    
                                    sa.fdat,
                                    min(sa.fdat) over (partition by sa.acc) mindat
                             FROM  bars.dpt_deposit dd,
                                   bars.saldoa sa
                             WHERE dd.dat_begin >= bars.dat_next_u(p_dat, -15)                  -- депозиты, открытые не более 15 дней назад
                               and (dd.dat_end is null or dd.dat_end > trunc(sysdate))          -- еще не закрытые
                               and bars.dpt.f_dptw(dd.deposit_id, 'NCASH') = '1'                -- по безналу
                               and sa.acc = dd.acc
                               and sa.kos > 0) ds
                       WHERE ds.fdat = ds.mindat        -- первая дата пополнения
                         and ds.fdat = p_dat) dep,
                    bars.dpt_vidd dv,
                    bars.dpt_types dt
             where dep.vidd = dv.vidd
               and dt.type_id = dv.type_id
               and dt.type_code <> 'AKC' -- не акционный
            ) loop

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

    if l_brate > 0 then      -- #1 исключаем индивидуальные ставки
      if (l_brtype = 'TIER' and l_irate > 0.5) then        --#2 если ступенчатая и бонус больше 0.5 , то пропускаем
        null;
      elsif l_brtype = 'FORMULA' then        --#2
        null;
      else --#2 ступенчатые (с бонусом 0.5 и меньше) и плоские ставки

        l_bonusval := 0;
        bc.go(i.kf);
        bars_audit.trace('%s запуск процедуры расчета льгот', l_title);

        dpt_bonus.set_bonus(i.deposit_id); -- рассчитываем бонус
        commit;
        bars_audit.trace('%s льготы рассчитаны', l_title);
        bars_audit.trace('%s поиск бонусной процентной ставки, не требующей подтверждения', l_title);

        select count(1)
          into l_bonus_cnt
          from dpt_bonus_requests t1, dpt_bonuses t2, DPT_REQUESTS t3
         where t1.dpt_id = i.deposit_id
           and T1.BONUS_ID = T2.BONUS_ID
           and T3.DPT_ID = t1.dpt_id
           and T1.REQ_ID = T3.REQ_ID
           and T3.REQTYPE_ID = 1 -- запит на бонусну ставку
           and T2.BONUS_CONFIRM = 'N' -- не потребує додаткового підтвердження
           and T1.REQUEST_STATE = 'ALLOW'; -- запит погоджено автоматично;

        bars_audit.trace('%s по вкладу найдено %s бонусных ставок, переход к подтверждению',
                         l_title,
                         to_char(l_bonus_cnt));

        if (l_bonus_cnt > 0) then
          delete from dpt_depositw
           where tag = 'BONUS'
             and DPT_ID = i.deposit_id;
          DPT_BONUS.SET_BONUS_RATE(i.deposit_id, p_dat + 1, l_bonusval);
          bars_audit.trace('%s встановлена бонусна ставка = %s',
                           l_title,
                           to_char(l_bonusval));
        end if;

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
          values(i.acc, 1, trunc(p_dat + 1), l_bonusval, l_indrate.base_rate, l_indrate.oper_id);
         exception when dup_val_on_index then
          update bars.int_ratn 
          set ir = l_bonusval,
              op = case when nvl(l_indrate.indv_rate, 0) != 0 and nvl(l_indrate.oper_id, 0) = 0 
                   then 1  else l_indrate.oper_id end
          where acc = i.acc and bdat = p_dat + 1 and id = 1;
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
  
          -- COBUMMFO-5605
          -- меняем лимит депозитам, открытым безналом на 12 или 18 месяцев, в день их первого пополнения
        if (i.bnal = '1' and (i.duration = 12 or i.duration = 18)) then --#5

          update bars.dpt_deposit 
          set limit = bars.fost(i.acc, p_dat)
          where deposit_id = i.deposit_id
            and acc = i.acc
            and kf = i.kf;   
            
        end if; --#5
      end if; --#2
    end if; --#1

    commit;

  end loop;

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DPT_BONUS_ADDIT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DPT_BONUS_ADDIT ***

  CREATE OR REPLACE PROCEDURE BARS.DPT_BONUS_ADDIT is
l_title constant varchar2(16) := 'dpt_bonus_addit:';
l_bonusval number;
l_bonus_cnt number;
p_dat DATE := trunc(sysdate);
-- v 1.4 24.10.2017 - by Petrishe
-- changed by Livshyts for newnbs 14.11.2017
BEGIN


 for k in
    (
   WITH C1 AS
    (SELECT DISTINCT RNK
       FROM BARS.ACCOUNTS_UPDATE U
      WHERE U.NBS = 2625
        AND U.OB22 IN ('24', '27', '31')
        AND U.CHGDATE between (p_dat-1) AND p_dat
     ),
  C2 AS
     (select distinct o.pdat, dp.dpt_id
      from oper o, dpt_payments dp
      where 1=1
      and o.pdat between (p_dat-1) and p_dat
      --and ((REGEXP_LIKE(o.nlsa,'^2630|^2635') and o.dk = 0) or (REGEXP_LIKE(o.nlsb,'^2630|^2635') and o.dk = 1))
      and ((REGEXP_LIKE(o.nlsa,'^2630') and o.dk = 0) or (REGEXP_LIKE(o.nlsb,'^2630') and o.dk = 1))
      and o.ref = dp.ref)
    (
    -- условие1 остаток на депозитном счете превышает минимальную граничную сумму по виду вклада
     SELECT D.DEPOSIT_ID, trunc(c2.pdat) + 1 DATZ, D.KF
       from  BARS.DPT_DEPOSIT D,  c2, INT_RATN IR
      WHERE d.deposit_id = c2.dpt_id
        AND KOST(D.ACC, trunc(c2.pdat)) >
            (SELECT NVL(MIN(S), 0)
               FROM BARS.DPT_BONUS_SETTINGS -- сумма превышает минимальную граничную для бонусов этого вида
              WHERE KV = D.KV
                AND DPT_TYPE =
                    (SELECT TYPE_ID FROM BARS.DPT_VIDD WHERE VIDD = D.VIDD))
           --общее исключение
        AND D.ACC = IR.ACC
        AND IR.BDAT IN (SELECT MAX(BDAT) FROM INT_RATN WHERE ACC = IR.ACC)
        AND IR.BR is not null -- ставка не индивидуальная
        AND not exists (select 1 from BARS.BR_TIER_EDIT e where e.br_id = ir.br)-- не ступенчатый код ставки на текущий момент
        AND D.VIDD NOT IN (SELECT V.VIDD -- не "Прогрессивный" и не виды со ступенчатой ставкой
                             FROM BARS.DPT_VIDD V
                             JOIN BARS.BRATES B
                               ON V.BR_ID = B.BR_ID
                            WHERE TYPE_ID IN
                                  (SELECT TYPE_ID
                                     FROM BARS.DPT_TYPES
                                    WHERE TYPE_CODE IN ('MPRG', 'AKC'))
                               OR B.BR_TYPE != 1)
     UNION
     -- условие 2 по клиенту открылась ЗП карта
     SELECT D.DEPOSIT_ID, A.DAOS + 1 DATZ, D.KF
       FROM BARS.DPT_DEPOSIT D, BARS.DPT_VIDD VV, BARS.ACCOUNTS A, C1, INT_RATN IR
      WHERE C1.RNK = A.RNK
        AND A.DAOS >= (p_dat-1)
        AND A.RNK = D.RNK
        AND D.VIDD = VV.VIDD
        AND ((newnbs.g_state = 1 and VV.BSD = '2630') or (newnbs.g_state = 0 and VV.BSD in ('2630', '2635')))
        and A.NBS = 2625
        and a.OB22 IN ('24', '27', '31')
           --общее исключение
        AND D.ACC = IR.ACC
        AND IR.BDAT IN (SELECT MAX(BDAT) FROM INT_RATN WHERE ACC = IR.ACC)
        AND IR.BR is not null -- ставка не индивидуальная
        AND not exists (select 1 from BARS.BR_TIER_EDIT e where e.br_id = ir.br)-- не ступенчатый код ставки на текущий момент
        AND D.VIDD NOT IN (SELECT V.VIDD -- не "Прогрессивный" и не виды со ступенчатой ставкой
                             FROM BARS.DPT_VIDD V
                             JOIN BARS.BRATES B
                               ON V.BR_ID = B.BR_ID
                            WHERE TYPE_ID IN
                                  (SELECT TYPE_ID
                                     FROM BARS.DPT_TYPES
                                    WHERE TYPE_CODE IN ('MPRG', 'AKC'))
                               OR B.BR_TYPE != 1)
     UNION
     -- условие 3 по клиенту закрылась ЗП карта
     SELECT D.DEPOSIT_ID, A.DAZS + 1 DATZ, D.KF
       FROM BARS.DPT_DEPOSIT D, BARS.DPT_VIDD VV, BARS.ACCOUNTS A, C1, INT_RATN IR
      WHERE C1.RNK = A.RNK
        AND A.DAZS >= (p_dat -1)
        AND A.RNK = D.RNK
        AND D.VIDD = VV.VIDD
        AND ((newnbs.g_state = 1 and VV.BSD = '2630') or (newnbs.g_state = 0 and VV.BSD in ('2630', '2635')))
        and A.NBS = 2625
        and a.OB22 IN ('24', '27', '31')
           --общее исключение
        AND D.ACC = IR.ACC
        AND IR.BDAT IN (SELECT MAX(BDAT) FROM INT_RATN WHERE ACC = IR.ACC)
        AND IR.BR is not null -- ставка не индивидуальная
        AND not exists (select 1 from BARS.BR_TIER_EDIT e where e.br_id = ir.br)-- не ступенчатый код ставки на текущий момент
        AND D.VIDD NOT IN (SELECT V.VIDD -- не "Прогрессивный" и не виды со ступенчатой ставкой
                             FROM BARS.DPT_VIDD V
                             JOIN BARS.BRATES B
                               ON V.BR_ID = B.BR_ID
                            WHERE TYPE_ID IN
                                  (SELECT TYPE_ID
                                     FROM BARS.DPT_TYPES
                                    WHERE TYPE_CODE IN ('MPRG', 'AKC'))
                               OR B.BR_TYPE != 1))

     )
   loop
     l_bonusval := 0;
     bc.go(k.kf);
     bars_audit.trace('%s запуск процедуры расчета льгот', l_title);

     dpt_bonus.set_bonus(k.deposit_id);
     commit;
     bars_audit.trace('%s льготы рассчитаны', l_title);

     bars_audit.trace('%s поиск бонусной процентной ставки, не требующей подтверждения', l_title);

          select count(1)
          into l_bonus_cnt
          from dpt_bonus_requests t1, dpt_bonuses t2, DPT_REQUESTS t3
          where t1.dpt_id = k.deposit_id
          and T1.BONUS_ID = T2.BONUS_ID
          and T3.DPT_ID = t1.dpt_id
          and T1.REQ_ID = T3.REQ_ID
          and T3.REQTYPE_ID = 1 -- запит на бонусну ставку
          and T2.BONUS_CONFIRM = 'N' -- не потребує додаткового підтвердження
          and T1.REQUEST_STATE = 'ALLOW'; -- запит погоджено автоматично;

      bars_audit.trace('%s по вкладу найдено %s бонусных ставок, переход к подтверждению', l_title, to_char(l_bonus_cnt));

        if (l_bonus_cnt>0) then
          delete dpt_depositw where tag = 'BONUS' and DPT_ID = k.deposit_id;
          DPT_BONUS.SET_BONUS_RATE(k.deposit_id, k.datz, l_bonusval);
          bars_audit.trace('%s встановлена бонусна ставка = %s', l_title, to_char(l_bonusval));
        end if;

   end loop;
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
