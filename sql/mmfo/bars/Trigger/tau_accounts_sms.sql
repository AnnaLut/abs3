

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_SMS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_ACCOUNTS_SMS ***

  CREATE OR REPLACE TRIGGER BARS.TAU_ACCOUNTS_SMS 
   AFTER UPDATE OF ostc
   ON ACCOUNTS
   FOR EACH ROW
    WHEN (    new.send_sms = 'Y'
         AND (   old.ostc <> new.ostc
              OR old.dos <> new.dos
              OR old.kos <> new.kos)) DECLARE
   l_nlsb   VARCHAR2 (15);
   l_nlsa   VARCHAR2 (15);
   l_kf     VARCHAR2 (6);
BEGIN
   SELECT T1.NLSA, T1.NLSB, t1.kf
     INTO l_nlsa, l_nlsb, l_KF
     FROM oper t1
    WHERE T1.REF = GL.AREF;

   INSERT INTO acc_balance_changes (id,
                                    change_time,
                                    rnk,
                                    acc,
                                    ostc,
                                    dos_delta,
                                    kos_delta,
                                    REF,
                                    tt,
                                    nlsb,
                                    nlsa,
                                    KF)
      SELECT s_accbalch.NEXTVAL,
             SYSDATE,
             :new.rnk,
             :new.acc,
             :new.ostc,
             CASE
                WHEN (:new.dapp <> :old.dapp OR :new.dappq <> :old.dappq)
                THEN
                   :new.dos
                ELSE
                   :new.dos - :old.dos
             END,
             CASE
                WHEN (:new.dapp <> :old.dapp OR :new.dappq <> :old.dappq)
                THEN
                   :new.kos
                ELSE
                   :new.kos - :old.kos
             END,
             GL.AREF,
             GL.ATT,
             l_nlsb,
             l_nlsa,
             l_KF
        FROM DUAL;
END;
/
ALTER TRIGGER BARS.TAU_ACCOUNTS_SMS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_SMS.sql =========*** En
PROMPT ===================================================================================== 
