

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/M_ACCP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure M_ACCP ***

  CREATE OR REPLACE PROCEDURE BARS.M_ACCP 
(
  mod_  INT
 ,nd_   INT
 ,accz_ INT
 ,tip_  INT
) IS
  custtype_  INT;
  l_ob22_old accounts.ob22%TYPE;
  l_ob22_new accounts.ob22%TYPE;
  l_nbs      accounts.nbs%TYPE;
  L_IN_ND NUMBER;
--MPIVanova додано ексепшен на повторне приєднання застави до КД
  /*
     10-11-2016 LUDA Присоединить/Отсоединить 9510 к пассивным МБДК  тип счета: 'DEP','DEN' + запись счета залога в ND_ACC

     для MOD_=15 Сухова - Привязать ИД деп.дог в договору залога
     ACCZ_ =  pawn_acc.ACC           счета залога
     ND_   =  pawn_acc.DEPOSIT_ID    ID депозита
     tip_  =  CUSTTYPE = 2-ЮЛ~3-ФЛ
  ---------------------------
  дд.мм.гггг Марценюк Л.
  MOD_ = 0  - Отсоединить залог
  MOD_ = 1  - Присоединить залог
  MOD_ = 15 - Привязать ИД деп.дог в договору залога
  TIP_ = 1 - Кредиты TIP_ = 2 - ОВЕРДРАФТЫ  TIP_ = 3 - БПК
  */
