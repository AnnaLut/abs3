

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_ACC_SPECPARAM.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_ACC_SPECPARAM ***

  CREATE OR REPLACE TRIGGER BARS.TAU_ACC_SPECPARAM 
  INSTEAD OF UPDATE ON "BARS"."ACCOUNTS_SPECPARAM"
  REFERENCING FOR EACH ROW
  BEGIN
  IF (:new.s580 is not null and (:old.s580 is null or :new.s580<>:old.s580))
     or
     (:new.s580 is null and (:old.s580 is not null or :new.s580<>:old.s580))
  THEN
    update SPECPARAM set s580 = :new.s580 WHERE acc = :old.acc;-- AND s580=:old.s580;
    IF SQL%rowcount = 0 THEN
       insert into SPECPARAM (acc, s580) values (:old.acc, :new.s580);
    END IF;
  END IF;
END TAU_ACC_SPECPARAM;



/
ALTER TRIGGER BARS.TAU_ACC_SPECPARAM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_ACC_SPECPARAM.sql =========*** E
PROMPT ===================================================================================== 
