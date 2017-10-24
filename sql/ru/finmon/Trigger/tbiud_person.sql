

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Trigger/TBIUD_PERSON.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_PERSON ***

  CREATE OR REPLACE TRIGGER FINMON.TBIUD_PERSON 
before insert or update or delete ON FINMON.PERSON for each row
begin

	if (inserting)then
        if (:new.branch_id is null) then
            :new.branch_id := get_branch_id;
        end if;
	end if;
    if (dbms_reputil.from_remote = false and dbms_snapshot.i_am_a_refresh = false and (isd_branch = 0)) then

        if (updating or deleting) then

            if (:old.branch_id != get_branch_id) then
                raise_application_error(-20100, 'cannot modify data for branch(es)');
            end if;

        end if;

    end if;

end;
/
ALTER TRIGGER FINMON.TBIUD_PERSON ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Trigger/TBIUD_PERSON.sql =========*** End 
PROMPT ===================================================================================== 
