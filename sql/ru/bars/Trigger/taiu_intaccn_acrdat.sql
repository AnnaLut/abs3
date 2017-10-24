

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_INTACCN_ACRDAT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_INTACCN_ACRDAT ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_INTACCN_ACRDAT 
after insert or update ON BARS.INT_ACCN for each row
 WHEN (
nvl(old.acr_dat, to_date('01.01.1900','dd.mm.yyyy'))
      !=
      nvl(new.acr_dat, to_date('01.01.1900','dd.mm.yyyy'))
      ) declare
   l_type char(1);
begin
   if (inserting) then
      l_type :='I';
   else
      l_type :='U';
   end if;

   insert into int_acrdat_upd
     (accid, intid, acrdat, rec_id, rec_type,
      rec_uid, rec_uname, rec_date, machine)
   values
     (:new.acc, :new.id, :new.acr_dat, s_intacrdatupd.nextval, l_type,
      sys_context('userenv', 'session_userid'),
      sys_context('userenv', 'session_user'),
      sysdate,
      sys_context('userenv', 'terminal'));
end;
/
ALTER TRIGGER BARS.TAIU_INTACCN_ACRDAT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_INTACCN_ACRDAT.sql =========***
PROMPT ===================================================================================== 
