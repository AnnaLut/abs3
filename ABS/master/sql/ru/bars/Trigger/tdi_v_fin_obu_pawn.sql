

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TDI_V_FIN_OBU_PAWN.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TDI_V_FIN_OBU_PAWN ***

  CREATE OR REPLACE TRIGGER BARS.TDI_V_FIN_OBU_PAWN 
INSTEAD OF delete  ON V_FIN_OBU_PAWN for each row
declare

begin
if :old.id >0 then
delete from FIN_OBU_PAWN where id = :old.id ;
else null;
end if;

end;
/
ALTER TRIGGER BARS.TDI_V_FIN_OBU_PAWN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TDI_V_FIN_OBU_PAWN.sql =========*** 
PROMPT ===================================================================================== 
