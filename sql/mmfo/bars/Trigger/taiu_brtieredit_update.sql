

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_BRTIEREDIT_UPDATE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_BRTIEREDIT_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_BRTIEREDIT_UPDATE 
after insert or delete or update
   of BR_ID, BDATE, KV, S, RATE
   on BARS.BR_TIER_EDIT for each row
declare
  ---------------------
  -- ver. 15.03.2017 --
  ---------------------
  l_rec    BR_TIER_EDIT_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
  begin

    if ( l_rec.CHGACTION = 'D' )
    then
      l_rec.KF    := :old.KF;
      l_rec.BR_ID := :old.BR_ID;  l_rec.BDATE := :old.BDATE;  l_rec.KV     := :old.KV;
      l_rec.S     := :old.S;      l_rec.RATE  := :old.RATE;   l_rec.BRANCH := :old.BRANCH;
    else
      l_rec.KF    := :new.KF;
      l_rec.BR_ID := :new.BR_ID;  l_rec.BDATE := :new.BDATE;  l_rec.KV     := :new.KV;
      l_rec.S     := :new.S;      l_rec.RATE  := :new.RATE;   l_rec.BRANCH := :new.BRANCH;
    end if;

    l_rec.IDUPD      := bars_sqnc.get_nextval( 's_brtieredit_update', l_rec.KF );
    l_rec.EFFECTDATE := COALESCE( gl.bd, glb_bankdate );
    l_rec.DONEBY     := gl.aUID; -- gl.aUID(NUMBER); user_name(VARCHAR2);
    l_rec.CHGDATE    := sysdate;

    insert into BARS.BR_TIER_EDIT_UPDATE values l_rec;

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
        when ( :old.BR_ID <> :new.BR_ID OR :old.BDATE <> :new.BDATE OR
               :old.KV    <> :new.KV    OR :old.S     <> :new.S )
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)

          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;

        when ( :old.RATE <> :new.RATE  OR (:old.RATE IS NULL AND :new.RATE IS NOT NULL)
                                       OR (:new.RATE IS NULL AND :old.RATE IS NOT NULL)
             )
        then -- При зміні значеннь полів, що НЕ входять в PRIMARY KEY

          -- протоколюємо внесені зміни
          l_rec.CHGACTION := 'U';
          SAVE_CHANGES;

        else -- UPDATE який не змінив значення полів таблиці
          Null;
      end case;
    else
      null;
  end case;
end;
/
ALTER TRIGGER BARS.TAIU_BRTIEREDIT_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_BRTIEREDIT_UPDATE.sql =========
PROMPT ===================================================================================== 
