

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TD_OBPC_DP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TD_OBPC_DP ***

  CREATE OR REPLACE TRIGGER BARS.TD_OBPC_DP 
before delete on obpc_dp
for each row
begin
  insert into obpc_dp_hist (id, num_conv, s_int_d, s_int_ss, s_int_cr, sos, ref)
  values (:old.id, :old.num_conv, :old.s_int_d, :old.s_int_ss, :old.s_int_cr, :old.sos, :old.ref);
end;




/
ALTER TRIGGER BARS.TD_OBPC_DP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TD_OBPC_DP.sql =========*** End *** 
PROMPT ===================================================================================== 
