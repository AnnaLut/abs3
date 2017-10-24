

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_ACCOUNTSW_UPDATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_ACCOUNTSW_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_ACCOUNTSW_UPDATE 
   AFTER INSERT OR DELETE OR UPDATE OF VALUE, tag, acc
   ON ACCOUNTSW
   FOR EACH ROW
DECLARE
   l_bankdate    DATE;
   l_chgaction   CHAR (1);
   l_idupd       NUMBER;
BEGIN
   l_bankdate := bars.gl.bd;

   IF l_bankdate IS NULL
   THEN
      SELECT TO_DATE (val, 'mm/dd/yyyy')
        INTO l_bankdate
        FROM params
       WHERE par = 'BANKDATE';
   END IF;

   IF DELETING
   THEN
      l_chgaction := 'D';
      l_idupd     := bars_sqnc.get_nextval(s_accountsw_update.NEXTVAL, :old.kf);
      INSERT INTO accountsw_update (idupd,
                                    chgaction,
                                    effectdate,
                                    chgdate,
                                    doneby,
                                    acc,
                                    tag,
                                    VALUE,
                                    kf)
           VALUES (l_idupd,
                   l_chgaction,
                   l_bankdate,
                   SYSDATE,
                   user_id,
                   :old.acc,
                   :old.tag,
                   :old.VALUE,
                   :old.kf);
   ELSIF INSERTING
   THEN
      l_chgaction := 'I';
      l_idupd     := bars_sqnc.get_nextval(s_accountsw_update.NEXTVAL, :new.kf);
      INSERT INTO accountsw_update (idupd,
                                    chgaction,
                                    effectdate,
                                    chgdate,
                                    doneby,
                                    acc,
                                    tag,
                                    VALUE,
                                    kf)
           VALUES (l_idupd,
                   l_chgaction,
                   l_bankdate,
                   SYSDATE,
                   user_id,
                   :new.acc,
                   :new.tag,
                   :new.VALUE,
                   :new.kf);
   ELSIF UPDATING AND (:old.tag <> :new.tag OR :old.acc <> :new.acc OR :old.kf <> :new.kf)
   THEN
      l_chgaction := 'D';
      l_idupd     := bars_sqnc.get_nextval(s_accountsw_update.NEXTVAL, :old.kf);
      INSERT INTO accountsw_update (idupd,
                                    chgaction,
                                    effectdate,
                                    chgdate,
                                    doneby,
                                    acc,
                                    tag,
                                    VALUE,
                                    kf)
           VALUES (l_idupd,
                   l_chgaction,
                   l_bankdate,
                   SYSDATE,
                   user_id,
                   :old.acc,
                   :old.tag,
                   :old.VALUE,
                   :old.kf);

      l_chgaction := 'I';
      l_idupd     := bars_sqnc.get_nextval(s_accountsw_update.NEXTVAL, :new.kf);
      INSERT INTO accountsw_update (idupd,
                                    chgaction,
                                    effectdate,
                                    chgdate,
                                    doneby,
                                    acc,
                                    tag,
                                    VALUE,
                                    kf)
           VALUES (l_idupd,
                   l_chgaction,
                   l_bankdate,
                   SYSDATE,
                   user_id,
                   :new.acc,
                   :new.tag,
                   :new.VALUE,
                   :new.kf);
   ELSIF UPDATING AND :old.VALUE <> :new.VALUE
   THEN
      l_chgaction := 'U';
      l_idupd     := bars_sqnc.get_nextval(s_accountsw_update.NEXTVAL, :new.kf);
      INSERT INTO accountsw_update (idupd,
                                    chgaction,
                                    effectdate,
                                    chgdate,
                                    doneby,
                                    acc,
                                    tag,
                                    VALUE,
                                    kf)
           VALUES (l_idupd,
                   l_chgaction,
                   l_bankdate,
                   SYSDATE,
                   user_id,
                   :new.acc,
                   :new.tag,
                   :new.VALUE,
                   :new.kf
                   );
   END IF;
END;
/
ALTER TRIGGER BARS.TAIU_ACCOUNTSW_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_ACCOUNTSW_UPDATE.sql =========*
PROMPT ===================================================================================== 
