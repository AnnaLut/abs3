

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TUI_V_FIN_OBU_PAWN.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TUI_V_FIN_OBU_PAWN ***

  CREATE OR REPLACE TRIGGER BARS.TUI_V_FIN_OBU_PAWN 
INSTEAD OF update  ON V_FIN_OBU_PAWN for each row
declare

begin
if :old.id >= 0 then

update fin_obu_pawn
set p_zast = :new.p_zast, datp =:new.datp
where id = :old.id;

else


insert into fin_obu_pawn (nd, rnk, pawn, kv, s_spv, p_zast, datp, acc)
values (:new.nd, :new.rnk, :new.pawn, :new.kv, :new.s_spv, :new.p_zast, :new.datp, :new.acc);


end if;


end;
/
ALTER TRIGGER BARS.TUI_V_FIN_OBU_PAWN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TUI_V_FIN_OBU_PAWN.sql =========*** 
PROMPT ===================================================================================== 
