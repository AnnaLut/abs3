

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_SWJOURNAL_LAU.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_SWJOURNAL_LAU ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_SWJOURNAL_LAU 
before insert or update of lau_flag on sw_journal
for each row
declare

l_value  params.val%type;

begin

    if (:new.lau_flag = 1) then
        :new.lau_act := 1;
    elsif (:new.lau_flag = 0) then
        :new.lau_act := 0;
    else
        -- values is NULL
        begin
            select val into l_value
              from params
             where par = 'SWTLAUC';

            if (l_value not in ('0', '1')) then
                l_value := '0';
            end if;

        exception
            when NO_DATA_FOUND then l_value := '0';
        end;

        if (l_value = '1' ) then
            :new.lau_act := 0;
        else
            :new.lau_act := 1;
        end if;
    end if;

end;




/
ALTER TRIGGER BARS.TBIU_SWJOURNAL_LAU ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_SWJOURNAL_LAU.sql =========*** 
PROMPT ===================================================================================== 
