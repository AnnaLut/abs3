

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_PERSON_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_PERSON_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_PERSON_UPDATE 
    after insert or delete or update
    of  RNK,            SEX,        PASSP,      SER,
        NUMDOC,         PDATE,      ORGAN,      BDAY,
        BPLACE,         TELD,       TELW,       CELLPHONE,
        BDOV,           EDOV,       DATE_PHOTO,
        ACTUAL_DATE,    EDDR_ID
-- в базовій таблиці є колонки DOV, CELLPHONE_CONFIRMED, яких немає в UPDATE -таблиці
    ON BARS.PERSON
    for each row
declare
  l_rec  PERSON_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
  begin

    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.RNK := :old.RNK;                  l_rec.SEX := :old.SEX;              l_rec.PASSP := :old.PASSP;      l_rec.SER := :old.SER;
        l_rec.NUMDOC := :old.NUMDOC;            l_rec.PDATE := :old.PDATE;          l_rec.ORGAN := :old.ORGAN;      l_rec.BDAY := :old.BDAY;
        l_rec.BPLACE := :old.BPLACE;            l_rec.TELD := :old.TELD;            l_rec.TELW := :old.TELW;        l_rec.CELLPHONE := :old.CELLPHONE;
        l_rec.BDOV := :old.BDOV;                l_rec.EDOV := :old.EDOV;            l_rec.DATE_PHOTO := :old.DATE_PHOTO;
        l_rec.ACTUAL_DATE := :old.ACTUAL_DATE;  l_rec.EDDR_ID := :old.EDDR_ID;
    else
        l_rec.RNK := :new.RNK;                  l_rec.SEX := :new.SEX;              l_rec.PASSP := :new.PASSP;  l_rec.SER := :new.SER;
        l_rec.NUMDOC := :new.NUMDOC;            l_rec.PDATE := :new.PDATE;          l_rec.ORGAN := :new.ORGAN;  l_rec.BDAY := :new.BDAY;
        l_rec.BPLACE := :new.BPLACE;            l_rec.TELD := :new.TELD;            l_rec.TELW := :new.TELW;    l_rec.CELLPHONE := :new.CELLPHONE;
        l_rec.BDOV := :new.BDOV;                l_rec.EDOV := :new.EDOV;            l_rec.DATE_PHOTO := :new.DATE_PHOTO;
        l_rec.ACTUAL_DATE := :new.ACTUAL_DATE;  l_rec.EDDR_ID := :new.EDDR_ID;
    end if;
    l_rec.IDUPD         := s_person_update.nextval;
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBAL_BDATE  := glb_bankdate;    -- sysdate
    l_rec.DONEBY        := gl.aUID; --gl.aUID;  user_name;
    l_rec.CHGDATE       := sysdate;

    insert into BARS.PERSON_UPDATE values l_rec;

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
        when (:old.rnk <> :new.rnk) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)

          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;

        when (
                :old.RNK <> :new.RNK
                OR :old.SEX <> :new.SEX       OR (:old.SEX IS NULL AND :new.SEX IS NOT NULL)       OR (:old.SEX IS NOT NULL AND :new.SEX IS NULL)
                OR :old.PASSP <> :new.PASSP   OR (:old.PASSP IS NULL AND :new.PASSP IS NOT NULL)   OR (:old.PASSP IS NOT NULL AND :new.PASSP IS NULL)
                OR :old.SER <> :new.SER       OR (:old.SER IS NULL AND :new.SER IS NOT NULL)       OR (:old.SER IS NOT NULL AND :new.SER IS NULL)
                OR :old.NUMDOC <> :new.NUMDOC OR (:old.NUMDOC IS NULL AND :new.NUMDOC IS NOT NULL) OR (:old.NUMDOC IS NOT NULL AND :new.NUMDOC IS NULL)
                OR :old.PDATE <> :new.PDATE   OR (:old.PDATE IS NULL AND :new.PDATE IS NOT NULL)   OR (:old.PDATE IS NOT NULL AND :new.PDATE IS NULL)
                OR :old.ORGAN <> :new.ORGAN   OR (:old.ORGAN IS NULL AND :new.ORGAN IS NOT NULL)   OR (:old.ORGAN IS NOT NULL AND :new.ORGAN IS NULL)
                OR :old.BDAY <> :new.BDAY     OR (:old.BDAY IS NULL AND :new.BDAY IS NOT NULL)     OR (:old.BDAY IS NOT NULL AND :new.BDAY IS NULL)
                OR :old.BPLACE <> :new.BPLACE OR (:old.BPLACE IS NULL AND :new.BPLACE IS NOT NULL) OR (:old.BPLACE IS NOT NULL AND :new.BPLACE IS NULL)
                OR :old.TELD <> :new.TELD     OR (:old.TELD IS NULL AND :new.TELD IS NOT NULL)     OR (:old.TELD IS NOT NULL AND :new.TELD IS NULL)
                OR :old.TELW <> :new.TELW     OR (:old.TELW IS NULL AND :new.TELW IS NOT NULL)     OR (:old.TELW IS NOT NULL AND :new.TELW IS NULL)
                OR :old.CELLPHONE <> :new.CELLPHONE   OR (:old.CELLPHONE IS NULL AND :new.CELLPHONE IS NOT NULL)   OR (:old.CELLPHONE IS NOT NULL AND :new.CELLPHONE IS NULL)
                OR :old.DATE_PHOTO <> :new.DATE_PHOTO OR (:old.DATE_PHOTO IS NULL AND :new.DATE_PHOTO IS NOT NULL) OR (:old.DATE_PHOTO IS NOT NULL AND :new.DATE_PHOTO IS NULL)
                OR :old.BDOV <> :new.BDOV     OR (:old.BDOV IS NULL AND :new.BDOV IS NOT NULL)     OR (:old.BDOV IS NOT NULL AND :new.BDOV IS NULL)
                OR :old.EDOV <> :new.EDOV     OR (:old.EDOV IS NULL AND :new.EDOV IS NOT NULL)     OR (:old.EDOV IS NOT NULL AND :new.EDOV IS NULL)
                OR :old.ACTUAL_DATE <> :new.ACTUAL_DATE     OR (:old.ACTUAL_DATE IS NULL AND :new.ACTUAL_DATE IS NOT NULL)     OR (:old.ACTUAL_DATE IS NOT NULL AND :new.ACTUAL_DATE IS NULL)
                OR :old.EDDR_ID <> :new.EDDR_ID OR (:old.EDDR_ID IS NULL AND :new.EDDR_ID IS NOT NULL) OR (:old.EDDR_ID IS NOT NULL AND :new.EDDR_ID IS NULL)
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

end taiu_person_update;
/
ALTER TRIGGER BARS.TAIU_PERSON_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_PERSON_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
