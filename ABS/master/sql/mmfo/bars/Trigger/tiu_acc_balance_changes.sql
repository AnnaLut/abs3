

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACC_BALANCE_CHANGES.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACC_BALANCE_CHANGES ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACC_BALANCE_CHANGES 
   AFTER DELETE
   ON ACC_BALANCE_CHANGES
   FOR EACH ROW
DECLARE
   ID   NUMBER;
   l_KF varchar2(6);
BEGIN
   begin
    select kf
      into l_KF
      from accounts
     where acc = :OLD.ACC;
   exception when no_data_found then l_KF := '300465';
    bars_audit.info('Для АСС = '|| :OLD.ACC ||' не знайдено значення KF. Встановлено 300465 за замовчуванням.');
   end;

   INSERT INTO ACC_BALANCE_CHANGES_UPDATE (ACC,
                                           CHANGE_TIME,
                                           DOS_DELTA,
                                           ID,
                                           KOS_DELTA,
                                           NLSB,
                                           OSTC,
                                           REF,
                                           RNK,
                                           TT,
                                           NLSA,
                                           KF)
        VALUES (:OLD.ACC,
                :OLD.CHANGE_TIME,
                :OLD.DOS_DELTA,
                :OLD.ID,
                :OLD.KOS_DELTA,
                :OLD.NLSB,
                :OLD.OSTC,
                :OLD.REF,
                :OLD.RNK,
                :OLD.TT,
                :OLD.NLSA,
                l_KF);
EXCEPTION
   WHEN OTHERS
   THEN bars_audit.error('TIU_ACC_BALANCE_CHANGES: Ошибка вставки в историю измненения баланса ACC_BALANCE_CHANGES_UPDATE '|| sqlerrm);
END TIU_ACC_BALANCE_CHANGES;
/
ALTER TRIGGER BARS.TIU_ACC_BALANCE_CHANGES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACC_BALANCE_CHANGES.sql ========
PROMPT ===================================================================================== 
