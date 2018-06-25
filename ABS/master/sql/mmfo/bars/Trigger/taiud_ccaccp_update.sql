

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_CCACCP_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_CCACCP_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_CCACCP_UPDATE 
-- of ACC, ACCS, ND
after insert or delete or update
ON BARS.CC_ACCP
for each row
declare
  l_rec  CC_ACCP_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
  begin

    if ( l_rec.CHGACTION = 'D' )
    then
      l_rec.ACC        := :old.ACC;
      l_rec.ACCS       := :old.ACCS;
      l_rec.ND         := :old.ND;
      l_rec.PR_12      := :old.PR_12;
      l_rec.IDZ        := :old.IDZ;
      l_rec.KF         := :old.KF;
      l_rec.RNK        := :old.RNK;
    else
      l_rec.ACC        := :new.ACC;
      l_rec.ACCS       := :new.ACCS;
      l_rec.ND         := :new.ND;
      l_rec.PR_12      := :new.PR_12;
      l_rec.IDZ        := :new.IDZ;
      l_rec.KF         := :new.KF;
      l_rec.RNK        := :new.RNK;
    end if;

    l_rec.IDUPD        := bars_sqnc.get_nextval(S_CCACCP_UPDATE.NextVal);
    l_rec.EFFECTDATE   := COALESCE(gl.bd, glb_bankdate);
 -- l_rec.GLOBAL_BDATE := glb_bankdate;
    l_rec.CHGDATE      := sysdate;
    l_rec.DONEBY       := gl.aUID;

    insert into BARS.CC_ACCP_UPDATE
    values l_rec;

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
        when ( (:old.ACC <> :new.ACC)
               OR
               (:old.ACCS <> :new.ACCS)
             )
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)

          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;

        when ( (:old.ND          != :new.ND) or
               (:old.ND is Null AND :new.ND is Not Null) or
               (:new.ND is Null AND :old.ND is Not Null)
               OR
               (:old.PR_12          != :new.PR_12) or
               (:old.PR_12 is Null AND :new.PR_12 is Not Null) or
               (:new.PR_12 is Null AND :old.PR_12 is Not Null)
               OR
               (:old.IDZ          != :new.IDZ) or
               (:old.IDZ is Null AND :new.IDZ is Not Null) or
               (:new.IDZ is Null AND :old.IDZ is Not Null)
               OR
               (:old.KF != :new.KF)
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

end TAIUD_CCACCP_UPDATE;
/
ALTER TRIGGER BARS.TAIUD_CCACCP_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_CCACCP_UPDATE.sql =========***
PROMPT ===================================================================================== 
