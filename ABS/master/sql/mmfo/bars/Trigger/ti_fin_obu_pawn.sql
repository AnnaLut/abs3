

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_FIN_OBU_PAWN.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_FIN_OBU_PAWN ***

  CREATE OR REPLACE TRIGGER BARS.TI_FIN_OBU_PAWN 
BEFORE INSERT  ON FIN_OBU_PAWN
 FOR EACH ROW
BEGIN
 If Nvl(:NEW.ID,0) =0 then
    SELECT S_FIN_OBU_PAWN.nextval into :NEW.ID FROM dual ;
 end if;
END TI_FIN_OBU_PAWN;


/
ALTER TRIGGER BARS.TI_FIN_OBU_PAWN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_FIN_OBU_PAWN.sql =========*** End
PROMPT ===================================================================================== 
