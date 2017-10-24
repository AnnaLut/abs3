

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCKRESTR_UPDATE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CCKRESTR_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CCKRESTR_UPDATE 
after insert or update or delete
   on BARS.CCK_RESTR for each row
declare
  -- ver. 09.12.2016
  l_rec    CCK_RESTR_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
    l_old_key varchar2(38);
  begin

    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.RESTR_ID  := :old.RESTR_ID;        l_rec.ND        := :old.ND;        l_rec.FDAT      := :old.FDAT;
        l_rec.VID_RESTR := :old.VID_RESTR;       l_rec.TXT       := :old.TXT;       l_rec.SUMR      := :old.SUMR;
        l_rec.FDAT_END  := :old.FDAT_END;        l_rec.PR_NO     := :old.PR_NO;     l_rec.S_RESTR   := :old.S_RESTR;
        l_rec.N_DODATOK := :old.N_DODATOK;       l_rec.QTY_PAY   := :old.QTY_PAY;   l_rec.KF        := :old.KF;
    else
        l_rec.RESTR_ID  := :new.RESTR_ID;        l_rec.ND        := :new.ND;        l_rec.FDAT      := :new.FDAT;
        l_rec.VID_RESTR := :new.VID_RESTR;       l_rec.TXT       := :new.TXT;       l_rec.SUMR      := :new.SUMR;
        l_rec.FDAT_END  := :new.FDAT_END;        l_rec.PR_NO     := :new.PR_NO;     l_rec.S_RESTR   := :new.S_RESTR;
        l_rec.N_DODATOK := :new.N_DODATOK;       l_rec.QTY_PAY   := :new.QTY_PAY;   l_rec.KF        := :new.KF;
    end if;

    l_rec.IDUPD         := bars_sqnc.get_nextval('s_cck_restr_update', l_rec.KF);
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.DONEBY        := gl.aUID; --gl.aUID(NUMBER);	user_name(VARCHAR2);
    l_rec.CHGDATE       := sysdate;

    insert into BARS.CCK_RESTR_UPDATE values l_rec;
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
        when ( :old.RESTR_ID <> :new.RESTR_ID ) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)

          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;

        when (     :old.ND <> :new.ND                OR (:old.ND IS NULL AND :new.ND IS NOT NULL)                OR (:old.ND IS NOT NULL AND :new.ND IS NULL)
                OR :old.FDAT <> :new.FDAT            OR (:old.FDAT IS NULL AND :new.FDAT IS NOT NULL)            OR (:old.FDAT IS NOT NULL AND :new.FDAT IS NULL)
                OR :old.VID_RESTR <> :new.VID_RESTR  OR (:old.VID_RESTR IS NULL AND :new.VID_RESTR IS NOT NULL)  OR (:old.VID_RESTR IS NOT NULL AND :new.VID_RESTR IS NULL)
                OR :old.TXT <> :new.TXT              OR (:old.TXT IS NULL AND :new.TXT IS NOT NULL)              OR (:old.TXT IS NOT NULL AND :new.TXT IS NULL)
                OR :old.SUMR <> :new.SUMR            OR (:old.SUMR IS NULL AND :new.SUMR IS NOT NULL)            OR (:old.SUMR IS NOT NULL AND :new.SUMR IS NULL)
                OR :old.FDAT_END <> :new.FDAT_END    OR (:old.FDAT_END IS NULL AND :new.FDAT_END IS NOT NULL)    OR (:old.FDAT_END IS NOT NULL AND :new.FDAT_END IS NULL)
                OR :old.PR_NO <> :new.PR_NO          OR (:old.PR_NO IS NULL AND :new.PR_NO IS NOT NULL)          OR (:old.PR_NO IS NOT NULL AND :new.PR_NO IS NULL)
                OR :old.S_RESTR <> :new.S_RESTR      OR (:old.S_RESTR IS NULL AND :new.S_RESTR IS NOT NULL)      OR (:old.S_RESTR IS NOT NULL AND :new.S_RESTR IS NULL)
                OR :old.N_DODATOK <> :new.N_DODATOK  OR (:old.N_DODATOK IS NULL AND :new.N_DODATOK IS NOT NULL)  OR (:old.N_DODATOK IS NOT NULL AND :new.N_DODATOK IS NULL)
                OR :old.QTY_PAY <> :new.QTY_PAY      OR (:old.QTY_PAY IS NULL AND :new.QTY_PAY IS NOT NULL)      OR (:old.QTY_PAY IS NOT NULL AND :new.QTY_PAY IS NULL)
                OR :old.KF <> :new.KF                OR (:old.KF IS NULL AND :new.KF IS NOT NULL)                OR (:old.KF IS NOT NULL AND :new.KF IS NULL)
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
ALTER TRIGGER BARS.TAIU_CCKRESTR_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCKRESTR_UPDATE.sql =========**
PROMPT ===================================================================================== 
