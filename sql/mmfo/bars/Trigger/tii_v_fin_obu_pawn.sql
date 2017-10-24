

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TII_V_FIN_OBU_PAWN.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TII_V_FIN_OBU_PAWN ***

  CREATE OR REPLACE TRIGGER BARS.TII_V_FIN_OBU_PAWN 
INSTEAD OF insert  ON V_FIN_OBU_PAWN for each row
declare

begin


insert into fin_obu_pawn (nd, rnk, pawn, kv, s_spv, p_zast, datp)
values (:new.nd, :new.rnk, :new.pawn, :new.kv, :new.s_spv, :new.p_zast, :new.datp);

end;


/
ALTER TRIGGER BARS.TII_V_FIN_OBU_PAWN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TII_V_FIN_OBU_PAWN.sql =========*** 
PROMPT ===================================================================================== 
