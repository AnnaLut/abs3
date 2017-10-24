

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_PAWNACC_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_PAWNACC_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_PAWNACC_UPDATE 
after insert or delete or update of ACC,PAWN,MPAWN,NREE,IDZ,NDZ,DEPOSIT_ID,KF,SV,CC_IDZ,SDATZ
 on bars.pawn_acc for each row
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
       insert into PAWN_ACC_update values( s_PAWNACC_update.nextval ,l_chgaction, l_bankdate, sysdate, user_id,     :old.ACC, :old.PAWN, :old.MPAWN, :old.NREE, :old.IDZ, :old.NDZ, :old.DEPOSIT_ID, :old.KF, :old.SV, :old.CC_IDZ, :old.SDATZ);
   else
       if  updating then
           l_chgaction:= 'U';
       else
          l_chgaction:= 'I';
       end if;
       insert into PAWN_ACC_update values( s_PAWNACC_update.nextval ,l_chgaction, l_bankdate, sysdate, user_id,     :new.ACC, :new.PAWN, :new.MPAWN, :new.NREE, :new.IDZ, :new.NDZ, :new.DEPOSIT_ID, :new.KF, :new.SV, :new.CC_IDZ, :new.SDATZ);
   end if;
end;
/
ALTER TRIGGER BARS.TAIU_PAWNACC_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_PAWNACC_UPDATE.sql =========***
PROMPT ===================================================================================== 
