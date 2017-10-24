

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_CP_KOD_351.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_CP_KOD_351 ***

  CREATE OR REPLACE TRIGGER BARS.TAU_CP_KOD_351 
before update of FIN_351, pd  ON BARS.CP_KOD  FOR EACH ROW
BEGIN
   If nvl(:new.FIN_351,0)  > 0  or nvl(:new.PD,0)  > 0 then

      if :new.fin_351 not in (1,2,3,4,5) THEN
         raise_application_error(-(20001),'/' ||'     ¬казано не ≥снуючий клас боржника - '|| :new.fin_351, TRUE);
      End if;
      if :new.pd < 0 or :new.pd > 1  THEN
         raise_application_error(-(20001),'/' ||'     ¬казано не можливе значенн€ PD (0-1) - '|| :new.pd, TRUE);
      End if;
   end if;

end TAU_CP_KOD_351;
/
ALTER TRIGGER BARS.TAU_CP_KOD_351 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_CP_KOD_351.sql =========*** End 
PROMPT ===================================================================================== 
