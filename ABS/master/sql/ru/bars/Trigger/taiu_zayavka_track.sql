

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_ZAYAVKA_TRACK.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_ZAYAVKA_TRACK ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_ZAYAVKA_TRACK 
   AFTER INSERT OR UPDATE OF sos, viza
   ON zayavka
   FOR EACH ROW
DECLARE
   l_trackid   INTEGER;
BEGIN
   SELECT s_zay_track.NEXTVAL INTO l_trackid FROM DUAL;

   -- зберігаємо історію змін статусів документів
   INSERT INTO zay_track (track_id,
                          id,
                          old_sos,
                          new_sos,
                          old_viza,
                          new_viza,
                          change_time,
                          userid)
        VALUES (l_trackid,
                :new.id,
                :old.sos,
                NVL (:new.sos, 0),
                :old.viza,
                NVL (:new.viza, 0),
                SYSDATE,
                user_id);
--
END taiu_zayavka_track;
/
ALTER TRIGGER BARS.TAIU_ZAYAVKA_TRACK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_ZAYAVKA_TRACK.sql =========*** 
PROMPT ===================================================================================== 
