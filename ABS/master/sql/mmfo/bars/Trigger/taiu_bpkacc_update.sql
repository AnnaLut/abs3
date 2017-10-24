

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_BPKACC_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_BPKACC_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_BPKACC_UPDATE 
after insert or update or delete
   on BARS.BPK_ACC for each row
declare
  -- ver. 07.12.2016
  l_rec    BPK_ACC_UPDATE%rowtype;
begin

  if deleting
  then
    l_rec.CHGACTION  := 'D';

    l_rec.ACC_PK     := :old.ACC_PK;    l_rec.ACC_OVR    := :old.ACC_OVR;    l_rec.ACC_9129   := :old.ACC_9129;
    l_rec.ACC_TOVR   := :old.ACC_TOVR;  l_rec.KF         := :old.KF;         l_rec.ACC_3570   := :old.ACC_3570;
    l_rec.ACC_2208   := :old.ACC_2208;  l_rec.ND         := :old.ND;         l_rec.PRODUCT_ID := :old.PRODUCT_ID;
    l_rec.ACC_2207   := :old.ACC_2207;  l_rec.ACC_3579   := :old.ACC_3579;   l_rec.ACC_2209   := :old.ACC_2209;
    l_rec.ACC_W4     := :old.ACC_W4;    l_rec.FIN        := :old.FIN;        l_rec.FIN23      := :old.FIN23;
    l_rec.OBS23      := :old.OBS23;     l_rec.KAT23      := :old.KAT23;      l_rec.K23        := :old.K23;
    l_rec.DAT_END    := :old.DAT_END;   l_rec.KOL_SP     := :old.KOL_SP;     l_rec.S250       := :old.S250;
    l_rec.GRP        := :old.GRP;       l_rec.DAT_CLOSE  := :old.DAT_CLOSE;
  else
    if updating
    then
      if ( (:old.ACC_PK != :new.ACC_PK)
           OR (:old.ACC_OVR      != :new.ACC_OVR) or     (:old.ACC_OVR is Null AND :new.ACC_OVR is Not Null) or       (:new.ACC_OVR is Null AND :old.ACC_OVR is Not Null)
           OR (:old.ACC_9129     != :new.ACC_9129) or    (:old.ACC_9129 is Null AND :new.ACC_9129 is Not Null) or     (:new.ACC_9129 is Null AND :old.ACC_9129 is Not Null)
           OR (:old.ACC_TOVR     != :new.ACC_TOVR) or    (:old.ACC_TOVR is Null AND :new.ACC_TOVR is Not Null) or     (:new.ACC_TOVR is Null AND :old.ACC_TOVR is Not Null)
           OR (:old.KF           != :new.KF) or          (:old.KF is Null AND :new.KF is Not Null) or                 (:new.KF is Null AND :old.KF is Not Null)
           OR (:old.ACC_3570     != :new.ACC_3570) or    (:old.ACC_3570 is Null AND :new.ACC_3570 is Not Null) or     (:new.ACC_3570 is Null AND :old.ACC_3570 is Not Null)
           OR (:old.ACC_2208     != :new.ACC_2208) or    (:old.ACC_2208 is Null AND :new.ACC_2208 is Not Null) or     (:new.ACC_2208 is Null AND :old.ACC_2208 is Not Null)
           OR (:old.ND != :new.ND)
           OR (:old.PRODUCT_ID   != :new.PRODUCT_ID) or  (:old.PRODUCT_ID is Null AND :new.PRODUCT_ID is Not Null) or (:new.PRODUCT_ID is Null AND :old.PRODUCT_ID is Not Null)
           OR (:old.ACC_2207     != :new.ACC_2207) or    (:old.ACC_2207 is Null AND :new.ACC_2207 is Not Null) or     (:new.ACC_2207 is Null AND :old.ACC_2207 is Not Null)
           OR (:old.ACC_3579     != :new.ACC_3579) or    (:old.ACC_3579 is Null AND :new.ACC_3579 is Not Null) or     (:new.ACC_3579 is Null AND :old.ACC_3579 is Not Null)
           OR (:old.ACC_2209     != :new.ACC_2209) or    (:old.ACC_2209 is Null AND :new.ACC_2209 is Not Null) or     (:new.ACC_2209 is Null AND :old.ACC_2209 is Not Null)
           OR (:old.ACC_W4       != :new.ACC_W4) or      (:old.ACC_W4 is Null AND :new.ACC_W4 is Not Null) or         (:new.ACC_W4 is Null AND :old.ACC_W4 is Not Null)
           OR (:old.FIN          != :new.FIN) or         (:old.FIN is Null AND :new.FIN is Not Null) or               (:new.FIN is Null AND :old.FIN is Not Null)
           OR (:old.FIN23        != :new.FIN23) or       (:old.FIN23 is Null AND :new.FIN23 is Not Null) or           (:new.FIN23 is Null AND :old.FIN23 is Not Null)
           OR (:old.OBS23        != :new.OBS23) or       (:old.OBS23 is Null AND :new.OBS23 is Not Null) or           (:new.OBS23 is Null AND :old.OBS23 is Not Null)
           OR (:old.KAT23        != :new.KAT23) or       (:old.KAT23 is Null AND :new.KAT23 is Not Null) or           (:new.KAT23 is Null AND :old.KAT23 is Not Null)
           OR (:old.K23          != :new.K23) or         (:old.K23 is Null AND :new.K23 is Not Null) or               (:new.K23 is Null AND :old.K23 is Not Null)
           OR (:old.DAT_END      != :new.DAT_END) or     (:old.DAT_END is Null AND :new.DAT_END is Not Null) or       (:new.DAT_END is Null AND :old.DAT_END is Not Null)
           OR (:old.KOL_SP       != :new.KOL_SP) or      (:old.KOL_SP is Null AND :new.KOL_SP is Not Null) or         (:new.KOL_SP is Null AND :old.KOL_SP is Not Null)
           OR (:old.S250         != :new.S250) or        (:old.S250 is Null AND :new.S250 is Not Null) or             (:new.S250 is Null AND :old.S250 is Not Null)
           OR (:old.GRP          != :new.GRP) or         (:old.GRP is Null AND :new.GRP is Not Null) or               (:new.GRP is Null AND :old.GRP is Not Null)
           OR (:old.DAT_CLOSE    != :new.DAT_CLOSE) or   (:old.DAT_CLOSE Is Null AND :new.DAT_CLOSE Is Not Null) or   (:new.DAT_CLOSE Is Null AND :old.DAT_CLOSE Is Not Null)
         )
      then
        l_rec.CHGACTION := 'U';
      end if;
    else
      l_rec.CHGACTION := 'I';
    end if;

    l_rec.ACC_PK     := :new.ACC_PK;    l_rec.ACC_OVR    := :new.ACC_OVR;    l_rec.ACC_9129   := :new.ACC_9129;
    l_rec.ACC_TOVR   := :new.ACC_TOVR;  l_rec.KF         := :new.KF;         l_rec.ACC_3570   := :new.ACC_3570;
    l_rec.ACC_2208   := :new.ACC_2208;  l_rec.ND         := :new.ND;         l_rec.PRODUCT_ID := :new.PRODUCT_ID;
    l_rec.ACC_2207   := :new.ACC_2207;  l_rec.ACC_3579   := :new.ACC_3579;   l_rec.ACC_2209   := :new.ACC_2209;
    l_rec.ACC_W4     := :new.ACC_W4;    l_rec.FIN        := :new.FIN;        l_rec.FIN23      := :new.FIN23;
    l_rec.OBS23      := :new.OBS23;     l_rec.KAT23      := :new.KAT23;      l_rec.K23        := :new.K23;
    l_rec.DAT_END    := :new.DAT_END;   l_rec.KOL_SP     := :new.KOL_SP;     l_rec.S250       := :new.S250;
    l_rec.GRP        := :new.GRP;       l_rec.DAT_CLOSE  := :new.DAT_CLOSE;
  end if;

  If (l_rec.CHGACTION Is Not Null)
  Then
    l_rec.IDUPD        := bars_sqnc.get_nextval('s_bpkacc_update', l_rec.KF);
    l_rec.EFFECTDATE   := COALESCE(gl.bd, glb_bankdate);
    l_rec.CHGDATE      := sysdate;
    l_rec.DONEBY       := gl.aUID;
    l_rec.GLOBAL_BDATE := glb_bankdate;

    insert into BARS.BPK_ACC_UPDATE
    values l_rec;

  End If;

end TAIU_BPKACC_UPDATE;
/
ALTER TRIGGER BARS.TAIU_BPKACC_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_BPKACC_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
