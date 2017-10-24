

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_OPERW_KODDZ.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_OPERW_KODDZ ***

  CREATE OR REPLACE TRIGGER BARS.TAI_OPERW_KODDZ 
  after insert or update on operw  for each row
   WHEN (  new.tag like 'K_DZ_' or new.tag = 'KODDZ'   ) begin
    --
    -- Триггер захвата документов, коротые имеют код держ.закуп
    --
    insert into REF_KODDZ(ref) values (:new.ref);
exception
    when DUP_VAL_ON_INDEX then null;
end tai_operw_KODDZ;
/
ALTER TRIGGER BARS.TAI_OPERW_KODDZ ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_OPERW_KODDZ.sql =========*** End
PROMPT ===================================================================================== 
