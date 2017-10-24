

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_DPUDEALW_UPDATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_DPUDEALW_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_DPUDEALW_UPDATE 
after insert or update of value or delete on DPU_DEALW
for each row
declare
  -- ver. 09.12.2016
 l_rec   dpu_dealw_update%rowtype;
  ---
  procedure SAVE_CHANGES
  is
    l_old_key varchar2(38);
  begin

    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.DPU_ID  := :old.DPU_ID;    l_rec.TAG  := :old.TAG;
        l_rec.VALUE   := :old.VALUE;     l_rec.KF   := :old.KF;
    else
        l_rec.DPU_ID  := :new.DPU_ID;    l_rec.TAG  := :new.TAG;
        l_rec.VALUE   := :new.VALUE;     l_rec.KF   := :new.KF;
    end if;

    l_rec.IDUPD     := bars_sqnc.get_nextval('s_dpu_dealw_update', l_rec.KF);
    l_rec.BDATE     := COALESCE(gl.bd, glb_bankdate);
    l_rec.DONEBY    := gl.aUID; --gl.aUID(NUMBER);	user_name(VARCHAR2);
    l_rec.CHGDATE   := sysdate;

    insert into BARS.DPU_DEALW_UPDATE values l_rec;
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
        when ( :old.DPU_ID <> :new.DPU_ID OR :old.TAG <> :new.TAG ) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)

          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;

        when (
                   :old.DPU_ID <> :new.DPU_ID
                OR :old.TAG <> :new.TAG
                OR :old.VALUE <> :new.VALUE    OR (:old.VALUE IS NULL AND :new.VALUE IS NOT NULL)    OR (:old.VALUE IS NOT NULL AND :new.VALUE IS NULL)
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
end;
/
ALTER TRIGGER BARS.TAIUD_DPUDEALW_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_DPUDEALW_UPDATE.sql =========*
PROMPT ===================================================================================== 
