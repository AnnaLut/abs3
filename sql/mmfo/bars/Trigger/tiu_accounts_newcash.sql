

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOUNTS_NEWCASH.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACCOUNTS_NEWCASH ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACCOUNTS_NEWCASH 
   --------------------------------------------
   -- триггер для касс отчетности.
   -- При открытии нового касс счета - он помещается в срез кассы
   --------------------------------------------
   BEFORE INSERT
   ON ACCOUNTS
   FOR EACH ROW
   FOLLOWS BARS.TIU_ACCOUNTS_BRANCH_TOBO
DECLARE
   l_nbs      VARCHAR2 (4);
   l_opdate   DATE;
BEGIN
   SELECT UNIQUE nbs
     INTO l_nbs
     FROM cash_nbs
    WHERE nbs = :new.nbs;

   --and ob22 = :new.ob22;
   ---
   -- Пока коментарим, так як при вставці
   -- в accounts ми ще не маемо ОБ22


   FOR c
      IN (SELECT opdate, shift
            FROM cash_open
           WHERE     opdate BETWEEN TRUNC (SYSDATE) AND SYSDATE
                 AND branch = :new.BRANCH)
   LOOP
      INSERT INTO cash_snapshot (opdate,
                                 branch,
                                 acc,
                                 ostf,
                                 kf)
           VALUES (c.opdate,
                   :new.branch,
                   :new.acc,
                   0,
                   :new.kf);
   END LOOP;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      NULL;
END tiu_accounts_newcash;



/
ALTER TRIGGER BARS.TIU_ACCOUNTS_NEWCASH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOUNTS_NEWCASH.sql =========**
PROMPT ===================================================================================== 
