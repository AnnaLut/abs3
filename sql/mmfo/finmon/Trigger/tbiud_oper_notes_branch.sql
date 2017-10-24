

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Trigger/TBIUD_OPER_NOTES_BRANCH.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_OPER_NOTES_BRANCH ***

  CREATE OR REPLACE TRIGGER FINMON.TBIUD_OPER_NOTES_BRANCH 
before insert or update or delete ON FINMON.OPER_NOTES for each row
begin

    if (inserting)then
        if (:new.branch_id is null) then
            :new.branch_id := get_branch_id;
        end if;
    end if;
    if (dbms_reputil.from_remote = false and dbms_snapshot.i_am_a_refresh = false and (isd_branch = 0)) then

        if (updating or deleting or :old.branch_id != get_branch_id) then

            if (:old.branch_id != get_branch_id) then
                raise_application_error(-20100, 'cannot modify data for branch(es)');
            end if;

        end if;

        if (inserting or updating) then

            if (:new.branch_id != get_branch_id) then
                 raise_application_error(-20100, 'cannot modify data for branch(es)');
            end if;

         end if;

     end if; --repl

end;
/
ALTER TRIGGER FINMON.TBIUD_OPER_NOTES_BRANCH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Trigger/TBIUD_OPER_NOTES_BRANCH.sql ======
PROMPT ===================================================================================== 
