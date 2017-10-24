

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_CUSB.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_CUSB ***

  CREATE OR REPLACE TRIGGER BARS.TIU_CUSB 
before insert or update on customer
-- Clears temp variables aiming next tiu_cus fires
begin
   kl.cus_rec.rnk := null;
end tiu_cusb;
/
ALTER TRIGGER BARS.TIU_CUSB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_CUSB.sql =========*** End *** ==
PROMPT ===================================================================================== 
