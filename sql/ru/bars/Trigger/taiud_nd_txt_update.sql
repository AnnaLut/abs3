

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_ND_TXT_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_ND_TXT_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_ND_TXT_UPDATE 
after insert or update or delete
on BARS.ND_TXT
for each row
declare
  -- version 2.0 26/12/2015 V.Kharin
  -- version 1.2 09/11/2015
  l_rec    ND_TXT_UPDATE%rowtype;

  procedure SAVE_CHANGES
  is
  begin

    if ( l_rec.CHGACTION = 3 )

    then l_rec.KF     := :old.KF;
         l_rec.ND     := :old.ND;
         l_rec.TAG    := :old.TAG;
         l_rec.TXT    := :old.TXT;

    else l_rec.KF     := :new.KF;
         l_rec.ND     := :new.ND;
         l_rec.TAG    := :new.TAG;
         l_rec.TXT    := :new.TXT;

    end if;

    l_rec.IDUPD        := S_ND_TXT_UPDATE.NextVal;
    l_rec.EFFECTDATE   := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBAL_BDATE := glb_bankdate;
    l_rec.CHGDATE      := sysdate;
    l_rec.DONEBY       := user;

    insert into BARS.ND_TXT_UPDATE
    values l_rec;
  end SAVE_CHANGES;

begin

  case
    when inserting
    then l_rec.CHGACTION := 1; --'I'
         SAVE_CHANGES;

    when deleting
    then l_rec.CHGACTION := 3; --'D'
         SAVE_CHANGES;

    when updating
    then
      case
         when ( (:old.KF   <> :new.KF ) OR
                (:old.ND   <> :new.ND ) OR
                (:old.TAG  <> :new.TAG) )
         then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)
              -- породжуємо в історії запис про видалення
              l_rec.CHGACTION := 3; --'D'
              SAVE_CHANGES;

              -- породжуємо в історії запис про вставку
              l_rec.CHGACTION := 1; --'I'
              SAVE_CHANGES;

         when ( (:old.TXT          != :new.TXT) or
                (:old.TXT is Null AND :new.TXT is Not Null) or
                (:new.TXT is Null AND :old.TXT is Not Null)
              )
         then -- При зміні значеннь полів, що НЕ входять в PRIMARY KEY
              -- протоколюємо внесені зміни
              l_rec.CHGACTION := 2; --'U'
              SAVE_CHANGES;
         else
              Null;
        end case;

    else
      null;
  end case;

end;
/
ALTER TRIGGER BARS.TAIUD_ND_TXT_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_ND_TXT_UPDATE.sql =========***
PROMPT ===================================================================================== 
