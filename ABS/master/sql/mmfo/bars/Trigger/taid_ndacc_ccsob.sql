

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAID_NDACC_CCSOB.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAID_NDACC_CCSOB ***

  CREATE OR REPLACE TRIGGER BARS.TAID_NDACC_CCSOB 
after insert or delete on nd_acc for each row
declare
   l_nls    varchar2(20);
   l_vidd   number;
begin

-- Если ND - из "Портфеля овердрафтов" - не проверяем:
  Begin
    Select 1 into l_vidd from ACC_OVER
    where ( ND=:new.ND or ND=:old.ND ) and rownum=1;
    Return;
  Exception when NO_DATA_FOUND then
    null;
  End;


-- Сохранения события отвязки/привязки счета к договору в события по КД (для vidd 1,2,3,11,12,13)
  if deleting then
           select vidd into l_vidd from cc_deal where nd = :old.ND;
           if l_vidd in (1,2,3,11,12,13) then
              select nls||'/'||kv into l_nls from accounts where acc = :old.acc;
              Insert into BARS.CC_SOB (     ND,    FDAT,   ID,     ISP,                          TXT, OTM, FREQ)
                               Values (:old.ND, sysdate, null, user_id, 'От КД отвязан счет '|| l_nls,  6,    2);
           end if;
  elsif inserting then
           select vidd into l_vidd from cc_deal where nd = :new.ND;
           if l_vidd in (1,2,3,11,12,13) then
              select nls||'/'||kv into l_nls from accounts where acc = :new.acc;
              Insert into BARS.CC_SOB (     ND,    FDAT,   ID,     ISP,                           TXT, OTM, FREQ)
                               Values (:new.ND, sysdate, null, user_id, 'К КД привязан счет '|| l_nls,   6,    2);
           end if;
  end if;
end;


/
ALTER TRIGGER BARS.TAID_NDACC_CCSOB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAID_NDACC_CCSOB.sql =========*** En
PROMPT ===================================================================================== 
