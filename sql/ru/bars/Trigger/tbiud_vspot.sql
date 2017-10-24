

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_VSPOT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_VSPOT ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_VSPOT 
       INSTEAD OF UPDATE OR INSERT OR DELETE
       ON V_SPOT REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
declare
    nTmp_ int;
BEGIN
   if updating then
      update spot set RATE_K=:new.RATE_K, RATE_P=:new.RATE_P where acc=:old.ACC;
   Elsif deleting then
      delete from spot where acc=:old.acc and vdate=:old.VDATE;
   Elsif inserting then
      insert into spot (acc,     vdate,     rate_k,     rate_p)
            values(:new.acc,:new.vdate,:new.rate_k,:new.rate_p);
   end if;
END TBIUD_VSPOT;
/
ALTER TRIGGER BARS.TBIUD_VSPOT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_VSPOT.sql =========*** End ***
PROMPT ===================================================================================== 
