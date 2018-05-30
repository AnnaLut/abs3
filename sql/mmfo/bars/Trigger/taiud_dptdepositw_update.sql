-- ======================================================================================
-- Module : DPT
-- Author : BAA
-- Date   : 08.05.2018
-- ===================================== <Comments> =====================================
-- create trigger TAIUD_DPTDEPOSITW_UPDATE
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create trigger TAIUD_DPTDEPOSITW_UPDATE
prompt -- ======================================================

CREATE OR REPLACE TRIGGER TAIUD_DPTDEPOSITW_UPDATE
after insert or update or delete ON DPT_DEPOSITW
for each row
declare
  l_rec   dpt_depositw_update%rowtype;
  ---
  procedure SAVE_CHANGES
  ( p_actn  varchar2
  ) is
  begin
    if ( p_actn = 'D' )
    then
      l_rec.DPT_ID  := :old.DPT_ID;
      l_rec.TAG     := :old.TAG;
      l_rec.VALUE   := :old.VALUE;
      l_rec.KF      := :old.KF;
    else
      l_rec.DPT_ID  := :new.DPT_ID;
      l_rec.TAG     := :new.TAG;
      l_rec.VALUE   := :new.VALUE;
      l_rec.KF      := :new.KF;
    end if;
    l_rec.CHGACTN := p_actn;
    l_rec.CHGDT   := sysdate;
    l_rec.EFFDT   := GL.BD();
    l_rec.DONEBY  := gl.aUID;
    l_rec.CHGID   := S_DPT_DEPOSITW_UPDATE.NextVal;
    insert into DPT_DEPOSITW_UPDATE
    values l_rec;
  end SAVE_CHANGES;
begin
  case
    when INSERTING
    then
      SAVE_CHANGES('I');
    when DELETING
    then
      SAVE_CHANGES('D');
    when UPDATING
    then
      if ( :old.DPT_ID <> :new.DPT_ID or :old.TAG <> :new.TAG )
      then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)
        SAVE_CHANGES('D'); -- породжуємо в історії запис про видалення
        SAVE_CHANGES('I'); -- породжуємо в історії запис про вставку
      else -- При зміні значеннь полів, що НЕ входять в PRIMARY KEY
        if ( :old.VALUE = :new.VALUE )
        then
          null;
        else
          SAVE_CHANGES('U');
        end if;
      end if;
    else
      null;
  end case;
end TAIUD_DPTDEPOSITW_UPDATE;
/

show errors;
