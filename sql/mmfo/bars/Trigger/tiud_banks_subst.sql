

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_BANKS_SUBST.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_BANKS_SUBST ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_BANKS_SUBST 
instead of insert or update or delete on banks for each row
begin
  if inserting then
    insert into banks$base(mfo,sab,nb,kodg,blk,mfou,ssp,nmo)
    values(:new.mfo, :new.sab, :new.nb, :new.kodg, :new.blk, :new.mfou, :new.ssp, :new.nmo);
    -- прямой участник расчетов?
    if sys_context('bars_context','user_mfop') is not null and :new.mfop<>sys_context('bars_context','user_mfop') then
        insert into banks$settings(kf,mfo,fmi,fmo,pm,kodn,mfop)
        values(sys_context('bars_context','user_mfo'), :new.mfo, :new.fmi, :new.fmo, :new.pm, :new.kodn, :new.mfop);
    end if;
  elsif updating then
    update banks$base set sab=:new.sab, nb=:new.nb, kodg=:new.kodg, blk=:new.blk,
        mfou=:new.mfou, ssp=:new.ssp, nmo=:new.nmo
    where mfo=:old.mfo;
    -- был прямым участником и остался?
    if sys_context('bars_context','user_mfop') is not null then
      if    :old.mfop<>sys_context('bars_context','user_mfop') and :new.mfop<>sys_context('bars_context','user_mfop') then
        update banks$settings set fmi=:new.fmi, fmo=:new.fmo, pm=:new.pm, kodn=:new.kodn, mfop=:new.mfop
        where kf=sys_context('bars_context','user_mfo') and mfo=:old.mfo;
      -- был прямым участником, теперь исключили
      elsif :old.mfop<>sys_context('bars_context','user_mfop') and :new.mfop=sys_context('bars_context','user_mfop') then
        delete from banks$settings where kf=sys_context('bars_context','user_mfo') and mfo=:old.mfo;
      -- не был прямым участником, теперь добавили
      elsif :old.mfop=sys_context('bars_context','user_mfop') and :new.mfop<>sys_context('bars_context','user_mfop') then
        insert into banks$settings(kf,mfo,fmi,fmo,pm,kodn,mfop)
        values(sys_context('bars_context','user_mfo'),:new.mfo,:new.fmi,:new.fmo,:new.pm,:new.kodn,:new.mfop);
      end if;
    end if;
  elsif deleting then
    if sys_context('bars_context','user_mfop') is not null then
        delete from banks$settings where mfo=:old.mfo and kf=sys_context('bars_context','user_mfo');
    end if;
    delete from banks$base where mfo=:old.mfo;
  end if;
end;




/
ALTER TRIGGER BARS.TIUD_BANKS_SUBST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_BANKS_SUBST.sql =========*** En
PROMPT ===================================================================================== 
