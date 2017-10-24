

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_VSTOGROUPS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_VSTOGROUPS ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_VSTOGROUPS 
instead of insert or update or delete on v_stogroups
begin
  if inserting then
     insert into sto_grp (idg, name, tobo)
     values (s_sto_idg.nextval, :new.grp_name, nvl(:new.tobo, tobopack.gettobo));
  elsif updating then
     update sto_grp set name = :new.grp_name where idg = :new.grp_id and tobo = :new.tobo;
  else
     delete from sto_grp where idg = :old.grp_id and tobo = :old.tobo;
  end if;
end;



/
ALTER TRIGGER BARS.TIUD_VSTOGROUPS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_VSTOGROUPS.sql =========*** End
PROMPT ===================================================================================== 
