

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOB22.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACCOB22 ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACCOB22 
  after insert or update of ob22 on SPECPARAM_INT
for each row
-- Version 1.0 23.01.2011 Sta
-- триггер для репликации OB22 в ACCOUNTS
begin
    if inserting  OR
       updating and  nvl(:new.ob22,'  ') <> nvl(:old.ob22,'  ') then
     update accounts set ob22 = :new.ob22 where acc = :new.acc;
  end if;
end tiu_accOB22;
/
ALTER TRIGGER BARS.TIU_ACCOB22 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOB22.sql =========*** End ***
PROMPT ===================================================================================== 
