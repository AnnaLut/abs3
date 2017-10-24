

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_FDAT_ACCM.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_FDAT_ACCM ***

  CREATE OR REPLACE TRIGGER BARS.TI_FDAT_ACCM 
after insert on fdat
for each row
begin
    --
    -- Внесение в очередь для синхронизации накопительных таблиц
    --
    bars_accm_sync.enqueue_fdat(:new.fdat);

end;
/
ALTER TRIGGER BARS.TI_FDAT_ACCM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_FDAT_ACCM.sql =========*** End **
PROMPT ===================================================================================== 
