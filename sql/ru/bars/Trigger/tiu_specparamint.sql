

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_SPECPARAMINT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_SPECPARAMINT ***

  CREATE OR REPLACE TRIGGER BARS.TIU_SPECPARAMINT 
after insert or update of p080, ob22, ob88, mfo, r020_fa on specparam_int
for each row
-- Version 1.0 23.06.2009
declare
  l_id number;
begin
  select s_specparamintupdate.nextval into l_id from dual;
  if inserting or updating and (
     :new.p080 <> :old.p080 or
         (:old.p080 is null and :new.p080 is not null) or
         (:old.p080 is not null and :new.p080 is null) or
     :new.ob22 <> :old.ob22 or
         (:old.ob22 is null and :new.ob22 is not null) or
         (:old.ob22 is not null and :new.ob22 is null) or
     :new.ob88 <> :old.ob88 or
         (:old.ob88 is null and :new.ob88 is not null) or
         (:old.ob88 is not null and :new.ob88 is null) or
     :new.mfo  <> :old.mfo  or
         (:old.mfo is null and :new.mfo is not null) or
         (:old.mfo is not null and :new.mfo is null) or
     :new.r020_fa <> :old.r020_fa or
         (:old.r020_fa is null and :new.r020_fa is not null) or
         (:old.r020_fa is not null and :new.r020_fa is null) ) then
     insert into specparam_int_update (acc, p080, ob22, ob88, mfo, r020_fa,
         fdat, user_name, idupd)
     values (:new.acc, :new.p080, :new.ob22, :new.ob88, :new.mfo, :new.r020_fa,
         sysdate, user_name, l_id);
  end if;
end;
/
ALTER TRIGGER BARS.TIU_SPECPARAMINT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_SPECPARAMINT.sql =========*** En
PROMPT ===================================================================================== 
