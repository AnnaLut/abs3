

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CUSTBANK_UPDATE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CUSTBANK_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CUSTBANK_UPDATE 
after insert or delete or update
 on bars.CUSTBANK for each row
declare
-- Author : V.Kharin
-- Date   : 08/12/2016
  l_rec  CUSTBANK_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
    l_old_key varchar2(38);
  begin
    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.RNK         := :old.RNK;        l_rec.MFO         := :old.MFO;        l_rec.ALT_BIC     := :old.ALT_BIC;
        l_rec.BIC         := :old.BIC;        l_rec.RATING      := :old.RATING;     l_rec.KOD_B       := :old.KOD_B;
        l_rec.DAT_ND      := :old.DAT_ND;     l_rec.RUK         := :old.RUK;        l_rec.TELR        := :old.TELR;
        l_rec.BUH         := :old.BUH;        l_rec.TELB        := :old.TELB;       l_rec.NUM_ND      := :old.NUM_ND;
    else
        l_rec.RNK         := :new.RNK;        l_rec.MFO         := :new.MFO;        l_rec.ALT_BIC     := :new.ALT_BIC;
        l_rec.BIC         := :new.BIC;        l_rec.RATING      := :new.RATING;     l_rec.KOD_B       := :new.KOD_B;
        l_rec.DAT_ND      := :new.DAT_ND;     l_rec.RUK         := :new.RUK;        l_rec.TELR        := :new.TELR;
        l_rec.BUH         := :new.BUH;        l_rec.TELB        := :new.TELB;       l_rec.NUM_ND      := :new.NUM_ND;
    end if;

    bars_sqnc.split_key(l_rec.RNK, l_old_key, l_rec.KF);
    l_rec.IDUPD         := bars_sqnc.get_nextval('s_custbank_update', l_rec.KF);
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    --l_rec.GLOBAL_BDATE  := glb_bankdate;    -- sysdate
    l_rec.DONEBY        := gl.aUID; --gl.aUID;  user_name;
    l_rec.CHGDATE       := sysdate;

    insert into BARS.CUSTBANK_UPDATE values l_rec;

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
        when (:old.RNK <> :new.RNK) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)
          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;

        when (     :old.RNK <> :new.RNK
                OR :old.ALT_BIC <> :new.ALT_BIC   OR (:old.ALT_BIC IS NULL AND :new.ALT_BIC IS NOT NULL) OR (:old.ALT_BIC IS NOT NULL AND :new.ALT_BIC IS NULL)
                OR :old.BIC <> :new.BIC           OR (:old.BIC IS NULL AND :new.BIC IS NOT NULL)         OR (:old.BIC IS NOT NULL AND :new.BIC IS NULL)
                OR :old.RATING <> :new.RATING     OR (:old.RATING IS NULL AND :new.RATING IS NOT NULL)   OR (:old.RATING IS NOT NULL AND :new.RATING IS NULL)
                OR :old.KOD_B <> :new.KOD_B       OR (:old.KOD_B IS NULL AND :new.KOD_B IS NOT NULL)     OR (:old.KOD_B IS NOT NULL AND :new.KOD_B IS NULL)
                OR :old.DAT_ND <> :new.DAT_ND     OR (:old.DAT_ND IS NULL AND :new.DAT_ND IS NOT NULL)   OR (:old.DAT_ND IS NOT NULL AND :new.DAT_ND IS NULL)
                OR :old.RUK <> :new.RUK           OR (:old.RUK IS NULL AND :new.RUK IS NOT NULL)         OR (:old.RUK IS NOT NULL AND :new.RUK IS NULL)
                OR :old.TELR <> :new.TELR         OR (:old.TELR IS NULL AND :new.TELR IS NOT NULL)       OR (:old.TELR IS NOT NULL AND :new.TELR IS NULL)
                OR :old.BUH <> :new.BUH           OR (:old.BUH IS NULL AND :new.BUH IS NOT NULL)         OR (:old.BUH IS NOT NULL AND :new.BUH IS NULL)
                OR :old.TELB <> :new.TELB         OR (:old.TELB IS NULL AND :new.TELB IS NOT NULL)       OR (:old.TELB IS NOT NULL AND :new.TELB IS NULL)
                OR :old.NUM_ND <> :new.NUM_ND     OR (:old.NUM_ND IS NULL AND :new.NUM_ND IS NOT NULL)   OR (:old.NUM_ND IS NOT NULL AND :new.NUM_ND IS NULL)
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
ALTER TRIGGER BARS.TAIU_CUSTBANK_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CUSTBANK_UPDATE.sql =========**
PROMPT ===================================================================================== 
