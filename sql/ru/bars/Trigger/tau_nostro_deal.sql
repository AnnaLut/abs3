

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_NOSTRO_DEAL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_NOSTRO_DEAL ***

  CREATE OR REPLACE TRIGGER BARS.TAU_NOSTRO_DEAL INSTEAD OF UPDATE
  ON BARS.NOSTRO_DEAL  FOR EACH ROW
BEGIN
   If (nvl(:new.fin23,0)>0  OR nvl(:new.obs23,0)  > 0 )
    or nvl(:new.FIN_351,0)  > 0  or nvl(:new.PD,0)  > 0 then
      if :new.fin_351 not in (1,2,3,4,5) THEN
         raise_application_error(-(20001),'/' ||'     ¬казано не ≥снуючий клас боржника - '|| :new.fin_351, TRUE);
      End if;
      if :new.pd < 0 or :new.pd > 1  THEN
         raise_application_error(-(20001),'/' ||'     ¬казано не можливе значенн€ PD (0-1) - '|| :new.pd, TRUE);
      End if;
      update cc_deal set sos  = :new.sos  , cc_id = :new.cc_id, SDATE = :new.sdate, WDATE   =:new.wdate,
                         limit= :new.limit, fin23 = :new.FIN23, obs23 = :new.OBS23, FIN_351 = :new.FIN_351,
                         PD   = :new.PD
       where nd=:old.nd and vidd in (150,1502);
   end if;

end TAU_NOSTRO_DEAL;
/
ALTER TRIGGER BARS.TAU_NOSTRO_DEAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_NOSTRO_DEAL.sql =========*** End
PROMPT ===================================================================================== 
