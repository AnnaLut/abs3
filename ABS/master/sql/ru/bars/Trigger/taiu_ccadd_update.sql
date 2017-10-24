

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCADD_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CCADD_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CCADD_UPDATE 
after insert or update or delete
   on BARS.CC_ADD for each row
declare
  l_rec    CC_ADD_UPDATE%rowtype;
begin

  if deleting
  then

    l_rec.CHGACTION   := 'D';

    l_rec.ND          := :old.ND;
    l_rec.ADDS        := :old.ADDS;
    l_rec.AIM         := :old.AIM;
    l_rec.S           := :old.S;
    l_rec.KV          := :old.KV;
    l_rec.BDATE       := :old.BDATE;
    l_rec.WDATE       := :old.WDATE;
    l_rec.ACCS        := :old.ACCS;
    l_rec.ACCP        := :old.ACCP;
    l_rec.SOUR        := :old.SOUR;
    l_rec.ACCKRED     := :old.ACCKRED;
    l_rec.MFOKRED     := :old.MFOKRED;
    l_rec.FREQ        := :old.FREQ;
    l_rec.PDATE       := :old.PDATE;
    l_rec.REFV        := :old.REFV;
    l_rec.REFP        := :old.REFP;
    l_rec.ACCPERC     := :old.ACCPERC;
    l_rec.MFOPERC     := :old.MFOPERC;
    l_rec.SWI_BIC     := :old.SWI_BIC;
    l_rec.SWI_ACC     := :old.SWI_ACC;
    l_rec.SWI_REF     := :old.SWI_REF;
    l_rec.SWO_BIC     := :old.SWO_BIC;
    l_rec.SWO_ACC     := :old.SWO_ACC;
    l_rec.SWO_REF     := :old.SWO_REF;
    l_rec.INT_AMOUNT  := :old.INT_AMOUNT;
    l_rec.ALT_PARTYB  := :old.ALT_PARTYB;
    l_rec.INTERM_B    := :old.INTERM_B;
    l_rec.INT_PARTYA  := :old.INT_PARTYA;
    l_rec.INT_PARTYB  := :old.INT_PARTYB;
    l_rec.INT_INTERMA := :old.INT_INTERMA;
    l_rec.INT_INTERMB := :old.INT_INTERMB;
    l_rec.SSUDA       := :old.SSUDA;
    l_rec.KF          := :old.KF;
    l_rec.OKPOKRED    := :old.OKPOKRED;
    l_rec.NAMKRED     := :old.NAMKRED;
    l_rec.NAZNKRED    := :old.NAZNKRED;
    l_rec.NLS_1819    := :old.NLS_1819;
    l_rec.FIELD_58D   := :old.FIELD_58D;

  else

    if updating
    then
      if ( (:old.ND != :new.ND)
           OR
           (:old.ADDS != :new.ADDS)
           OR
           (:old.AIM          != :new.AIM) or
           (:old.AIM is Null AND :new.AIM is Not Null) or
           (:new.AIM is Null AND :old.AIM is Not Null)
           OR
           (:old.S          != :new.S) or
           (:old.S is Null AND :new.S is Not Null) or
           (:new.S is Null AND :old.S is Not Null)
           OR
           (:old.KV          != :new.KV) or
           (:old.KV is Null AND :new.KV is Not Null) or
           (:new.KV is Null AND :old.KV is Not Null)
           OR
           (:old.BDATE          != :new.BDATE) or
           (:old.BDATE is Null AND :new.BDATE is Not Null) or
           (:new.BDATE is Null AND :old.BDATE is Not Null)
           OR
           (:old.WDATE          != :new.WDATE) or
           (:old.WDATE is Null AND :new.WDATE is Not Null) or
           (:new.WDATE is Null AND :old.WDATE is Not Null)
           OR
           (:old.ACCS          != :new.ACCS) or
           (:old.ACCS is Null AND :new.ACCS is Not Null) or
           (:new.ACCS is Null AND :old.ACCS is Not Null)
           OR
           (:old.ACCP          != :new.ACCP) or
           (:old.ACCP is Null AND :new.ACCP is Not Null) or
           (:new.ACCP is Null AND :old.ACCP is Not Null)
           OR
           (:old.SOUR          != :new.SOUR) or
           (:old.SOUR is Null AND :new.SOUR is Not Null) or
           (:new.SOUR is Null AND :old.SOUR is Not Null)
           OR
           (:old.ACCKRED          != :new.ACCKRED) or
           (:old.ACCKRED is Null AND :new.ACCKRED is Not Null) or
           (:new.ACCKRED is Null AND :old.ACCKRED is Not Null)
           OR
           (:old.MFOKRED          != :new.MFOKRED) or
           (:old.MFOKRED is Null AND :new.MFOKRED is Not Null) or
           (:new.MFOKRED is Null AND :old.MFOKRED is Not Null)
           OR
           (:old.FREQ          != :new.FREQ) or
           (:old.FREQ is Null AND :new.FREQ is Not Null) or
           (:new.FREQ is Null AND :old.FREQ is Not Null)
           OR
           (:old.PDATE          != :new.PDATE) or
           (:old.PDATE is Null AND :new.PDATE is Not Null) or
           (:new.PDATE is Null AND :old.PDATE is Not Null)
           OR
           (:old.REFV          != :new.REFV) or
           (:old.REFV is Null AND :new.REFV is Not Null) or
           (:new.REFV is Null AND :old.REFV is Not Null)
           OR
           (:old.REFP          != :new.REFP) or
           (:old.REFP is Null AND :new.REFP is Not Null) or
           (:new.REFP is Null AND :old.REFP is Not Null)
           OR
           (:old.ACCPERC          != :new.ACCPERC) or
           (:old.ACCPERC is Null AND :new.ACCPERC is Not Null) or
           (:new.ACCPERC is Null AND :old.ACCPERC is Not Null)
           OR
           (:old.MFOPERC          != :new.MFOPERC) or
           (:old.MFOPERC is Null AND :new.MFOPERC is Not Null) or
           (:new.MFOPERC is Null AND :old.MFOPERC is Not Null)
           OR
           (:old.SWI_BIC          != :new.SWI_BIC) or
           (:old.SWI_BIC is Null AND :new.SWI_BIC is Not Null) or
           (:new.SWI_BIC is Null AND :old.SWI_BIC is Not Null)
           OR
           (:old.SWI_ACC          != :new.SWI_ACC) or
           (:old.SWI_ACC is Null AND :new.SWI_ACC is Not Null) or
           (:new.SWI_ACC is Null AND :old.SWI_ACC is Not Null)
           OR
           (:old.SWI_REF          != :new.SWI_REF) or
           (:old.SWI_REF is Null AND :new.SWI_REF is Not Null) or
           (:new.SWI_REF is Null AND :old.SWI_REF is Not Null)
           OR
           (:old.SWO_BIC          != :new.SWO_BIC) or
           (:old.SWO_BIC is Null AND :new.SWO_BIC is Not Null) or
           (:new.SWO_BIC is Null AND :old.SWO_BIC is Not Null)
           OR
           (:old.SWO_ACC          != :new.SWO_ACC) or
           (:old.SWO_ACC is Null AND :new.SWO_ACC is Not Null) or
           (:new.SWO_ACC is Null AND :old.SWO_ACC is Not Null)
           OR
           (:old.SWO_REF          != :new.SWO_REF) or
           (:old.SWO_REF is Null AND :new.SWO_REF is Not Null) or
           (:new.SWO_REF is Null AND :old.SWO_REF is Not Null)
           OR
           (:old.INT_AMOUNT          != :new.INT_AMOUNT) or
           (:old.INT_AMOUNT is Null AND :new.INT_AMOUNT is Not Null) or
           (:new.INT_AMOUNT is Null AND :old.INT_AMOUNT is Not Null)
           OR
           (:old.ALT_PARTYB          != :new.ALT_PARTYB) or
           (:old.ALT_PARTYB is Null AND :new.ALT_PARTYB is Not Null) or
           (:new.ALT_PARTYB is Null AND :old.ALT_PARTYB is Not Null)
           OR
           (:old.INTERM_B          != :new.INTERM_B) or
           (:old.INTERM_B is Null AND :new.INTERM_B is Not Null) or
           (:new.INTERM_B is Null AND :old.INTERM_B is Not Null)
           OR
           (:old.INT_PARTYA          != :new.INT_PARTYA) or
           (:old.INT_PARTYA is Null AND :new.INT_PARTYA is Not Null) or
           (:new.INT_PARTYA is Null AND :old.INT_PARTYA is Not Null)
           OR
           (:old.INT_PARTYB          != :new.INT_PARTYB) or
           (:old.INT_PARTYB is Null AND :new.INT_PARTYB is Not Null) or
           (:new.INT_PARTYB is Null AND :old.INT_PARTYB is Not Null)
           OR
           (:old.INT_INTERMA          != :new.INT_INTERMA) or
           (:old.INT_INTERMA is Null AND :new.INT_INTERMA is Not Null) or
           (:new.INT_INTERMA is Null AND :old.INT_INTERMA is Not Null)
           OR
           (:old.INT_INTERMB          != :new.INT_INTERMB) or
           (:old.INT_INTERMB is Null AND :new.INT_INTERMB is Not Null) or
           (:new.INT_INTERMB is Null AND :old.INT_INTERMB is Not Null)
           OR
           (:old.SSUDA          != :new.SSUDA) or
           (:old.SSUDA is Null AND :new.SSUDA is Not Null) or
           (:new.SSUDA is Null AND :old.SSUDA is Not Null)
           OR
           (:old.KF != :new.KF)
           OR
           (:old.OKPOKRED          != :new.OKPOKRED) or
           (:old.OKPOKRED is Null AND :new.OKPOKRED is Not Null) or
           (:new.OKPOKRED is Null AND :old.OKPOKRED is Not Null)
           OR
           (:old.NAMKRED          != :new.NAMKRED) or
           (:old.NAMKRED is Null AND :new.NAMKRED is Not Null) or
           (:new.NAMKRED is Null AND :old.NAMKRED is Not Null)
           OR
           (:old.NAZNKRED          != :new.NAZNKRED) or
           (:old.NAZNKRED is Null AND :new.NAZNKRED is Not Null) or
           (:new.NAZNKRED is Null AND :old.NAZNKRED is Not Null)
           OR
           (:old.NLS_1819          != :new.NLS_1819) or
           (:old.NLS_1819 is Null AND :new.NLS_1819 is Not Null) or
           (:new.NLS_1819 is Null AND :old.NLS_1819 is Not Null)
           OR
           (:old.FIELD_58D          != :new.FIELD_58D) or
           (:old.FIELD_58D is Null AND :new.FIELD_58D is Not Null) or
           (:new.FIELD_58D is Null AND :old.FIELD_58D is Not Null)
         )
      then
        l_rec.CHGACTION := 'U';
      end if;

    else
      l_rec.CHGACTION := 'I';
    end if;

    l_rec.ND          := :new.ND;
    l_rec.ADDS        := :new.ADDS;
    l_rec.AIM         := :new.AIM;
    l_rec.S           := :new.S;
    l_rec.KV          := :new.KV;
    l_rec.BDATE       := :new.BDATE;
    l_rec.WDATE       := :new.WDATE;
    l_rec.ACCS        := :new.ACCS;
    l_rec.ACCP        := :new.ACCP;
    l_rec.SOUR        := :new.SOUR;
    l_rec.ACCKRED     := :new.ACCKRED;
    l_rec.MFOKRED     := :new.MFOKRED;
    l_rec.FREQ        := :new.FREQ;
    l_rec.PDATE       := :new.PDATE;
    l_rec.REFV        := :new.REFV;
    l_rec.REFP        := :new.REFP;
    l_rec.ACCPERC     := :new.ACCPERC;
    l_rec.MFOPERC     := :new.MFOPERC;
    l_rec.SWI_BIC     := :new.SWI_BIC;
    l_rec.SWI_ACC     := :new.SWI_ACC;
    l_rec.SWI_REF     := :new.SWI_REF;
    l_rec.SWO_BIC     := :new.SWO_BIC;
    l_rec.SWO_ACC     := :new.SWO_ACC;
    l_rec.SWO_REF     := :new.SWO_REF;
    l_rec.INT_AMOUNT  := :new.INT_AMOUNT;
    l_rec.ALT_PARTYB  := :new.ALT_PARTYB;
    l_rec.INTERM_B    := :new.INTERM_B;
    l_rec.INT_PARTYA  := :new.INT_PARTYA;
    l_rec.INT_PARTYB  := :new.INT_PARTYB;
    l_rec.INT_INTERMA := :new.INT_INTERMA;
    l_rec.INT_INTERMB := :new.INT_INTERMB;
    l_rec.SSUDA       := :new.SSUDA;
    l_rec.KF          := :new.KF;
    l_rec.OKPOKRED    := :new.OKPOKRED;
    l_rec.NAMKRED     := :new.NAMKRED;
    l_rec.NAZNKRED    := :new.NAZNKRED;
    l_rec.NLS_1819    := :new.NLS_1819;
    l_rec.FIELD_58D   := :new.FIELD_58D;

  end if;

  If (l_rec.CHGACTION Is Not Null)
  Then

    l_rec.IDUPD      := S_CCADD_UPDATE.NextVal;
    l_rec.EFFECTDATE := COALESCE(gl.bd, glb_bankdate);
    l_rec.CHGDATE    := sysdate;
    l_rec.DONEBY     := gl.aUID;

    insert into BARS.CC_ADD_UPDATE
    values l_rec;

  End If;

end TAIU_CCADD_UPDATE;
/
ALTER TRIGGER BARS.TAIU_CCADD_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCADD_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
