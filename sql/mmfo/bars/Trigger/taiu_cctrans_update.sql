

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCTRANS_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CCTRANS_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CCTRANS_UPDATE 
after insert or update or delete
   on BARS.CC_TRANS for each row
declare
  l_rec    CC_TRANS_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
    l_old_key varchar2(38);
  begin
    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.NPP    := :old.NPP;        l_rec.REF    := :old.REF;        l_rec.ACC    := :old.ACC;
        l_rec.FDAT   := :old.FDAT;       l_rec.SV     := :old.SV;         l_rec.SZ     := :old.SZ;
        l_rec.D_PLAN := :old.D_PLAN;     l_rec.D_FAKT := :old.D_FAKT;     l_rec.DAPP   := :old.DAPP;
        l_rec.REFP   := :old.REFP;       l_rec.COMM   := :old.COMM;       l_rec.ID0    := :old.ID0;
        l_rec.KF     := :old.KF;
    else
        l_rec.NPP    := :new.NPP;        l_rec.REF    := :new.REF;        l_rec.ACC    := :new.ACC;
        l_rec.FDAT   := :new.FDAT;       l_rec.SV     := :new.SV;         l_rec.SZ     := :new.SZ;
        l_rec.D_PLAN := :new.D_PLAN;     l_rec.D_FAKT := :new.D_FAKT;     l_rec.DAPP   := :new.DAPP;
        l_rec.REFP   := :new.REFP;       l_rec.COMM   := :new.COMM;       l_rec.ID0    := :new.ID0;
        l_rec.KF     := :new.KF;
    end if;

    l_rec.IDUPD         := bars_sqnc.get_nextval('s_cctrans_update', l_rec.KF);
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.DONEBY        := gl.aUID; --gl.aUID(NUMBER);	user_name(VARCHAR2);
    l_rec.CHGDATE       := sysdate;

    insert into BARS.CC_TRANS_UPDATE values l_rec;
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
        when ( :old.NPP <> :new.NPP ) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)

          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;
        when (
                   :old.NPP <> :new.NPP
                OR :old.REF <> :new.REF        OR (:old.REF IS NULL AND :new.REF IS NOT NULL)        OR (:old.REF IS NOT NULL AND :new.REF IS NULL)
                OR :old.ACC <> :new.ACC        OR (:old.ACC IS NULL AND :new.ACC IS NOT NULL)        OR (:old.ACC IS NOT NULL AND :new.ACC IS NULL)
                OR :old.FDAT <> :new.FDAT      OR (:old.FDAT IS NULL AND :new.FDAT IS NOT NULL)      OR (:old.FDAT IS NOT NULL AND :new.FDAT IS NULL)
                OR :old.SV <> :new.SV          OR (:old.SV IS NULL AND :new.SV IS NOT NULL)          OR (:old.SV IS NOT NULL AND :new.SV IS NULL)
                OR :old.SZ <> :new.SZ          OR (:old.SZ IS NULL AND :new.SZ IS NOT NULL)          OR (:old.SZ IS NOT NULL AND :new.SZ IS NULL)
                OR :old.D_PLAN <> :new.D_PLAN  OR (:old.D_PLAN IS NULL AND :new.D_PLAN IS NOT NULL)  OR (:old.D_PLAN IS NOT NULL AND :new.D_PLAN IS NULL)
                OR :old.D_FAKT <> :new.D_FAKT  OR (:old.D_FAKT IS NULL AND :new.D_FAKT IS NOT NULL)  OR (:old.D_FAKT IS NOT NULL AND :new.D_FAKT IS NULL)
                OR :old.DAPP <> :new.DAPP      OR (:old.DAPP IS NULL AND :new.DAPP IS NOT NULL)      OR (:old.DAPP IS NOT NULL AND :new.DAPP IS NULL)
                OR :old.REFP <> :new.REFP      OR (:old.REFP IS NULL AND :new.REFP IS NOT NULL)      OR (:old.REFP IS NOT NULL AND :new.REFP IS NULL)
                OR :old.COMM <> :new.COMM      OR (:old.COMM IS NULL AND :new.COMM IS NOT NULL)      OR (:old.COMM IS NOT NULL AND :new.COMM IS NULL)
                OR :old.ID0 <> :new.ID0        OR (:old.ID0 IS NULL AND :new.ID0 IS NOT NULL)        OR (:old.ID0 IS NOT NULL AND :new.ID0 IS NULL)
                OR :old.KF <> :new.KF          OR (:old.KF IS NULL AND :new.KF IS NOT NULL)          OR (:old.KF IS NOT NULL AND :new.KF IS NULL)
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
end TAIU_CCTRANS_UPDATE;
/
ALTER TRIGGER BARS.TAIU_CCTRANS_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCTRANS_UPDATE.sql =========***
PROMPT ===================================================================================== 
