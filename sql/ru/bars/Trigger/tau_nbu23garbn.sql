

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_NBU23GARBN.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_NBU23GARBN ***

  CREATE OR REPLACE TRIGGER BARS.TAU_NBU23GARBN INSTEAD OF UPDATE
  ON NBU23_GAR_BN REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
  If nvl(:new.fin23,0)<>nvl(:old.fin23,0)
    OR nvl(:new.obs23,0)<>nvl(:old.obs23,0)
  --OR nvl(:new.kat23,0)<>nvl(:old.kat23,0)
  --OR nvl(:new.k23  ,0)<>nvl(:old.k23  ,0)
  then
    update cc_deal set fin23 = :new.fin23, OBS23 = :new.obs23
  --,  KAT23 = :new.kat23,   k23   = :new.k23
    where nd    = :old.ND;
  end if;
end TAU_NBU23GARBN;
/
ALTER TRIGGER BARS.TAU_NBU23GARBN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_NBU23GARBN.sql =========*** End 
PROMPT ===================================================================================== 
