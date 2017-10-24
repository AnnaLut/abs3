

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_BRANCH.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_BRANCH ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_BRANCH 
after insert or update on branch for each row 
declare
  l_mfo  banks.mfo%type;
begin
  if :new.branch='/' then
  	return;
  end if;
  l_mfo := bc.extract_mfo(:new.branch);
  begin
  	select mfo into l_mfo from banks where mfo=l_mfo;
  exception when no_data_found then
  	raise_application_error(-20000, 'Код банка "'||l_mfo||'" не найден в BANKS', true);
  end;
end taiu_branch; 




/
ALTER TRIGGER BARS.TAIU_BRANCH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_BRANCH.sql =========*** End ***
PROMPT ===================================================================================== 
