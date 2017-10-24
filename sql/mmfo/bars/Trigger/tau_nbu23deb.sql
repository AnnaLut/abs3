

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_NBU23DEB.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_NBU23DEB ***

  CREATE OR REPLACE TRIGGER BARS.TAU_NBU23DEB INSTEAD OF UPDATE
  ON BARS.NBU23_DEB REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
  If nvl(:new.fin23,0)<>nvl(:old.fin23,0)
    OR nvl(:new.obs23,0)<>nvl(:old.obs23,0)
    OR nvl(:new.kat23,0)<>nvl(:old.kat23,0)
  --OR nvl(:new.k23  ,0)<>nvl(:old.k23  ,0)
  then
    update ACC_DEB_23
       set FIN = :new.fin23, OBS = :new.obs23,
           KAT = decode(:new.kat23,1,:new.kat23,
                                   2,:new.kat23,
                                   3,:new.kat23,
                                   4,:new.kat23,
                                   5,:new.kat23,:old.kat23),
           K   = decode(:new.kat23,1,0,
                                   2,0.2,
                                   3,0.5,
                                   4,0.8,
                                   5,1,:old.k23)
     where acc = :old.ND;
    if SQL%rowcount = 0 then
       insert into ACC_DEB_23 (acc, fin, obs, kat, k) values
          (:old.nd , :new.fin23, :new.obs23, :new.kat23, :new.k23);
    end if;
  end if;
end TAU_NBU23DEB;


/
ALTER TRIGGER BARS.TAU_NBU23DEB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_NBU23DEB.sql =========*** End **
PROMPT ===================================================================================== 
