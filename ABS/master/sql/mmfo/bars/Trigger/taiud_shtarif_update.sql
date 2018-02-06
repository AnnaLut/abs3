CREATE OR REPLACE TRIGGER TAIUD_SHTARIF_UPDATE
after insert or update or delete on BARS.SH_TARIF
for each row
declare
  -- v. 09.12.2016 VK
  l_rec  SH_TARIF_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
  begin
    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.IDS   := :old.IDS;      l_rec.KOD      := :old.KOD;
        l_rec.TAR   := :old.TAR;      l_rec.PR       := :old.PR;
        l_rec.SMIN  := :old.SMIN;     l_rec.SMAX     := :old.SMAX;
        /*l_rec.KF    := :old.KF;*/       l_rec.NBS_OB22 := :old.NBS_OB22;
    else
        l_rec.IDS   := :new.IDS;      l_rec.KOD      := :new.KOD;
        l_rec.TAR   := :new.TAR;      l_rec.PR       := :new.PR;
        l_rec.SMIN  := :new.SMIN;     l_rec.SMAX     := :new.SMAX;
        /*l_rec.KF    := :new.KF;*/       l_rec.NBS_OB22 := :new.NBS_OB22;
    end if;
    l_rec.IDUPD         := bars_sqnc.get_nextval('s_shtarif_update', '300465');
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBAL_BDATE  := glb_bankdate;    -- sysdate
    l_rec.DONEBY        := gl.aUID; --gl.aUID(NUMBER);    user_name(VARCHAR2);
    l_rec.CHGDATE       := sysdate;

    insert into BARS.SH_TARIF_UPDATE values l_rec;

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
        when (:old.KOD <> :new.KOD) or (:old.IDS <> :new.IDS)/* or (:old.KF <> :new.KF)*/ -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)
          l_rec.CHGACTION := 'D';   -- породжуємо в історії запис про видалення
          SAVE_CHANGES;
          l_rec.CHGACTION := 'I';   -- породжуємо в історії запис про вставку
          SAVE_CHANGES;
        when (     :old.IDS  <> :new.IDS   OR (:old.IDS IS NULL AND :new.IDS IS NOT NULL)   OR (:old.IDS IS NOT NULL AND :new.IDS IS NULL)
               OR  :old.KOD  <> :new.KOD   OR (:old.KOD IS NULL AND :new.KOD IS NOT NULL)   OR (:old.KOD IS NOT NULL AND :new.KOD IS NULL)
               OR  :old.TAR  <> :new.TAR   OR (:old.TAR IS NULL AND :new.TAR IS NOT NULL)   OR (:old.TAR IS NOT NULL AND :new.TAR IS NULL)
               OR  :old.PR   <> :new.PR    OR (:old.PR IS NULL AND :new.PR IS NOT NULL)     OR (:old.PR IS NOT NULL AND :new.PR IS NULL)
               OR  :old.SMIN <> :new.SMIN  OR (:old.SMIN IS NULL AND :new.SMIN IS NOT NULL) OR (:old.SMIN IS NOT NULL AND :new.SMIN IS NULL)
               OR  :old.SMAX <> :new.SMAX  OR (:old.SMAX IS NULL AND :new.SMAX IS NOT NULL) OR (:old.SMAX IS NOT NULL AND :new.SMAX IS NULL)
               --OR  :old.KF   <> :new.KF    OR (:old.KF IS NULL AND :new.KF IS NOT NULL)     OR (:old.KF IS NOT NULL AND :new.KF IS NULL)
               OR  :old.NBS_OB22 <> :new.NBS_OB22    OR (:old.NBS_OB22 IS NULL AND :new.NBS_OB22 IS NOT NULL)   OR (:old.NBS_OB22 IS NOT NULL AND :new.NBS_OB22 IS NULL)
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
end TAIUD_SHTARIF_UPDATE;
/