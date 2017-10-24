

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_STO_DAT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_STO_DAT ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_STO_DAT 
   AFTER INSERT OR UPDATE OR DELETE
   ON STO_DAT    FOR EACH ROW
DECLARE
   --------------------
   -- коммерч.банк   --
   --------------------
   l_bankdate   DATE := gl.bdate;
   l_userid     NUMBER (38) := gl.auid;
   l_actionid   NUMBER (1);
   l_idupd      NUMBER (38);
BEGIN
   IF DELETING
   THEN
      l_actionid := -1;                                            -- удаление

      SELECT bars_sqnc.get_nextval('S_STO_DAT_UPDATE') INTO l_idupd FROM DUAL;

      INSERT INTO sto_dat_update (IDD,
                                  DAT,
                                  "REF",
                                  KF,
                                  ACTION,
                                  IDUPD,
                                  "WHEN",
                                  USERID)
           VALUES (:old.IDD,
                   :old.DAT,
                   :old."REF",
                   :old.KF,
                   l_actionid,
                   l_idupd,
                   SYSDATE,
                   l_userid);
   ELSIF INSERTING
   THEN
      l_actionid := 0;                                             -- открытие

      SELECT bars_sqnc.get_nextval('S_STO_DAT_UPDATE') INTO l_idupd FROM DUAL;

      INSERT INTO sto_dat_update (IDD,
                                  DAT,
                                  "REF",
                                  KF,
                                  ACTION,
                                  IDUPD,
                                  "WHEN",
                                  USERID)
           VALUES (:new.IDD,
                   :new.DAT,
                   :new."REF",
                   :new.KF,
                   l_actionid,
                   l_idupd,
                   SYSDATE,
                   l_userid);
   ELSIF UPDATING THEN
      l_actionid := 1;                                            -- изменение

      -- проверим, действительно ли что-то менялось
      IF    :new.IDD != :old.IDD
         OR :new.DAT != :old.DAT
         OR :new."REF" != :old."REF"
         OR :new.KF != :old.KF
      THEN
         SELECT bars_sqnc.get_nextval('S_STO_DAT_UPDATE') INTO l_idupd FROM DUAL;

         INSERT INTO sto_dat_update (IDD,
                                     DAT,
                                     "REF",
                                     KF,
                                     ACTION,
                                     IDUPD,
                                     "WHEN",
                                     USERID)
              VALUES (:new.IDD,
                      :new.DAT,
                      :new."REF",
                      :new.KF,
                      l_actionid,
                      l_idupd,
                      SYSDATE,
                      l_userid);
      ELSE
         RETURN;                                -- ничего не менялось, выходим
      END IF;
   END IF;
END;
/
ALTER TRIGGER BARS.TIUD_STO_DAT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_STO_DAT.sql =========*** End **
PROMPT ===================================================================================== 
