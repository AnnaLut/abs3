CREATE OR REPLACE TRIGGER TAIUD_CP_ACCOUNTS_UPDATE
AFTER INSERT OR UPDATE OR DELETE OF CP_REF, CP_ACCTYPE, CP_ACC ON BARS.CP_ACCOUNTS
for each row
declare
-- Author : V.Kharin
-- Date   : 06/08/2018
  l_rec  CP_ACCOUNTS_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
    l_old_key varchar2(38);
  begin

    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.CP_REF  := :old.CP_REF;  l_rec.CP_ACCTYPE  := :old.CP_ACCTYPE;   l_rec.CP_ACC  := :old.CP_ACC;
    else
        l_rec.CP_REF  := :new.CP_REF;  l_rec.CP_ACCTYPE  := :new.CP_ACCTYPE;   l_rec.CP_ACC  := :new.CP_ACC;
    end if;
    bars_sqnc.split_key(l_rec.CP_REF, l_old_key, l_rec.KF);
    l_rec.IDUPD         := bars_sqnc.get_nextval('s_cpaccounts_update', l_rec.KF);
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBALBD      := glb_bankdate;    -- sysdate
    l_rec.DONEBY        := gl.aUID; --gl.aUID;  user_name;
    l_rec.CHGDATE       := sysdate;

    insert into BARS.CP_ACCOUNTS_UPDATE values l_rec;

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
        when (:old.CP_REF <> :new.CP_REF or :old.CP_ACCTYPE <> :new.CP_ACCTYPE OR :old.CP_ACC <> :new.CP_ACC) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)
          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;
        when (     :old.CP_REF != :new.CP_REF
                OR :old.CP_ACCTYPE != :new.CP_ACCTYPE
                OR :old.CP_ACC <> :new.CP_ACC
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