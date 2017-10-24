

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_ACCM.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_OPER_ACCM ***

  CREATE OR REPLACE TRIGGER BARS.TU_OPER_ACCM 
after update of sos, vob ON BARS.OPER
for each row
    WHEN (
(new.vob in (96, 99) or new.tt like 'ZG%') and (new.sos = 5 or new.sos < 0)
      ) begin
    --
    -- Внесение в очередь для синхронизации накопительных таблиц
    --
    bars_accm_sync.enqueue_corrdoc(:new.ref);

end;


/
ALTER TRIGGER BARS.TU_OPER_ACCM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_ACCM.sql =========*** End **
PROMPT ===================================================================================== 
