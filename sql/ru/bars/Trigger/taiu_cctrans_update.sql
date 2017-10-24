

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCTRANS_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CCTRANS_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CCTRANS_UPDATE 
after insert or update or delete
   on BARS.CC_TRANS for each row
declare
  l_rec    CC_TRANS_UPDATE%rowtype;
begin

  if deleting
  then

    l_rec.CHGACTION := 'D';

    l_rec.NPP       := :old.NPP;
    l_rec.REF       := :old.REF;
    l_rec.ACC       := :old.ACC;
    l_rec.FDAT      := :old.FDAT;
    l_rec.SV        := :old.SV;
    l_rec.SZ        := :old.SZ;
    l_rec.D_PLAN    := :old.D_PLAN;
    l_rec.D_FAKT    := :old.D_FAKT;
    l_rec.DAPP      := :old.DAPP;
    l_rec.REFP      := :old.REFP;
    l_rec.COMM      := :old.COMM;
    l_rec.ID0       := :old.ID0;

  else

    if updating
    then
      if ( (:old.NPP != :new.NPP)
           OR
           (:old.REF          != :new.REF) or
           (:old.REF is Null AND :new.REF is Not Null) or
           (:new.REF is Null AND :old.REF is Not Null)
           OR
           (:old.ACC          != :new.ACC) or
           (:old.ACC is Null AND :new.ACC is Not Null) or
           (:new.ACC is Null AND :old.ACC is Not Null)
           OR
           (:old.FDAT          != :new.FDAT) or
           (:old.FDAT is Null AND :new.FDAT is Not Null) or
           (:new.FDAT is Null AND :old.FDAT is Not Null)
           OR
           (:old.SV          != :new.SV) or
           (:old.SV is Null AND :new.SV is Not Null) or
           (:new.SV is Null AND :old.SV is Not Null)
           OR
           (:old.SZ          != :new.SZ) or
           (:old.SZ is Null AND :new.SZ is Not Null) or
           (:new.SZ is Null AND :old.SZ is Not Null)
           OR
           (:old.D_PLAN          != :new.D_PLAN) or
           (:old.D_PLAN is Null AND :new.D_PLAN is Not Null) or
           (:new.D_PLAN is Null AND :old.D_PLAN is Not Null)
           OR
           (:old.D_FAKT          != :new.D_FAKT) or
           (:old.D_FAKT is Null AND :new.D_FAKT is Not Null) or
           (:new.D_FAKT is Null AND :old.D_FAKT is Not Null)
           OR
           (:old.DAPP          != :new.DAPP) or
           (:old.DAPP is Null AND :new.DAPP is Not Null) or
           (:new.DAPP is Null AND :old.DAPP is Not Null)
           OR
           (:old.REFP          != :new.REFP) or
           (:old.REFP is Null AND :new.REFP is Not Null) or
           (:new.REFP is Null AND :old.REFP is Not Null)
           OR
           (:old.COMM          != :new.COMM) or
           (:old.COMM is Null AND :new.COMM is Not Null) or
           (:new.COMM is Null AND :old.COMM is Not Null)
           OR
           (:old.ID0          != :new.ID0) or
           (:old.ID0 is Null AND :new.ID0 is Not Null) or
           (:new.ID0 is Null AND :old.ID0 is Not Null)
         )
      then
        l_rec.CHGACTION := 'U';
      end if;

    else
      l_rec.CHGACTION := 'I';
    end if;

    l_rec.NPP        := :new.NPP;
    l_rec.REF        := :new.REF;
    l_rec.ACC        := :new.ACC;
    l_rec.FDAT       := :new.FDAT;
    l_rec.SV         := :new.SV;
    l_rec.SZ         := :new.SZ;
    l_rec.D_PLAN     := :new.D_PLAN;
    l_rec.D_FAKT     := :new.D_FAKT;
    l_rec.DAPP       := :new.DAPP;
    l_rec.REFP       := :new.REFP;
    l_rec.COMM       := :new.COMM;
    l_rec.ID0        := :new.ID0;

  end if;

  If (l_rec.CHGACTION Is Not Null)
  Then

    l_rec.IDUPD      := S_CCTRANS_UPDATE.NextVal;
    l_rec.EFFECTDATE := COALESCE(gl.bd, glb_bankdate);
    l_rec.CHGDATE    := sysdate;
    l_rec.DONEBY     := gl.aUID;

    insert into BARS.CC_TRANS_UPDATE
    values l_rec;

  End If;

end TAIU_CCTRANS_UPDATE;
/
ALTER TRIGGER BARS.TAIU_CCTRANS_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCTRANS_UPDATE.sql =========***
PROMPT ===================================================================================== 
