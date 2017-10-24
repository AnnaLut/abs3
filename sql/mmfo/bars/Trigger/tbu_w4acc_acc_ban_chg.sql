

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_W4ACC_ACC_BAN_CHG.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_W4ACC_ACC_BAN_CHG ***

  CREATE OR REPLACE TRIGGER BARS.TBU_W4ACC_ACC_BAN_CHG 
before update of ACC_PK,   ACC_OVR,  ACC_9129, ACC_3579, ACC_3570, ACC_2628,  ACC_2627X,
                 ACC_2627, ACC_2203, ACC_2209, ACC_2208, ACC_2207, ACC_2625D, ACC_2625X
ON BARS.W4_ACC
for each row
   WHEN ( old.DAT_CLOSE Is Not Null and new.DAT_CLOSE Is Not Null ) declare
begin

  if ( (:old.ACC_PK != :new.ACC_PK)
       OR
       (:old.ACC_OVR          != :new.ACC_OVR) or
       (:old.ACC_OVR is Null AND :new.ACC_OVR is Not Null) or
       (:new.ACC_OVR is Null AND :old.ACC_OVR is Not Null)
       OR
       (:old.ACC_9129          != :new.ACC_9129) or
       (:old.ACC_9129 is Null AND :new.ACC_9129 is Not Null) or
       (:new.ACC_9129 is Null AND :old.ACC_9129 is Not Null)
       OR
       (:old.ACC_2627          != :new.ACC_2627) or
       (:old.ACC_2627 is Null AND :new.ACC_2627 is Not Null) or
       (:new.ACC_2627 is Null AND :old.ACC_2627 is Not Null)
       OR
       (:old.ACC_2628          != :new.ACC_2628) or
       (:old.ACC_2628 is Null AND :new.ACC_2628 is Not Null) or
       (:new.ACC_2628 is Null AND :old.ACC_2628 is Not Null)
       OR
       (:old.ACC_3570          != :new.ACC_3570) or
       (:old.ACC_3570 is Null AND :new.ACC_3570 is Not Null) or
       (:new.ACC_3570 is Null AND :old.ACC_3570 is Not Null)
       OR
       (:old.ACC_3579          != :new.ACC_3579) or
       (:old.ACC_3579 is Null AND :new.ACC_3579 is Not Null) or
       (:new.ACC_3579 is Null AND :old.ACC_3579 is Not Null)
       OR
       (:old.ACC_2203          != :new.ACC_2203) or
       (:old.ACC_2203 is Null AND :new.ACC_2203 is Not Null) or
       (:new.ACC_2203 is Null AND :old.ACC_2203 is Not Null)
       OR
       (:old.ACC_2207          != :new.ACC_2207) or
       (:old.ACC_2207 is Null AND :new.ACC_2207 is Not Null) or
       (:new.ACC_2207 is Null AND :old.ACC_2207 is Not Null)
       OR
       (:old.ACC_2208          != :new.ACC_2208) or
       (:old.ACC_2208 is Null AND :new.ACC_2208 is Not Null) or
       (:new.ACC_2208 is Null AND :old.ACC_2208 is Not Null)
       OR
       (:old.ACC_2209          != :new.ACC_2209) or
       (:old.ACC_2209 is Null AND :new.ACC_2209 is Not Null) or
       (:new.ACC_2209 is Null AND :old.ACC_2209 is Not Null)
       OR
       (:old.ACC_2625X          != :new.ACC_2625X) or
       (:old.ACC_2625X is Null AND :new.ACC_2625X is Not Null) or
       (:new.ACC_2625X is Null AND :old.ACC_2625X is Not Null)
       OR
       (:old.ACC_2627X          != :new.ACC_2627X) or
       (:old.ACC_2627X is Null AND :new.ACC_2627X is Not Null) or
       (:new.ACC_2627X is Null AND :old.ACC_2627X is Not Null)
       OR
       (:old.ACC_2625D          != :new.ACC_2625D) or
       (:old.ACC_2625D is Null AND :new.ACC_2625D is Not Null) or
       (:new.ACC_2625D is Null AND :old.ACC_2625D is Not Null) )
  then -- COBUPRVN-256
    raise_application_error( -20444, 'Заборонено змінювати зв`язок рахунків по закритому договору БПК!', true );
  else
    null;
  end if;

end TBU_W4ACC_ACC_BAN_CHG;


/
ALTER TRIGGER BARS.TBU_W4ACC_ACC_BAN_CHG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_W4ACC_ACC_BAN_CHG.sql =========*
PROMPT ===================================================================================== 
