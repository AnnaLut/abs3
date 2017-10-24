

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_RKOLST_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_RKOLST_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_RKOLST_UPDATE 
after insert or update or delete on BARS.RKO_LST
for each row
declare
  l_rec  RKO_LST_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
  begin
    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.ACC   := :old.ACC;    l_rec.ACCD  := :old.ACCD;    l_rec.DAT0A := :old.DAT0A;    l_rec.DAT0B  := :old.DAT0B;    l_rec.S0     := :old.S0;
        l_rec.DAT1A := :old.DAT1A;  l_rec.DAT1B := :old.DAT1B;   l_rec.ACC1  := :old.ACC1;     l_rec.DAT2A  := :old.DAT2A;    l_rec.DAT2B  := :old.DAT2B;
        l_rec.ACC2  := :old.ACC2;   l_rec.COMM  := :old.COMM;    l_rec.KF    := :old.KF;       l_rec.KOLDOK := :old.KOLDOK;   l_rec.SUMDOK := :old.SUMDOK;
        l_rec.ND    := :old.ND;     l_rec.CC_ID := :old.CC_ID;   l_rec.SDATE := :old.SDATE;    l_rec.SOS    := :old.SOS;
    else
        l_rec.ACC   := :new.ACC;    l_rec.ACCD  := :new.ACCD;    l_rec.DAT0A := :new.DAT0A;    l_rec.DAT0B  := :new.DAT0B;    l_rec.S0     := :new.S0;
        l_rec.DAT1A := :new.DAT1A;  l_rec.DAT1B := :new.DAT1B;   l_rec.ACC1  := :new.ACC1;     l_rec.DAT2A  := :new.DAT2A;    l_rec.DAT2B  := :new.DAT2B;
        l_rec.ACC2  := :new.ACC2;   l_rec.COMM  := :new.COMM;    l_rec.KF    := :new.KF;       l_rec.KOLDOK := :new.KOLDOK;   l_rec.SUMDOK := :new.SUMDOK;
        l_rec.ND    := :new.ND;     l_rec.CC_ID := :new.CC_ID;   l_rec.SDATE := :new.SDATE;    l_rec.SOS    := :new.SOS;
    end if;
    l_rec.IDUPD        := bars_sqnc.get_nextval('s_rko_lst_update');
    l_rec.EFFECTDATE   := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBAL_BDATE := glb_bankdate;
    l_rec.DONEBY       := gl.aUID;
    l_rec.CHGDATE      := sysdate;

    insert into BARS.RKO_LST_UPDATE values l_rec;
  end SAVE_CHANGES;
  ---
begin

  case
    when inserting    then
      l_rec.CHGACTION := 'I';
      SAVE_CHANGES;
    when deleting    then
      l_rec.CHGACTION := 'D';
      SAVE_CHANGES;
    when updating    then
      case
        when (:old.acc <> :new.acc) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)

          l_rec.CHGACTION := 'D'; -- породжуємо в історії запис про видалення
          SAVE_CHANGES;

          l_rec.CHGACTION := 'I'; -- породжуємо в історії запис про вставку
          SAVE_CHANGES;
        when (  :old.acc <> :new.acc
                OR :old.ACCD   != :new.ACCD   OR (:old.ACCD  is Null AND :new.ACCD  is Not Null)     OR (:new.ACCD  is Null AND :old.ACCD  is Not Null)
                OR :old.DAT0A  != :new.DAT0A  OR (:old.DAT0A is Null AND :new.DAT0A is Not Null)     OR (:new.DAT0A is Null AND :old.DAT0A is Not Null)
                OR :old.DAT0B  != :new.DAT0B  OR (:old.DAT0B is Null AND :new.DAT0B is Not Null)     OR (:new.DAT0B is Null AND :old.DAT0B is Not Null)
                OR :old.S0     != :new.S0     OR (:old.S0 is Null AND :new.S0 is Not Null)           OR (:new.S0 is Null AND :old.S0 is Not Null)
                OR :old.DAT1A  != :new.DAT1A  OR (:old.DAT1A is Null AND :new.DAT1A is Not Null)     OR (:new.DAT1A is Null AND :old.DAT1A is Not Null)
                OR :old.DAT1B  != :new.DAT1B  OR (:old.DAT1B is Null AND :new.DAT1B is Not Null)     OR (:new.DAT1B is Null AND :old.DAT1B is Not Null)
                OR :old.ACC1   != :new.ACC1   OR (:old.ACC1  is Null AND :new.ACC1  is Not Null)     OR (:new.ACC1  is Null AND :old.ACC1  is Not Null)
                OR :old.DAT2A  != :new.DAT2A  OR (:old.DAT2A is Null AND :new.DAT2A is Not Null)     OR (:new.DAT2A is Null AND :old.DAT2A is Not Null)
                OR :old.DAT2B  != :new.DAT2B  OR (:old.DAT2B is Null AND :new.DAT2B is Not Null)     OR (:new.DAT2B is Null AND :old.DAT2B is Not Null)
                OR :old.ACC2   != :new.ACC2   OR (:old.ACC2  is Null AND :new.ACC2  is Not Null)     OR (:new.ACC2  is Null AND :old.ACC2  is Not Null)
                OR :old.COMM   != :new.COMM   OR (:old.COMM  is Null AND :new.COMM  is Not Null)     OR (:new.COMM  is Null AND :old.COMM  is Not Null)
                OR :old.KF     != :new.KF     OR (:old.KF  is Null AND :new.KF  is Not Null)         OR (:new.KF  is Null AND :old.KF  is Not Null)
                OR :old.KOLDOK != :new.KOLDOK OR (:old.KOLDOK  is Null AND :new.KOLDOK  is Not Null) OR (:new.KOLDOK  is Null AND :old.KOLDOK  is Not Null)
                OR :old.SUMDOK != :new.SUMDOK OR (:old.SUMDOK  is Null AND :new.SUMDOK  is Not Null) OR (:new.SUMDOK  is Null AND :old.SUMDOK  is Not Null)
                OR :old.ND     != :new.ND     OR (:old.ND  is Null AND :new.ND  is Not Null)         OR (:new.ND  is Null AND :old.ND  is Not Null)
                OR :old.CC_ID  != :new.CC_ID  OR (:old.CC_ID is Null AND :new.CC_ID is Not Null)     OR (:new.CC_ID is Null AND :old.CC_ID is Not Null)
                OR :old.SDATE  != :new.SDATE  OR (:old.SDATE is Null AND :new.SDATE is Not Null)     OR (:new.SDATE is Null AND :old.SDATE is Not Null)
                OR :old.SOS    != :new.SOS    OR (:old.SOS is Null AND :new.SOS is Not Null)         OR (:new.SOS is Null AND :old.SOS is Not Null)
            )        then -- При зміні значеннь полів, що НЕ входять в PRIMARY KEY протоколюємо внесені зміни

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
ALTER TRIGGER BARS.TAIUD_RKOLST_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_RKOLST_UPDATE.sql =========***
PROMPT ===================================================================================== 
