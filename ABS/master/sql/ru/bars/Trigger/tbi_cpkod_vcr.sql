

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CPKOD_VCR.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CPKOD_VCR ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CPKOD_VCR 
before update of vncrr on cp_kod
for each row
begin
  if :old.vncrr is null and :new.vncrr is not null and :new.vncrp is null then
     :new.vncrp := :new.vncrr;
  end if;
end;
/
ALTER TRIGGER BARS.TBI_CPKOD_VCR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CPKOD_VCR.sql =========*** End *
PROMPT ===================================================================================== 
