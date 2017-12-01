

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_DAZS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOUNTS_DAZS ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCOUNTS_DAZS 
   BEFORE UPDATE OF DAZS
   ON ACCOUNTS
   FOR EACH ROW
DECLARE
   l_active   NUMBER (1);
BEGIN
   /*
   -- 30.11.2017 KHOMIDAVV - для процедури RNK2RNK ігноруємо 
   -- 10.02.2015 BAA - реанімація договору БПК при реанімації його основного рахунку (2625)
   --                - заборонено закривати рахунок 2625 за наявності залишків на рахунках договору БПК
   --
   -- 19.11.2013 BAA - заборонено реанімування рахунків депозитних портфелів!
   --
   -- 29-08-2011 STA - т.к. снапы стали чувствительными к датам dapp, dappQ, dazs
   --                  то такой триггер не допустит их несоответствия
   */

   IF sys_context('USERENV','ACTION') = 'rnk2rnk' THEN
     NULL;
   ELSE
   
     IF (:NEW.dazs IS NOT NULL)
     THEN
        IF (:new.dapp >= :NEW.dazs)
        THEN
           raise_application_error (
              -20444,
                 ' Рах.'
              || :new.nls
              || ' вал.'
              || :new.kv
              || ' Дата остан.руху '
              || TO_CHAR (:new.dapp, 'dd.mm.yyyy')
              || ' >='
              || ' Датi закриття '
              || TO_CHAR (:NEW.dazs, 'dd.mm.yyyy'));
        END IF;

        IF (:new.kv <> gl.baseval AND :new.dappQ >= :NEW.dazs)
        THEN
           raise_application_error (
              -20444,
                 ' Рах.'
              || :new.nls
              || ' вал.'
              || :new.kv
              || ' Дата остан.переоц.'
              || TO_CHAR (:new.dappQ, 'dd.mm.yyyy')
              || ' >='
              || ' Датi закриття '
              || TO_CHAR (:NEW.dazs, 'dd.mm.yyyy'));
        END IF;

        IF (SUBSTR (:new.TIP, 1, 2) = 'W4')
        THEN -- заборонено закривати рахунок 2625, якщо по договору існують рахунки із залишком
           WITH acnt
                AS (SELECT acc_id
                      FROM (SELECT ACC_OVR,
                                   ACC_9129,
                                   ACC_3570,
                                   ACC_2208,
                                   ACC_2627,
                                   ACC_2207,
                                   ACC_3579,
                                   ACC_2209,
                                   ACC_2625X,
                                   ACC_2627X,
                                   ACC_2625D,
                                   ACC_2628,
                                   ACC_2203
                              FROM W4_ACC
                             WHERE ACC_PK = :new.acc) UNPIVOT (acc_id
                                                      FOR acc_fild
                                                      IN  (ACC_2203 AS '2203',
                                                          ACC_2207 AS '2207',
                                                          ACC_2208 AS '2208',
                                                          ACC_2209 AS '2209',
                                                          ACC_2627 AS '2627',
                                                          ACC_2628 AS '2628',
                                                          ACC_3570 AS '3570',
                                                          ACC_2625X AS '2625X',
                                                          ACC_3579 AS '3739',
                                                          ACC_2625D AS '2625D',
                                                          ACC_9129 AS '9129',
                                                          ACC_2627X AS '2627X',
                                                          ACC_OVR AS 'OVER')))
           SELECT COUNT (1)
             INTO l_active
             FROM SALDOA s, acnt a
            WHERE     s.acc = a.acc_id
                  AND (s.acc, s.fdat) = (  SELECT c.acc, MAX (c.fdat)
                                             FROM saldoa c
                                            WHERE c.acc = a.acc_id
                                         GROUP BY c.acc)
                  AND (s.ostf + s.kos - s.dos) <> 0;

           IF (l_active > 0)
           THEN
              raise_application_error (
                 -20444,
                 'Заборонено закриття рахунку (наявні залишки на інших рахунках договору БПК)!',
                 TRUE);
           END IF;
        END IF;

        --Заявка на модифікацію № 14/2-01/ID-4455 16.11.2015р Щодо закриття рахунків ЮО COBUSUPABS-3939
        IF     :new.nbs IN ('2512',
                            '2513',
                            '2520',
                            '2523',
                            '2526',
                            '2530',
                            '2531',
                            '2541',
                            '2542',
                            '2544',
                            '2545',
                            '2552',
                            '2553',
                            '2554',
                            '2555',
                            '2560',
                            '2561',
                            '2562',
                            '2565',
                            '2570',
                            '2571',
                            '2572',
                            '2600',
                            '2601',
                            '2602',
                            '2603',
                            '2604',
                            '2640',
                            '2641',
                            '2642',
                            '2643',
                            '2644',
                            '2650',
                            --Поточні рахунки з використанням БПК:
                            '2655',
                            '2605',
                            --Депозитні рахунки:
                            '2525',
                            '2546',
                            '2610',
                            '2611',
                            '2615',
                            '2651',
                            '2652')
           AND -- Рахунок відкритий до 01.09.2015 року; )
               :new.daos < TO_DATE ('01.09.2015', 'dd.mm.yyyy')
        THEN
           UPDATE specparam s
              SET s.nkd =
                     COALESCE (
                        s.nkd,
                           TO_CHAR (:new.rnk)
                        || '_'
                        || TO_CHAR (SYSDATE, 'ddmmyyyy')
                        || '_'
                        || TO_CHAR (SYSDATE, 'HH24MISS'))
            WHERE s.acc = :new.acc;

           IF SQL%ROWCOUNT = 0
           THEN
              INSERT INTO specparam (acc, nkd)
                      VALUES (
                                :new.acc,
                                   TO_CHAR (:new.rnk)
                                || '_'
                                || TO_CHAR (SYSDATE, 'ddmmyyyy')
                                || '_'
                                || TO_CHAR (SYSDATE, 'HH24MISS'));
           END IF;
        END IF;
     END IF;

     IF ( (:NEW.dazs IS NULL) AND (:OLD.dazs IS NOT NULL))
     THEN                                               -- реанімування рахунків
        IF (:new.TIP IN ('DEP', 'DEN', 'NL8'))
        THEN           -- реанімування рахунків депозитних портфелів заборонена!
           SELECT CASE
                     -- депозитний портфель ФО
                     WHEN EXISTS
                             (SELECT 1
                                FROM DPT_ACCOUNTS a, DPT_DEPOSIT d
                               WHERE     a.accid = :new.acc
                                     AND a.dptid = d.deposit_id)
                     THEN
                        1
                     -- депозитний портфель ЮО
                     WHEN EXISTS
                             (SELECT 1
                                FROM DPU_ACCOUNTS a, DPU_DEAL d
                               WHERE     a.accid = :new.acc
                                     AND a.dpuid = d.dpu_id
                                     AND d.closed = 0)
                     THEN
                        1
                     --
                     ELSE
                        0
                  END
             INTO l_active
             FROM DUAL;

           IF (l_active = 0)
           THEN
              raise_application_error (
                 -20444,
                 'Заборонено реанімувати рахунок, що належить закритому депозитному договору!',
                 TRUE);
           END IF;
        END IF;

        IF (SUBSTR (:new.TIP, 1, 2) = 'W4')
        THEN   -- реанімуємо договір БПК якому належить реанімуємий рахунок 2625
           UPDATE BARS.W4_ACC
              SET DAT_CLOSE = NULL
            WHERE ACC_PK = :new.acc AND DAT_CLOSE IS NOT NULL;
        END IF;
     END IF;
   END IF;
END TBU_ACCOUNTS_DAZS;



/
ALTER TRIGGER BARS.TBU_ACCOUNTS_DAZS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_DAZS.sql =========*** E
PROMPT ===================================================================================== 