BEGIN
  -- проверка/замена об22 на сч залога ACCZ_
  bars_audit.trace('m_accp' || chr(10) ||
                   'mod_  : ' || mod_  || chr(10) ||
                   'nd_   : ' || nd_   || chr(10) ||
                   'accz_ : ' || accz_ || chr(10) ||
                   'tip_  : ' || tip_);
  BEGIN
    SELECT nvl(a.ob22, '**'), decode(c.custtype, 3, n.ob22_fo, n.ob22_uo)
      INTO l_ob22_old, l_ob22_new
      FROM accounts a, pawn_acc p, cc_pawn n, customer c
     WHERE a.dazs IS NULL
       AND a.acc = p.acc
       AND p.pawn = n.pawn
       AND a.rnk = c.rnk
       AND a.acc = accz_;
    IF l_ob22_old <> l_ob22_new THEN
      UPDATE specparam_int SET ob22 = l_ob22_new WHERE acc = accz_;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO specparam_int (ob22, acc) VALUES (l_ob22_new, accz_);
      END IF;
    END IF;
  EXCEPTION
    WHEN no_data_found THEN
       RAISE_APPLICATION_ERROR(-20001,'Помилка ідентифікації клієнта');
  END;

  IF mod_ = 15 THEN
    UPDATE pawn_acc SET deposit_id = nd_ WHERE acc = accz_;
    IF nvl(tip_, 0) NOT IN (2, 3) THEN
      BEGIN
        SELECT custtype
          INTO custtype_
          FROM customer
         WHERE rnk = (SELECT rnk FROM accounts WHERE acc = accz_);
      EXCEPTION
        WHEN no_data_found THEN
          RAISE_APPLICATION_ERROR(-20001,'Помилка ідентифікації клієнта');
      END;
    END IF;
    IF custtype_ = 3 THEN
      UPDATE accounts
         SET blkd = 101
       WHERE acc =
             (SELECT d.acc FROM dpt_deposit d WHERE d.deposit_id = nd_);
    ELSIF custtype_ = 2 THEN
      UPDATE accounts
         SET blkd = 101
       WHERE acc = (SELECT d.acc FROM dpu_deal d WHERE d.dpu_id = nd_);
    END IF;
    RETURN;
  END IF;

  IF mod_ = 1 THEN
    ---присoединить

    IF tip_ = 1 THEN
      -- Кредиты

            begin
                select COUNT(1) into L_IN_ND from cc_accp ca where ca.nd= nd_ and ca.acc=accz_ ;
            end;
            if L_IN_ND>0 then
                  RAISE_APPLICATION_ERROR(-20001,'Обране забезпечення вже включено в  КД '||nd_);
            end if;
      FOR k IN (SELECT n.acc, a.tip
                  FROM nd_acc n, accounts a
                 WHERE a.acc = n.acc
                   AND n.nd = nd_
                   AND a.tip IN ('SS '
                                ,'SL '
                                ,'SP '
                                ,'CR9'
                                ,'SN '
                                ,'SNO'
                                ,'SPN'
                                ,'DEP'
                                ,'DEN')
                   AND a.nbs NOT LIKE '25%'
                   AND a.nbs NOT LIKE '26%'
                   AND (accz_, n.acc) NOT IN (SELECT acc, accs FROM cc_accp))
      LOOP
        BEGIN

          /*SELECT nbs INTO l_nbs FROM accounts WHERE acc = accz_;
          IF k.tip IN ('DEP', 'DEN')
             AND l_nbs = '9510'
             OR k.tip IN ('SS ', 'SL ', 'SP ', 'CR9', 'SN ', 'SNO', 'SPN')
             AND l_nbs <> '9510' THEN*/

           INSERT INTO cc_accp
              (acc, nd, accs, pr_12)
            VALUES
              (accz_, nd_, k.acc, 2);

          -- END IF;
          -- IF k.tip IN ('DEP', 'DEN') THEN
            BEGIN
              INSERT INTO nd_acc (acc, nd) VALUES (accz_, nd_);
            EXCEPTION
              WHEN dup_val_on_index THEN
                NULL;
            END;
          -- END IF;
        EXCEPTION
          WHEN no_data_found THEN
            RAISE_APPLICATION_ERROR(-20001,'Помилка ідентифікації рахунку');
        END;
      END LOOP;
    ELSIF tip_ = 2 THEN
      -- ОВЕРДРАФТЫ
      FOR k IN (SELECT *
                  FROM (SELECT acco acc, nd
                          FROM acc_over
                        UNION ALL
                        SELECT acc_9129, nd
                          FROM acc_over
                         WHERE acc_9129 IS NOT NULL
                        UNION ALL
                        SELECT a.acc, o.nd
                          FROM accounts a, acc_over o
                         WHERE a.acc = (SELECT acra
                                          FROM int_accn
                                         WHERE id = 0
                                           AND acc = o.acco)
                           AND a.nbs NOT LIKE '8%')
                 WHERE nd = nd_)
      LOOP
        INSERT INTO cc_accp
          (acc, nd, accs, pr_12)
        VALUES
          (accz_, nd_, k.acc, 2);
      END LOOP;
    ELSIF tip_ = 3 THEN
      -- БПК
      FOR k IN (SELECT *
                  FROM (SELECT acc_2207 acc, nd
                          FROM v_w4_acc
                         WHERE acc_2207 IS NOT NULL
                        UNION ALL
                        SELECT acc_pk, nd
                          FROM v_w4_acc
                         WHERE acc_pk IS NOT NULL
                        UNION ALL
                        SELECT acc_2209, nd
                          FROM v_w4_acc
                         WHERE acc_2209 IS NOT NULL
                        UNION ALL
                        SELECT acc_2208, nd
                          FROM v_w4_acc
                         WHERE acc_2208 IS NOT NULL
                        UNION ALL
                        SELECT acc_ovr, nd
                          FROM v_w4_acc
                         WHERE acc_ovr IS NOT NULL
                        UNION ALL
                        SELECT acc_9129, nd
                          FROM v_w4_acc
                         WHERE acc_9129 IS NOT NULL)
                 WHERE nd = nd_)
      LOOP
        INSERT INTO cc_accp
          (acc, nd, accs, pr_12)
        VALUES
          (accz_, nd_, k.acc, 2);
      END LOOP;
    END IF;

  ELSE
    DELETE FROM cc_accp
     WHERE acc = accz_
       AND nd = nd_; ---oтсоединить
    DELETE FROM nd_acc
     WHERE acc = accz_
       AND nd = nd_; ---oтсоединить
  END IF;
END;
/
show err;

PROMPT *** Create  grants  M_ACCP ***
grant EXECUTE                                                                on M_ACCP          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on M_ACCP          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/M_ACCP.sql =========*** End *** ==
PROMPT ===================================================================================== 
