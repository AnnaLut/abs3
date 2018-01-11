

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CPDAT_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CPDAT_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CPDAT_UPDATE 
after insert or update or delete
 ON BARS.CP_DAT for each row
declare
   l_bankdate  date;
   l_chgaction char(1);
begin

  l_bankdate := bars.gl.bd;

  if ( l_bankdate is Null )
  then

    l_bankdate := bars.glb_bankdate;

  end if;

   if  deleting
   then

     l_chgaction:= 'D';

     insert into bars.cp_dat_update
       ( idupd, action, effectdate, chg_date, doneby, id, npp, dok, kup, nom, ir)
     values
       ( s_cp_dat_update.nextval ,l_chgaction, l_bankdate, sysdate, user_id, :old.id,
                       :old.npp, :old.dok, :old.kup, :old.nom, :old.ir);
   else

     if updating
     then
       l_chgaction:= 'U';
     else
       l_chgaction:= 'I';
     end if;

     insert into bars.cp_dat_update
       ( idupd, action, effectdate, chg_date, doneby, id, npp, dok, kup, nom, ir)
     values
       ( s_cp_dat_update.nextval ,l_chgaction, l_bankdate, sysdate, user_id, :new.id,
                       :new.npp, :new.dok, :new.kup, :new.nom, :new.ir);

     /*begin
      update cp_kod
         set ir = :new.ir
       where id = :new.id
         and dnk = :new.dok;
     end;*/

   end if;

end;
/
ALTER TRIGGER BARS.TAIU_CPDAT_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CPDAT_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
