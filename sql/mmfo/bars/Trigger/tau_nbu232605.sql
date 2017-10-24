

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_NBU232605.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_NBU232605 ***

  CREATE OR REPLACE TRIGGER BARS.TAU_NBU232605 INSTEAD OF UPDATE
  ON NBU23_2605 REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
  If nvl(:new.fin23,0)<>nvl(:old.fin23,0) 
    OR nvl(:new.obs23,0)<>nvl(:old.obs23,0) 
  --OR nvl(:new.kat23,0)<>nvl(:old.kat23,0) 
  --OR nvl(:new.k23  ,0)<>nvl(:old.k23  ,0) 
  then
    update ACC_FIN_OBS_KAT 
       set fin = :new.fin23,  OBS = :new.obs23
     --, KAT = :new.kat23,  k   = :new.k23 
     where acc = :old.ND;
    if SQL%rowcount = 0 then
       insert into ACC_FIN_OBS_KAT (acc, fin, obs, kat, k) values 
          (:old.nd , :new.fin23, :new.obs23, :new.kat23, :new.k23);
    end if;
  end if;
end TAU_NBU232605;


/
ALTER TRIGGER BARS.TAU_NBU232605 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_NBU232605.sql =========*** End *
PROMPT ===================================================================================== 
