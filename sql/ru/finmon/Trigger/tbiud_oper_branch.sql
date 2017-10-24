

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Trigger/TBIUD_OPER_BRANCH.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_OPER_BRANCH ***

  CREATE OR REPLACE TRIGGER FINMON.TBIUD_OPER_BRANCH 
before insert or update or delete ON FINMON.OPER for each row
begin

    if (dbms_reputil.from_remote = false and dbms_snapshot.i_am_a_refresh = false and (isd_branch = 0)) then

        if (inserting or updating) then

            if (:new.branch_id != get_branch_id) then
                raise_application_error(-20100, 'cannot modify data for branch(es)');
            end if;

        else

            if (:old.branch_id != get_branch_id) then
                raise_application_error(-20100, 'cannot modify data for branch(es)');
            end if;

        end if;

    elsif (dbms_reputil.from_remote = true) then

        if (inserting) then
            :new.kl_id   := null;
            :new.kl_date := null;
        end if;

    end if;

end;
/
ALTER TRIGGER FINMON.TBIUD_OPER_BRANCH DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Trigger/TBIUD_OPER_BRANCH.sql =========***
PROMPT ===================================================================================== 
