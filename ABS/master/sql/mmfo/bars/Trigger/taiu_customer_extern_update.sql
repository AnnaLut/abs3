

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CUSTOMER_EXTERN_UPDATE.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CUSTOMER_EXTERN_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CUSTOMER_EXTERN_UPDATE 
after insert or delete or update
 on bars.customer_extern for each row
declare
-- Author : V.Kharin
-- Date   : 08/12/2016
  l_rec  CUSTOMER_EXTERN_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
    l_old_key varchar2(38);
  begin

    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.ID         := :old.ID;          l_rec.NAME       := :old.NAME;        l_rec.DOC_TYPE   := :old.DOC_TYPE;
        l_rec.DOC_SERIAL := :old.DOC_SERIAL;  l_rec.DOC_NUMBER := :old.DOC_NUMBER;  l_rec.DOC_DATE   := :old.DOC_DATE;
        l_rec.DOC_ISSUER := :old.DOC_ISSUER;  l_rec.BIRTHDAY   := :old.BIRTHDAY;    l_rec.BIRTHPLACE := :old.BIRTHPLACE;
        l_rec.SEX        := :old.SEX;         l_rec.ADR        := :old.ADR;         l_rec.TEL        := :old.TEL;
        l_rec.EMAIL      := :old.EMAIL;       l_rec.CUSTTYPE   := :old.CUSTTYPE;    l_rec.OKPO       := :old.OKPO;
        l_rec.COUNTRY    := :old.COUNTRY;     l_rec.REGION     := :old.REGION;      l_rec.FS         := :old.FS;
        l_rec.VED        := :old.VED;         l_rec.SED        := :old.SED;         l_rec.ISE        := :old.ISE;
        l_rec.NOTES      := :old.NOTES;
    else
        l_rec.ID         := :new.ID;          l_rec.NAME       := :new.NAME;        l_rec.DOC_TYPE   := :new.DOC_TYPE;
        l_rec.DOC_SERIAL := :new.DOC_SERIAL;  l_rec.DOC_NUMBER := :new.DOC_NUMBER;  l_rec.DOC_DATE   := :new.DOC_DATE;
        l_rec.DOC_ISSUER := :new.DOC_ISSUER;  l_rec.BIRTHDAY   := :new.BIRTHDAY;    l_rec.BIRTHPLACE := :new.BIRTHPLACE;
        l_rec.SEX        := :new.SEX;         l_rec.ADR        := :new.ADR;         l_rec.TEL        := :new.TEL;
        l_rec.EMAIL      := :new.EMAIL;       l_rec.CUSTTYPE   := :new.CUSTTYPE;    l_rec.OKPO       := :new.OKPO;
        l_rec.COUNTRY    := :new.COUNTRY;     l_rec.REGION     := :new.REGION;      l_rec.FS         := :new.FS;
        l_rec.VED        := :new.VED;         l_rec.SED        := :new.SED;         l_rec.ISE        := :new.ISE;
        l_rec.NOTES      := :new.NOTES;
    end if;
    bars_sqnc.split_key(l_rec.ID, l_old_key, l_rec.KF);
    l_rec.IDUPD         := bars_sqnc.get_nextval('s_customer_extern_update', l_rec.KF);
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    --l_rec.GLOBAL_BDATE  := glb_bankdate;    -- sysdate
    l_rec.DONEBY        := gl.aUID; --gl.aUID;  user_name;
    l_rec.CHGDATE       := sysdate;

    insert into BARS.CUSTOMER_EXTERN_UPDATE values l_rec;

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
        when (:old.id <> :new.id) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)
          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;

        when (  :old.ID <> :new.ID
                OR :old.NAME <> :new.NAME             OR (:old.NAME IS NULL AND :new.NAME IS NOT NULL)             OR (:old.NAME IS NOT NULL AND :new.NAME IS NULL)
                OR :old.DOC_TYPE <> :new.DOC_TYPE     OR (:old.DOC_TYPE IS NULL AND :new.DOC_TYPE IS NOT NULL)     OR (:old.DOC_TYPE IS NOT NULL AND :new.DOC_TYPE IS NULL)
                OR :old.DOC_SERIAL <> :new.DOC_SERIAL OR (:old.DOC_SERIAL IS NULL AND :new.DOC_SERIAL IS NOT NULL) OR (:old.DOC_SERIAL IS NOT NULL AND :new.DOC_SERIAL IS NULL)
                OR :old.DOC_NUMBER <> :new.DOC_NUMBER OR (:old.DOC_NUMBER IS NULL AND :new.DOC_NUMBER IS NOT NULL) OR (:old.DOC_NUMBER IS NOT NULL AND :new.DOC_NUMBER IS NULL)
                OR :old.DOC_DATE <> :new.DOC_DATE     OR (:old.DOC_DATE IS NULL AND :new.DOC_DATE IS NOT NULL)     OR (:old.DOC_DATE IS NOT NULL AND :new.DOC_DATE IS NULL)
                OR :old.DOC_ISSUER <> :new.DOC_ISSUER OR (:old.DOC_ISSUER IS NULL AND :new.DOC_ISSUER IS NOT NULL) OR (:old.DOC_ISSUER IS NOT NULL AND :new.DOC_ISSUER IS NULL)
                OR :old.BIRTHDAY <> :new.BIRTHDAY     OR (:old.BIRTHDAY IS NULL AND :new.BIRTHDAY IS NOT NULL)     OR (:old.BIRTHDAY IS NOT NULL AND :new.BIRTHDAY IS NULL)
                OR :old.BIRTHPLACE <> :new.BIRTHPLACE OR (:old.BIRTHPLACE IS NULL AND :new.BIRTHPLACE IS NOT NULL) OR (:old.BIRTHPLACE IS NOT NULL AND :new.BIRTHPLACE IS NULL)
                OR :old.SEX <> :new.SEX               OR (:old.SEX IS NULL AND :new.SEX IS NOT NULL)               OR (:old.SEX IS NOT NULL AND :new.SEX IS NULL)
                OR :old.ADR <> :new.ADR               OR (:old.ADR IS NULL AND :new.ADR IS NOT NULL)               OR (:old.ADR IS NOT NULL AND :new.ADR IS NULL)
                OR :old.TEL <> :new.TEL               OR (:old.TEL IS NULL AND :new.TEL IS NOT NULL)               OR (:old.TEL IS NOT NULL AND :new.TEL IS NULL)
                OR :old.EMAIL <> :new.EMAIL           OR (:old.EMAIL IS NULL AND :new.EMAIL IS NOT NULL)           OR (:old.EMAIL IS NOT NULL AND :new.EMAIL IS NULL)
                OR :old.CUSTTYPE <> :new.CUSTTYPE     OR (:old.CUSTTYPE IS NULL AND :new.CUSTTYPE IS NOT NULL)     OR (:old.CUSTTYPE IS NOT NULL AND :new.CUSTTYPE IS NULL)
                OR :old.OKPO <> :new.OKPO             OR (:old.OKPO IS NULL AND :new.OKPO IS NOT NULL)             OR (:old.OKPO IS NOT NULL AND :new.OKPO IS NULL)
                OR :old.COUNTRY <> :new.COUNTRY       OR (:old.COUNTRY IS NULL AND :new.COUNTRY IS NOT NULL)       OR (:old.COUNTRY IS NOT NULL AND :new.COUNTRY IS NULL)
                OR :old.REGION <> :new.REGION         OR (:old.REGION IS NULL AND :new.REGION IS NOT NULL)         OR (:old.REGION IS NOT NULL AND :new.REGION IS NULL)
                OR :old.FS <> :new.FS                 OR (:old.FS IS NULL AND :new.FS IS NOT NULL)                 OR (:old.FS IS NOT NULL AND :new.FS IS NULL)
                OR :old.VED <> :new.VED               OR (:old.VED IS NULL AND :new.VED IS NOT NULL)               OR (:old.VED IS NOT NULL AND :new.VED IS NULL)
                OR :old.SED <> :new.SED               OR (:old.SED IS NULL AND :new.SED IS NOT NULL)               OR (:old.SED IS NOT NULL AND :new.SED IS NULL)
                OR :old.ISE <> :new.ISE               OR (:old.ISE IS NULL AND :new.ISE IS NOT NULL)               OR (:old.ISE IS NOT NULL AND :new.ISE IS NULL)
                OR :old.NOTES <> :new.NOTES           OR (:old.NOTES IS NULL AND :new.NOTES IS NOT NULL)           OR (:old.NOTES IS NOT NULL AND :new.NOTES IS NULL)
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
ALTER TRIGGER BARS.TAIU_CUSTOMER_EXTERN_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CUSTOMER_EXTERN_UPDATE.sql ====
PROMPT ===================================================================================== 
