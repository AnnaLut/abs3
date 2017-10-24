

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_OPERW_NOSTRO.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_OPERW_NOSTRO ***

  CREATE OR REPLACE TRIGGER BARS.TAI_OPERW_NOSTRO 
after insert or update ON BARS.OPERW
for each row
     WHEN (
new.tag = 'NOS_A' and new.value = '0'
      ) begin
    --
    -- Триггер захвата документов для очереди подбора корсчета
    --
    insert into sw_nostro_que(ref) values (:new.ref);
exception
    when DUP_VAL_ON_INDEX then null;
end tai_operw_nostro;


/
ALTER TRIGGER BARS.TAI_OPERW_NOSTRO ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_OPERW_NOSTRO.sql =========*** En
PROMPT ===================================================================================== 
