

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
               FROM BARS.DPT_BONUS_SETTINGS -- сумма превышает минимальную граничную дл€ бонусов этого вида
              WHERE KV = D.KV
                AND DPT_TYPE =
                    (SELECT TYPE_ID FROM BARS.DPT_VIDD WHERE VIDD = D.VIDD))
           --общее исключение
        AND D.ACC = IR.ACC
        AND IR.BDAT IN (SELECT MAX(BDAT) FROM INT_RATN WHERE ACC = IR.ACC)
        AND IR.BR is not null -- ставка не индивидуальна€
        AND not exists (select 1 from BARS.BR_TIER_EDIT e where e.br_id = ir.br)-- не ступенчатый код ставки на текущий момент
        AND D.VIDD NOT IN (SELECT V.VIDD -- не "ѕрогрессивный" и не виды со ступенчатой ставкой
                             FROM BARS.DPT_VIDD V
                             JOIN BARS.BRATES B
                               ON V.BR_ID = B.BR_ID
                            WHERE TYPE_ID IN
                                  (SELECT TYPE_ID
                                     FROM BARS.DPT_TYPES
                                    WHERE TYPE_CODE IN ('MPRG', 'AKC'))
                               OR B.BR_TYPE != 1)
     UNION
     -- условие 2 по клиенту открылась «ѕ карта
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
        AND IR.BR is not null -- ставка не индивидуальна€
        AND not exists (select 1 from BARS.BR_TIER_EDIT e where e.br_id = ir.br)-- не ступенчатый код ставки на текущий момент
        AND D.VIDD NOT IN (SELECT V.VIDD -- не "ѕрогрессивный" и не виды со ступенчатой ставкой
                             FROM BARS.DPT_VIDD V
                             JOIN BARS.BRATES B
                               ON V.BR_ID = B.BR_ID
                            WHERE TYPE_ID IN
                                  (SELECT TYPE_ID
                                     FROM BARS.DPT_TYPES
                                    WHERE TYPE_CODE IN ('MPRG', 'AKC'))
                               OR B.BR_TYPE != 1)
     UNION
     -- условие 3 по клиенту закрылась «ѕ карта
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
        AND IR.BR is not null -- ставка не индивидуальна€
        AND not exists (select 1 from BARS.BR_TIER_EDIT e where e.br_id = ir.br)-- не ступенчатый код ставки на текущий момент
        AND D.VIDD NOT IN (SELECT V.VIDD -- не "ѕрогрессивный" и не виды со ступенчатой ставкой
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

     bars_audit.trace('%s поиск бонусной процентной ставки, не требующей подтверждени€', l_title);

          select count(1)
          into l_bonus_cnt
          from dpt_bonus_requests t1, dpt_bonuses t2, DPT_REQUESTS t3
          where t1.dpt_id = k.deposit_id
          and T1.BONUS_ID = T2.BONUS_ID
          and T3.DPT_ID = t1.dpt_id
          and T1.REQ_ID = T3.REQ_ID
          and T3.REQTYPE_ID = 1 -- запит на бонусну ставку
          and T2.BONUS_CONFIRM = 'N' -- не потребуЇ додаткового п≥дтвердженн€
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

PROMPT *** Create  grants  DPT_BONUS_ADDIT ***
grant EXECUTE                                                                on DPT_BONUS_ADDIT to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DPT_BONUS_ADDIT to DPT_ADMIN;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DPT_BONUS_ADDIT.sql =========*** E
PROMPT ===================================================================================== 
