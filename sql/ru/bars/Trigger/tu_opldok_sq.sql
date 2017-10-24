

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_OPLDOK_SQ.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_OPLDOK_SQ ***

  CREATE OR REPLACE TRIGGER BARS.TU_OPLDOK_SQ BEFORE UPDATE OF sos ON BARS.OPLDOK FOR EACH ROW
 WHEN (
OLD.sos < 5 AND NEW.sos >=5
      ) declare KV_ int;  acc_ number ; s_ number ; l_vob oper.vob%type;
BEGIN

    select o.vob into l_vob from oper o where o.ref=:new.ref;


    if l_vob not in(96,99) then
       KV_  := gl.acc.kv ;
       acc_ := :old.acc  ;
       s_   := :old.S    ;

       If  :old.sos = 4 or KV_ is null then  select kv into KV_ from accounts where acc = :old.acc; end if ;
       IF kv_ <> 980                   then  :NEW.SQ := gl.p_icurval (KV_, S_, :new.fdat );          END IF ;
    end if;

END tu_opldok_sq ;
/
ALTER TRIGGER BARS.TU_OPLDOK_SQ DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_OPLDOK_SQ.sql =========*** End **
PROMPT ===================================================================================== 
