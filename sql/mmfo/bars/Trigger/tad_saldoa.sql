

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAD_SALDOA.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAD_SALDOA ***

  CREATE OR REPLACE TRIGGER BARS.TAD_SALDOA 
    after delete on saldoa for each row
        --
        -- Удаленные из SALDOA записи переносим в SALDOA_DEL_ROWS
        --
    begin
        --
        insert
          into saldoa_del_rows(acc, fdat)
        values (:old.acc, :old.fdat);
        --
    end tad_saldoa;



/
ALTER TRIGGER BARS.TAD_SALDOA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAD_SALDOA.sql =========*** End *** 
PROMPT ===================================================================================== 
