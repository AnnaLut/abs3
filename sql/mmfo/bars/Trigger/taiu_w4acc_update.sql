

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_W4ACC_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_W4ACC_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_W4ACC_UPDATE AFTER UPDATE OR INSERT OR DELETE ON "BARS"."W4_ACC" FOR EACH ROW 
declare
  -- ver. 07.12.2016
  -- ver. 11.09.2018  Add columns (ACC_9129I) for Instolment
  l_rec    W4_ACC_UPDATE%rowtype;
begin

  if deleting
  then

    l_rec.CHGACTION    := 'D';

    l_rec.ND           := :old.ND;
    l_rec.ACC_PK       := :old.ACC_PK;
    l_rec.ACC_OVR      := :old.ACC_OVR;
    l_rec.ACC_9129     := :old.ACC_9129;
    l_rec.ACC_3570     := :old.ACC_3570;
    l_rec.ACC_2208     := :old.ACC_2208;
    l_rec.ACC_2627     := :old.ACC_2627;
    l_rec.ACC_2207     := :old.ACC_2207;
    l_rec.ACC_3579     := :old.ACC_3579;
    l_rec.ACC_2209     := :old.ACC_2209;
    l_rec.CARD_CODE    := :old.CARD_CODE;
    l_rec.ACC_2625X    := :old.ACC_2625X;
    l_rec.ACC_2627X    := :old.ACC_2627X;
    l_rec.ACC_2625D    := :old.ACC_2625D;
    l_rec.ACC_2628     := :old.ACC_2628;
    l_rec.ACC_2203     := :old.ACC_2203;
    l_rec.FIN          := :old.FIN;
    l_rec.FIN23        := :old.FIN23;
    l_rec.OBS23        := :old.OBS23;
    l_rec.KAT23        := :old.KAT23;
    l_rec.K23          := :old.K23;
    l_rec.DAT_BEGIN    := :old.DAT_BEGIN;
    l_rec.DAT_END      := :old.DAT_END;
    l_rec.DAT_CLOSE    := :old.DAT_CLOSE;
    l_rec.PASS_DATE    := :old.PASS_DATE;
    l_rec.PASS_STATE   := :old.PASS_STATE;
    l_rec.KOL_SP       := :old.KOL_SP;
    l_rec.S250         := :old.S250;
    l_rec.GRP          := :old.GRP;
    l_rec.KF           := :old.KF;
    l_rec.ACC_9129I    := :old.ACC_9129I;
    

  else

    if updating
    then
      if ( (:old.ND != :new.ND)
           OR
           (:old.ACC_PK != :new.ACC_PK)
           OR
           (:old.ACC_OVR          != :new.ACC_OVR) or
           (:old.ACC_OVR is Null AND :new.ACC_OVR is Not Null) or
           (:new.ACC_OVR is Null AND :old.ACC_OVR is Not Null)
           OR
           (:old.ACC_9129          != :new.ACC_9129) or
           (:old.ACC_9129 is Null AND :new.ACC_9129 is Not Null) or
           (:new.ACC_9129 is Null AND :old.ACC_9129 is Not Null)
           OR
           (:old.ACC_3570          != :new.ACC_3570) or
           (:old.ACC_3570 is Null AND :new.ACC_3570 is Not Null) or
           (:new.ACC_3570 is Null AND :old.ACC_3570 is Not Null)
           OR
           (:old.ACC_2208          != :new.ACC_2208) or
           (:old.ACC_2208 is Null AND :new.ACC_2208 is Not Null) or
           (:new.ACC_2208 is Null AND :old.ACC_2208 is Not Null)
           OR
           (:old.ACC_2627          != :new.ACC_2627) or
           (:old.ACC_2627 is Null AND :new.ACC_2627 is Not Null) or
           (:new.ACC_2627 is Null AND :old.ACC_2627 is Not Null)
           OR
           (:old.ACC_2207          != :new.ACC_2207) or
           (:old.ACC_2207 is Null AND :new.ACC_2207 is Not Null) or
           (:new.ACC_2207 is Null AND :old.ACC_2207 is Not Null)
           OR
           (:old.ACC_3579          != :new.ACC_3579) or
           (:old.ACC_3579 is Null AND :new.ACC_3579 is Not Null) or
           (:new.ACC_3579 is Null AND :old.ACC_3579 is Not Null)
           OR
           (:old.ACC_2209          != :new.ACC_2209) or
           (:old.ACC_2209 is Null AND :new.ACC_2209 is Not Null) or
           (:new.ACC_2209 is Null AND :old.ACC_2209 is Not Null)
           OR
           (:old.CARD_CODE != :new.CARD_CODE)
           OR
           (:old.ACC_2625X          != :new.ACC_2625X) or
           (:old.ACC_2625X is Null AND :new.ACC_2625X is Not Null) or
           (:new.ACC_2625X is Null AND :old.ACC_2625X is Not Null)
           OR
           (:old.ACC_2627X          != :new.ACC_2627X) or
           (:old.ACC_2627X is Null AND :new.ACC_2627X is Not Null) or
           (:new.ACC_2627X is Null AND :old.ACC_2627X is Not Null)
           OR
           (:old.ACC_2625D          != :new.ACC_2625D) or
           (:old.ACC_2625D is Null AND :new.ACC_2625D is Not Null) or
           (:new.ACC_2625D is Null AND :old.ACC_2625D is Not Null)
           OR
           (:old.ACC_2628          != :new.ACC_2628) or
           (:old.ACC_2628 is Null AND :new.ACC_2628 is Not Null) or
           (:new.ACC_2628 is Null AND :old.ACC_2628 is Not Null)
           OR
           (:old.ACC_2203          != :new.ACC_2203) or
           (:old.ACC_2203 is Null AND :new.ACC_2203 is Not Null) or
           (:new.ACC_2203 is Null AND :old.ACC_2203 is Not Null)
           OR
           (:old.FIN          != :new.FIN) or
           (:old.FIN is Null AND :new.FIN is Not Null) or
           (:new.FIN is Null AND :old.FIN is Not Null)
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
           (:old.DAT_BEGIN          != :new.DAT_BEGIN) or
           (:old.DAT_BEGIN is Null AND :new.DAT_BEGIN is Not Null) or
           (:new.DAT_BEGIN is Null AND :old.DAT_BEGIN is Not Null)
           OR
           (:old.DAT_END          != :new.DAT_END) or
           (:old.DAT_END is Null AND :new.DAT_END is Not Null) or
           (:new.DAT_END is Null AND :old.DAT_END is Not Null)
           OR
           (:old.DAT_CLOSE          != :new.DAT_CLOSE) or
           (:old.DAT_CLOSE is Null AND :new.DAT_CLOSE is Not Null) or
           (:new.DAT_CLOSE is Null AND :old.DAT_CLOSE is Not Null)
           OR
           (:old.PASS_DATE          != :new.PASS_DATE) or
           (:old.PASS_DATE is Null AND :new.PASS_DATE is Not Null) or
           (:new.PASS_DATE is Null AND :old.PASS_DATE is Not Null)
           OR
           (:old.PASS_STATE          != :new.PASS_STATE) or
           (:old.PASS_STATE is Null AND :new.PASS_STATE is Not Null) or
           (:new.PASS_STATE is Null AND :old.PASS_STATE is Not Null)
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
           (:old.ACC_9129I    != :new.ACC_9129I) or
           (:old.ACC_9129I is Null AND :new.ACC_9129I is Not Null) or
           (:new.ACC_9129I is Null AND :old.ACC_9129I is Not Null)
         )
      then
        l_rec.CHGACTION := 'U';
      end if;

    else
      l_rec.CHGACTION := 'I';
    end if;

    l_rec.ND         := :new.ND;
    l_rec.ACC_PK     := :new.ACC_PK;
    l_rec.ACC_OVR    := :new.ACC_OVR;
    l_rec.ACC_9129   := :new.ACC_9129;
    l_rec.ACC_3570   := :new.ACC_3570;
    l_rec.ACC_2208   := :new.ACC_2208;
    l_rec.ACC_2627   := :new.ACC_2627;
    l_rec.ACC_2207   := :new.ACC_2207;
    l_rec.ACC_3579   := :new.ACC_3579;
    l_rec.ACC_2209   := :new.ACC_2209;
    l_rec.CARD_CODE  := :new.CARD_CODE;
    l_rec.ACC_2625X  := :new.ACC_2625X;
    l_rec.ACC_2627X  := :new.ACC_2627X;
    l_rec.ACC_2625D  := :new.ACC_2625D;
    l_rec.ACC_2628   := :new.ACC_2628;
    l_rec.ACC_2203   := :new.ACC_2203;
    l_rec.FIN        := :new.FIN;
    l_rec.FIN23      := :new.FIN23;
    l_rec.OBS23      := :new.OBS23;
    l_rec.KAT23      := :new.KAT23;
    l_rec.K23        := :new.K23;
    l_rec.DAT_BEGIN  := :new.DAT_BEGIN;
    l_rec.DAT_END    := :new.DAT_END;
    l_rec.DAT_CLOSE  := :new.DAT_CLOSE;
    l_rec.PASS_DATE  := :new.PASS_DATE;
    l_rec.PASS_STATE := :new.PASS_STATE;
    l_rec.KOL_SP     := :new.KOL_SP;
    l_rec.S250       := :new.S250;
    l_rec.GRP        := :new.GRP;
    l_rec.KF         := :new.KF;
    l_rec.ACC_9129I  := :new.ACC_9129I;

  end if;

  If (l_rec.CHGACTION Is Not Null)
  Then
    l_rec.IDUPD        := bars_sqnc.get_nextval('s_w4acc_update', l_rec.KF);
    l_rec.EFFECTDATE   := COALESCE(gl.bd, glb_bankdate);
    l_rec.CHGDATE      := sysdate;
    l_rec.DONEBY       := gl.aUID;
    l_rec.GLOBAL_BDATE := glb_bankdate;
    --l_rec.kf := sys_context('bars_context','user_mfo');
    insert into BARS.W4_ACC_UPDATE
    values l_rec;

  End If;

end TAIU_W4ACC_UPDATE;

/
ALTER TRIGGER BARS.TAIU_W4ACC_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_W4ACC_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
