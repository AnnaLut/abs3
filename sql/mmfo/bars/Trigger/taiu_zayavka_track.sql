

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
    begin
      select branch into l_branch from zayavka_ru where req_id = :new.id;
      insert into zay_track(track_id, id, old_sos, new_sos, old_viza, new_viza, change_time, userid, branch)
      values(l_trackid, :new.id, :old.sos, nvl(:new.sos,0), :old.viza, nvl(:new.viza,0), sysdate, user_id, l_branch);
    exception when no_data_found then
      insert into zay_track(track_id, id, old_sos, new_sos, old_viza, new_viza, change_time, userid)
      values(l_trackid, :new.id, :old.sos, nvl(:new.sos,0), :old.viza, nvl(:new.viza,0), sysdate, user_id);
    end;
    --
end taiu_zayavka_track;

/
ALTER TRIGGER BARS.TAIU_ZAYAVKA_TRACK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_ZAYAVKA_TRACK.sql =========*** 
PROMPT ===================================================================================== 
