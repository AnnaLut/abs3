

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_CCADD_SOUR.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_CCADD_SOUR ***

  CREATE OR REPLACE TRIGGER BARS.TBU_CCADD_SOUR before update of sour ON BARS.CC_ADD
for each row
begin
  set_ADDIR (p_nd => :old.nd, p_sour=>:new.sour );
end tbu_ccadd_sour;


/
ALTER TRIGGER BARS.TBU_CCADD_SOUR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_CCADD_SOUR.sql =========*** End 
PROMPT ===================================================================================== 
