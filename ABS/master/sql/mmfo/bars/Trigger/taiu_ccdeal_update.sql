

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCDEAL_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CCDEAL_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CCDEAL_UPDATE 
after insert or update or delete
   on BARS.CC_DEAL for each row
declare
  l_rec    CC_DEAL_UPDATE%rowtype;
begin

  if deleting
  then

    l_rec.CHGACTION := 'D';

    l_rec.ND        := :old.ND;
    l_rec.SOS       := :old.SOS;
    l_rec.CC_ID     := :old.CC_ID;
    l_rec.SDATE     := :old.SDATE;
    l_rec.WDATE     := :old.WDATE;
    l_rec.RNK       := :old.RNK;
    l_rec.VIDD      := :old.VIDD;
    l_rec.LIMIT     := :old.LIMIT;
    l_rec.KPROLOG   := :old.KPROLOG;
    l_rec.USER_ID   := :old.USER_ID;
    l_rec.OBS       := :old.OBS;
    l_rec.BRANCH    := :old.BRANCH;
    l_rec.KF        := :old.KF;
    l_rec.IR        := :old.IR;
    l_rec.PROD      := :old.PROD;
    l_rec.SDOG      := :old.SDOG;
    l_rec.SKARB_ID  := :old.SKARB_ID;
    l_rec.FIN       := :old.FIN;
    l_rec.NDI       := :old.NDI;
    l_rec.FIN23     := :old.FIN23;
    l_rec.OBS23     := :old.OBS23;
    l_rec.KAT23     := :old.KAT23;
    l_rec.K23       := :old.K23;
    l_rec.KOL_SP    := :old.KOL_SP;
    l_rec.S250      := :old.S250;
    l_rec.GRP       := :old.GRP;
    l_rec.NDG       := :old.NDG;

  else

    if updating
    then
      if ( (:old.ND != :new.ND)
           OR
           (:old.SOS != :new.SOS)
           OR
           (:old.CC_ID          != :new.CC_ID) or
           (:old.CC_ID is Null AND :new.CC_ID is Not Null) or
           (:new.CC_ID is Null AND :old.CC_ID is Not Null)
           OR
           (:old.SDATE          != :new.SDATE) or
           (:old.SDATE is Null AND :new.SDATE is Not Null) or
           (:new.SDATE is Null AND :old.SDATE is Not Null)
           OR
           (:old.WDATE          != :new.WDATE) or
           (:old.WDATE is Null AND :new.WDATE is Not Null) or
           (:new.WDATE is Null AND :old.WDATE is Not Null)
           OR
           (:old.RNK != :new.RNK)
           OR
           (:old.VIDD != :new.VIDD)
           OR
           (:old.LIMIT          != :new.LIMIT) or
           (:old.LIMIT is Null AND :new.LIMIT is Not Null) or
           (:new.LIMIT is Null AND :old.LIMIT is Not Null)
           OR
           (:old.KPROLOG          != :new.KPROLOG) or
           (:old.KPROLOG is Null AND :new.KPROLOG is Not Null) or
           (:new.KPROLOG is Null AND :old.KPROLOG is Not Null)
           OR
           (:old.USER_ID != :new.USER_ID)
           OR
           (:old.OBS          != :new.OBS) or
           (:old.OBS is Null AND :new.OBS is Not Null) or
           (:new.OBS is Null AND :old.OBS is Not Null)
           OR
           (:old.BRANCH != :new.BRANCH)
           OR
           (:old.KF != :new.KF)
           OR
           (:old.IR          != :new.IR) or
           (:old.IR is Null AND :new.IR is Not Null) or
           (:new.IR is Null AND :old.IR is Not Null)
           OR
           (:old.PROD          != :new.PROD) or
           (:old.PROD is Null AND :new.PROD is Not Null) or
           (:new.PROD is Null AND :old.PROD is Not Null)
           OR
           (:old.SDOG          != :new.SDOG) or
           (:old.SDOG is Null AND :new.SDOG is Not Null) or
           (:new.SDOG is Null AND :old.SDOG is Not Null)
           OR
           (:old.SKARB_ID          != :new.SKARB_ID) or
           (:old.SKARB_ID is Null AND :new.SKARB_ID is Not Null) or
           (:new.SKARB_ID is Null AND :old.SKARB_ID is Not Null)
           OR
           (:old.FIN          != :new.FIN) or
           (:old.FIN is Null AND :new.FIN is Not Null) or
           (:new.FIN is Null AND :old.FIN is Not Null)
           OR
           (:old.NDI          != :new.NDI) or
           (:old.NDI is Null AND :new.NDI is Not Null) or
           (:new.NDI is Null AND :old.NDI is Not Null)
           OR
           (:old.FIN23          != :new.FIN23) or
           (:old.FIN23 is Null AND :new.FIN23 is Not Null) or
           (:new.FIN23 is Null AND :old.FIN23 is Not Null)
           OR
           (:old.OBS23          != :new.OBS23) or
           (:old.OBS23 is Null AND :new.OBS23 is Not Null) or
           (:new.OBS23 is Null AND :old.OBS23 is Not Null)
           OR
           (:old.KAT23          != :new.KAT23) or
           (:old.KAT23 is Null AND :new.KAT23 is Not Null) or
           (:new.KAT23 is Null AND :old.KAT23 is Not Null)
           OR
           (:old.K23          != :new.K23) or
           (:old.K23 is Null AND :new.K23 is Not Null) or
           (:new.K23 is Null AND :old.K23 is Not Null)
           OR
           (:old.KOL_SP          != :new.KOL_SP) or
           (:old.KOL_SP is Null AND :new.KOL_SP is Not Null) or
           (:new.KOL_SP is Null AND :old.KOL_SP is Not Null)
           OR
           (:old.S250          != :new.S250) or
           (:old.S250 is Null AND :new.S250 is Not Null) or
           (:new.S250 is Null AND :old.S250 is Not Null)
           OR
           (:old.GRP          != :new.GRP) or
           (:old.GRP is Null AND :new.GRP is Not Null) or
           (:new.GRP is Null AND :old.GRP is Not Null)
           OR
           (:old.NDG          != :new.NDG) or
           (:old.NDG is Null AND :new.NDG is Not Null) or
           (:new.NDG is Null AND :old.NDG is Not Null)
         )
      then
        l_rec.CHGACTION := 'U';
      end if;

    else
      l_rec.CHGACTION := 'I';
    end if;

    l_rec.ND        := :new.ND;
    l_rec.SOS       := :new.SOS;
    l_rec.CC_ID     := :new.CC_ID;
    l_rec.SDATE     := :new.SDATE;
    l_rec.WDATE     := :new.WDATE;
    l_rec.RNK       := :new.RNK;
    l_rec.VIDD      := :new.VIDD;
    l_rec.LIMIT     := :new.LIMIT;
    l_rec.KPROLOG   := :new.KPROLOG;
    l_rec.USER_ID   := :new.USER_ID;
    l_rec.OBS       := :new.OBS;
    l_rec.BRANCH    := :new.BRANCH;
    l_rec.KF        := :new.KF;
    l_rec.IR        := :new.IR;
    l_rec.PROD      := :new.PROD;
    l_rec.SDOG      := :new.SDOG;
    l_rec.SKARB_ID  := :new.SKARB_ID;
    l_rec.FIN       := :new.FIN;
    l_rec.NDI       := :new.NDI;
    l_rec.FIN23     := :new.FIN23;
    l_rec.OBS23     := :new.OBS23;
    l_rec.KAT23     := :new.KAT23;
    l_rec.K23       := :new.K23;
    l_rec.KOL_SP    := :new.KOL_SP;
    l_rec.S250      := :new.S250;
    l_rec.GRP       := :new.GRP;
    l_rec.NDG       := :new.NDG;

  end if;

  If (l_rec.CHGACTION Is Not Null)
  Then

    l_rec.IDUPD      := bars_sqnc.get_nextval(S_CCDEAL_UPDATE.NextVal);
    l_rec.EFFECTDATE := COALESCE(gl.bd, glb_bankdate);
    l_rec.CHGDATE    := sysdate;
    l_rec.DONEBY     := gl.aUID;

    insert into BARS.CC_DEAL_UPDATE
    values l_rec;

  End If;

end TAIU_CCDEAL_UPDATE;


/
ALTER TRIGGER BARS.TAIU_CCDEAL_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCDEAL_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
