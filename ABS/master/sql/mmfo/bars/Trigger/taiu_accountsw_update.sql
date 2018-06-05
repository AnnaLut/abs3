

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_ACCOUNTSW_UPDATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_ACCOUNTSW_UPDATE ***

CREATE OR REPLACE TRIGGER TAIU_ACCOUNTSW_UPDATE
AFTER INSERT OR UPDATE OR DELETE OF VALUE, TAG, ACC ON BARS.ACCOUNTSW
for each row
declare
-- Author : V.Kharin
-- Date   : 03/04/2018
  l_rec  ACCOUNTSW_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
    l_old_key varchar2(38);
  begin

    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.acc  := :old.acc;  l_rec.tag  := trim(:old.tag);   l_rec.value  := :old.value;
    else
        l_rec.acc  := :new.acc;  l_rec.tag  := trim(:new.tag);   l_rec.value  := :new.value;
    end if;
    bars_sqnc.split_key(l_rec.acc, l_old_key, l_rec.KF);
    l_rec.IDUPD         := bars_sqnc.get_nextval('s_accountsw_update', l_rec.KF);
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    --l_rec.GLOBAL_BDATE  := glb_bankdate;    -- sysdate
    l_rec.DONEBY        := user_id; --gl.aUID;  user_name;
    l_rec.CHGDATE       := sysdate;

    insert into BARS.ACCOUNTSW_UPDATE values l_rec;

  end SAVE_CHANGES;
  ---
begin
  case
    when inserting
    then
      l_rec.CHGACTION := 'I';
      SAVE_CHANGES;

    when deleting
    then
      l_rec.CHGACTION := 'D';
      SAVE_CHANGES;

    when updating
    then
      case
        when (:old.acc <> :new.acc or :old.tag <> :new.tag) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)
          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;

        when (     :old.ACC != :new.ACC
                OR :old.TAG != :new.TAG
                OR :old.VALUE <> :new.VALUE
                OR (:old.VALUE IS     NULL AND :new.VALUE IS NOT NULL)
                OR (:old.VALUE IS NOT NULL AND :new.VALUE IS     NULL)
             )
        then -- При зміні значеннь полів, що НЕ входять в PRIMARY KEY
          l_rec.CHGACTION := 'U';
          SAVE_CHANGES;
        else
          Null;
      end case;
    else
      null;
  end case;
end;
/

ALTER TRIGGER BARS.TAIU_ACCOUNTSW_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_ACCOUNTSW_UPDATE.sql =========*
PROMPT ===================================================================================== 
