

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOUNTS_NEWCASH.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACCOUNTS_NEWCASH ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACCOUNTS_NEWCASH 
  before insert  ON BARS.ACCOUNTS for each row
  follows BARS.TIU_ACCOUNTS_BRANCH_TOBO

--------------------------------------------
-- триггер для касс отчетности.
-- При открытии нового касс счета - он помещается в срез кассы
--------------------------------------------
declare
   l_nbs      varchar2(4);
   l_opdate   date;
begin

   select unique nbs into l_nbs
     from cash_nbs
    where nbs = :new.nbs;
    --and ob22 = :new.ob22;
    ---
    -- Пока коментарим, так як при вставці
    -- в accounts ми ще не маемо ОБ22


   for c in ( select opdate, shift
                from cash_open
               where opdate between trunc(sysdate) and sysdate
             and branch = :new.BRANCH
            ) loop
      insert into cash_snapshot(opdate,branch, acc, ostf, kf)
      values(c.opdate, :new.branch, :new.acc, 0, :new.kf);
   end loop;

exception when no_data_found then null;
end  tiu_accounts_newcash;
/
ALTER TRIGGER BARS.TIU_ACCOUNTS_NEWCASH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOUNTS_NEWCASH.sql =========**
PROMPT ===================================================================================== 
