

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCADD_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CCADD_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CCADD_UPDATE 
after insert or update or delete
   on BARS.CC_ADD for each row
declare
  -- ver. 09.12.2016
  l_rec    CC_ADD_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
    l_old_key varchar2(38);
  begin

    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.ND          := :old.ND;          l_rec.ADDS        := :old.ADDS;        l_rec.AIM         := :old.AIM;
        l_rec.S           := :old.S;           l_rec.KV          := :old.KV;          l_rec.BDATE       := :old.BDATE;
        l_rec.WDATE       := :old.WDATE;       l_rec.ACCS        := :old.ACCS;        l_rec.ACCP        := :old.ACCP;
        l_rec.SOUR        := :old.SOUR;        l_rec.ACCKRED     := :old.ACCKRED;     l_rec.MFOKRED     := :old.MFOKRED;
        l_rec.FREQ        := :old.FREQ;        l_rec.PDATE       := :old.PDATE;       l_rec.REFV        := :old.REFV;
        l_rec.REFP        := :old.REFP;        l_rec.ACCPERC     := :old.ACCPERC;     l_rec.MFOPERC     := :old.MFOPERC;
        l_rec.SWI_BIC     := :old.SWI_BIC;     l_rec.SWI_ACC     := :old.SWI_ACC;     l_rec.SWI_REF     := :old.SWI_REF;
        l_rec.SWO_BIC     := :old.SWO_BIC;     l_rec.SWO_ACC     := :old.SWO_ACC;     l_rec.SWO_REF     := :old.SWO_REF;
        l_rec.INT_AMOUNT  := :old.INT_AMOUNT;  l_rec.ALT_PARTYB  := :old.ALT_PARTYB;  l_rec.INTERM_B    := :old.INTERM_B;
        l_rec.INT_PARTYA  := :old.INT_PARTYA;  l_rec.INT_PARTYB  := :old.INT_PARTYB;  l_rec.INT_INTERMA := :old.INT_INTERMA;
        l_rec.INT_INTERMB := :old.INT_INTERMB; l_rec.SSUDA       := :old.SSUDA;       l_rec.KF          := :old.KF;
        l_rec.OKPOKRED    := :old.OKPOKRED;    l_rec.NAMKRED     := :old.NAMKRED;     l_rec.NAZNKRED    := :old.NAZNKRED;
        l_rec.NLS_1819    := :old.NLS_1819;    l_rec.FIELD_58D   := :old.FIELD_58D;
    else
        l_rec.ND          := :new.ND;          l_rec.ADDS        := :new.ADDS;        l_rec.AIM         := :new.AIM;
        l_rec.S           := :new.S;           l_rec.KV          := :new.KV;          l_rec.BDATE       := :new.BDATE;
        l_rec.WDATE       := :new.WDATE;       l_rec.ACCS        := :new.ACCS;        l_rec.ACCP        := :new.ACCP;
        l_rec.SOUR        := :new.SOUR;        l_rec.ACCKRED     := :new.ACCKRED;     l_rec.MFOKRED     := :new.MFOKRED;
        l_rec.FREQ        := :new.FREQ;        l_rec.PDATE       := :new.PDATE;       l_rec.REFV        := :new.REFV;
        l_rec.REFP        := :new.REFP;        l_rec.ACCPERC     := :new.ACCPERC;     l_rec.MFOPERC     := :new.MFOPERC;
        l_rec.SWI_BIC     := :new.SWI_BIC;     l_rec.SWI_ACC     := :new.SWI_ACC;     l_rec.SWI_REF     := :new.SWI_REF;
        l_rec.SWO_BIC     := :new.SWO_BIC;     l_rec.SWO_ACC     := :new.SWO_ACC;     l_rec.SWO_REF     := :new.SWO_REF;
        l_rec.INT_AMOUNT  := :new.INT_AMOUNT;  l_rec.ALT_PARTYB  := :new.ALT_PARTYB;  l_rec.INTERM_B    := :new.INTERM_B;
        l_rec.INT_PARTYA  := :new.INT_PARTYA;  l_rec.INT_PARTYB  := :new.INT_PARTYB;  l_rec.INT_INTERMA := :new.INT_INTERMA;
        l_rec.INT_INTERMB := :new.INT_INTERMB; l_rec.SSUDA       := :new.SSUDA;       l_rec.KF          := :new.KF;
        l_rec.OKPOKRED    := :new.OKPOKRED;    l_rec.NAMKRED     := :new.NAMKRED;     l_rec.NAZNKRED    := :new.NAZNKRED;
        l_rec.NLS_1819    := :new.NLS_1819;    l_rec.FIELD_58D   := :new.FIELD_58D;
    end if;

    l_rec.IDUPD         := bars_sqnc.get_nextval('s_ccadd_update', l_rec.KF);
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.DONEBY        := gl.aUID; --gl.aUID(NUMBER);	user_name(VARCHAR2);
    l_rec.CHGDATE       := sysdate;

    insert into BARS.CC_ADD_UPDATE values l_rec;
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
        when ( :old.ND <> :new.ND OR :old.ADDS <> :new.ADDS ) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)

          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;

        when (
                   :old.ND <> :new.ND
                OR :old.ADDS <> :new.ADDS
                OR :old.KF != :new.KF
                OR :old.AIM <> :new.AIM                  OR (:old.AIM IS NULL AND :new.AIM IS NOT NULL)                  OR (:old.AIM IS NOT NULL AND :new.AIM IS NULL)
                OR :old.S <> :new.S                      OR (:old.S IS NULL AND :new.S IS NOT NULL)                      OR (:old.S IS NOT NULL AND :new.S IS NULL)
                OR :old.KV <> :new.KV                    OR (:old.KV IS NULL AND :new.KV IS NOT NULL)                    OR (:old.KV IS NOT NULL AND :new.KV IS NULL)
                OR :old.BDATE <> :new.BDATE              OR (:old.BDATE IS NULL AND :new.BDATE IS NOT NULL)              OR (:old.BDATE IS NOT NULL AND :new.BDATE IS NULL)
                OR :old.WDATE <> :new.WDATE              OR (:old.WDATE IS NULL AND :new.WDATE IS NOT NULL)              OR (:old.WDATE IS NOT NULL AND :new.WDATE IS NULL)
                OR :old.ACCS <> :new.ACCS                OR (:old.ACCS IS NULL AND :new.ACCS IS NOT NULL)                OR (:old.ACCS IS NOT NULL AND :new.ACCS IS NULL)
                OR :old.ACCP <> :new.ACCP                OR (:old.ACCP IS NULL AND :new.ACCP IS NOT NULL)                OR (:old.ACCP IS NOT NULL AND :new.ACCP IS NULL)
                OR :old.SOUR <> :new.SOUR                OR (:old.SOUR IS NULL AND :new.SOUR IS NOT NULL)                OR (:old.SOUR IS NOT NULL AND :new.SOUR IS NULL)
                OR :old.ACCKRED <> :new.ACCKRED          OR (:old.ACCKRED IS NULL AND :new.ACCKRED IS NOT NULL)          OR (:old.ACCKRED IS NOT NULL AND :new.ACCKRED IS NULL)
                OR :old.MFOKRED <> :new.MFOKRED          OR (:old.MFOKRED IS NULL AND :new.MFOKRED IS NOT NULL)          OR (:old.MFOKRED IS NOT NULL AND :new.MFOKRED IS NULL)
                OR :old.FREQ <> :new.FREQ                OR (:old.FREQ IS NULL AND :new.FREQ IS NOT NULL)                OR (:old.FREQ IS NOT NULL AND :new.FREQ IS NULL)
                OR :old.PDATE <> :new.PDATE              OR (:old.PDATE IS NULL AND :new.PDATE IS NOT NULL)              OR (:old.PDATE IS NOT NULL AND :new.PDATE IS NULL)
                OR :old.REFV <> :new.REFV                OR (:old.REFV IS NULL AND :new.REFV IS NOT NULL)                OR (:old.REFV IS NOT NULL AND :new.REFV IS NULL)
                OR :old.REFP <> :new.REFP                OR (:old.REFP IS NULL AND :new.REFP IS NOT NULL)                OR (:old.REFP IS NOT NULL AND :new.REFP IS NULL)
                OR :old.ACCPERC <> :new.ACCPERC          OR (:old.ACCPERC IS NULL AND :new.ACCPERC IS NOT NULL)          OR (:old.ACCPERC IS NOT NULL AND :new.ACCPERC IS NULL)
                OR :old.MFOPERC <> :new.MFOPERC          OR (:old.MFOPERC IS NULL AND :new.MFOPERC IS NOT NULL)          OR (:old.MFOPERC IS NOT NULL AND :new.MFOPERC IS NULL)
                OR :old.SWI_BIC <> :new.SWI_BIC          OR (:old.SWI_BIC IS NULL AND :new.SWI_BIC IS NOT NULL)          OR (:old.SWI_BIC IS NOT NULL AND :new.SWI_BIC IS NULL)
                OR :old.SWI_ACC <> :new.SWI_ACC          OR (:old.SWI_ACC IS NULL AND :new.SWI_ACC IS NOT NULL)          OR (:old.SWI_ACC IS NOT NULL AND :new.SWI_ACC IS NULL)
                OR :old.SWI_REF <> :new.SWI_REF          OR (:old.SWI_REF IS NULL AND :new.SWI_REF IS NOT NULL)          OR (:old.SWI_REF IS NOT NULL AND :new.SWI_REF IS NULL)
                OR :old.SWO_BIC <> :new.SWO_BIC          OR (:old.SWO_BIC IS NULL AND :new.SWO_BIC IS NOT NULL)          OR (:old.SWO_BIC IS NOT NULL AND :new.SWO_BIC IS NULL)
                OR :old.SWO_ACC <> :new.SWO_ACC          OR (:old.SWO_ACC IS NULL AND :new.SWO_ACC IS NOT NULL)          OR (:old.SWO_ACC IS NOT NULL AND :new.SWO_ACC IS NULL)
                OR :old.SWO_REF <> :new.SWO_REF          OR (:old.SWO_REF IS NULL AND :new.SWO_REF IS NOT NULL)          OR (:old.SWO_REF IS NOT NULL AND :new.SWO_REF IS NULL)
                OR :old.INT_AMOUNT <> :new.INT_AMOUNT    OR (:old.INT_AMOUNT IS NULL AND :new.INT_AMOUNT IS NOT NULL)    OR (:old.INT_AMOUNT IS NOT NULL AND :new.INT_AMOUNT IS NULL)
                OR :old.ALT_PARTYB <> :new.ALT_PARTYB    OR (:old.ALT_PARTYB IS NULL AND :new.ALT_PARTYB IS NOT NULL)    OR (:old.ALT_PARTYB IS NOT NULL AND :new.ALT_PARTYB IS NULL)
                OR :old.INTERM_B <> :new.INTERM_B        OR (:old.INTERM_B IS NULL AND :new.INTERM_B IS NOT NULL)        OR (:old.INTERM_B IS NOT NULL AND :new.INTERM_B IS NULL)
                OR :old.INT_PARTYA <> :new.INT_PARTYA    OR (:old.INT_PARTYA IS NULL AND :new.INT_PARTYA IS NOT NULL)    OR (:old.INT_PARTYA IS NOT NULL AND :new.INT_PARTYA IS NULL)
                OR :old.INT_PARTYB <> :new.INT_PARTYB    OR (:old.INT_PARTYB IS NULL AND :new.INT_PARTYB IS NOT NULL)    OR (:old.INT_PARTYB IS NOT NULL AND :new.INT_PARTYB IS NULL)
                OR :old.INT_INTERMA <> :new.INT_INTERMA  OR (:old.INT_INTERMA IS NULL AND :new.INT_INTERMA IS NOT NULL)  OR (:old.INT_INTERMA IS NOT NULL AND :new.INT_INTERMA IS NULL)
                OR :old.INT_INTERMB <> :new.INT_INTERMB  OR (:old.INT_INTERMB IS NULL AND :new.INT_INTERMB IS NOT NULL)  OR (:old.INT_INTERMB IS NOT NULL AND :new.INT_INTERMB IS NULL)
                OR :old.SSUDA <> :new.SSUDA              OR (:old.SSUDA IS NULL AND :new.SSUDA IS NOT NULL)              OR (:old.SSUDA IS NOT NULL AND :new.SSUDA IS NULL)
                OR :old.OKPOKRED <> :new.OKPOKRED        OR (:old.OKPOKRED IS NULL AND :new.OKPOKRED IS NOT NULL)        OR (:old.OKPOKRED IS NOT NULL AND :new.OKPOKRED IS NULL)
                OR :old.NAMKRED <> :new.NAMKRED          OR (:old.NAMKRED IS NULL AND :new.NAMKRED IS NOT NULL)          OR (:old.NAMKRED IS NOT NULL AND :new.NAMKRED IS NULL)
                OR :old.NAZNKRED <> :new.NAZNKRED        OR (:old.NAZNKRED IS NULL AND :new.NAZNKRED IS NOT NULL)        OR (:old.NAZNKRED IS NOT NULL AND :new.NAZNKRED IS NULL)
                OR :old.NLS_1819 <> :new.NLS_1819        OR (:old.NLS_1819 IS NULL AND :new.NLS_1819 IS NOT NULL)        OR (:old.NLS_1819 IS NOT NULL AND :new.NLS_1819 IS NULL)
                OR :old.FIELD_58D <> :new.FIELD_58D      OR (:old.FIELD_58D IS NULL AND :new.FIELD_58D IS NOT NULL)      OR (:old.FIELD_58D IS NOT NULL AND :new.FIELD_58D IS NULL)
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
end TAIU_CCADD_UPDATE;
/
ALTER TRIGGER BARS.TAIU_CCADD_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCADD_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
