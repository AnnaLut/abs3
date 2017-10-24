

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_ACCOUNTS_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_ACCOUNTS_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAI_ACCOUNTS_UPDATE 
  after insert ON BARS.ACCOUNTS_UPDATE
  for each row
   WHEN (
new.chgaction=1
      ) declare
  l_branch      branch.branch%type;
  l_userbranch  branch.branch%type;
  l_opdate      date;

begin
  if :new.nbs = '1102' or
     :new.nbs = '1101' or
     :new.nbs = '9819' or
     :new.nbs = '9812' or
     :new.nbs = '9810' or
     :new.nbs = '9820' or
     :new.nbs = '9821' or
     :new.nbs = '9898' then

    l_userbranch := sys_context('bars_context', 'user_branch');

--  бранч указанный для счета
    select branch into l_branch from accounts where acc = :new.acc;

    bc.subst_branch(l_branch);

    select max(opdate)
    into   l_opdate
    from   cash_open
    where  opdate between trunc(sysdate) and trunc(sysdate)+0.999 and
           branch = l_branch;

    if l_opdate is not null then
      begin
        insert into cash_snapshot(branch,   opdate,   acc,      ostf)
                          values (l_branch, l_opdate, :new.acc, 0);
        exception when dup_val_on_index then
          null; -- если вдруг по какой-то причине запись с открытием
                -- попадет второй раз в acounts_update
      end;
    end if;

--  bc.set_context;
    bc.subst_branch(l_userbranch);

  end if;
exception when others then
--bc.set_context;
  bc.subst_branch(l_userbranch);
  raise;
end;


/
ALTER TRIGGER BARS.TAI_ACCOUNTS_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_ACCOUNTS_UPDATE.sql =========***
PROMPT ===================================================================================== 
