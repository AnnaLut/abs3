

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_VIDD.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPU_VIDD ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPU_VIDD 
before insert on dpu_vidd
for each row
 WHEN (new.vidd is null or new.vidd = 0) begin
  select s_dpu_vidd.nextval into :new.vidd from dual;
end;
/
ALTER TRIGGER BARS.TBI_DPU_VIDD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_VIDD.sql =========*** End **
PROMPT ===================================================================================== 
