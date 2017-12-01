PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CP_REFW_UPDATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CP_REFW_UPDATE ***

 CREATE OR REPLACE TRIGGER TAIU_CP_REFW_UPDATE
   AFTER INSERT OR DELETE OR UPDATE OF value, tag, ref
   ON CP_REFW
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
      l_idupd     := bars.s_cp_refw_update.nextval;
      INSERT INTO cp_refw_update (idupd,
                                    chgaction,
                                    effectdate,
                                    chgdate,
                                    doneby,
                                    ref,
                                    tag,
                                    VALUE)
           VALUES (l_idupd,
                   l_chgaction,
                   l_bankdate,
                   SYSDATE,
                   user_id,
                   :old.ref,
                   :old.tag,
                   :old.VALUE);
   ELSIF INSERTING
   THEN
      l_chgaction := 'I';
      l_idupd     := bars.s_cp_refw_update.nextval;
      INSERT INTO cp_refw_update (idupd,
                                    chgaction,
                                    effectdate,
                                    chgdate,
                                    doneby,
                                    ref,
                                    tag,
                                    VALUE)
           VALUES (l_idupd,
                   l_chgaction,
                   l_bankdate,
                   SYSDATE,
                   user_id,
                   :new.ref,
                   :new.tag,
                   :new.VALUE);
   ELSIF UPDATING AND (:old.tag <> :new.tag OR :old.ref <> :new.ref)
   THEN
      l_chgaction := 'D';
      l_idupd     := bars.s_cp_refw_update.nextval;
      INSERT INTO cp_refw_update (idupd,
                                    chgaction,
                                    effectdate,
                                    chgdate,
                                    doneby,
                                    ref,
                                    tag,
                                    VALUE)
           VALUES (l_idupd,
                   l_chgaction,
                   l_bankdate,
                   SYSDATE,
                   user_id,
                   :old.ref,
                   :old.tag,
                   :old.VALUE);

      l_chgaction := 'I';
      l_idupd     := bars.s_cp_refw_update.nextval;
      INSERT INTO cp_refw_update (idupd,
                                    chgaction,
                                    effectdate,
                                    chgdate,
                                    doneby,
                                    ref,
                                    tag,
                                    VALUE)
           VALUES (l_idupd,
                   l_chgaction,
                   l_bankdate,
                   SYSDATE,
                   user_id,
                   :new.ref,
                   :new.tag,
                   :new.VALUE);
   ELSIF UPDATING AND :old.VALUE <> :new.VALUE
   THEN
      l_chgaction := 'U';
      l_idupd     := bars.s_cp_refw_update.nextval;
      INSERT INTO cp_refw_update (idupd,
                                    chgaction,
                                    effectdate,
                                    chgdate,
                                    doneby,
                                    ref,
                                    tag,
                                    VALUE)
           VALUES (l_idupd,
                   l_chgaction,
                   l_bankdate,
                   SYSDATE,
                   user_id,
                   :new.ref,
                   :new.tag,
                   :new.VALUE);
   END IF;
END;

/
ALTER TRIGGER BARS.TAIU_CP_REFW_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CP_REFW_UPDATE.sql =========*
PROMPT ===================================================================================== 
