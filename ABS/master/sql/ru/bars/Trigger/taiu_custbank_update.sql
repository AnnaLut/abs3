

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CUSTBANK_UPDATE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CUSTBANK_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CUSTBANK_UPDATE 
after insert or delete or update of RNK,MFO,ALT_BIC,BIC,RATING,KOD_B,DAT_ND,RUK,TELR,BUH,TELB,NUM_ND
 on bars.custbank for each row
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
       insert into CUSTBANK_update values( s_CUSTBANK_update.nextval ,l_chgaction, l_bankdate, sysdate, user_id,     :old.RNK, :old.MFO, :old.ALT_BIC, :old.BIC, :old.RATING, :old.KOD_B, :old.DAT_ND, :old.RUK, :old.TELR, :old.BUH, :old.TELB, :old.NUM_ND);
   else
       if  updating then
           l_chgaction:= 'U';
       else
          l_chgaction:= 'I';
       end if;
       insert into CUSTBANK_update values( s_CUSTBANK_update.nextval ,l_chgaction, l_bankdate, sysdate, user_id,     :new.RNK, :new.MFO, :new.ALT_BIC, :new.BIC, :new.RATING, :new.KOD_B, :new.DAT_ND, :new.RUK, :new.TELR, :new.BUH, :new.TELB, :new.NUM_ND);
   end if;
end;
/
ALTER TRIGGER BARS.TAIU_CUSTBANK_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CUSTBANK_UPDATE.sql =========**
PROMPT ===================================================================================== 
