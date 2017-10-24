

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CORPS_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CORPS_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CORPS_UPDATE 
after insert or delete or update
of  RNK, NMKU, RUK, TELR,
    BUH, TELB, DOV, BDOV,
    EDOV, NLSNEW, MAINNLS, MAINMFO,
    MFONEW, TEL_FAX, E_MAIL, SEAL_ID,
    NMK
ON BARS.CORPS
for each row
declare
  l_rec  BARS.CORPS_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
  begin

    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.RNK := :old.RNK;          l_rec.NMKU := :old.NMKU;        l_rec.RUK := :old.RUK;          l_rec.TELR := :old.TELR;
        l_rec.BUH := :old.BUH;          l_rec.TELB := :old.TELB;        l_rec.DOV := :old.DOV;          l_rec.BDOV := :old.BDOV;
        l_rec.EDOV := :old.EDOV;        l_rec.NLSNEW := :old.NLSNEW;    l_rec.MAINNLS := :old.MAINNLS;  l_rec.MAINMFO := :old.MAINMFO;
        l_rec.MFONEW := :old.MFONEW;    l_rec.TEL_FAX := :old.TEL_FAX;  l_rec.E_MAIL := :old.E_MAIL;    l_rec.SEAL_ID := :old.SEAL_ID;
        l_rec.NMK := :old.NMK;
    else
        l_rec.RNK := :new.RNK;          l_rec.NMKU := :new.NMKU;        l_rec.RUK := :new.RUK;          l_rec.TELR := :new.TELR;
        l_rec.BUH := :new.BUH;          l_rec.TELB := :new.TELB;        l_rec.DOV := :new.DOV;
        l_rec.BDOV := :new.BDOV;
        l_rec.EDOV := :new.EDOV;        l_rec.NLSNEW := :new.NLSNEW;    l_rec.MAINNLS := :new.MAINNLS;  l_rec.MAINMFO := :new.MAINMFO;
        l_rec.MFONEW := :new.MFONEW;    l_rec.TEL_FAX := :new.TEL_FAX;  l_rec.E_MAIL := :new.E_MAIL;    l_rec.SEAL_ID := :new.SEAL_ID;
        l_rec.NMK := :new.NMK;
    end if;
    l_rec.IDUPD         := s_corps_update.nextval;
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBAL_BDATE  := glb_bankdate;    -- sysdate
    l_rec.DONEBY        := gl.aUID; --gl.aUID(NUMBER);	user_name(VARCHAR2);
    l_rec.CHGDATE       := sysdate;

    insert into BARS.CORPS_UPDATE values l_rec;

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

        when (
                    :old.NMKU <> :new.NMKU          OR (:old.NMKU IS NULL AND :new.NMKU IS NOT NULL)       OR (:old.NMKU IS NOT NULL AND :new.NMKU IS NULL)
                OR  :old.RUK <> :new.RUK            OR (:old.RUK IS NULL AND :new.RUK IS NOT NULL)         OR (:old.RUK IS NOT NULL AND :new.RUK IS NULL)
                OR  :old.TELR <> :new.TELR          OR (:old.TELR IS NULL AND :new.TELR IS NOT NULL)       OR (:old.TELR IS NOT NULL AND :new.TELR IS NULL)
                OR  :old.BUH <> :new.BUH            OR (:old.BUH IS NULL AND :new.BUH IS NOT NULL)         OR (:old.BUH IS NOT NULL AND :new.BUH IS NULL)
                OR  :old.TELB <> :new.TELB          OR (:old.TELB IS NULL AND :new.TELB IS NOT NULL)       OR (:old.TELB IS NOT NULL AND :new.TELB IS NULL)
                OR  :old.DOV <> :new.DOV            OR (:old.DOV IS NULL AND :new.DOV IS NOT NULL)         OR (:old.DOV IS NOT NULL AND :new.DOV IS NULL)
                OR  :old.BDOV <> :new.BDOV          OR (:old.BDOV IS NULL AND :new.BDOV IS NOT NULL)       OR (:old.BDOV IS NOT NULL AND :new.BDOV IS NULL)
                OR  :old.EDOV <> :new.EDOV          OR (:old.EDOV IS NULL AND :new.EDOV IS NOT NULL)       OR (:old.EDOV IS NOT NULL AND :new.EDOV IS NULL)
                OR  :old.NLSNEW <> :new.NLSNEW      OR (:old.NLSNEW IS NULL AND :new.NLSNEW IS NOT NULL)   OR (:old.NLSNEW IS NOT NULL AND :new.NLSNEW IS NULL)
                OR  :old.MAINNLS <> :new.MAINNLS    OR (:old.MAINNLS IS NULL AND :new.MAINNLS IS NOT NULL) OR (:old.MAINNLS IS NOT NULL AND :new.MAINNLS IS NULL)
                OR  :old.MAINMFO <> :new.MAINMFO    OR (:old.MAINMFO IS NULL AND :new.MAINMFO IS NOT NULL) OR (:old.MAINMFO IS NOT NULL AND :new.MAINMFO IS NULL)
                OR  :old.MFONEW <> :new.MFONEW      OR (:old.MFONEW IS NULL AND :new.MFONEW IS NOT NULL)   OR (:old.MFONEW IS NOT NULL AND :new.MFONEW IS NULL)
                OR  :old.TEL_FAX <> :new.TEL_FAX    OR (:old.TEL_FAX IS NULL AND :new.TEL_FAX IS NOT NULL) OR (:old.TEL_FAX IS NOT NULL AND :new.TEL_FAX IS NULL)
                OR  :old.E_MAIL <> :new.E_MAIL      OR (:old.E_MAIL IS NULL AND :new.E_MAIL IS NOT NULL)   OR (:old.E_MAIL IS NOT NULL AND :new.E_MAIL IS NULL)
                OR  :old.SEAL_ID <> :new.SEAL_ID    OR (:old.SEAL_ID IS NULL AND :new.SEAL_ID IS NOT NULL) OR (:old.SEAL_ID IS NOT NULL AND :new.SEAL_ID IS NULL)
                OR  :old.NMK <> :new.NMK            OR (:old.NMK IS NULL AND :new.NMK IS NOT NULL)         OR (:old.NMK IS NOT NULL AND :new.NMK IS NULL)
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

end TAIU_CORPS_UPDATE;
/
ALTER TRIGGER BARS.TAIU_CORPS_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CORPS_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
