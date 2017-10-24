

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCGRT_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CCGRT_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CCGRT_UPDATE 
after insert or delete or update of ND,GRT_DEAL_ID
 on bars.cc_grt for each row
declare
   l_bankdate date;
   -- триггер предполагает только одну запись за один банковский день
   -- если в один банк. день было несколько изменений, то они перезаписывают пердидущее за этот банковский день
   l_chgaction char(1);
   l_idupd	   number;
begin
   l_bankdate := gl.bd;
   if l_bankdate is null then
      select to_date(val,'dd/mm/yyyy') into l_bankdate from params$base where par= 'BANKDATE';
   end if;
   if  deleting   then
       l_chgaction:= 'D';
       insert into CC_GRT_update values( s_CCGRT_update.nextval ,l_chgaction, gl.bd, sysdate, user_id,     :old.ND, :old.GRT_DEAL_ID);
   else
       if  updating then
           l_chgaction:= 'U';
       else
          l_chgaction:= 'I';
       end if;
       insert into CC_GRT_update values( s_CCGRT_update.nextval ,l_chgaction, gl.bd, sysdate, user_id,     :new.ND, :new.GRT_DEAL_ID);
   end if;
end;
/
ALTER TRIGGER BARS.TAIU_CCGRT_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCGRT_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
