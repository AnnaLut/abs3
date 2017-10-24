

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TD_OBPC_ELPLAT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TD_OBPC_ELPLAT ***

  CREATE OR REPLACE TRIGGER BARS.TD_OBPC_ELPLAT 
before delete on obpc_elplat
for each row
begin
  insert into obpc_elplat_hist (id, nls, s, sos, ref)
  values (:old.id, :old.nls, :old.s, :old.sos, :old.ref);
end;
/
ALTER TRIGGER BARS.TD_OBPC_ELPLAT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TD_OBPC_ELPLAT.sql =========*** End 
PROMPT ===================================================================================== 
