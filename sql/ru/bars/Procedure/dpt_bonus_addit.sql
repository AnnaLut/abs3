create or replace procedure dpt_bonus_addit is
l_title constant varchar2(16) := 'dpt_bonus_addit:';
l_bonusval number;
l_bonus_cnt number;
begin
 for k in
    (SELECT d.deposit_id, sa.fdat + 1 datz, d.kf
       FROM saldoa sa, dpt_deposit d
      WHERE     sa.acc IN (SELECT accid FROM dpt_accounts)
            AND sa.fdat >= DAT_NEXT_U (gl.bdate, -1)
            AND sa.kos > 0
            --AND sa.ostf > 0
            AND d.acc = sa.acc
            AND d.vidd NOT IN (SELECT vidd
                                 FROM dpt_vidd
                                WHERE type_id IN (SELECT type_id
                                                    FROM dpt_types
                                                   WHERE type_code = 'MPRG')))
   loop
     l_bonusval := 0;
     bc.go(k.kf);
     bars_audit.trace('%s запуск процедуры расчета льгот', l_title);

     dpt_bonus.set_bonus (k.deposit_id);
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
