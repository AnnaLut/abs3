

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_TFSCALE_UPDATE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_TFSCALE_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_TFSCALE_UPDATE 
after insert or update or delete on BARS.TARIF_SCALE
for each row
declare
  l_rec  TARIF_SCALE_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
  begin
    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.KOD       := :old.KOD;       l_rec.SUM_LIMIT := :old.SUM_LIMIT;
        l_rec.SUM_TARIF := :old.SUM_TARIF; l_rec.PR        := :old.PR;
        l_rec.KF        := :old.KF;        l_rec.SMIN      := :old.SMIN;
        l_rec.SMAX      := :old.SMAX;
    else
        l_rec.KOD       := :new.KOD;       l_rec.SUM_LIMIT := :new.SUM_LIMIT;
        l_rec.SUM_TARIF := :new.SUM_TARIF; l_rec.PR        := :new.PR;
        l_rec.KF        := :new.KF;        l_rec.SMIN      := :new.SMIN;
        l_rec.SMAX      := :new.SMAX;
    end if;
    l_rec.IDUPD         := S_TFSCALE_UPDATE.nextval;
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBAL_BDATE  := glb_bankdate;    -- sysdate
    l_rec.DONEBY        := gl.aUID; --gl.aUID(NUMBER);	user_name(VARCHAR2);
    l_rec.CHGDATE       := sysdate;

    insert into BARS.TARIF_SCALE_UPDATE values l_rec;

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
        when (:old.KOD <> :new.KOD) or (:old.SUM_LIMIT <> :new.SUM_LIMIT) or (:old.KF <> :new.KF) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)
          l_rec.CHGACTION := 'D';   -- породжуємо в історії запис про видалення
          SAVE_CHANGES;
          l_rec.CHGACTION := 'I';   -- породжуємо в історії запис про вставку
          SAVE_CHANGES;
        when (     :old.KOD       <> :new.KOD       OR (:old.KOD IS NULL AND :new.KOD IS NOT NULL)             OR (:old.KOD IS NOT NULL AND :new.KOD IS NULL)
               OR  :old.SUM_LIMIT <> :new.SUM_LIMIT OR (:old.SUM_LIMIT IS NULL AND :new.SUM_LIMIT IS NOT NULL) OR (:old.SUM_LIMIT IS NOT NULL AND :new.SUM_LIMIT IS NULL)
               OR  :old.SUM_TARIF <> :new.SUM_TARIF OR (:old.SUM_TARIF IS NULL AND :new.SUM_TARIF IS NOT NULL) OR (:old.SUM_TARIF IS NOT NULL AND :new.SUM_TARIF IS NULL)
               OR  :old.PR        <> :new.PR        OR (:old.PR IS NULL AND :new.PR IS NOT NULL)               OR (:old.PR IS NOT NULL AND :new.PR IS NULL)
               OR  :old.KF        <> :new.KF        OR (:old.KF IS NULL AND :new.KF IS NOT NULL)               OR (:old.KF IS NOT NULL AND :new.KF IS NULL)
               OR  :old.SMIN      <> :new.SMIN      OR (:old.SMIN IS NULL AND :new.SMIN IS NOT NULL)           OR (:old.SMIN IS NOT NULL AND :new.SMIN IS NULL)
               OR  :old.SMAX      <> :new.SMAX      OR (:old.SMAX IS NULL AND :new.SMAX IS NOT NULL)           OR (:old.SMAX IS NOT NULL AND :new.SMAX IS NULL)
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
end TAIUD_TFSCALE_UPDATE;
/
ALTER TRIGGER BARS.TAIUD_TFSCALE_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_TFSCALE_UPDATE.sql =========**
PROMPT ===================================================================================== 
