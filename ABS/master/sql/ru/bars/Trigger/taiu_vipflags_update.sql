

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_VIPFLAGS_UPDATE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_VIPFLAGS_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_VIPFLAGS_UPDATE 
after insert or update on BARS.VIP_FLAGS
for each row
begin

  begin
    insert into BARS.VIP_FLAGS_UPDATE
      ( MFO, RNK, DATBEG, DATEND, VIP, KVIP, COMMENTS )
    values
      ( :new.MFO, :new.RNK, :new.DATBEG, :new.DATEND, :new.VIP, :new.KVIP, :new.COMMENTS );
  exception
    when DUP_VAL_ON_INDEX then
      update BARS.VIP_FLAGS_UPDATE
         set DATEND   = :new.DATEND,
             VIP      = :new.VIP,
             KVIP     = :new.KVIP,
             COMMENTS = :new.COMMENTS
       where MFO      = :new.MFO
         and RNK      = :new.RNK
         and DATBEG   = :new.DATBEG;
  end;

end;
/
ALTER TRIGGER BARS.TAIU_VIPFLAGS_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_VIPFLAGS_UPDATE.sql =========**
PROMPT ===================================================================================== 
