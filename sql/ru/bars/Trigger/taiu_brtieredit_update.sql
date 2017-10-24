

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_BRTIEREDIT_UPDATE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_BRTIEREDIT_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_BRTIEREDIT_UPDATE 
after insert or delete or update of BR_ID,BDATE,KV,S,RATE,BRANCH
 on bars.br_tier_edit for each row
declare
   l_bankdate date;
   -- триггер предполагает только одну запись за один банковский день
   -- если в один банк. день было несколько изменений, то они перезаписывают пердидущее за этот банковский день
   l_chgaction char(1);
   l_idupd	   number;
begin

   l_bankdate := bars.gl.bd;
   if l_bankdate is null then
      select to_date(val,'mm/dd/yyyy')
        into l_bankdate
        from params
       where  par='BANKDATE';
   end if;

   if  deleting   then
       l_chgaction:= 'D';
       insert into BR_TIER_EDIT_update values( s_BRTIEREDIT_update.nextval ,l_chgaction, l_bankdate, sysdate, user_id,     :old.BR_ID, :old.BDATE, :old.KV, :old.S, :old.RATE, :old.BRANCH);
   else
       if  updating then
           l_chgaction:= 'U';
       else
          l_chgaction:= 'I';
       end if;
       insert into BR_TIER_EDIT_update values( s_BRTIEREDIT_update.nextval ,l_chgaction, l_bankdate, sysdate, user_id,     :new.BR_ID, :new.BDATE, :new.KV, :new.S, :new.RATE, :new.BRANCH);
   end if;
end;
/
ALTER TRIGGER BARS.TAIU_BRTIEREDIT_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_BRTIEREDIT_UPDATE.sql =========
PROMPT ===================================================================================== 
