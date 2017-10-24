

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_VFINREZ.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_VFINREZ ***

  CREATE OR REPLACE TRIGGER BARS.TAU_VFINREZ INSTEAD OF UPDATE
  ON BARS.V_FINREZ  REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
  If :new.br_fin != :old.br_fin then
     update opldok
        set txt  = :new.br_fin
      where ref  = :old.ref
        and stmt = :old.stmt
        and dk   = :old.dk ;
  end if;
END TAU_VFINREZ ;
/
ALTER TRIGGER BARS.TAU_VFINREZ ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_VFINREZ.sql =========*** End ***
PROMPT ===================================================================================== 
