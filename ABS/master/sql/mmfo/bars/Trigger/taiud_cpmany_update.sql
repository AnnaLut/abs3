

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_CPMANY_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_CPMANY_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_CPMANY_UPDATE 
after insert or update or delete on BARS.CP_MANY
for each row
declare
  -- ver. 09.12.2016
  l_rec  cp_many_update%rowtype;
  ---
  procedure SAVE_CHANGES
  is
    l_old_key varchar2(38);
  begin

    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.REF  := :old.REF;   l_rec.FDAT  := :old.FDAT;   l_rec.SS1  := :old.SS1;
        l_rec.SDP  := :old.SDP;   l_rec.SN2   := :old.SN2;
    else
        l_rec.REF  := :new.REF;   l_rec.FDAT  := :new.FDAT;   l_rec.SS1  := :new.SS1;
        l_rec.SDP  := :new.SDP;   l_rec.SN2   := :new.SN2;
    end if;

    bars_sqnc.split_key(l_rec.REF, l_old_key, l_rec.KF);
    l_rec.IDUPD         := bars_sqnc.get_nextval('s_cp_many_update', l_rec.KF);
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.DONEBY        := gl.aUID; --gl.aUID(NUMBER);	user_name(VARCHAR2);
    l_rec.CHGDATE       := sysdate;

    insert into BARS.CP_MANY_UPDATE values l_rec;
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
        when ( :old.REF <> :new.REF OR :old.FDAT <> :new.FDAT ) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)

          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;

        when (
                   :old.REF <> :new.REF
                OR :old.FDAT <> :new.FDAT
                OR :old.SS1 <> :new.SS1    OR (:old.SS1 IS NULL AND :new.SS1 IS NOT NULL)    OR (:old.SS1 IS NOT NULL AND :new.SS1 IS NULL)
                OR :old.SDP <> :new.SDP    OR (:old.SDP IS NULL AND :new.SDP IS NOT NULL)    OR (:old.SDP IS NOT NULL AND :new.SDP IS NULL)
                OR :old.SN2 <> :new.SN2    OR (:old.SN2 IS NULL AND :new.SN2 IS NOT NULL)    OR (:old.SN2 IS NOT NULL AND :new.SN2 IS NULL)
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
ALTER TRIGGER BARS.TAIUD_CPMANY_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_CPMANY_UPDATE.sql =========***
PROMPT ===================================================================================== 
