PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_STAFF_SUBSTITUTE_CORP2.sql ====
PROMPT ===================================================================================== 

PROMPT *** Create  trigger TAIU_STAFF_SUBSTITUTE_CORP2 ***

DROP TRIGGER BARS.TAIU_STAFF_SUBSTITUTE_CORP2;

CREATE OR REPLACE TRIGGER BARS.taiu_staff_substitute_corp2
after insert or update ON BARS.STAFF_SUBSTITUTE for each row

/*
заявка COBUSUPABS-6383
10.09.2017 yurii.hrytsenia Додано операції 'CL1', 'CL2', 'CL5' - операції CorpLight
*/

begin
  update oper o set o.userid=:new.id_who
  where userid=:new.id_whom
        and (tt like 'IB%' or tt in ('CL1', 'CL2', 'CL5'))
        and  exists (select 1 from ref_que where ref=o.ref)
        and date_is_valid(:new.date_start, :new.date_finish, null, null)=1;
end;
/
ALTER TRIGGER BARS.TAIU_STAFF_SUBSTITUTE_CORP2 ENABLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_STAFF_SUBSTITUTE_CORP2.sql ====
PROMPT ===================================================================================== 
