

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_EDEAL$BASE_UPDATE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_EDEAL$BASE_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_EDEAL$BASE_UPDATE 
after insert or delete or update of nd, rnk, cc_id, sdate, kf, acc26, acc36, accd, accp
 on bars.e_deal$base for each row
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
       insert into e_deal$base_update(idupd,chgaction, effectdate,  chgdate, doneby,
                              acc26, acc36, accd, accp, cc_id, kf,
                              nd, rnk, sa, sdate, sos, user_id, wdate)
          values( S_EDEAL$BASEUPDATE.nextval ,l_chgaction, l_bankdate, sysdate, user_id,
                             :old.acc26, :old.acc36, :old.accd, :old.accp, :old.cc_id, :old.kf,
                             :old.nd, :old.rnk, :old.sa, :old.sdate, :old.sos, :old.user_id, :old.wdate);
   else
       if updating then
          l_chgaction:= 'U';
       else
          l_chgaction:= 'I';
       end if;

       insert into e_deal$base_update(idupd, chgaction, effectdate,  chgdate, doneby,
                              acc26, acc36, accd, accp, cc_id, kf,
                              nd, rnk, sa, sdate, sos, user_id, wdate)
          values( S_EDEAL$BASEUPDATE.nextval ,l_chgaction, l_bankdate, sysdate, user_id,
                              :new.acc26, :new.acc36, :new.accd, :new.accp, :new.cc_id, :new.kf,
                              :new.nd, :new.rnk, :new.sa, :new.sdate, :new.sos, :new.user_id, :new.wdate);
   end if;
end;
/
ALTER TRIGGER BARS.TAIU_EDEAL$BASE_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_EDEAL$BASE_UPDATE.sql =========
PROMPT ===================================================================================== 
