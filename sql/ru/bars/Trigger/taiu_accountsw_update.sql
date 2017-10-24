

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_ACCOUNTSW_UPDATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_ACCOUNTSW_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_ACCOUNTSW_UPDATE 
after insert or delete or update of value, tag, acc on bars.accountsw for each row
declare
   l_bankdate  date;
   l_chgaction char(1);
begin

   l_bankdate := bars.gl.bd;
   if l_bankdate is null then
      select to_date(val,'mm/dd/yyyy')
        into l_bankdate
        from params
       where par = 'BANKDATE';
   end if;

   if deleting then
       l_chgaction := 'D';
       insert into accountsw_update(idupd, chgaction, effectdate, chgdate, doneby, acc, tag, value)
       values( s_accountsw_update.nextval,l_chgaction, l_bankdate, sysdate, user_id, :old.acc, :old.tag, :old.value);
   elsif inserting then
       l_chgaction := 'I';
       insert into accountsw_update(idupd, chgaction, effectdate, chgdate, doneby, acc, tag, value)
       values( s_accountsw_update.nextval,l_chgaction, l_bankdate, sysdate, user_id, :new.acc, :new.tag, :new.value);
   elsif updating and ( :old.tag <> :new.tag or :old.acc <> :new.acc ) then
       l_chgaction := 'D';
       insert into accountsw_update(idupd, chgaction, effectdate, chgdate, doneby, acc, tag, value)
       values( s_accountsw_update.nextval,l_chgaction, l_bankdate, sysdate, user_id, :old.acc, :old.tag, :old.value);
       l_chgaction := 'I';
       insert into accountsw_update(idupd, chgaction, effectdate, chgdate, doneby, acc, tag, value)
       values( s_accountsw_update.nextval,l_chgaction, l_bankdate, sysdate, user_id, :new.acc, :new.tag, :new.value);
   elsif updating and :old.value <> :new.value then
       l_chgaction := 'U';
       insert into accountsw_update(idupd, chgaction, effectdate, chgdate, doneby, acc, tag, value)
       values( s_accountsw_update.nextval,l_chgaction, l_bankdate, sysdate, user_id, :new.acc, :new.tag, :new.value);
   end if;

end;
/
ALTER TRIGGER BARS.TAIU_ACCOUNTSW_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_ACCOUNTSW_UPDATE.sql =========*
PROMPT ===================================================================================== 
