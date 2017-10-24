

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_PAWNACC_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_PAWNACC_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_PAWNACC_UPDATE 
after insert or delete or update of ACC,PAWN,MPAWN,NREE,IDZ,NDZ,DEPOSIT_ID,KF,SV,CC_IDZ,SDATZ
 on bars.pawn_acc for each row
declare
  --v. 09.12.2016 VK
  l_rec  PAWN_ACC_update%rowtype;
  ---
  procedure SAVE_CHANGES
  is
  begin
    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.ACC        := :old.ACC;        l_rec.PAWN  := :old.PAWN;      l_rec.MPAWN := :old.MPAWN;
        l_rec.NREE       := :old.NREE;       l_rec.IDZ   := :old.IDZ;       l_rec.NDZ   := :old.NDZ;
        l_rec.DEPOSIT_ID := :old.DEPOSIT_ID; l_rec.KF    := :old.KF;        l_rec.SV    := :old.SV;
        l_rec.CC_IDZ     := :old.CC_IDZ;     l_rec.SDATZ := :old.SDATZ;
    else
        l_rec.ACC        := :new.ACC;        l_rec.PAWN  := :new.PAWN;      l_rec.MPAWN := :new.MPAWN;
        l_rec.NREE       := :new.NREE;       l_rec.IDZ   := :new.IDZ;       l_rec.NDZ   := :new.NDZ;
        l_rec.DEPOSIT_ID := :new.DEPOSIT_ID; l_rec.KF    := :new.KF;        l_rec.SV    := :new.SV;
        l_rec.CC_IDZ     := :new.CC_IDZ;     l_rec.SDATZ := :new.SDATZ;
    end if;
    l_rec.IDUPD         := bars_sqnc.get_nextval('s_pawnacc_update', l_rec.KF);
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.DONEBY        := user_id; --gl.aUID(NUMBER);    user_name(VARCHAR2);
    l_rec.CHGDATE       := sysdate;

    insert into BARS.PAWN_ACC_update values l_rec;
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
        when (:old.ACC <> :new.ACC or :old.KF <> :new.KF ) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)
          l_rec.CHGACTION := 'D';   -- породжуємо в історії запис про видалення
          SAVE_CHANGES;
          l_rec.CHGACTION := 'I';   -- породжуємо в історії запис про вставку
          SAVE_CHANGES;
        when (     :old.ACC  <> :new.ACC
               OR  :old.PAWN <> :new.PAWN             OR (:old.PAWN IS NULL AND :new.PAWN IS NOT NULL)             OR (:old.PAWN IS NOT NULL AND :new.PAWN IS NULL)
               OR  :old.MPAWN <> :new.MPAWN           OR (:old.MPAWN IS NULL AND :new.MPAWN IS NOT NULL)           OR (:old.MPAWN IS NOT NULL AND :new.MPAWN IS NULL)
               OR  :old.NREE <> :new.NREE             OR (:old.NREE IS NULL AND :new.NREE IS NOT NULL)             OR (:old.NREE IS NOT NULL AND :new.NREE IS NULL)
               OR  :old.IDZ <> :new.IDZ               OR (:old.IDZ IS NULL AND :new.IDZ IS NOT NULL)               OR (:old.IDZ IS NOT NULL AND :new.IDZ IS NULL)
               OR  :old.NDZ <> :new.NDZ               OR (:old.NDZ IS NULL AND :new.NDZ IS NOT NULL)               OR (:old.NDZ IS NOT NULL AND :new.NDZ IS NULL)
               OR  :old.DEPOSIT_ID <> :new.DEPOSIT_ID OR (:old.DEPOSIT_ID IS NULL AND :new.DEPOSIT_ID IS NOT NULL) OR (:old.DEPOSIT_ID IS NOT NULL AND :new.DEPOSIT_ID IS NULL)
               OR  :old.KF <> :new.KF                 OR (:old.KF IS NULL AND :new.KF IS NOT NULL)                 OR (:old.KF IS NOT NULL AND :new.KF IS NULL)
               OR  :old.SV <> :new.SV                 OR (:old.SV IS NULL AND :new.SV IS NOT NULL)                 OR (:old.SV IS NOT NULL AND :new.SV IS NULL)
               OR  :old.CC_IDZ <> :new.CC_IDZ         OR (:old.CC_IDZ IS NULL AND :new.CC_IDZ IS NOT NULL)         OR (:old.CC_IDZ IS NOT NULL AND :new.CC_IDZ IS NULL)
               OR  :old.SDATZ <> :new.SDATZ           OR (:old.SDATZ IS NULL AND :new.SDATZ IS NOT NULL)           OR (:old.SDATZ IS NOT NULL AND :new.SDATZ IS NULL)
             )
        then -- При зміні значеннь полів, що НЕ входять в PRIMARY KEY
          -- протоколюємо внесені зміни
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
ALTER TRIGGER BARS.TAIU_PAWNACC_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_PAWNACC_UPDATE.sql =========***
PROMPT ===================================================================================== 
