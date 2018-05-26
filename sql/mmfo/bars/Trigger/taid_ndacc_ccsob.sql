

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAID_NDACC_CCSOB.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAID_NDACC_CCSOB ***

CREATE OR REPLACE TRIGGER BARS.TAID_NDACC_CCSOB
after insert or delete ON BARS.ND_ACC for each row

-- 24.05.2018 Sta  
-- Сохранения события отвязки/привязки счета к договору в события по КД НЕзависимо от vidd ( біло только для 1,2,3,11,12,13)

begin

  if deleting then
     Insert into CC_SOB (ND,FDAT,ISP,OTM,FREQ,TXT) select :old.ND, sysdate,gl.auid, 6,2, 'От Дог отвязан счет '||kv||'/'||nls from accounts where acc= :old.acc;
  elsif inserting then
     Insert into CC_SOB (ND,FDAT,ISP,OTM,FREQ,TXT) select :new.ND, sysdate,gl.auid, 6,2, 'К Дог привязан счет '||kv||'/'||nls from accounts where acc= :new.acc;
  end if;

end TAID_NDACC_CCSOB ;


/
ALTER TRIGGER BARS.TAID_NDACC_CCSOB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAID_NDACC_CCSOB.sql =========*** En
PROMPT ===================================================================================== 
