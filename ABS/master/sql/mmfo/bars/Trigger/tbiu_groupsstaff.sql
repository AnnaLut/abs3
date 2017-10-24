

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_GROUPSSTAFF.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_GROUPSSTAFF ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_GROUPSSTAFF 
before insert or update on groups_staff
for each row
begin
    if (inserting) then
        if (:new.secg is not null) then
            -- заполняем отдельные поля
            :new.sec_sel := bitand(:new.secg, 4)/4;
            :new.sec_deb := bitand(:new.secg, 2)/2;
            :new.sec_cre := bitand(:new.secg, 1);
        else
            -- по отдельным полям формируем маску
            :new.secg := nvl(:new.sec_sel, 0) * 4 + nvl(:new.sec_deb, 0) * 2 + nvl(:new.sec_cre, 0);
        end if;

    else
        if (nvl(:old.secg, -1) != nvl(:new.secg, -1)) then

            -- заполняем отдельные поля
            :new.sec_sel := bitand(:new.secg, 4)/4;
            :new.sec_deb := bitand(:new.secg, 2)/2;
            :new.sec_cre := bitand(:new.secg, 1);

        else
            -- по отдельным полям формируем маску
            :new.secg := nvl(:new.sec_sel, 0) * 4 + nvl(:new.sec_deb, 0) * 2 + nvl(:new.sec_cre, 0);
        end if;
    end if;
end;




/
ALTER TRIGGER BARS.TBIU_GROUPSSTAFF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_GROUPSSTAFF.sql =========*** En
PROMPT ===================================================================================== 
