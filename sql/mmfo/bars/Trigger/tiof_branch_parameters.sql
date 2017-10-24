

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIOF_BRANCH_PARAMETERS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIOF_BRANCH_PARAMETERS ***

  CREATE OR REPLACE TRIGGER BARS.TIOF_BRANCH_PARAMETERS instead of insert or update or delete
on v_depricated_branch_parameters
for each row
declare
    l_attribute_row branch_attribute%rowtype;
begin
    if (inserting or updating) then
        l_attribute_row := branch_attribute_utl.read_attribute(:new.tag);

        branch_attribute_utl.set_attribute_value(:new.branch, :new.tag, :new.val);

        if (updating and (:new.branch <> :old.branch or :new.tag <> :old.tag)) then
            -- змінюється унікальний ключ значення - присвоюємо даній комбінації пусте значення (так як це відбувалося б при update)
            branch_attribute_utl.set_attribute_value(:old.branch, :old.tag, null);
        end if;
    elsif (deleting) then
        branch_attribute_utl.set_attribute_value(:old.branch, :old.tag, null);
    end if;
end;
/
ALTER TRIGGER BARS.TIOF_BRANCH_PARAMETERS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIOF_BRANCH_PARAMETERS.sql =========
PROMPT ===================================================================================== 
