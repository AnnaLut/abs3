

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACC_TARIF.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACC_TARIF ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACC_TARIF 
AFTER INSERT or UPDATE or DELETE ON BARS.ACC_TARIF FOR EACH ROW
declare
  l_idupd  acc_tarif_arc.idupd%type;
  l_rec    acc_tarif_arc%rowtype;

  ---
  procedure SAVE_CHANGES
  is
  begin
    if ( l_rec.VID = 'D' )
    then
        l_rec.ACC     := :old.ACC;     l_rec.KOD      := :old.KOD;
        l_rec.TAR     := :old.TAR;     l_rec.PR       := :old.PR;
        l_rec.SMIN    := :old.SMIN;    l_rec.SMAX     := :old.SMAX;
        l_rec.OST_AVG := :old.OST_AVG; l_rec.BDATE    := :old.BDATE;
        l_rec.EDATE   := :old.EDATE;   l_rec.NDOK_RKO := :old.NDOK_RKO;
        l_rec.KF      := :old.KF;      l_rec.KV_SMIN  := :old.KV_SMIN;
        l_rec.KV_SMAX := :old.KV_SMAX;
    else
        l_rec.ACC     := :new.ACC;     l_rec.KOD      := :new.KOD;
        l_rec.TAR     := :new.TAR;     l_rec.PR       := :new.PR;
        l_rec.SMIN    := :new.SMIN;    l_rec.SMAX     := :new.SMAX;
        l_rec.OST_AVG := :new.OST_AVG; l_rec.BDATE    := :new.BDATE;
        l_rec.EDATE   := :new.EDATE;   l_rec.NDOK_RKO := :new.NDOK_RKO;
        l_rec.KF      := :new.KF;      l_rec.KV_SMIN  := :new.KV_SMIN;
        l_rec.KV_SMAX := :new.KV_SMAX;
    end if;
    l_rec.IDUPD         := l_idupd;
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBAL_BDATE  := glb_bankdate;    -- sysdate
    l_rec.USER_ID       := gl.aUID; --gl.aUID(NUMBER);    user_name(VARCHAR2);  --DONEBY
    l_rec.FDAT          := sysdate; --CHGDATE

    insert into BARS.acc_tarif_arc values l_rec;
  end SAVE_CHANGES;
  ---

BEGIN

--Репликация: Если изменения пришли из удаленной БД, то ничего не делаем
  if dbms_mview.i_am_a_refresh=true or dbms_reputil.from_remote=true then
    return;
  end if;

--
--Модифицировано для поддержки уникальности идентификатора
--при наличии распределенных БД
--
  select s_acc_tarif_arc.nextval
  into   l_idupd
  from   dual;

--l_idupd := l_idupd*1000+to_number(sys_context('bars_context','db_id'));
--

  IF DELETING THEN
      l_rec.VID := 'D';
      SAVE_CHANGES;
  ELSIF INSERTING THEN
      l_rec.VID := 'I';
      SAVE_CHANGES;
  ELSIF UPDATING THEN
      case
        when (:old.KOD <> :new.KOD) or (:old.KF <> :new.KF) or (:old.ACC <> :new.ACC) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)
          l_rec.VID := 'D';   -- породжуємо в історії запис про видалення
          SAVE_CHANGES;
          l_rec.VID := 'I';   -- породжуємо в історії запис про вставку
          SAVE_CHANGES;
        when (     :old.TAR      <> :new.TAR      OR (:old.TAR IS NULL AND :new.TAR IS NOT NULL)           OR (:old.TAR IS NOT NULL AND :new.TAR IS NULL)
               OR  :old.PR       <> :new.PR       OR (:old.PR IS NULL AND :new.PR IS NOT NULL)             OR (:old.PR IS NOT NULL AND :new.PR IS NULL)
               OR  :old.SMIN     <> :new.SMIN     OR (:old.SMIN IS NULL AND :new.SMIN IS NOT NULL)         OR (:old.SMIN IS NOT NULL AND :new.SMIN IS NULL)
               OR  :old.SMAX     <> :new.SMAX     OR (:old.SMAX IS NULL AND :new.SMAX IS NOT NULL)         OR (:old.SMAX IS NOT NULL AND :new.SMAX IS NULL)
               OR  :old.OST_AVG  <> :new.OST_AVG  OR (:old.OST_AVG IS NULL AND :new.OST_AVG IS NOT NULL)   OR (:old.OST_AVG IS NOT NULL AND :new.OST_AVG IS NULL)
               OR  :old.BDATE    <> :new.BDATE    OR (:old.BDATE IS NULL AND :new.BDATE IS NOT NULL)       OR (:old.BDATE IS NOT NULL AND :new.BDATE IS NULL)
               OR  :old.EDATE    <> :new.EDATE    OR (:old.EDATE IS NULL AND :new.EDATE IS NOT NULL)       OR (:old.EDATE IS NOT NULL AND :new.EDATE IS NULL)
               OR  :old.NDOK_RKO <> :new.NDOK_RKO OR (:old.NDOK_RKO IS NULL AND :new.NDOK_RKO IS NOT NULL) OR (:old.NDOK_RKO IS NOT NULL AND :new.NDOK_RKO IS NULL)
               OR  :old.KV_SMIN  <> :new.KV_SMIN  OR (:old.KV_SMIN IS NULL AND :new.KV_SMIN IS NOT NULL)   OR (:old.KV_SMIN IS NOT NULL AND :new.KV_SMIN IS NULL)
               OR  :old.KV_SMAX  <> :new.KV_SMAX  OR (:old.KV_SMAX IS NULL AND :new.KV_SMAX IS NOT NULL)   OR (:old.KV_SMAX IS NOT NULL AND :new.KV_SMAX IS NULL)
             )
        then -- При зміні значеннь полів, що НЕ входять в PRIMARY KEY
          -- протоколюємо внесені зміни
          l_rec.VID := 'U';
          SAVE_CHANGES;
        else
          Null;
      end case;
  ELSE
    NULL;
  END IF;
END TIU_ACC_TARIF;
/
ALTER TRIGGER BARS.TIU_ACC_TARIF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACC_TARIF.sql =========*** End *
PROMPT ===================================================================================== 
