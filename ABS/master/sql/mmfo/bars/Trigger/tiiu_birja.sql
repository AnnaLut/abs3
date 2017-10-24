

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIIU_BIRJA.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIIU_BIRJA ***

  CREATE OR REPLACE TRIGGER BARS.TIIU_BIRJA 
instead of insert or update or delete on birja for each row
begin
  if inserting then
    if :new.kf is null then
      insert into birja_param (par, comm, val) values(:new.par, :new.comm, :new.val);
    else
      insert into birja_mfo (par, comm, val) values(:new.par, :new.comm, :new.val);
    end if;
  elsif deleting then
    if :old.kf is null then
      delete from birja_param where par = :old.par;
    else
      delete from birja_mfo where par = :old.par;
    end if;
  elsif updating then
    case when (:new.kf is null and :old.kf is null) then
      update birja_param set par = :new.par, comm = :new.comm, val = :new.val where par = :old.par;
         when (:new.kf is not null and :old.kf is not null) then
      update birja_mfo set par = :new.par, comm = :new.comm, val = :new.val where par = :old.par;
    when (:new.kf is null and :old.kf is not null) then
      delete from birja_mfo where par = :old.par;
      insert into birja_param (par, comm, val) values(:new.par, :new.comm, :new.val);
    when (:new.kf is not null and :old.kf is null) then
      delete from birja_param where par = :old.par;
      insert into birja_mfo (par, comm, val) values(:new.par, :new.comm, :new.val);
    end case;
  end if;
end;

/
ALTER TRIGGER BARS.TIIU_BIRJA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIIU_BIRJA.sql =========*** End *** 
PROMPT ===================================================================================== 
