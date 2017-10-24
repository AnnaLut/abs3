

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_INTACCN_ACRDAT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_INTACCN_ACRDAT ***

  CREATE OR REPLACE TRIGGER BARS.TBI_INTACCN_ACRDAT 
before insert on int_accn
for each row
 WHEN (new.acr_dat is null) begin
  :new.acr_dat := to_date('01.01.1900','dd.mm.yyyy');
end tbi_intaccn_acrdat;
/
ALTER TRIGGER BARS.TBI_INTACCN_ACRDAT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_INTACCN_ACRDAT.sql =========*** 
PROMPT ===================================================================================== 
