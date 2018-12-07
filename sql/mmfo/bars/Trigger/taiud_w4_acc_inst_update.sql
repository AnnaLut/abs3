CREATE OR REPLACE TRIGGER TAIUD_W4_ACC_INST_UPDATE
AFTER INSERT OR UPDATE OR DELETE ON BARS.W4_ACC_INST
for each row
declare
-- Author : V.Kharin
-- Date   : 21/08/2018
  l_rec  W4_ACC_INST_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
    l_old_key varchar2(38);
  begin

    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.ND  := :old.ND;  l_rec.ACC_PK  := :old.ACC_PK;   l_rec.CHAIN_IDT  := :old.CHAIN_IDT;
        l_rec.TRANS_MASK  := :old.TRANS_MASK;  l_rec.ACC  := :old.ACC;   l_rec.CRT_BD  := :old.CRT_BD;
        l_rec.KF  := :old.KF;
    else
        l_rec.ND  := :new.ND;  l_rec.ACC_PK  := :new.ACC_PK;   l_rec.CHAIN_IDT  := :new.CHAIN_IDT;
        l_rec.TRANS_MASK  := :new.TRANS_MASK;  l_rec.ACC  := :new.ACC;   l_rec.CRT_BD  := :new.CRT_BD;
        l_rec.KF  := :new.KF;
    end if;

    l_rec.IDUPD         := bars_sqnc.get_nextval('s_w4_acc_inst_upd', l_rec.KF);
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBALBD      := glb_bankdate;    -- sysdate
    l_rec.DONEBY        := gl.aUID; --gl.aUID;  user_name;
    l_rec.CHGDATE       := sysdate;

    insert into BARS.W4_ACC_INST_UPDATE values l_rec;

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
        when (:old.ACC_PK <> :new.ACC_PK or :old.CHAIN_IDT <> :new.CHAIN_IDT or :old.TRANS_MASK <> :new.TRANS_MASK or :old.KF <> :new.KF) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)
          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;
        when (     :old.ND      <> :new.ND
                or :old.ACC     <> :new.ACC
                or :old.CRT_BD  <> :new.CRT_BD
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