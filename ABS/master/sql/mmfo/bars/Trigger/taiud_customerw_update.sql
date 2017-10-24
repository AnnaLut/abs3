

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_CUSTOMERW_UPDATE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_CUSTOMERW_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_CUSTOMERW_UPDATE 
AFTER INSERT OR UPDATE OR DELETE OF VALUE ON BARS.CUSTOMERW
for each row
declare
-- Author : V.Kharin
-- Date   : 08/12/2016
  l_rec  CUSTOMERW_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
    l_old_key varchar2(38);
  begin

    if ( l_rec.CHGACTION = 3 )
    then
        l_rec.rnk  := :old.rnk;  l_rec.tag  := trim(:old.tag);   l_rec.value  := :old.value;  l_rec.isp  := :old.isp;
    else
        l_rec.rnk  := :new.rnk;  l_rec.tag  := trim(:new.tag);   l_rec.value  := :new.value;  l_rec.isp  := :new.isp;
    end if;
    bars_sqnc.split_key(l_rec.rnk, l_old_key, l_rec.KF);
    l_rec.IDUPD         := bars_sqnc.get_nextval('s_customerw_update', l_rec.KF);
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    --l_rec.GLOBAL_BDATE  := glb_bankdate;    -- sysdate
    l_rec.DONEBY        := user_name; --gl.aUID;  user_name;
    l_rec.CHGDATE       := sysdate;

    insert into BARS.CUSTOMERW_UPDATE values l_rec;

  end SAVE_CHANGES;
  ---
begin
  case
    when inserting
    then
      l_rec.CHGACTION := 1; --'I';
      SAVE_CHANGES;

    when deleting
    then
      l_rec.CHGACTION := 3; --'D';
      SAVE_CHANGES;

    when updating
    then
      case
        when (:old.rnk <> :new.rnk or :old.tag <> :new.tag) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)
          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 3; --'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 1; --'I';
          SAVE_CHANGES;

        when (     :old.RNK != :new.RNK
                OR :old.TAG != :new.TAG
                OR :old.VALUE <> :new.VALUE           OR (:old.VALUE IS NULL AND :new.VALUE IS NOT NULL)           OR (:old.VALUE IS NOT NULL AND :new.VALUE IS NULL)
             )
        then -- При зміні значеннь полів, що НЕ входять в PRIMARY KEY
          l_rec.CHGACTION := 2; --'U';
          SAVE_CHANGES;
        else
          Null;
      end case;
    else
      null;
  end case;
end;
/
ALTER TRIGGER BARS.TAIUD_CUSTOMERW_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_CUSTOMERW_UPDATE.sql =========
PROMPT ===================================================================================== 
