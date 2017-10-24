

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_DEAL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPU_DEAL ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPU_DEAL 
before insert ON BARS.DPU_DEAL
for each row
begin

  if ( :new.dpu_id is null OR :new.dpu_id = 0 )
  then
    :new.dpu_id := bars_sqnc.get_nextval('s_cc_deal'); --s_cc_deal.nextval;
  end if;

  if ( :new.trustee_id is null )
  then
    :new.trustee_id := 0;
  end if;

end TBI_DPU_DEAL;
/
ALTER TRIGGER BARS.TBI_DPU_DEAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_DEAL.sql =========*** End **
PROMPT ===================================================================================== 
