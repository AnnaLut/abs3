

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_DEAL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPU_DEAL ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPU_DEAL 
before insert on dpu_deal
for each row
begin

   if :new.dpu_id is null or :new.dpu_id = 0 then
     select s_cc_deal.nextval into :new.dpu_id from dual;
   end if;

   if :new.trustee_id is null then
      :new.trustee_id := 0;
   end if;
   
end tbi_dpu_deal; 
/
ALTER TRIGGER BARS.TBI_DPU_DEAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_DEAL.sql =========*** End **
PROMPT ===================================================================================== 
