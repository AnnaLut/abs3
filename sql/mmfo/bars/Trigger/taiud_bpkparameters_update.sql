

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_BPKPARAMETERS_UPDATE.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_BPKPARAMETERS_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_BPKPARAMETERS_UPDATE 
after insert or update or delete on BARS.BPK_PARAMETERS
for each row
declare
  l_rec  BPK_PARAMETERS_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
     l_old_key varchar2(38);
  begin

    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.ND        := :old.ND;
        l_rec.TAG       := :old.TAG;
        l_rec.VALUE     := :old.VALUE;
    else
        l_rec.ND        := :new.ND;
        l_rec.TAG       := :new.TAG;
        l_rec.VALUE     := :new.VALUE;
    end if;
    bars_sqnc.split_key(l_rec.ND, l_old_key, l_rec.KF);
    l_rec.IDUPD        := bars_sqnc.get_nextval('s_bpk_parameters_update', l_rec.KF);
    l_rec.CHGDATE      := sysdate;
    l_rec.DONEBY       := gl.aUID;
    l_rec.GLOBAL_BDATE := glb_bankdate;
    l_rec.EFFECTDATE   := COALESCE(gl.bd, glb_bankdate);

    insert into BARS.BPK_PARAMETERS_UPDATE values l_rec;

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
        when (:old.ND <> :new.ND or :old.TAG <> :new.TAG) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)

          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;

        when (
                    :old.ND        != :new.ND
                OR  :old.TAG       != :new.TAG
                OR  :old.VALUE     != :new.VALUE    OR (:old.VALUE is Null AND :new.VALUE is Not Null)     OR (:new.VALUE is Null AND :old.VALUE is Not Null)
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

end TAIUD_BPKPARAMETERS_UPDATE;
/
ALTER TRIGGER BARS.TAIUD_BPKPARAMETERS_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_BPKPARAMETERS_UPDATE.sql =====
PROMPT ===================================================================================== 
