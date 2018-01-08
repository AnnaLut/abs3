

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_ZAYAVKA_TRACK.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_ZAYAVKA_TRACK ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_ZAYAVKA_TRACK 
after insert or update of sos, viza ON BARS.ZAYAVKA for each row
declare
    l_trackid   integer;
    l_branch    zayavka_ru.branch%type;
begin
    l_trackid := bars_sqnc.get_nextval('s_zay_track');
    -- зберігаємо історію змін статусів документів
      insert into zay_track(track_id, id, old_sos, new_sos, old_viza, new_viza, change_time, userid, branch)
      values(l_trackid, :new.id, :old.sos, nvl(:new.sos,0), :old.viza, nvl(:new.viza,0), sysdate, user_id, :new.branch);
    --
end taiu_zayavka_track;
/
ALTER TRIGGER BARS.TAIU_ZAYAVKA_TRACK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_ZAYAVKA_TRACK.sql =========*** 
PROMPT ===================================================================================== 
