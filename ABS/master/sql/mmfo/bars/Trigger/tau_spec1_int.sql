

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_SPEC1_INT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_SPEC1_INT ***

  CREATE OR REPLACE TRIGGER BARS.TAU_SPEC1_INT 
  INSTEAD OF UPDATE ON "BARS"."SPEC1_INT"
  REFERENCING FOR EACH ROW
BEGIN
-- ******************
-- | Макаренко И.В. |
-- | 01.2013        |
-- ******************
  IF (:new.ob22 is not null and (:old.ob22 is null or :new.ob22<>:old.ob22))
     or
     (:new.ob22 is null and (:old.ob22 is not null or :new.ob22<>:old.ob22))
  THEN
    update SPECPARAM_INT set ob22=:new.ob22 where acc=:old.acc;
    IF SQL%rowcount = 0 THEN
       insert into SPECPARAM_INT (acc, ob22) values (:old.acc, :new.ob22);
    END IF;
  END IF;

--  IF :new.nms is not null and (:old.nms is null or :new.nms<>:old.nms) then
  IF :new.nms <> :old.nms then
    update ACCOUNTS set nms=:new.nms where acc=:old.acc;
  end if;
end TAU_SPEC1_INT;


/
ALTER TRIGGER BARS.TAU_SPEC1_INT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_SPEC1_INT.sql =========*** End *
PROMPT ===================================================================================== 
