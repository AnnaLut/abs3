

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_KKFORBPK_DATA.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_KKFORBPK_DATA ***

  CREATE OR REPLACE TRIGGER BARS.TBI_KKFORBPK_DATA 
  before insert on kkforbk_data
  for each row
declare
  -- local variables here
begin
  if :new.id is null then
    :new.id := s_kkforbk_data.nextval;
  end if;
end tbi_kkforbpk_data;
/
ALTER TRIGGER BARS.TBI_KKFORBPK_DATA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_KKFORBPK_DATA.sql =========*** E
PROMPT ===================================================================================== 
