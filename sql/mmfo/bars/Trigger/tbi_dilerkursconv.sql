

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DILERKURSCONV.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DILERKURSCONV ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DILERKURSCONV 
after insert or update on diler_kurs_conv
for each row
begin
  bars_audit.info('ZAY. Установлены курсы конверсии: индикативный=>' || :new.kurs_i || ', фактический=>' || :new.kurs_f);
end;


/
ALTER TRIGGER BARS.TBI_DILERKURSCONV ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DILERKURSCONV.sql =========*** E
PROMPT ===================================================================================== 
