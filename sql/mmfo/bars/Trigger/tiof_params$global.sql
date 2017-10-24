

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIOF_PARAMS$GLOBAL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIOF_PARAMS$GLOBAL ***

  CREATE OR REPLACE TRIGGER BARS.TIOF_PARAMS$GLOBAL instead of insert or update or delete
on v_depricated_params$global
for each row
declare
    l_attribute_row branch_attribute%rowtype;
    l_another_values_count integer;
begin
    if (inserting or updating) then
        l_attribute_row := branch_attribute_utl.read_attribute(:new.par, p_raise_ndf => false);
        if (l_attribute_row.attribute_code is null) then
            branch_attribute_utl.add_new_attribute(:new.par, :new.comm, 'C', '', '', null);
        end if;

        branch_attribute_utl.set_attribute_value('/', :new.par, :new.val);

        if (updating and :new.par <> :old.par) then
            -- змінюється унікальний ключ значення - присвоюємо даній комбінації пусте значення (так як це відбувалося б при update)
            branch_attribute_utl.set_attribute_value('/', :old.par, null);
        end if;
    elsif (deleting) then
        branch_attribute_utl.set_attribute_value('/', :old.par, null);
    end if;

    if (not inserting) then
        select count(*)
        into   l_another_values_count
        from   branch_attribute_value t
        where  t.attribute_code = :old.par;

        if (l_another_values_count = 0) then
            branch_attribute_utl.delete_attribute(:old.par);
        end if;
    end if;
end;
/
ALTER TRIGGER BARS.TIOF_PARAMS$GLOBAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIOF_PARAMS$GLOBAL.sql =========*** 
PROMPT ===================================================================================== 
