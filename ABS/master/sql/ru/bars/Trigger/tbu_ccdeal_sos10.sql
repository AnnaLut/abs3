

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_CCDEAL_SOS10.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_CCDEAL_SOS10 ***

  CREATE OR REPLACE TRIGGER BARS.TBU_CCDEAL_SOS10 before update on cc_deal
for each row
declare
 l_sour number;
begin
  if :old.sos <10 and :new.sos=10 then
     begin
       select sour into l_sour from cc_add where nd = :old.nd and adds =0 ;
     EXCEPTION WHEN NO_DATA_FOUND THEN RETURN ;
     end;
     set_ADDIR (p_nd => :old.nd, p_sour => l_sour );
  end if;
end tbu_ccdeal_sos10;
/
ALTER TRIGGER BARS.TBU_CCDEAL_SOS10 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_CCDEAL_SOS10.sql =========*** En
PROMPT ===================================================================================== 
