

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_CC_SOB_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_CC_SOB_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_CC_SOB_UPDATE 
after insert or update of otm, FACT_DATE   or delete ON BARS.CC_SOB for each row
-- version 1.0 19.11.2010
declare

  l_chgaction CC_SOB_UPDATE.chgaction%type := 0;
  l_idupd CC_SOB_UPDATE.idupd%type:=null;
  l_nd    CC_SOB_UPDATE.nd%type:=null;
  l_FDAT   CC_SOB_UPDATE.FDAT%type:=null;
  l_ID   CC_SOB_UPDATE.ID%type:=null;
  l_ISP   CC_SOB_UPDATE.ISP%type:=null;
  l_TXT   CC_SOB_UPDATE.TXT%type:=null;
  l_OTM   CC_SOB_UPDATE.OTM%type:=null;
  l_FREQ   CC_SOB_UPDATE.FREQ%type:=null;
  l_PSYS   CC_SOB_UPDATE.PSYS%type:=null;
  l_FACT_DATE   CC_SOB_UPDATE.FACT_DATE%type:=null;
begin


  if deleting then
     l_chgaction   := 3;
     l_nd   := :old.nd;
     l_id := :old.id;
     l_fdat:=:OLD.FDAT;
     l_isp:=user_id;

  else

     if    inserting            then l_chgaction := 1;
     elsif :old.OTM <> :new.OTM or :old.FACT_DATE <> :new.FACT_DATE  then l_chgaction := 2;
     end if;
     if l_chgaction IN (1,2) then
        l_nd   := :new.nd;
        l_FDAT   := :new.FDAT;
        l_ID := :new.ID;
        l_ISP := :new.ISP;
        l_TXT := :new.TXT;
        l_OTM := :new.OTM;
        l_FREQ := :new.FREQ;
        l_PSYS := :new.PSYS;
        l_ID := :new.ID;
        l_FACT_DATE := :new.FACT_DATE;
     end if;
  end if;

  if l_chgaction > 0 then
     select s_CC_SOB_UPDATE.nextval into l_idupd from dual;
     insert into CC_SOB_UPDATE (nd,FDAT,ID,ISP,TXT,OTM,FREQ,PSYS, FACT_DATE,
                                chgdate, chgaction, doneby, idupd)
                        values (l_nd,l_FDAT,l_ID,l_ISP,l_TXT,l_OTM,l_FREQ,l_PSYS, l_FACT_DATE,
                                sysdate, l_chgaction,(select logname from staff$base where id = user_id), l_idupd
                               );
  end if;

end;
/
ALTER TRIGGER BARS.TAIUD_CC_SOB_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_CC_SOB_UPDATE.sql =========***
PROMPT ===================================================================================== 
