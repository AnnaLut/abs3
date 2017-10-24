

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_CCTRANS_D_PLAN.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_CCTRANS_D_PLAN ***

  CREATE OR REPLACE TRIGGER BARS.TBU_CCTRANS_D_PLAN 
   BEFORE UPDATE OF D_PLAN ON BARS.CC_TRANS FOR EACH ROW
BEGIN

  IF :NEW.D_FAKT is not null THEN
     raise_application_error(-(20000+444),' Транш № ' || :new.npp  || ' уже погашено !' );
  end if;

-- chk_nbs : перевiрка строку траншу з балансовим рахунком.
  cct.chk_nbs (:new.npp, :new.acc, :new.fdat, :new.d_plan);
-- chk_term : проверка срока транша со сроком договора 
  cct.chk_term (:new.npp, :new.acc, :new.d_plan);

end tbu_CCTRANS_D_PLAN;


/
ALTER TRIGGER BARS.TBU_CCTRANS_D_PLAN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_CCTRANS_D_PLAN.sql =========*** 
PROMPT ===================================================================================== 
