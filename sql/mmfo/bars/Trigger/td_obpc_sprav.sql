

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TD_OBPC_SPRAV.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TD_OBPC_SPRAV ***

  CREATE OR REPLACE TRIGGER BARS.TD_OBPC_SPRAV 
before delete on obpc_sprav
for each row
begin
  insert into obpc_sprav_hist (num_conv, vid_z, vid_s, fio,
    acc_sbon, acc_card, acc_bal )
  values (:old.num_conv, :old.vid_z, :old.vid_s, :old.fio,
    :old.acc_sbon, :old.acc_card, :old.acc_bal);
end;




/
ALTER TRIGGER BARS.TD_OBPC_SPRAV ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TD_OBPC_SPRAV.sql =========*** End *
PROMPT ===================================================================================== 
