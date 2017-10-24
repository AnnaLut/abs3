

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_VRKOLST.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_VRKOLST ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_VRKOLST 
instead of insert or update or delete ON BARS.V_RKO_LST for each row
begin
  if inserting then
    insert into rko_lst(acc, accd, dat0a, dat0b, s0, KOLDOK, dat1a, dat1b, acc1, dat2a, dat2b, acc2, comm)
    values(:new.acc, :new.accd, :new.dat0a, :new.dat0b, nvl(:new.s0,0), nvl(:new.KOLDOK,0),:new.dat1a, :new.dat1b, :new.acc1,
            :new.dat2a, :new.dat2b, :new.acc2, :new.comm);
  elsif updating then
    update rko_lst set
        accd    = :new.accd,
        dat0a   = :new.dat0a,
        dat0b   = :new.dat0b,
        s0      = nvl(:new.s0,0),
        KOLDOK  = nvl(:new.KOLDOK,0),
        dat1a   = :new.dat1a,
        dat1b   = :new.dat1b,
        acc1    = :new.acc1,
        dat2a   = :new.dat2a,
        dat2b   = :new.dat2b,
        acc2    = :new.acc2,
        comm    = :new.comm
    where acc=:old.acc;
  elsif deleting then
    delete from rko_lst where acc=:old.acc;
  end if;
end;
/
ALTER TRIGGER BARS.TIUD_VRKOLST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_VRKOLST.sql =========*** End **
PROMPT ===================================================================================== 
